using NetTopologySuite.Geometries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static Polig3D;
using Termodel.utilities;
using static Termodel.Leggidxf.LeggiDxf;
using Xbim.Ifc4.GeometryResource;

namespace Termodel.Leggidxf
{
    static class Confini
    {
        public static List<Coordinate3D> Poligono3DAssoluto(IfcPolyline poligonoRelativo)
        {
            var output = new List<Coordinate3D>(poligonoRelativo?.Points?.Count ?? 0);
            if (poligonoRelativo?.Points == null) return output;

            foreach (var p in poligonoRelativo.Points)
            {
                var c = p.Coordinates; // IList<IfcLengthMeasure>
                double x = c.Count > 0 ? Convert.ToDouble(c[0]) : 0.0;
                double y = c.Count > 1 ? Convert.ToDouble(c[1]) : 0.0;
                double z = c.Count > 2 ? Convert.ToDouble(c[2]) : 0.0; // molti IFC 2D non hanno Z

                output.Add(new Coordinate3D(x, y, z));
            }

            return output;
        }
        private static void AggiungiNuovoPonte(
        ElementoAssociato parete,
        Coordinate3D start,
        Coordinate3D end,
        string codice,
        PosizionePonte posizione)
        {
            /*
            var nuovo = new ElementoAssociato
            {
                Tipo = TipoElemento.Ponte,
                PareteACuiAssociata = parete, // se esiste questa proprietà
                datiopaca = new TDatiSuperficieOpaca(codice, 0, 0, start, end)
                {
                    PosizioneRelativa = posizione
                }
            };
            
            ElementiAssociati.Add(nuovo);
            */
        }
        public static PosizionePonte ClassificaLatoParete(ElementoAssociato parete, Coordinate3D start, Coordinate3D end)
        {
            // Calcolo il vettore direzione
            var dx = end.X - start.X;
            var dy = end.Y - start.Y;
            var dz = end.Z - start.Z;

            // Se quasi tutto Z → Lato orizzontale verticale
            if (Math.Abs(dz) > Math.Abs(dx) && Math.Abs(dz) > Math.Abs(dy))
            {
                return dz > 0 ? PosizionePonte.Sopra : PosizionePonte.Sotto;
            }

            // Se direzione X predominante
            if (Math.Abs(dx) > Math.Abs(dy))
            {
                return dx > 0 ? PosizionePonte.Destra : PosizionePonte.Sinistra;
            }
            else
            {
                return dy > 0 ? PosizionePonte.Destra : PosizionePonte.Sinistra;
            }

            // fallback
            // return PosizioneRelativa.Manuale;
        }
        public static void GestisciPontiDopoSovrapposizione(
           ElementoAssociato par1,
           ElementoAssociato par2,
           bool sdoppiato1,
           bool sdoppiato2)
        {
            // Caso 1️⃣: entrambi sdoppiati → i ponti vanno ricalcolati sui due nuovi residui
            if (sdoppiato1 && sdoppiato2)
            {
                // Assumiamo che i nuovi residui siano gli ultimi due elementi aggiunti in ordine: prima par1, poi par2
                nuoviPoligoni[^2].AzionePonti = AzionePontiPostConfine.RielaboraPonti;  // residuo di par1
                nuoviPoligoni[^1].AzionePonti = AzionePontiPostConfine.RielaboraPonti;  // residuo di par2
            }
            // Caso 2️⃣: solo par1 è stato sdoppiato
            else if (sdoppiato1)
            {
                nuoviPoligoni[^1].AzionePonti = AzionePontiPostConfine.RielaboraPonti;  // unico residuo (par1)
                par2.AzionePonti = AzionePontiPostConfine.EliminaTuttiIPonti;
            }
            // Caso 3️⃣: solo par2 è stato sdoppiato
            else if (sdoppiato2)
            {
                nuoviPoligoni[^1].AzionePonti = AzionePontiPostConfine.RielaboraPonti;  // unico residuo (par2)
                par1.AzionePonti = AzionePontiPostConfine.EliminaTuttiIPonti;
            }
            // Caso 4️⃣: nessuno è stato sdoppiato → sovrapposizione totale
            else
            {
                par1.AzionePonti = AzionePontiPostConfine.EliminaTuttiIPonti;
                par2.AzionePonti = AzionePontiPostConfine.EliminaTuttiIPonti;
            }
        }
        public static void CorreggiPonti()
        {
            TermodelLog.WriteLog("Rielaborazioni ponti con confine",TermodelLog.LogCategory.PontiAutomatici);
            ApplicaAzioniPonti();
            TermodelLog.WriteLog("Rielaborazioni ponti in 3D", TermodelLog.LogCategory.PontiAutomatici);
            RevisioneFinalePonti();
        }
        private static void ApplicaAzioniPonti()
        {
            // Ciclo solo sulle pareti
            foreach (var parete in ElementiAssociati
                .Where(e => e.Tipo == TipoElemento.Parete)
                .ToList()) // copia per sicurezza, se modifichiamo
            {
                switch (parete.AzionePonti)
                {
                    case AzionePontiPostConfine.EliminaTuttiIPonti:
                        EliminaPonti(parete);
                        TermodelLog.LogOperation($"[Ponti] Eliminati tutti i ponti termici associati a ID: {parete.Poligono.ElementIdentifier}");
                        break;

                    case AzionePontiPostConfine.RielaboraPonti:
                        RielaboraPonti(parete);
                        TermodelLog.LogOperation($"[Ponti] Rielaborati i ponti termici per ID: {parete.Poligono.ElementIdentifier}");
                        break;

                    case AzionePontiPostConfine.Nessuna:
                    default:
                        // Nessuna azione richiesta
                        break;
                }

                // Reset finale
                parete.AzionePonti = AzionePontiPostConfine.Nessuna;
            }
        }

         private static void EliminaPonti(ElementoAssociato parete)
        {
            // Verifica che l'elemento sia una parete
            if (parete == null || parete.Tipo != TipoElemento.Parete)
                return;

            int rimossi = ElementiAssociati.RemoveAll(e =>
                e.Tipo == TipoElemento.Ponte &&
                Parete_ACuiAssociato(e) == parete);

            TermodelLog.WriteLog($"🗑️ Eliminati {rimossi} ponti termici associati alla parete {parete.Poligono.ElementIdentifier}");
        }

        public enum LatoPonte
        {
            Alto,
            Basso,
            Sinistra,
            Destra
        }

        public static void PontiAutomatici3D(
          string DescrBreve,
          double Altezza1,        // quota inferiore
          double Altezza2,        // quota superiore
          GiunzioneType giunzione,
          Modello.Line lineaBase,
          double quota,
          LatoPonte lato,         // 🔹 nuovo parametro
          PosizionePiano posizionepiano = PosizionePiano.PianoIntermedio)
        {
            if (Database.DB.ItemNessuno(DescrBreve))
                return;

            double DimPonte = 0.5;

            switch (lato)
            {
                case LatoPonte.Alto:
                    string ponteAlto = (posizionepiano == PosizionePiano.Ultimo)
                        ? Database.DB.GetDataDB("DescBreve", DescrBreve, "AltoUltimo", Database.DB.GetCollection("PontiAutomatici"))
                        : Database.DB.GetDataDB("DescBreve", DescrBreve, "Alto", Database.DB.GetCollection("PontiAutomatici"));

                    if (!Database.DB.ItemNessuno(ponteAlto))
                    {
                        Modellostatic.mod.AggiungiPonteOriz(
                            lineaBase,
                            Altezza2, Altezza2, DimPonte,
                            "Ponte automatico in alto",
                            ponteAlto
                        );
                    }
                    break;

                case LatoPonte.Basso:
                    string ponteBasso = (posizionepiano == PosizionePiano.PianoTerra)
                        ? Database.DB.GetDataDB("DescBreve", DescrBreve, "BassoTerra", Database.DB.GetCollection("PontiAutomatici"))
                        : Database.DB.GetDataDB("DescBreve", DescrBreve, "Basso", Database.DB.GetCollection("PontiAutomatici"));

                    if (!Database.DB.ItemNessuno(ponteBasso))
                    {
                        Modellostatic.mod.AggiungiPonteOriz(
                            lineaBase,
                            quota, 0, DimPonte,
                            "Ponte automatico in basso",
                            ponteBasso
                        );
                    }
                    break;

                case LatoPonte.Sinistra:
                case LatoPonte.Destra:
                    string ponteVert = null;

                    switch (giunzione)
                    {
                        case GiunzioneType.Sporgente:
                            ponteVert = Database.DB.GetDataDB("DescBreve", DescrBreve, "SpigoloPareteSporgente", Database.DB.GetCollection("PontiAutomatici"));
                            if (!Database.DB.ItemNessuno(ponteVert))
                                Modellostatic.mod.AggiungiPonteVert(quota, lineaBase.Start, lineaBase.Start, lineaBase.End, DimPonte, Altezza2, $"Ponte spigolo sporgente ({lato})", ponteVert);
                            break;

                        case GiunzioneType.Rientrante:
                            ponteVert = Database.DB.GetDataDB("DescBreve", DescrBreve, "SpigoloPareteRientrante", Database.DB.GetCollection("PontiAutomatici"));
                            if (!Database.DB.ItemNessuno(ponteVert))
                                Modellostatic.mod.AggiungiPonteVert(quota, lineaBase.Start, lineaBase.Start, lineaBase.End, DimPonte, Altezza2, $"Ponte spigolo rientrante ({lato})", ponteVert);
                            break;

                        case GiunzioneType.Piana:
                            ponteVert = Database.DB.GetDataDB("DescBreve", DescrBreve, "GiunzioneParetePiana", Database.DB.GetCollection("PontiAutomatici"));
                            if (!Database.DB.ItemNessuno(ponteVert))
                                Modellostatic.mod.AggiungiPonteVert(quota, lineaBase.Start, lineaBase.Start, lineaBase.End, DimPonte, Altezza2, $"Ponte giunzione piana ({lato})", ponteVert);
                            break;
                    }
                    break;
            }
        }




        public static void RielaboraPonti(ElementoAssociato parete)
        {
            TermodelLog.WriteLog($"♻️ Rigenerazione ponti termici associati alla parete {parete.Poligono.ElementIdentifier}");

            // 1️⃣ Verifica che sia una parete
            if (parete == null || parete.Tipo != TipoElemento.Parete)
                return;

            // 2️⃣ Elimina ponti esistenti
            EliminaPonti(parete);
            TermodelLog.WriteLog($"Eliminati i ponti della parete:",TermodelLog.LogCategory.PontiAutomatici);

            // 3️⃣ Recupera i punti del poligono in coordinate assolute 3D
            var punti = Poligono3DAssoluto(parete.Poligono.Poligono);
            if (punti == null || punti.Count < 2)
                return;

            // 4️⃣ Imposta la parete corrente (necessaria per AggiungiPonte...)
            Polig3D.Parete_Corrente = parete;

            // 5️⃣ Parametri comuni
            string descrBreve = parete.datiopaca?.Codice ?? "Default";
            double quotaBase = parete.Poligono.QuotaCorrente;
            double altezzaParete = parete.datiopaca?.Altezza ?? 3.0; // fallback
            double altezzaTop = quotaBase + altezzaParete;

            // 6️⃣ Cicla i lati del poligono
            for (int i = 0; i < punti.Count - 1; i++)
            {
                var start = punti[i];
                var end = punti[i + 1];
                var posizione = ClassificaLatoParete(parete, start, end);

                var lineaBase = new Modello.Line(
                    new Coordinate(start.X, start.Y),
                    new Coordinate(end.X, end.Y)
                );

                switch (posizione)
                {
                    case PosizionePonte.Sopra:
                        PontiAutomatici3D(
                            descrBreve,
                            quotaBase,
                            altezzaTop,
                            GiunzioneType.Piana, // orizzontale = piana
                            lineaBase,
                            quotaBase,
                            LatoPonte.Alto
                        );
                        TermodelLog.WriteLog($"[Ponte] Orizzontale Sopra aggiunto", TermodelLog.LogCategory.PontiAutomatici);
                        break;

                    case PosizionePonte.Sotto:
                        PontiAutomatici3D(
                            descrBreve,
                            quotaBase,
                            altezzaTop,
                            GiunzioneType.Piana,
                            lineaBase,
                            quotaBase,
                            LatoPonte.Basso
                        );
                        TermodelLog.WriteLog($"[Ponte] Orizzontale Sotto aggiunto", TermodelLog.LogCategory.PontiAutomatici);
                        break;

                    case PosizionePonte.Sinistra:
                        var giunzionePrima = parete.datiopaca?.AngoloPrima ?? GiunzioneType.Piana;
                        PontiAutomatici3D(
                            descrBreve,
                            quotaBase,
                            altezzaTop,
                            giunzionePrima,
                            lineaBase,
                            quotaBase,
                            LatoPonte.Sinistra
                        );
                        TermodelLog.WriteLog($"[Ponte] Verticale sinistra (giunzione {giunzionePrima})", TermodelLog.LogCategory.PontiAutomatici);
                        break;

                    case PosizionePonte.Destra:
                        var giunzioneDopo = parete.datiopaca?.AngoloDopo ?? GiunzioneType.Piana;
                        PontiAutomatici3D(
                            descrBreve,
                            quotaBase,
                            altezzaTop,
                            giunzioneDopo,
                            lineaBase,
                            quotaBase,
                            LatoPonte.Destra
                        );
                        TermodelLog.WriteLog($"[Ponte] Verticale destra (giunzione {giunzioneDopo})", TermodelLog.LogCategory.PontiAutomatici);
                        break;

                    default:
                        TermodelLog.WriteLog($"[Ponte] Lato non classificato → nessun ponte generato", TermodelLog.LogCategory.PontiAutomatici);
                        break;
                }
            }
        }

        public static void RevisioneFinalePonti()
        {
            TermodelLog.WriteLog("🔍 Revisione finale dei ponti termici (2 pass: balconi → duplicati)");

            // Snapshot iniziale
            var tuttiPonti = ElementiAssociati
                .Where(e => e.Tipo == TipoElemento.Ponte)
                .ToList();

            // --- PASSO 1: sostituzione con ponti BALCONE ---
            var pontiBalcone = tuttiPonti.Where(IsPonteBalcone).ToList();
            var pontiReali = tuttiPonti.Where(p => !IsPonteBalcone(p)).ToList();

            if (pontiBalcone.Count > 0 && pontiReali.Count > 0)
            {
                var toRemove = new HashSet<ElementoAssociato>();
                var toAdd = new List<ElementoAssociato>();

                // (opzionale) semplice filtro per quota/piano se disponibile:
                // var bucketsBalcone = pontiBalcone.GroupBy(b => b.Poligono.QuotaCorrente).ToDictionary(...);

                foreach (var reale in pontiReali)
                {
                    if (toRemove.Contains(reale)) continue;

                    var a1 = reale?.datiopaca?.Start;
                    var a2 = reale?.datiopaca?.End;
                    if (a1 == null || a2 == null) continue;

                    // Candidati: qui lineare; se serve performance, usa indice spaziale XY
                    foreach (var balc in pontiBalcone)
                    {
                        var b1 = balc?.datiopaca?.Start;
                        var b2 = balc?.datiopaca?.End;
                        if (b1 == null || b2 == null) continue;

                        // Overlap robusto in XY (solo orizzontali): usa Inters3D
                        if (!Inters3D.SegmentsOverlap3D(a1, a2, b1, b2, Inters3D.Tolerances.Default, out var ovLen, out var kind))
                            continue;

                        if (kind != Inters3D.OverlapKind.HorizontalXY || ovLen <= Inters3D.Tolerances.Default.APR)
                            continue;

                        // Calcolo estremi del tratto comune in coordinate 3D (Z coerente con il ponte reale)
                        if (!TryComputeOverlapSegmentXY(a1, a2, b1, b2, Inters3D.Tolerances.Default.APR, out var o1, out var o2))
                            continue;

                        // Classifica: totale vs parziale
                        bool coperturaTotale = IsCoveredWithinAPR(a1, a2, o1, o2, Inters3D.Tolerances.Default.APR);

                        if (coperturaTotale)
                        {
                            // Sostituzione totale: rimuovi reale, aggiungi ponte balcone equivalente al tratto (o clone codificato balcone)
                            var balconeEq = CreaPonteBalconeDaTratto(balc, reale, o1, o2);
                            if (balconeEq != null)
                            {
                                toRemove.Add(reale);
                                toAdd.Add(balconeEq);
                                TermodelLog.WriteLog($"[Balcone] Sostituzione TOTALE ponte {reale.Poligono.ElementIdentifier} con balcone (len={ovLen:0.###})");
                            }
                            // Un ponte reale completamente coperto non ha senso continuare a processarlo con altri balconi
                            break;
                        }
                        else
                        {
                            // Sostituzione PARZIALE: split del ponte reale → residuo/i + tratto balcone
                            var (resL, resR) = CreaResiduiDaTaglio(reale, o1, o2, Inters3D.Tolerances.Default.APR);
                            var balconePart = CreaPonteBalconeDaTratto(balc, reale, o1, o2);

                            // Accumula modifiche (sostituzione atomica a fine passata)
                            toRemove.Add(reale);
                            if (resL != null) toAdd.Add(resL);
                            if (resR != null) toAdd.Add(resR);
                            if (balconePart != null) toAdd.Add(balconePart);

                            TermodelLog.WriteLog($"[Balcone] Sostituzione PARZIALE ponte {reale.Poligono.ElementIdentifier} (overlap={ovLen:0.###})", TermodelLog.LogCategory.PontiAutomatici);
                            // Nota: non faccio break per consentire più balconi sullo stesso ponte reale; 
                            // se vuoi “un solo balcone per ponte”, decommenta il break
                            // break;
                        }
                    }
                }

                // Applica modifica batch
                if (toRemove.Count > 0 || toAdd.Count > 0)
                {
                    ElementiAssociati.RemoveAll(e => toRemove.Contains(e));
                    ElementiAssociati.AddRange(toAdd);
                    TermodelLog.WriteLog($"[Balcone] Applicate sostituzioni: -{toRemove.Count} +{toAdd.Count}", TermodelLog.LogCategory.PontiAutomatici);
                }
            }
            
            // --- PASSO 2: gestione duplicati/sovrapposti residui (logica esistente) ---
            // Ricalcola snapshot dopo le sostituzioni balcone
            tuttiPonti = ElementiAssociati.Where(e => e.Tipo == TipoElemento.Ponte).ToList();

            foreach (var ponte in tuttiPonti)
            {
                // Escludi i ponti balcone dalla ripartizione duplicati (se vuoi)
                if (IsPonteBalcone(ponte)) continue;

                var sovrapposti = tuttiPonti
                    .Where(p => p != ponte && !IsPonteBalcone(p) && PontiSiSovrappongono(ponte, p))
                    .ToList();

                if (sovrapposti.Count == 0) continue;

                if (TuttiSimili(ponte, sovrapposti))
                {
                    double attrib =sovrapposti.Count + 1;
                    ponte.datiopaca.Attribuzione = attrib;
                    foreach (var dup in sovrapposti)
                        dup.datiopaca.Attribuzione = attrib;

                    TermodelLog.WriteLog($"[Duplicati] Ponte {ponte.Poligono.ElementIdentifier} attribuito {attrib}", TermodelLog.LogCategory.PontiAutomatici);
                }
                // (altri casi rimangono come in futuro/estensioni)
            }
            
        }
        private static bool TuttiSimili(ElementoAssociato ponteBase, List<ElementoAssociato> lista)
        {
 
            var tipoBase = ponteBase.datiopaca.Codice;

            foreach (var p in lista)
            {
                var tipo = p.datiopaca.Codice;
                if (!string.Equals(tipo, tipoBase, StringComparison.OrdinalIgnoreCase))
                {
                    TermodelLog.WriteLog($"[Duplicati] Tipologia diversa rilevata: base={tipoBase}, found={tipo} (provvisorio: accetto comunque).");
                }
            }

            // Provvisorio: accetta sempre come "simili"
            return true;
        }

        /* ===================== Helper specifici BALCONE (stub) ===================== */

        // Riconoscimento ponte balcone (adegua alla tua struttura dati)
        private static bool IsPonteBalcone(ElementoAssociato e)
        {
        return e.datiopaca.Balcone ;
        }

        // Verifica se il tratto [o1,o2] copre interamente [a1,a2] entro APR (sull’asse principale in XY)
        private static bool IsCoveredWithinAPR(Coordinate3D a1, Coordinate3D a2, Coordinate3D o1, Coordinate3D o2, double apr)
        {
            bool useX = Math.Abs(a2.X - a1.X) >= Math.Abs(a2.Y - a1.Y);
            (double amin, double amax) = Project(a1, a2, useX);
            (double omin, double omax) = Project(o1, o2, useX);
            return (omin <= amin + apr) && (omax >= amax - apr);
        }

        // Calcola gli estremi del segmento di overlap in XY tra AB (reale) e CD (balcone)
        // Restituisce i punti 3D con Z interpolata linearmente lungo AB (Z di riferimento del ponte reale)
        private static bool TryComputeOverlapSegmentXY(
            Coordinate3D a1, Coordinate3D a2,
            Coordinate3D b1, Coordinate3D b2,
            double apr,
            out Coordinate3D o1, out Coordinate3D o2)
        {
            o1 = o2 = null;

            bool useX = Math.Abs(a2.X - a1.X) >= Math.Abs(a2.Y - a1.Y);
            (double amin, double amax) = Project(a1, a2, useX);
            (double bmin, double bmax) = Project(b1, b2, useX);

            double lo = Math.Max(amin, bmin);
            double hi = Math.Min(amax, bmax);
            if (hi - lo <= apr) return false;

            // Parametrizza AB sull’asse scelto
            double aRange = amax - amin;
            if (aRange <= double.Epsilon) return false;

            double t1 = (lo - amin) / aRange;
            double t2 = (hi - amin) / aRange;
            t1 = Math.Max(0, Math.Min(1, t1));
            t2 = Math.Max(0, Math.Min(1, t2));

            o1 = Lerp3D(a1, a2, t1);
            o2 = Lerp3D(a1, a2, t2);
            // Normalizza Z “orizzontale”: se ΔZ di AB è piccolo, allinea a media
            if (Math.Abs(a2.Z - a1.Z) <= apr)
            {
                double zflat = 0.5 * (a1.Z + a2.Z);
                o1 = new Coordinate3D(o1.X, o1.Y, zflat);
                o2 = new Coordinate3D(o2.X, o2.Y, zflat);
            }
            return true;
        }

        // Crea due residui del ponte reale tagliato dal tratto [cut1,cut2]; ritorna (sinistra, destra) se > APR
        private static (ElementoAssociato left, ElementoAssociato right) CreaResiduiDaTaglio(
            ElementoAssociato ponteReale,
            Coordinate3D cut1, Coordinate3D cut2,
            double apr)
        {
            var a1 = ponteReale.datiopaca.Start;
            var a2 = ponteReale.datiopaca.End;

            // Ordina lungo AB
            bool useX = Math.Abs(a2.X - a1.X) >= Math.Abs(a2.Y - a1.Y);
            var (amin, amax) = Project(a1, a2, useX);
            var (cmin, cmax) = Project(cut1, cut2, useX);

            // ricava punti ordinati rispetto ad A→B
            Coordinate3D pStart = (Val(useX, cut1) < Val(useX, cut2)) ? cut1 : cut2;
            Coordinate3D pEnd = (pStart == cut1) ? cut2 : cut1;

            ElementoAssociato left = null, right = null;

            // Residuo sinistro: [A, pStart]
            if (Val(useX, pStart) - amin > apr)
                left = CreaPonteRealeDaTratto(ponteReale, a1, pStart);

            // Residuo destro: [pEnd, B]
            if (amax - Val(useX, pEnd) > apr)
                right = CreaPonteRealeDaTratto(ponteReale, pEnd, a2);

            return (left, right);
        }

        // Crea nuovo ponte BALCONE sul tratto [s,e], ereditando i riferimenti utili (parete, locale, ecc.)
        private static ElementoAssociato CreaPonteBalconeDaTratto(ElementoAssociato sorgenteBalcone, ElementoAssociato ponteReale, Coordinate3D s, Coordinate3D e)
        {
            // TODO: implementa la costruzione concreta secondo le tue classi/costruttori.
            // Linee guida:
            // - Tipologia = Balcone
            // - ParetePadre = ponteReale.ParetePadre (per report per parete)
            // - CodiceArchivio = da sorgenteBalcone (archivio "PontiAutomatici")
            // - Attribuzione = 1.0
            // - Start/End = s,e
            return ClonaPonteConNuoviEstremi(sorgenteBalcone, ponteReale, s, e, isBalcone: true);
        }

        // Crea nuovo ponte REALE sul tratto [s,e], copiando metadati dal ponteReale
        private static ElementoAssociato CreaPonteRealeDaTratto(ElementoAssociato ponteReale, Coordinate3D s, Coordinate3D e)
        {
            return ClonaPonteConNuoviEstremi(ponteReale, ponteReale, s, e, isBalcone: false);
        }

        /* ===================== Utility geometriche minime ===================== */
        private static (double min, double max) Project(Coordinate3D s, Coordinate3D e, bool useX)
        {
            double a = useX ? s.X : s.Y;
            double b = useX ? e.X : e.Y;
            return (Math.Min(a, b), Math.Max(a, b));
        }
        private static double Val(bool useX, Coordinate3D p) => useX ? p.X : p.Y;

        private static Coordinate3D Lerp3D(Coordinate3D a, Coordinate3D b, double t)
        {
            return new Coordinate3D(
                a.X + (b.X - a.X) * t,
                a.Y + (b.Y - a.Y) * t,
                a.Z + (b.Z - a.Z) * t
            );
        }

        /* ===================== Stub di costruzione (da collegare al tuo modello) ===================== */
        private static ElementoAssociato ClonaPonteConNuoviEstremi(
            ElementoAssociato sorgente,
            ElementoAssociato padrePerRiferimenti,
            Coordinate3D start,
            Coordinate3D end,
            bool isBalcone)
        {
            // ⚠️ Implementa in base alle tue classi:
            // - crea nuovo ElementoAssociato Tipo=Ponte
            // - copia metadati da 'sorgente' (codice archivio; se isBalcone, quelli del balcone)
            // - PareteACuiAssociata = padrePerRiferimenti.PareteACuiAssociata (o come chiami la proprietà)
            // - datiopaca.Start = start; datiopaca.End = end;
            // - datiopaca.Attribuzione = isBalcone ? 1.0 : padrePerRiferimenti.datiopaca.Attribuzione;
            // - marca Provenienza = isBalcone ? "Balcone" : "Reale"
            // Restituisci l'istanza.
            return null;
        }

        private static bool PontiSiSovrappongono(ElementoAssociato p1, ElementoAssociato p2, double tolleranza = 0.01)
{
    if (p1?.datiopaca == null || p2?.datiopaca == null) return false;

    var a1 = p1.datiopaca.Start; var a2 = p1.datiopaca.End;
    var b1 = p2.datiopaca.Start; var b2 = p2.datiopaca.End;

    var tol = Inters3D.Tolerances.Default;
    tol.APR = tolleranza;  // mantieni retrocompatibilità del parametro

    return Inters3D.SegmentsOverlap3D(a1, a2, b1, b2, tol, out _, out _);
}

    }
}
