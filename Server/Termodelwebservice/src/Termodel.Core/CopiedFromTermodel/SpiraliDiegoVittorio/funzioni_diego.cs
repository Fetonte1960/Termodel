using System;
using System.Collections.Generic;
using Termodel.utilities;

namespace SpiralHeatingDiegoVittorio
{
    /// <summary>
    /// Raccolta riutilizzabile delle funzioni sviluppate da Diego rispetto
    /// al motore Vittorio: ritorno parallelo, chiusura e raccordo.
    /// </summary>
    public static class funzioni_diego
    {
        private const double Tolleranza = 1e-9;

        private const double TolleranzaChiusura = 0.000001;
        private const int MaxTrattiTerminaliChiusura = 2;
        private sealed class ConfigurazioneTerminaleChiusura
        {
            public List<Punto> Punti { get; init; }
            public string Codice { get; init; }
            public int TrattiRimossi { get; init; }
        }

        /// <summary>
        /// Combinatoria rettilinea consolidata per la chiusura Diego.
        /// Mandata e Ripresa usano la stessa matrice:
        /// 0I, 0P, 1I, 1P, 2I, 2P.
        /// I = terminale invariato; P = terminale accorciato a massimo 2P, senza allungamento.
        /// Il primo candidato con chiusura >= 2P, innesti non acuti, nessuna
        /// intersezione e nessun parallelismo vicino del tratto di chiusura
        /// col nuovo setup viene accettato.
        /// Nessun raccordo o curva partecipa alla scelta.
        /// </summary>
        public static (
            List<Punto> Mandata,
            List<Punto> Ritorno,
            List<Punto> Chiusura,
            bool Applicata)
            chiusura_diego(
                List<Punto> mandataRettilinea,
                List<Punto> ritornoVersoCentro,
                double passo)
        {
            if (mandataRettilinea == null ||
                ritornoVersoCentro == null ||
                mandataRettilinea.Count < 2 ||
                ritornoVersoCentro.Count < 2 ||
                !double.IsFinite(passo) ||
                passo <= TolleranzaChiusura)
            {
                LogChiusura(
                    "Closure.Summary",
                    $"outcome=FAILURE attempts=0 selected=none " +
                    $"reason=invalid-input " +
                    $"supplyPoints={(mandataRettilinea == null ? -1 : mandataRettilinea.Count)} " +
                    $"returnPoints={(ritornoVersoCentro == null ? -1 : ritornoVersoCentro.Count)} " +
                    $"P={passo:R}");

                return (
                    mandataRettilinea ?? new List<Punto>(),
                    ritornoVersoCentro ?? new List<Punto>(),
                    new List<Punto>(),
                    false);
            }

            // Ordine definitivo approvato: I prima di P per ogni livello.
            // La stessa sequenza viene usata sia per Mandata sia per Ripresa.
            var azioniTerminali = new (int rimossi, bool normalizzaP)[]
            {
                (0, false),
                (0, true),
                (1, false),
                (1, true),
                (2, false),
                (2, true)
            };

            int numeroTentativo = 0;
            double lunghezzaMinimaChiusura = 2.0 * passo;

            foreach (var azioneMandata in azioniTerminali)
            {
                string codiceMandata =
                    $"M{azioneMandata.rimossi}" +
                    (azioneMandata.normalizzaP ? "P" : "I");

                ConfigurazioneTerminaleChiusura mandata =
                    CreaConfigurazioneTerminaleChiusura(
                        mandataRettilinea,
                        codiceMandata,
                        azioneMandata.rimossi,
                        azioneMandata.normalizzaP,
                        passo);
                if (mandata == null)
                    continue;

                foreach (var azioneRitorno in azioniTerminali)
                {
                    string codiceRitorno =
                        $"R{azioneRitorno.rimossi}" +
                        (azioneRitorno.normalizzaP ? "P" : "I");

                    ConfigurazioneTerminaleChiusura ritorno =
                        CreaConfigurazioneTerminaleChiusura(
                            ritornoVersoCentro,
                            codiceRitorno,
                            azioneRitorno.rimossi,
                            azioneRitorno.normalizzaP,
                            passo);
                    if (ritorno == null)
                        continue;

                    numeroTentativo++;

                    Punto ms = mandata.Punti[^2];
                    Punto me = mandata.Punti[^1];
                    Punto rs = ritorno.Punti[^2];
                    Punto re = ritorno.Punti[^1];

                    LogChiusura(
                        "Closure.Try",
                        $"attempt={numeroTentativo} " +
                        $"seq={codiceMandata}/{codiceRitorno} " +
                        $"supplyRemoved={azioneMandata.rimossi} " +
                        $"supplyMode={(azioneMandata.normalizzaP ? "P" : "I")} " +
                        $"supplyLast=({ms.X:R},{ms.Y:R})->({me.X:R},{me.Y:R}) " +
                        $"supplyLastLen={ms.DistanceTo(me):R} " +
                        $"returnRemoved={azioneRitorno.rimossi} " +
                        $"returnMode={(azioneRitorno.normalizzaP ? "P" : "I")} " +
                        $"returnLast=({rs.X:R},{rs.Y:R})->({re.X:R},{re.Y:R}) " +
                        $"returnLastLen={rs.DistanceTo(re):R} " +
                        $"endpointDistance={me.DistanceTo(re):R} " +
                        $"required={lunghezzaMinimaChiusura:R}");

                    Punto inizio = me;
                    Punto fine = re;
                    double lunghezzaChiusura = inizio.DistanceTo(fine);

                    // Regola definitiva: >= 2P.
                    if (lunghezzaChiusura <
                        lunghezzaMinimaChiusura - TolleranzaChiusura)
                    {
                        LogChiusura(
                            "Closure.Reject",
                            $"attempt={numeroTentativo} " +
                            $"seq={codiceMandata}/{codiceRitorno} " +
                            $"reason=length length={lunghezzaChiusura:R} " +
                            $"required={lunghezzaMinimaChiusura:R}");
                        LogEsitoTentativoChiusura(
                            numeroTentativo,
                            codiceMandata,
                            codiceRitorno,
                            azioneMandata.rimossi,
                            azioneMandata.normalizzaP,
                            ms,
                            me,
                            azioneRitorno.rimossi,
                            azioneRitorno.normalizzaP,
                            rs,
                            re,
                            lunghezzaChiusura,
                            lunghezzaMinimaChiusura,
                            "FAILURE",
                            "length");
                        continue;
                    }

                    Punto ingressoMandata = new Punto(
                        inizio.X - ms.X,
                        inizio.Y - ms.Y);
                    Punto uscitaRitorno = new Punto(
                        rs.X - fine.X,
                        rs.Y - fine.Y);
                    Punto direzioneChiusura = new Punto(
                        fine.X - inizio.X,
                        fine.Y - inizio.Y);

                    double cosMandata =
                        CosenoDirezioniChiusura(
                            ingressoMandata,
                            direzioneChiusura);
                    double cosRitorno =
                        CosenoDirezioniChiusura(
                            direzioneChiusura,
                            uscitaRitorno);

                    if (cosMandata < -TolleranzaChiusura ||
                        cosRitorno < -TolleranzaChiusura)
                    {
                        LogChiusura(
                            "Closure.Reject",
                            $"attempt={numeroTentativo} " +
                            $"seq={codiceMandata}/{codiceRitorno} " +
                            $"reason=acute cosSupply={cosMandata:R} " +
                            $"cosReturn={cosRitorno:R}");
                        LogEsitoTentativoChiusura(
                            numeroTentativo,
                            codiceMandata,
                            codiceRitorno,
                            azioneMandata.rimossi,
                            azioneMandata.normalizzaP,
                            ms,
                            me,
                            azioneRitorno.rimossi,
                            azioneRitorno.normalizzaP,
                            rs,
                            re,
                            lunghezzaChiusura,
                            lunghezzaMinimaChiusura,
                            "FAILURE",
                            "acute",
                            $"cosSupply={cosMandata:R} cosReturn={cosRitorno:R}");
                        continue;
                    }

                    // Il controllo riguarda soltanto il nuovo segmento di
                    // chiusura contro il setup risultante dopo tagli e
                    // normalizzazioni. I due terminali adiacenti sono esclusi.
                    bool intersecaMandata =
                        IntersecaTrattiNonAdiacentiChiusura(
                            inizio,
                            fine,
                            mandata.Punti);
                    bool intersecaRitorno =
                        IntersecaTrattiNonAdiacentiChiusura(
                            inizio,
                            fine,
                            ritorno.Punti);

                    if (intersecaMandata || intersecaRitorno)
                    {
                        LogChiusura(
                            "Closure.Reject",
                            $"attempt={numeroTentativo} " +
                            $"seq={codiceMandata}/{codiceRitorno} " +
                            $"reason=intersection supply={intersecaMandata} " +
                            $"return={intersecaRitorno}");
                        LogEsitoTentativoChiusura(
                            numeroTentativo,
                            codiceMandata,
                            codiceRitorno,
                            azioneMandata.rimossi,
                            azioneMandata.normalizzaP,
                            ms,
                            me,
                            azioneRitorno.rimossi,
                            azioneRitorno.normalizzaP,
                            rs,
                            re,
                            lunghezzaChiusura,
                            lunghezzaMinimaChiusura,
                            "FAILURE",
                            "intersection",
                            $"cosSupply={cosMandata:R} cosReturn={cosRitorno:R} " +
                            $"intersectsSupply={intersecaMandata} " +
                            $"intersectsReturn={intersecaRitorno}");
                        continue;
                    }

                    // Modificato da Codex per realizzare: esclusione delle chiusure
                    // quasi parallele e sovrapposte agli ultimi tratti non adiacenti
                    // quando la loro distanza e' strettamente minore di 2P.
                    double distanzaMinimaParallelismi = 2.0 * passo;
                    bool paralleloVicinoMandata =
                        HaParallelismoVicinoChiusura(
                            inizio,
                            fine,
                            mandata.Punti,
                            distanzaMinimaParallelismi,
                            out int trattoMandataDaFine,
                            out double distanzaMandata,
                            out double angoloMandata,
                            out double sovrapposizioneMandata);
                    bool paralleloVicinoRitorno =
                        HaParallelismoVicinoChiusura(
                            inizio,
                            fine,
                            ritorno.Punti,
                            distanzaMinimaParallelismi,
                            out int trattoRitornoDaFine,
                            out double distanzaRitorno,
                            out double angoloRitorno,
                            out double sovrapposizioneRitorno);

                    if (paralleloVicinoMandata || paralleloVicinoRitorno)
                    {
                        string percorso = paralleloVicinoMandata
                            ? "supply"
                            : "return";
                        int trattoDaFine = paralleloVicinoMandata
                            ? trattoMandataDaFine
                            : trattoRitornoDaFine;
                        double distanza = paralleloVicinoMandata
                            ? distanzaMandata
                            : distanzaRitorno;
                        double angolo = paralleloVicinoMandata
                            ? angoloMandata
                            : angoloRitorno;
                        double sovrapposizione = paralleloVicinoMandata
                            ? sovrapposizioneMandata
                            : sovrapposizioneRitorno;

                        LogChiusura(
                            "Closure.Reject",
                            $"attempt={numeroTentativo} " +
                            $"seq={codiceMandata}/{codiceRitorno} " +
                            $"reason=parallel-proximity path={percorso} " +
                            $"segmentFromEnd={trattoDaFine} " +
                            $"distance={distanza:R} " +
                            $"required={distanzaMinimaParallelismi:R} " +
                            $"angle={angolo:R} overlap={sovrapposizione:R}");
                        LogEsitoTentativoChiusura(
                            numeroTentativo,
                            codiceMandata,
                            codiceRitorno,
                            azioneMandata.rimossi,
                            azioneMandata.normalizzaP,
                            ms,
                            me,
                            azioneRitorno.rimossi,
                            azioneRitorno.normalizzaP,
                            rs,
                            re,
                            lunghezzaChiusura,
                            lunghezzaMinimaChiusura,
                            "FAILURE",
                            "parallel-proximity",
                            $"path={percorso} segmentFromEnd={trattoDaFine} " +
                            $"distance={distanza:R} " +
                            $"required={distanzaMinimaParallelismi:R} " +
                            $"angle={angolo:R} overlap={sovrapposizione:R}");
                        continue;
                    }

                    LogChiusura(
                        "Closure.Accept",
                        $"attempt={numeroTentativo} " +
                        $"seq={codiceMandata}/{codiceRitorno} " +
                        $"length={lunghezzaChiusura:R} " +
                        $"cosSupply={cosMandata:R} cosReturn={cosRitorno:R}");

                    LogEsitoTentativoChiusura(
                        numeroTentativo,
                        codiceMandata,
                        codiceRitorno,
                        azioneMandata.rimossi,
                        azioneMandata.normalizzaP,
                        ms,
                        me,
                        azioneRitorno.rimossi,
                        azioneRitorno.normalizzaP,
                        rs,
                        re,
                        lunghezzaChiusura,
                        lunghezzaMinimaChiusura,
                        "SUCCESS",
                        "accepted",
                        $"cosSupply={cosMandata:R} cosReturn={cosRitorno:R} " +
                        "intersectsSupply=False intersectsReturn=False");

                    LogChiusura(
                        "Closure.Selected",
                        $"attempt={numeroTentativo} " +
                        $"seq={codiceMandata}/{codiceRitorno} " +
                        $"type=first-straight-success " +
                        $"length={lunghezzaChiusura:R} " +
                        $"requiredLength={lunghezzaMinimaChiusura:R}");

                    bool ortogonale =
                        Math.Abs(inizio.X - fine.X) <= TolleranzaChiusura ||
                        Math.Abs(inizio.Y - fine.Y) <= TolleranzaChiusura;

                    LogChiusura(
                        "Closure.Result",
                        $"attempt={numeroTentativo} " +
                        $"seq={codiceMandata}/{codiceRitorno} " +
                        $"type={(ortogonale ? "orthogonal" : "oblique")} " +
                        $"length={lunghezzaChiusura:R} " +
                        $"cosSupply={cosMandata:R} cosReturn={cosRitorno:R} " +
                        $"removed={azioneMandata.rimossi}/{azioneRitorno.rimossi}");

                    LogChiusura(
                        "Closure.Summary",
                        $"outcome=SUCCESS attempts={numeroTentativo} " +
                        $"selected={codiceMandata}/{codiceRitorno} " +
                        $"closureLength={lunghezzaChiusura:R} " +
                        $"required={lunghezzaMinimaChiusura:R}");

                    return (
                        mandata.Punti,
                        ritorno.Punti,
                        new List<Punto> { inizio, fine },
                        true);
                }
            }

            LogChiusura(
                "Closure.Summary",
                $"outcome=FAILURE attempts={numeroTentativo} selected=none " +
                $"reason=no-valid-permutation required={lunghezzaMinimaChiusura:R}");

            return (
                mandataRettilinea,
                ritornoVersoCentro,
                new List<Punto>(),
                false);
        }

        private static ConfigurazioneTerminaleChiusura
            CreaConfigurazioneTerminaleChiusura(
                List<Punto> originale,
                string codice,
                int trattiRimossi,
                bool normalizzaP,
                double passo)
        {
            if (originale == null ||
                trattiRimossi < 0 ||
                trattiRimossi > MaxTrattiTerminaliChiusura ||
                originale.Count - trattiRimossi < 2)
            {
                return null;
            }

            int count = originale.Count - trattiRimossi;
            var punti = new List<Punto>(count);
            for (int i = 0; i < count; i++)
                punti.Add(new Punto(originale[i].X, originale[i].Y));

            if (normalizzaP)
            {
                Punto inizio = punti[^2];
                Punto fine = punti[^1];
                double lunghezza = inizio.DistanceTo(fine);
                if (lunghezza <= TolleranzaChiusura)
                    return null;

                // Modificato per la prova approvata 02/10/2026:
                // la variante storica "P" diventa un solo accorciamento
                // a massimo 2P. Non allungare mai un terminale gia' <= 2P.
                double lunghezzaTerminale = 2.0 * passo;
                if (lunghezza > lunghezzaTerminale + TolleranzaChiusura)
                {
                    double rapporto = lunghezzaTerminale / lunghezza;
                    punti[^1] = new Punto(
                        inizio.X + (fine.X - inizio.X) * rapporto,
                        inizio.Y + (fine.Y - inizio.Y) * rapporto);
                }
            }

            return new ConfigurazioneTerminaleChiusura
            {
                Punti = punti,
                Codice = codice,
                TrattiRimossi = trattiRimossi
            };
        }

        private static double CosenoDirezioniChiusura(
            Punto a,
            Punto b)
        {
            double lunghezzaA = Math.Sqrt(a.X * a.X + a.Y * a.Y);
            double lunghezzaB = Math.Sqrt(b.X * b.X + b.Y * b.Y);
            if (lunghezzaA <= TolleranzaChiusura ||
                lunghezzaB <= TolleranzaChiusura)
            {
                return -1.0;
            }

            return (a.X * b.X + a.Y * b.Y) /
                   (lunghezzaA * lunghezzaB);
        }

        private static bool IntersecaTrattiNonAdiacentiChiusura(
            Punto inizioChiusura,
            Punto fineChiusura,
            List<Punto> polilinea)
        {
            if (polilinea == null || polilinea.Count < 3)
                return false;

            // L'ultimo segmento e' adiacente all'innesto e viene escluso.
            for (int i = 0; i < polilinea.Count - 2; i++)
            {
                if (SegmentiIntersecanoChiusura(
                    inizioChiusura,
                    fineChiusura,
                    polilinea[i],
                    polilinea[i + 1]))
                {
                    return true;
                }
            }

            return false;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool HaParallelismoVicinoChiusura(
            Punto inizioChiusura,
            Punto fineChiusura,
            List<Punto> polilinea,
            double distanzaMinima,
            out int trattoDaFine,
            out double distanza,
            out double angoloGradi,
            out double sovrapposizione)
        {
            trattoDaFine = -1;
            distanza = double.PositiveInfinity;
            angoloGradi = double.NaN;
            sovrapposizione = 0.0;

            if (polilinea == null || polilinea.Count < 3)
                return false;

            double dxChiusura = fineChiusura.X - inizioChiusura.X;
            double dyChiusura = fineChiusura.Y - inizioChiusura.Y;
            double lunghezzaChiusura =
                Math.Sqrt(dxChiusura * dxChiusura + dyChiusura * dyChiusura);
            if (lunghezzaChiusura <= TolleranzaChiusura)
                return false;

            double uxChiusura = dxChiusura / lunghezzaChiusura;
            double uyChiusura = dyChiusura / lunghezzaChiusura;
            int ultimoIndiceSegmento = polilinea.Count - 2;

            // Fra gli ultimi tre tratti il primo, direttamente adiacente alla
            // chiusura, viene escluso. Si controllano solo il secondo e il terzo.
            for (int posizioneDaFine = 2; posizioneDaFine <= 3; posizioneDaFine++)
            {
                int indice = ultimoIndiceSegmento - (posizioneDaFine - 1);
                if (indice < 0)
                    continue;

                Punto a = polilinea[indice];
                Punto b = polilinea[indice + 1];
                double dx = b.X - a.X;
                double dy = b.Y - a.Y;
                double lunghezza = Math.Sqrt(dx * dx + dy * dy);
                if (lunghezza <= TolleranzaChiusura)
                    continue;

                double cosenoAssoluto = Math.Abs(
                    (dxChiusura * dx + dyChiusura * dy) /
                    (lunghezzaChiusura * lunghezza));
                cosenoAssoluto = Math.Max(0.0, Math.Min(1.0, cosenoAssoluto));
                double angolo = Math.Acos(cosenoAssoluto) * 180.0 / Math.PI;
                if (angolo > 5.0 + TolleranzaChiusura)
                    continue;

                double proiezioneA =
                    (a.X - inizioChiusura.X) * uxChiusura +
                    (a.Y - inizioChiusura.Y) * uyChiusura;
                double proiezioneB =
                    (b.X - inizioChiusura.X) * uxChiusura +
                    (b.Y - inizioChiusura.Y) * uyChiusura;
                double inizioSovrapposizione =
                    Math.Max(0.0, Math.Min(proiezioneA, proiezioneB));
                double fineSovrapposizione =
                    Math.Min(
                        lunghezzaChiusura,
                        Math.Max(proiezioneA, proiezioneB));
                double sovrapposizioneCorrente =
                    fineSovrapposizione - inizioSovrapposizione;
                if (sovrapposizioneCorrente <= TolleranzaChiusura)
                    continue;

                double distanzaCorrente = Math.Min(
                    Math.Min(
                        DistanzaPuntoSegmentoChiusura(
                            inizioChiusura,
                            a,
                            b),
                        DistanzaPuntoSegmentoChiusura(
                            fineChiusura,
                            a,
                            b)),
                    Math.Min(
                        DistanzaPuntoSegmentoChiusura(
                            a,
                            inizioChiusura,
                            fineChiusura),
                        DistanzaPuntoSegmentoChiusura(
                            b,
                            inizioChiusura,
                            fineChiusura)));

                if (distanzaCorrente <
                    distanzaMinima - TolleranzaChiusura)
                {
                    trattoDaFine = posizioneDaFine;
                    distanza = distanzaCorrente;
                    angoloGradi = angolo;
                    sovrapposizione = sovrapposizioneCorrente;
                    return true;
                }
            }

            return false;
        }

        // Funzione realizzata da Codex in autonomia
        private static double DistanzaPuntoSegmentoChiusura(
            Punto punto,
            Punto inizioSegmento,
            Punto fineSegmento)
        {
            double dx = fineSegmento.X - inizioSegmento.X;
            double dy = fineSegmento.Y - inizioSegmento.Y;
            double lunghezzaQuadrata = dx * dx + dy * dy;
            if (lunghezzaQuadrata <=
                TolleranzaChiusura * TolleranzaChiusura)
            {
                return punto.DistanceTo(inizioSegmento);
            }

            double parametro =
                ((punto.X - inizioSegmento.X) * dx +
                 (punto.Y - inizioSegmento.Y) * dy) /
                lunghezzaQuadrata;
            parametro = Math.Max(0.0, Math.Min(1.0, parametro));

            var proiezione = new Punto(
                inizioSegmento.X + parametro * dx,
                inizioSegmento.Y + parametro * dy);
            return punto.DistanceTo(proiezione);
        }

        private static bool SegmentiIntersecanoChiusura(
            Punto a,
            Punto b,
            Punto c,
            Punto d)
        {
            double o1 = OrientamentoChiusura(a, b, c);
            double o2 = OrientamentoChiusura(a, b, d);
            double o3 = OrientamentoChiusura(c, d, a);
            double o4 = OrientamentoChiusura(c, d, b);

            if (((o1 > TolleranzaChiusura && o2 < -TolleranzaChiusura) ||
                 (o1 < -TolleranzaChiusura && o2 > TolleranzaChiusura)) &&
                ((o3 > TolleranzaChiusura && o4 < -TolleranzaChiusura) ||
                 (o3 < -TolleranzaChiusura && o4 > TolleranzaChiusura)))
            {
                return true;
            }

            return
                Math.Abs(o1) <= TolleranzaChiusura &&
                    PuntoSulSegmentoChiusura(a, b, c) ||
                Math.Abs(o2) <= TolleranzaChiusura &&
                    PuntoSulSegmentoChiusura(a, b, d) ||
                Math.Abs(o3) <= TolleranzaChiusura &&
                    PuntoSulSegmentoChiusura(c, d, a) ||
                Math.Abs(o4) <= TolleranzaChiusura &&
                    PuntoSulSegmentoChiusura(c, d, b);
        }

        private static double OrientamentoChiusura(
            Punto a,
            Punto b,
            Punto c)
        {
            return (b.X - a.X) * (c.Y - a.Y) -
                   (b.Y - a.Y) * (c.X - a.X);
        }

        private static bool PuntoSulSegmentoChiusura(
            Punto a,
            Punto b,
            Punto p)
        {
            return
                p.X >= Math.Min(a.X, b.X) - TolleranzaChiusura &&
                p.X <= Math.Max(a.X, b.X) + TolleranzaChiusura &&
                p.Y >= Math.Min(a.Y, b.Y) - TolleranzaChiusura &&
                p.Y <= Math.Max(a.Y, b.Y) + TolleranzaChiusura;
        }

        private static void LogEsitoTentativoChiusura(
            int numeroTentativo,
            string codiceMandata,
            string codiceRitorno,
            int mandataRimossi,
            bool mandataNormalizzaP,
            Punto mandataInizio,
            Punto mandataFine,
            int ritornoRimossi,
            bool ritornoNormalizzaP,
            Punto ritornoInizio,
            Punto ritornoFine,
            double lunghezzaChiusura,
            double lunghezzaMinimaChiusura,
            string esito,
            string motivo,
            string dettagli = "")
        {
            string report =
                $"attempt={numeroTentativo} " +
                $"seq={codiceMandata}/{codiceRitorno} " +
                $"outcome={esito} reason={motivo} " +
                $"supplyRemoved={mandataRimossi} " +
                $"supplyMode={(mandataNormalizzaP ? "P" : "I")} " +
                $"supplyLast=({mandataInizio.X:R},{mandataInizio.Y:R})->" +
                $"({mandataFine.X:R},{mandataFine.Y:R}) " +
                $"supplyLastLen={mandataInizio.DistanceTo(mandataFine):R} " +
                $"returnRemoved={ritornoRimossi} " +
                $"returnMode={(ritornoNormalizzaP ? "P" : "I")} " +
                $"returnLast=({ritornoInizio.X:R},{ritornoInizio.Y:R})->" +
                $"({ritornoFine.X:R},{ritornoFine.Y:R}) " +
                $"returnLastLen={ritornoInizio.DistanceTo(ritornoFine):R} " +
                $"closureLength={lunghezzaChiusura:R} " +
                $"required={lunghezzaMinimaChiusura:R}";

            if (!string.IsNullOrWhiteSpace(dettagli))
                report += " " + dettagli;

            LogChiusura("Closure.AttemptReport", report);
        }

        private static void LogChiusura(string tag, string message)
        {
            if (!TermodelLog.IsEnabled(TermodelLog.LogCategory.SpiraliDiego))
                return;

            TermodelLog.WriteLog(
                $"[SpiraliDiego][{tag}] {message}",
                TermodelLog.LogCategory.SpiraliDiego);
        }

        /// <summary>
        /// Raccorda una polilinea definitiva con archi circolari tangenti.
        /// La funzione lavora dopo Return e chiusura: non partecipa alla
        /// scelta della geometria. Se il raggio non entra nei due tratti
        /// adiacenti lo spigolo resta vivo; il raggio non viene ridotto.
        /// La discretizzazione e' adattiva sulla sagitta massima.
        /// </summary>
        public static List<Punto> raccorda_diego(
            IReadOnlyList<Punto> spezzata,
            double raggio,
            double tolleranzaDiscretizzazione,
            out Dictionary<int, int> indiceTransizionePerVertice)
        {
            const double epsilon = 0.000001;
            const double tolleranzaDuplicatiRaccordo = 0.0001;

            indiceTransizionePerVertice = new Dictionary<int, int>();

            if (spezzata == null || spezzata.Count == 0)
                return new List<Punto>();

            if (spezzata.Count < 3 ||
                raggio <= epsilon ||
                !double.IsFinite(raggio) ||
                tolleranzaDiscretizzazione <= epsilon ||
                !double.IsFinite(tolleranzaDiscretizzazione))
            {
                List<Punto> copia = Copia(spezzata);
                for (int i = 1; i < copia.Count - 1; i++)
                    indiceTransizionePerVertice[i] = i;
                return copia;
            }

            int count = spezzata.Count;
            var lunghezze = new double[count - 1];
            for (int i = 0; i < count - 1; i++)
                lunghezze[i] = spezzata[i].DistanceTo(spezzata[i + 1]);

            var raccordabile = new bool[count];
            var distanzeTangenti = new double[count];

            for (int i = 1; i < count - 1; i++)
            {
                double len1 = lunghezze[i - 1];
                double len2 = lunghezze[i];
                if (len1 <= epsilon || len2 <= epsilon)
                    continue;

                var u1 = new Punto(
                    (spezzata[i].X - spezzata[i - 1].X) / len1,
                    (spezzata[i].Y - spezzata[i - 1].Y) / len1);
                var u2 = new Punto(
                    (spezzata[i + 1].X - spezzata[i].X) / len2,
                    (spezzata[i + 1].Y - spezzata[i].Y) / len2);

                double prodotto = Math.Max(
                    -1.0,
                    Math.Min(1.0, u1.X * u2.X + u1.Y * u2.Y));
                double deviazione = Math.Acos(prodotto);
                double verso = Cross(u1, u2);

                if (deviazione <= epsilon ||
                    deviazione >= Math.PI - epsilon ||
                    Math.Abs(verso) <= epsilon)
                {
                    continue;
                }

                double distanzaTangente =
                    raggio * Math.Tan(deviazione / 2.0);
                if (!double.IsFinite(distanzaTangente) ||
                    distanzaTangente <= epsilon ||
                    distanzaTangente > len1 + epsilon ||
                    distanzaTangente > len2 + epsilon)
                {
                    continue;
                }

                raccordabile[i] = true;
                distanzeTangenti[i] = distanzaTangente;
            }

            // Due raccordi adiacenti non possono consumare piu' del segmento
            // comune. In caso di conflitto entrambi gli spigoli restano vivi:
            // non si riduce arbitrariamente il raggio.
            for (int segmento = 0; segmento < count - 1; segmento++)
            {
                int a = segmento;
                int b = segmento + 1;
                double usoA =
                    a > 0 && a < count - 1 && raccordabile[a]
                        ? distanzeTangenti[a]
                        : 0.0;
                double usoB =
                    b > 0 && b < count - 1 && raccordabile[b]
                        ? distanzeTangenti[b]
                        : 0.0;

                if (usoA + usoB > lunghezze[segmento] + epsilon)
                {
                    if (a > 0 && a < count - 1)
                        raccordabile[a] = false;
                    if (b > 0 && b < count - 1)
                        raccordabile[b] = false;
                }
            }

            var risultato = new List<Punto>();
            AggiungiSeDistintoRaccordo(
                risultato,
                spezzata[0],
                tolleranzaDuplicatiRaccordo);

            for (int i = 1; i < count - 1; i++)
            {
                Punto p0 = spezzata[i - 1];
                Punto p1 = spezzata[i];
                Punto p2 = spezzata[i + 1];

                if (!raccordabile[i])
                {
                    AggiungiSeDistintoRaccordo(
                        risultato,
                        p1,
                        tolleranzaDuplicatiRaccordo);
                    indiceTransizionePerVertice[i] = risultato.Count - 1;
                    continue;
                }

                double len1 = lunghezze[i - 1];
                double len2 = lunghezze[i];
                var u1 = new Punto(
                    (p1.X - p0.X) / len1,
                    (p1.Y - p0.Y) / len1);
                var u2 = new Punto(
                    (p2.X - p1.X) / len2,
                    (p2.Y - p1.Y) / len2);
                double distanzaTangente = distanzeTangenti[i];

                var pStart = new Punto(
                    p1.X - u1.X * distanzaTangente,
                    p1.Y - u1.Y * distanzaTangente);
                var pEnd = new Punto(
                    p1.X + u2.X * distanzaTangente,
                    p1.Y + u2.Y * distanzaTangente);

                double verso = Cross(u1, u2);
                Punto normale = verso > 0
                    ? new Punto(-u1.Y, u1.X)
                    : new Punto(u1.Y, -u1.X);
                var centro = new Punto(
                    pStart.X + normale.X * raggio,
                    pStart.Y + normale.Y * raggio);

                double angoloInizio = Math.Atan2(
                    pStart.Y - centro.Y,
                    pStart.X - centro.X);
                double angoloFine = Math.Atan2(
                    pEnd.Y - centro.Y,
                    pEnd.X - centro.X);
                double sviluppo = angoloFine - angoloInizio;

                if (verso > 0)
                {
                    while (sviluppo < 0)
                        sviluppo += 2.0 * Math.PI;
                }
                else
                {
                    while (sviluppo > 0)
                        sviluppo -= 2.0 * Math.PI;
                }

                double rapportoErrore =
                    Math.Min(1.0, tolleranzaDiscretizzazione / raggio);
                double angoloMassimo =
                    rapportoErrore >= 1.0
                        ? Math.PI
                        : 2.0 * Math.Acos(1.0 - rapportoErrore);
                if (!double.IsFinite(angoloMassimo) ||
                    angoloMassimo <= epsilon)
                {
                    angoloMassimo = Math.PI / 180.0;
                }

                int segmenti = Math.Max(
                    1,
                    (int)Math.Ceiling(
                        Math.Abs(sviluppo) / angoloMassimo));
                int segmentoTransizione =
                    (int)Math.Ceiling(segmenti / 2.0);

                AggiungiSeDistintoRaccordo(
                    risultato,
                    pStart,
                    tolleranzaDuplicatiRaccordo);

                for (int j = 1; j <= segmenti; j++)
                {
                    double angolo =
                        angoloInizio + sviluppo * j / segmenti;
                    AggiungiSeDistintoRaccordo(
                        risultato,
                        new Punto(
                            centro.X + raggio * Math.Cos(angolo),
                            centro.Y + raggio * Math.Sin(angolo)),
                        tolleranzaDuplicatiRaccordo);

                    if (j == segmentoTransizione)
                        indiceTransizionePerVertice[i] =
                            risultato.Count - 1;
                }

                if (!indiceTransizionePerVertice.ContainsKey(i))
                    indiceTransizionePerVertice[i] = risultato.Count - 1;
            }

            AggiungiSeDistintoRaccordo(
                risultato,
                spezzata[^1],
                tolleranzaDuplicatiRaccordo);

            return risultato;
        }

        public static List<Punto> raccorda_diego(
            IReadOnlyList<Punto> spezzata,
            double raggio,
            double tolleranzaDiscretizzazione)
        {
            return raccorda_diego(
                spezzata,
                raggio,
                tolleranzaDiscretizzazione,
                out _);
        }

        /// <summary>
        /// Costruisce l'offset parallelo di una spezzata rettilinea senza usare
        /// raccordi o campionamenti curvi.
        /// Distanza positiva = lato sinistro rispetto al verso della spezzata;
        /// negativa = lato destro. Agli spigoli concavi e convessi usa
        /// l'intersezione delle due rette offset adiacenti.
        /// </summary>

        public static List<Punto> ritorno_Parallelo_diego(
            IReadOnlyList<Punto> spezzata,
            double distanza)
        {
            if (spezzata == null)
                throw new ArgumentNullException(nameof(spezzata));

            if (!double.IsFinite(distanza))
                throw new ArgumentOutOfRangeException(
                    nameof(distanza),
                    "La distanza deve essere finita.");

            List<Punto> punti = EliminaDuplicatiConsecutivi(spezzata);
            if (punti.Count < 2)
                throw new ArgumentException(
                    "La spezzata deve contenere almeno due punti distinti.",
                    nameof(spezzata));

            if (Math.Abs(distanza) <= Tolleranza)
                return Copia(punti);

            var segmenti = new List<SegmentoOffset>(punti.Count - 1);
            for (int i = 0; i < punti.Count - 1; i++)
            {
                Punto a = punti[i];
                Punto b = punti[i + 1];
                double dx = b.X - a.X;
                double dy = b.Y - a.Y;
                double lunghezza = Math.Sqrt(dx * dx + dy * dy);

                if (lunghezza <= Tolleranza)
                    continue;

                double ux = dx / lunghezza;
                double uy = dy / lunghezza;

                // Normale sinistra rispetto al verso del segmento.
                double nx = -uy;
                double ny = ux;

                segmenti.Add(new SegmentoOffset(
                    new Punto(
                        a.X + nx * distanza,
                        a.Y + ny * distanza),
                    new Punto(ux, uy),
                    new Punto(nx, ny)));
            }

            if (segmenti.Count == 0)
                throw new ArgumentException(
                    "La spezzata non contiene segmenti validi.",
                    nameof(spezzata));

            var risultato = new List<Punto>
            {
                new Punto(
                    punti[0].X + segmenti[0].Normale.X * distanza,
                    punti[0].Y + segmenti[0].Normale.Y * distanza)
            };

            for (int i = 1; i < punti.Count - 1; i++)
            {
                SegmentoOffset precedente = segmenti[i - 1];
                SegmentoOffset successivo = segmenti[i];

                double cross = Cross(
                    precedente.Direzione,
                    successivo.Direzione);
                double dot =
                    precedente.Direzione.X * successivo.Direzione.X +
                    precedente.Direzione.Y * successivo.Direzione.Y;

                Punto verticeOffset;

                if (Math.Abs(cross) <= Tolleranza)
                {
                    if (dot < 0.0)
                    {
                        throw new InvalidOperationException(
                            $"Offset non definito sul vertice {i}: " +
                            "inversione di direzione prossima a 180 gradi.");
                    }

                    // Segmenti collineari nello stesso verso.
                    verticeOffset = new Punto(
                        punti[i].X + precedente.Normale.X * distanza,
                        punti[i].Y + precedente.Normale.Y * distanza);
                }
                else
                {
                    verticeOffset = IntersezioneRette(
                        precedente.OrigineOffset,
                        precedente.Direzione,
                        successivo.OrigineOffset,
                        successivo.Direzione);
                }

                AggiungiSeDistinto(risultato, verticeOffset);
            }

            SegmentoOffset ultimo = segmenti[^1];
            Punto finale = punti[^1];
            AggiungiSeDistinto(
                risultato,
                new Punto(
                    finale.X + ultimo.Normale.X * distanza,
                    finale.Y + ultimo.Normale.Y * distanza));

            return risultato;
        }

        private static Punto IntersezioneRette(
            Punto origineA,
            Punto direzioneA,
            Punto origineB,
            Punto direzioneB)
        {
            double determinante = Cross(direzioneA, direzioneB);
            if (Math.Abs(determinante) <= Tolleranza)
                throw new InvalidOperationException(
                    "Impossibile intersecare due rette parallele.");

            double deltaX = origineB.X - origineA.X;
            double deltaY = origineB.Y - origineA.Y;

            double t =
                (deltaX * direzioneB.Y - deltaY * direzioneB.X) /
                determinante;

            return new Punto(
                origineA.X + t * direzioneA.X,
                origineA.Y + t * direzioneA.Y);
        }

        private static double Cross(Punto a, Punto b) =>
            a.X * b.Y - a.Y * b.X;

        private static List<Punto> EliminaDuplicatiConsecutivi(
            IReadOnlyList<Punto> punti)
        {
            var risultato = new List<Punto>();
            foreach (Punto punto in punti)
            {
                if (punto == null ||
                    !double.IsFinite(punto.X) ||
                    !double.IsFinite(punto.Y))
                {
                    throw new ArgumentException(
                        "La spezzata contiene un punto nullo o non finito.",
                        nameof(punti));
                }

                if (risultato.Count == 0 ||
                    DistanzaQuadrata(risultato[^1], punto) >
                        Tolleranza * Tolleranza)
                {
                    risultato.Add(new Punto(punto.X, punto.Y));
                }
            }

            return risultato;
        }

        private static List<Punto> Copia(IReadOnlyList<Punto> punti)
        {
            var risultato = new List<Punto>(punti.Count);
            foreach (Punto punto in punti)
                risultato.Add(new Punto(punto.X, punto.Y));
            return risultato;
        }

        private static void AggiungiSeDistinto(
            List<Punto> punti,
            Punto candidato)
        {
            if (punti.Count == 0 ||
                DistanzaQuadrata(punti[^1], candidato) >
                    Tolleranza * Tolleranza)
            {
                punti.Add(candidato);
            }
        }

        private static double DistanzaQuadrata(Punto a, Punto b)
        {
            double dx = a.X - b.X;
            double dy = a.Y - b.Y;
            return dx * dx + dy * dy;
        }

        private static void AggiungiSeDistintoRaccordo(
            List<Punto> punti,
            Punto candidato,
            double tolleranza)
        {
            if (punti.Count == 0 ||
                punti[^1].DistanceTo(candidato) > tolleranza)
            {
                punti.Add(new Punto(candidato.X, candidato.Y));
            }
        }

        private sealed record SegmentoOffset(
            Punto OrigineOffset,
            Punto Direzione,
            Punto Normale);
    }
}
