# TERMODEL CENED — PROJECT SUMMARY

> Documento primario di continuità del progetto Cened.
>
> Ogni nuova sessione che lavora sul branch `TermodelCened` deve leggere questo file prima di proporre o modificare codice.

Ultimo aggiornamento: **2026-09-22**  
Branch di riferimento: **TermodelCened**  
Versione corrente: **0.1.1-dev**

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
│   ├── RIFERIMENTO-GESTXML-TERMODEL.md
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
│   ├── BLUMATICA-XML-001.md
│   └── BLUMATICA-APE-PREVIEW-001.md
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

È disponibile la prima bozza WebJS navigabile in `src/WebJS/index.html`.

La bozza non integra CENED+2 Motore e non esegue calcoli ufficiali.

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

## 11. Riferimento GestXml Termodel

Acquisito come riferimento non vincolante **TERMODEL-GESTXML-001** il sorgente `SorgentiTermodel/Library/GestXml.cs`.

Snapshot fornito dall'utente:
- SHA-256 `906cde73c919fa90359daae0df0c00a1a088e318e3c2b9130b293ab1e51c0736`;
- circa 2069 righe;
- sorgente usato da Termodel per costruire l'XML nazionale.

Uso consentito: fonte di ispirazione per gerarchie, mapping, classificazione confini, superfici opache/vetrate, ponti termici, orientamento/inclinazione e serializzazione.

Uso non consentito come automatismo: il file non è specifica normativa e non vincola l'architettura WebJS. Dipendenze Desktop/WPF/Xbim, stato globale e valori hard-coded non devono essere trasferiti senza verifica.

Dettagli: `docs/RIFERIMENTO-GESTXML-TERMODEL.md`.

## 12. Golden Reference anteprima APE

Acquisito come riferimento di progetto **BLUMATICA-APE-PREVIEW-001**, derivato dal file RTF prodotto da Blumatica e fornito dall'utente.

Caratteristiche:
- riferimento per contenuti, sezioni e ordine logico dell'anteprima APE WebJS;
- SHA-256 originale: `59e0300d1210a92cd31d5fe4e1e730797fa6d9ff0df6aabb61b41872de982e5f`;
- file grezzo non pubblicato per presenza di dati personali reali;
- grafica/layout Blumatica non vincolanti;
- futura stampa WebJS da marcare come `ANTEPRIMA APE — NON UFFICIALE`;
- la stampa deve derivare dallo stesso modello dati normalizzato usato per l'XML.

Dettagli: `GoldenResults/BLUMATICA-APE-PREVIEW-001.md`.

## 13. Prima bozza WebJS 0.1.1-dev

Realizzata la prima bozza navigabile in `src/WebJS/index.html`.

Funzioni presenti:
- progetto demo con dati fittizi;
- navigazione Panoramica / Dati generali / Zone e locali / Involucro / Serramenti / Ponti termici / Impianti / Risultati / Anteprima APE / XML;
- validazione preliminare di completezza;
- import locale XML nazionale;
- lettura preliminare di `ape2015` e `datiCalcolo`;
- lettura di zone, locali, superfici opache, vetrate, ponti termici e impianti;
- lettura dei risultati APE già presenti nell'XML;
- anteprima marcata `ANTEPRIMA APE — NON UFFICIALE`;
- XML dimostrativo scaricabile, esplicitamente non dichiarato conforme a CENED+2 Motore/CEER.

Verifiche:
- JavaScript della pagina compilato sintatticamente senza errori;
- parser XML provato in Chromium headless sul Golden XML fornito dall'utente;
- letti correttamente: comune Reggio di Calabria, zona B, superficie 43,3 m², volume 148,41 m³, classe F, EPgl,nren 217,04;
- rilevati 1 subEdificio, 5 locali, 39 superfici opache, 25 superfici vetrate, 184 ponti termici e 2 impianti.

Questa versione è esclusivamente una base di discussione del prodotto.

## 14. Pubblicazione WebJS 0.1.1-dev

La bozza WebJS è stata pubblicata come copia di deploy in:

`main/docs/cened-bridge/index.html`

URL pubblico previsto:

`https://www.termodel.it/cened-bridge/?v=0.1.1`

La sorgente autorevole resta:

`TermodelCened/CenedPreprocessor/src/WebJS/index.html`

Commit della copia di deploy su `main`:

`dbee4c4b78477821f2c1ff24942ba76b7d9980bc`

Nota di verifica: il contenuto pubblicato su `main` è stato verificato nel repository; l'ambiente strumenti di questa sessione non è riuscito a risolvere direttamente `www.termodel.it`, quindi la raggiungibilità HTTP esterna non è stata certificata dalla sessione.

## 15. Contratto di ingresso duale

Decisione D-0012: il Bridge richiede **due file complementari** per costruire il modello intermedio:

1. **gbXML** — fonte primaria per geometria e modello termico fisico;
2. **XML nazionale** — fonte complementare per dati italiani/APE, codifiche, impianti e altri campi non sufficientemente rappresentati dal gbXML.

Regole consolidate:
- geometria, superfici, aperture, orientamenti e cause fisiche → autorità gbXML;
- dati specifici nazionali e campi assenti dal gbXML → autorità XML nazionale;
- dati duplicati discordanti → diagnostica, nessuna scelta silenziosa;
- risultati energetici già presenti nell'XML nazionale → confronto/riferimento, non sostituzione delle cause fisiche;
- il Bridge non edita il modello tecnico: le correzioni si fanno nel software sorgente e richiedono nuova esportazione;
- il modello intermedio deve conservare la provenienza dei dati significativi.

Esempio fondamentale: un fattore mensile di ombreggiamento presente nell'XML nazionale non sostituisce la geometria dell'aggetto quando questa è necessaria al mapping successivo.

## 16. Principio formati pubblici riconosciuti

Decisione D-0013: il Bridge accetta **formati pubblici, documentati e riconosciuti**, mantenuti separati per dominio fino alla fase di import/fusione.

Prima applicazione:
- `gbXML` → geometria/modello termico fisico;
- XML nazionale → dati specifici nazionali/APE e completamento dei dati mancanti.

Il modello intermedio resta interno al Bridge e non viene imposto come formato di scambio proprietario.

L'architettura deve usare adapter per consentire in futuro l'aggiunta di altri formati pubblici riconosciuti senza cambiare il nucleo del Bridge.

## 17. Primo sample gbXML di regressione

Creato:

`samples/GBXML-ROOM-2WINDOWS-001.xml`

Caso minimo:
- gbXML 8.01;
- una stanza 4,00 × 4,00 × 3,00 m;
- area 16,00 m²;
- volume 48,00 m³;
- 6 superfici di involucro;
- due finestre da 1,00 × 1,20 m sulla parete Sud;
- area vetrata totale 2,40 m²;
- parete Sud opaca netta attesa 9,60 m²;
- una zona termica;
- costruzioni schematiche e dati interamente fittizi.

Specifiche del test:

`tests/GBXML-ROOM-2WINDOWS-001.md`

Controlli iniziali:
- 1 Space;
- 6 Surface;
- 2 Opening;
- 3 Construction;
- 1 Zone;
- nessun riferimento ID interno irrisolto.

La fixture è costruita usando elementi ed enumerazioni verificati contro lo schema pubblico gbXML 8.01. La validazione completa con il validator ufficiale gbXML verrà aggiunta alla pipeline di test.

## 18. Prossimo passo

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
