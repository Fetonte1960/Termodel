# TERMODEL CENED — PROJECT SUMMARY

> Documento primario di continuità del progetto Cened.
>
> Ogni nuova sessione che lavora sul branch `TermodelCened` deve leggere questo file prima di proporre o modificare codice.

Ultimo aggiornamento: **2026-09-22**  
Branch di riferimento: **TermodelCened**  
Versione iniziale di progetto: **0.1.0-dev**

---

## 1. Obiettivo

Realizzare un **Software Bridge per modelli termici** con identità propria, capace di importare dati da formati standard, normalizzarli, presentarli per verifica e integrarli con **CENED+2 Motore**.

Dal punto di vista ARIA/CENED, la versione che utilizza realmente CENED+2 Motore è un **Client di terze parti integrato con CENED+2 Motore** e deve seguire il relativo percorso di autorizzazione.

Il prodotto viene sviluppato in parallelo in due versioni:

1. **WebJS**, online e sperimentale, pubblicabile su termodel.it;
2. **Desktop**, destinata al reale percorso di autorizzazione ARIA.

L'obiettivo architetturale è mantenere le due versioni semanticamente equivalenti mediante specifiche, casi prova e Golden Results condivisi.

## 2. Flusso prodotto

```text
Termodel / altri software / formati standard
        ↓
importazione e normalizzazione
        ↓
modello termico intermedio strutturato
        ↓
presentazione e validazione dati
        ↓
CENED+2 Motore
        ↓
calcolo
        ↓
XML conforme per CEER
        ↓
anteprima APE non ufficiale
```

Termodel è una possibile sorgente dei dati, non il componente da sottoporre ad autorizzazione.

Il formato intermedio deve avere identità propria e non dipendere dall'interfaccia grafica di Termodel.

## 3. Vincoli ARIA verificati

Verifica effettuata il **22/09/2026** sulle Condizioni d'uso CENED, revisione **01/09/2026**, e sulla documentazione ufficiale CENED+2 disponibile.

Punti consolidati:
- CENED+2 Motore è integrabile con Client di terze parti conformi alle specifiche O.d.A.;
- l'uso del Motore da parte di terzi è subordinato ad autorizzazione;
- il Client autorizzato genera tramite il Motore XML conformi per il CEER;
- la riproduzione grafica dell'interfaccia CENED+2 Client è consentita esclusivamente a fini didattici;
- il Bridge avrà quindi una UI originale, pur mantenendo un'organizzazione funzionale dei dati comprensibile a chi usa CENED;
- l'anteprima APE del Bridge è un fac-simile di controllo e non sostituisce l'APE ufficiale del flusso CEER;
- una major release del Client richiede nuova autodichiarazione di conformità; aggiornamenti del Motore possono richiedere riallineamento/autorizzazione.

## 4. Struttura

```text
CenedPreprocessor/
├── PROJECT-SUMMARY-CENED.md
├── README.md
├── VERSION.txt
├── docs/
│   ├── COMMISSIONI.md
│   ├── DECISIONI.md
│   ├── ARCHITETTURA.md
│   └── CERTIFICAZIONE.md
├── spec/
│   └── README.md
├── src/
│   ├── WebJS/
│   │   └── README.md
│   └── Desktop/
│       └── README.md
├── tests/
│   └── README.md
├── GoldenResults/
│   └── README.md
└── samples/
    └── README.md
```

## 5. Regola commissioni

Prima di ogni intervento:
1. leggere questo summary;
2. verificare lo stato reale del branch e i commit successivi;
3. registrare l'incarico in `docs/COMMISSIONI.md` come `COMMISSIONATO`;
4. rileggere i file coinvolti prima di modificarli.

Dopo l'intervento:
1. verificare le modifiche;
2. eseguire i test disponibili;
3. aggiornare questo summary quando cambiano architettura o stato;
4. cambiare la commissione in `ESEGUITO`;
5. indicare commit/versione risultante.

Le deliberazioni architetturali consolidate vengono registrate separatamente in `docs/DECISIONI.md`.

## 6. Versionamento

Ogni versione software deve avere un numero esplicito.

La fonte iniziale è `VERSION.txt`. WebJS e Desktop dovranno mostrare la versione nelle rispettive caption/interfacce.

Il versionamento è anche rilevante per il percorso ARIA: le major release richiedono nuova autodichiarazione di conformità; le minor release devono essere valutate con attenzione quando possono influire sui risultati.

## 7. Stato corrente

Completati:
- struttura Git iniziale;
- definizione del prodotto come Software Bridge;
- distinzione tra identità commerciale "Bridge" e ruolo regolatorio di Client CENED+2 di terze parti;
- vincolo di UI originale;
- distinzione tra anteprima APE e APE ufficiale CEER;
- dossier iniziale di autorizzazione.

Non è ancora implementata alcuna trasformazione verso input CENED+2 Motore.

## 8. Prossimo passo

Studiare e documentare con precisione le **specifiche tecniche riservate agli Utenti Motore CENED+**, con priorità a:
- invocazione del Motore;
- schema e campi richiesti;
- validazioni;
- produzione XML;
- casi studio ufficiali;
- costruzione del primo caso prova riproducibile.

Da questo studio nascerà la **specifica intermedia autorevole** in `spec/`.
