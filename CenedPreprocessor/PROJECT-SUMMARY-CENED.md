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

### Fase attiva dal 2026-09-22

Da questa data **si sviluppa e si discute esclusivamente la versione WebJS**.

- **WebJS** è l'unica linea attiva di implementazione, studio e prototipazione.
- **Desktop** resta sospesa e non deve essere modificata o sviluppata fino a nuova decisione esplicita.
- Il percorso Desktop/autorizzazione ARIA resta documentato come obiettivo futuro.
- Specifiche, modelli dati, test e Golden Results continuano a essere progettati in modo riutilizzabile, ma senza sviluppo parallelo obbligatorio della versione Desktop.

Questa fase sospende operativamente la precedente impostazione a due implementazioni parallele senza cancellarla dallo storico decisioni.

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
│   ├── CERTIFICAZIONE.md
│   ├── RIFERIMENTI-CENED.md
│   └── STUDIO-FATTIBILITA-MOTORE-CENED.md
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
│   ├── README.md
│   └── BLUMATICA-XML-001.md
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

**Fase attiva:** sviluppo e discussione esclusivamente WebJS. La linea Desktop è sospesa.

Completati:
- struttura Git iniziale;
- definizione del prodotto come Software Bridge;
- distinzione tra identità commerciale "Bridge" e ruolo regolatorio di Client CENED+2 di terze parti;
- vincolo di UI originale;
- distinzione tra anteprima APE e APE ufficiale CEER;
- dossier iniziale di autorizzazione.

Non è ancora implementata alcuna trasformazione verso input CENED+2 Motore.

## 8. Studio fattibilità Motore CENED

Completato lo studio in sola lettura `docs/STUDIO-FATTIBILITA-MOTORE-CENED.md`.

Conclusioni consolidate:
- fattibilità tecnica alta per un'integrazione mediante processo Java separato;
- il Core C# deve restare privo di dipendenze Java/JAR proprietarie;
- il WebService dovrà eventualmente orchestrare un runner Java esterno e isolato;
- la prima strategia deve usare una JVM per elaborazione finché thread safety e stato globale non siano verificati;
- la versione 1.1.14 installata può essere usata per studio, ma il riferimento corrente ARIA è CENED+2 1.1.15;
- il kit Motore 1.1.15 e le specifiche riservate agli Utenti Motore sono il riferimento da acquisire prima del prototipo;
- non è ancora dimostrato il funzionamento headless;
- non è ancora completo l'inventario delle dipendenze e della configurazione Spring perché questa sessione non ha accesso al filesystem locale e le specifiche tecniche complete sono riservate;
- nessuna modifica è stata apportata a Termodel.Core, WebService, frontend o definizionedati.json.

## 9. Riferimenti permanenti CENED

È stato creato `docs/RIFERIMENTI-CENED.md` come indice permanente dei riferimenti ufficiali ARIA/CENED.

Contiene:
- pagina ufficiale del Manuale d'uso Software CENED+2.0;
- link diretti a Copertina/Indice e Moduli A-F;
- pagina ufficiale Software CENED+2.0;
- pagina generale Download;
- nota sulla versione del manuale e distinzione dalla versione software corrente;
- priorità dei moduli per lo sviluppo del Software Bridge.

Regola: per future analisi funzionali del Client partire da questo file prima di eseguire nuove ricerche Web.

## 10. Golden Reference XML nazionale

Acquisito come riferimento di progetto **BLUMATICA-XML-001**, derivato dal file `output.xml` fornito dall'utente e dichiarato importato con successo in Blumatica.

Caratteristiche:
- XML ben formato;
- struttura principale `<documento><ape2015>...<datiCalcolo>...`;
- riferimento per l'output XML nazionale/interoperabile della WebJS;
- SHA-256 originale: `4988a0700ad1aeb60ef6906235411a176baee514f7a902533dfcc1ad86980647`;
- file grezzo non pubblicato nel repository perché contiene dati personali reali e il repository è pubblico;
- metadati e struttura registrati in `GoldenResults/BLUMATICA-XML-001.md`.

Regola: la compatibilità con Blumatica e la struttura XML nazionale restano concetti distinti dalla futura integrazione specifica con CENED+2 Motore.

## 11. Prossimo passo

Proseguire esclusivamente sulla **versione WebJS** come ambiente di studio e discussione del Software Bridge.

Priorità:
- struttura dell'interfaccia WebJS;
- mapping dei dati importati verso le sezioni funzionali CENED;
- modello intermedio comune;
- utilizzo del Manuale CENED+2 come riferimento operativo;
- prototipi Web per import, verifica dati, anteprima del flusso di calcolo/XML/APE.

Lo studio delle **specifiche tecniche riservate agli Utenti Motore CENED+** resta importante, ma non autorizza ancora sviluppo Desktop, runner Java o modifiche al Service.

Quando verrà riattivata la linea certificabile, le priorità tecniche saranno:
- invocazione del Motore;
- schema e campi richiesti;
- validazioni;
- produzione XML;
- casi studio ufficiali;
- costruzione del primo caso prova riproducibile.

Da questo studio nascerà la **specifica intermedia autorevole** in `spec/`.
