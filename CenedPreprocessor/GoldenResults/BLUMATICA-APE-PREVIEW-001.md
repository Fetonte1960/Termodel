# Golden Reference — Anteprima APE Blumatica

Identificativo: **BLUMATICA-APE-PREVIEW-001**  
Data acquisizione: **2026-09-22**  
File originale fornito: `ape (linee guida 2015) del 05-12-2023_16-10.rtf`  
Stato: **RIFERIMENTO ESTERNO ACQUISITO — FILE GREZZO NON PUBBLICATO**

## 1. Provenienza e funzione

L'utente ha fornito un documento RTF prodotto da **Blumatica** come esempio di stampa/anteprima APE.

Il documento viene assunto come **Golden Reference di presentazione e contenuto** per la futura funzione WebJS di anteprima APE.

Non costituisce:
- specifica grafica vincolante;
- prova di conformità CENED Lombardia;
- modello da copiare pixel-per-pixel;
- APE ufficiale depositato.

## 2. Integrità del file originale

- formato: RTF
- dimensione: **3113990 byte**
- SHA-256: **59e0300d1210a92cd31d5fe4e1e730797fa6d9ff0df6aabb61b41872de982e5f**

Il digest SHA-256 identifica in modo univoco lo snapshot originale fornito.

## 3. Struttura funzionale rilevata

Il documento segue la struttura nazionale APE prevista dalle linee guida 2015 e contiene, in sequenza:

1. **Copertina / intestazione**
   - area geografica;
   - ubicazione;
   - proprietà;
   - progettista/costruttore;
   - tecnico;
   - codice certificato;
   - data elaborazione.

2. **Dati generali**
   - destinazione d'uso;
   - classificazione DPR 412/93;
   - oggetto dell'attestato;
   - motivazione;
   - dati identificativi;
   - coordinate GIS;
   - zona climatica;
   - anno costruzione;
   - superfici e volumi;
   - dati catastali;
   - servizi energetici presenti.

3. **Prestazione energetica globale e del fabbricato**
   - qualità inverno;
   - qualità estate;
   - classe energetica;
   - EPgl,nren;
   - riferimenti edificio nuovo/simile.

4. **Prestazione energetica degli impianti e consumi stimati**
   - fonti energetiche;
   - consumi annui;
   - EPgl,nren;
   - EPgl,ren;
   - emissioni CO2.

5. **Raccomandazioni**
   - codici REN1–REN6;
   - tipo intervento;
   - ristrutturazione importante;
   - tempo di ritorno;
   - classe raggiungibile.

6. **Altri dati energetici generali**
   - energia esportata;
   - vettore energetico.

7. **Dati di dettaglio del fabbricato**
   - volume riscaldato;
   - superficie disperdente;
   - rapporto S/V;
   - EPH,nd;
   - Asol,est/Asup,utile;
   - YIE.

8. **Dati di dettaglio degli impianti**
   - servizio energetico;
   - tipo impianto;
   - anno installazione;
   - codice catasto impianti;
   - vettore;
   - potenza;
   - efficienza;
   - EPren;
   - EPnren.

9. **Informazioni sul miglioramento della prestazione energetica**

10. **Soggetto certificatore**
    - tipologia soggetto;
    - dati professionali;
    - dichiarazione di indipendenza;
    - informazioni aggiuntive.

11. **Sopralluoghi e dati di ingresso**
    - conferma del sopralluogo obbligatorio.

12. **Software utilizzato**
    - rispondenza ai requisiti;
    - metodo semplificato;
    - dichiarazioni finali;
    - data emissione e firma.

13. **Note esplicative**
    - spiegazione della prima pagina;
    - spiegazione della seconda pagina;
    - spiegazione della terza pagina;
    - legenda delle raccomandazioni REN1–REN6.

## 4. Valore per la WebJS

La WebJS dovrà usare questo documento come riferimento per progettare la funzione **Anteprima APE**, con i seguenti obiettivi:

- mostrare all'utente una rappresentazione leggibile dell'APE prima dell'eventuale deposito ufficiale;
- utilizzare i dati già presenti nel modello/intermediate model;
- distinguere chiaramente dati di input, risultati di calcolo e dati del certificatore;
- organizzare le informazioni in sezioni coerenti con l'APE nazionale;
- permettere una futura esportazione/stampa PDF o equivalente;
- mantenere una grafica originale del Software Bridge.

## 5. Relazione con BLUMATICA-XML-001

`BLUMATICA-XML-001` è il riferimento per la struttura XML nazionale.

`BLUMATICA-APE-PREVIEW-001` è il riferimento per la presentazione/stampa APE.

La futura catena WebJS dovrà essere concettualmente:

```text
modello intermedio
      ↓
dati APE + datiCalcolo
      ↓
XML nazionale
      ↓
view model APE
      ↓
Anteprima APE
```

La stampa non deve essere costruita leggendo direttamente l'XML in modo fragile: è preferibile derivare sia XML sia anteprima dallo stesso modello dati normalizzato.

## 6. Elementi da non copiare automaticamente

Non assumere come vincolanti:
- font;
- spaziature;
- impaginazione esatta;
- loghi;
- elementi grafici specifici di Blumatica;
- scelte tipografiche;
- testo accessorio non richiesto dalle fonti ufficiali;
- posizione pixel-per-pixel dei campi.

Il riferimento serve per **contenuti, sezioni, ordine logico e leggibilità**, non per clonare l'interfaccia o il layout proprietario.

## 7. Privacy e repository pubblico

Il documento originale contiene dati personali e professionali reali.

Poiché il repository è pubblico:
- l'RTF originale non viene pubblicato;
- non vengono riportati nel repository nomi, email, telefono e indirizzi reali;
- il file è identificato soltanto tramite metadati e hash;
- eventuali mockup futuri dovranno usare dati fittizi.

## 8. Regola futura per la bozza WebJS

La prima anteprima APE WebJS dovrà essere classificata chiaramente come:

**ANTEPRIMA APE — NON UFFICIALE**

e dovrà essere confrontata con questo riferimento almeno per:
- presenza delle sezioni;
- gerarchia dei contenuti;
- leggibilità;
- coerenza dei valori;
- completezza dei dati disponibili.

La compatibilità grafica con Blumatica non è un obiettivo.
