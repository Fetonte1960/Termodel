# Registro commissioni — Termodel Cened

Regola: ogni incarico viene registrato prima dell'esecuzione come `COMMISSIONATO` e, a lavoro completato e verificato, aggiornato a `ESEGUITO`.

## CENED-0001 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** creare la struttura Git iniziale del preprocessore Cened nel branch dedicato `TermodelCened`.

**Decisioni già consolidate:**
- il preprocessore Cened è un prodotto con identità propria, distinto da Termodel;
- sviluppo parallelo in due versioni: Web JavaScript pubblicabile online e Desktop destinata al percorso reale di certificazione;
- le due versioni devono condividere specifiche, casi prova e risultati attesi;
- il preprocessore deve trasformare un modello termico strutturato in input idoneo al motore Cened, senza rendere Termodel parte del perimetro di certificazione;
- ogni versione software avrà numero di versione esplicito e coerente nelle caption;
- tutte le decisioni e commissioni significative devono essere tracciate nel repository.

**Ambito eseguito:**
1. creato il branch `TermodelCened` da `main`;
2. creata la struttura base in `CenedPreprocessor/`;
3. creato `PROJECT-SUMMARY-CENED.md`;
4. creati registro commissioni e storico decisioni;
5. predisposte le aree `spec`, `src/WebJS`, `src/Desktop`, `tests`, `GoldenResults`, `samples`;
6. predisposta la documentazione iniziale di architettura e certificazione;
7. inizializzata la versione `0.1.0-dev`;
8. nessuna funzione applicativa Cened è stata ancora implementata.

**Verifica:** presenza e contenuto dei file principali riletti sul branch `TermodelCened`; Project Summary aggiornato allo stato effettivo.

## CENED-0002 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** verificare la definizione del prodotto rispetto alle condizioni e regole ARIA/CENED correnti e consolidarne la formulazione nel progetto.

**Definizione consolidata:** software bridge tra formati standard di modelli termici e CENED+2 Motore; importa e normalizza i dati, li presenta mediante UI originale, avvia il calcolo attraverso il Motore, produce XML conforme per CEER e genera un'anteprima APE chiaramente non ufficiale.

**Esito della verifica ARIA:**
- il posizionamento commerciale come `Software Bridge` è compatibile;
- quando integra realmente CENED+2 Motore, per ARIA il prodotto è un **Client di terze parti** e deve seguire il relativo percorso di autorizzazione;
- la riproduzione grafica del CENED+2 Client non viene adottata, poiché le Condizioni d'uso vigenti la consentono esclusivamente a fini didattici;
- l'interfaccia sarà originale ma potrà organizzare i dati in modo funzionalmente familiare al certificatore;
- l'anteprima APE è distinta dall'APE ufficiale del flusso CEER;
- il versionamento deve tenere conto degli obblighi ARIA sulle major release e degli aggiornamenti del Motore.

**Documenti aggiornati:**
- `docs/DECISIONI.md`;
- `docs/ARCHITETTURA.md`;
- `docs/CERTIFICAZIONE.md`;
- `PROJECT-SUMMARY-CENED.md`.

**Fonti ufficiali verificate:** Condizioni d'uso CENED revisione 01/09/2026 e pagine ufficiali ARIA/CENED relative a CENED+2 Motore e ai Client di terze parti.

**Codice applicativo:** nessuna modifica.


## CENED-0003 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** studio di fattibilità in sola lettura per l'integrazione headless di CENED+2 Motore con Termodel.Core / Termodel.WebService mediante runner Java separato.

**Vincoli:**
- nessuna modifica a Termodel.Core, Termodel.WebService, frontend o `definizionedati.json`;
- nessun JAR proprietario copiato o pubblicato nel repository;
- nessuna decompilazione o riscrittura del motore proprietario;
- nessuna dichiarazione di funzionamento headless senza prova reale;
- runner Java, se successivamente autorizzato, separato dal Core C#;
- percorsi locali del software CENED configurati esternamente;
- distinguere evidenze documentali, analisi statica, prototipo, compilazione, esecuzione e validazione.

**Studio richiesto:**
1. dipendenze del motore;
2. configurazione Spring richiesta;
3. classi/API pubbliche utili;
4. struttura XML input/output;
5. schema del runner Java headless minimo;
6. rischi tecnici e di licenza;
7. modifiche minime future a Core/WebService;
8. piano di prova reale successivo, non eseguito in questa commissione.


**Risultato CENED-0003:**
- creato `docs/STUDIO-FATTIBILITA-MOTORE-CENED.md`;
- verificata la documentazione pubblica ARIA/CENED corrente;
- rilevato che la versione ufficiale corrente è 1.1.15 e che la 1.1.14 installata non è più il riferimento per nuovi APE dal 03/06/2026;
- confermata la disponibilità per gli Utenti Motore di un kit Motore 1.1.15 e specifiche tecniche dedicate;
- analizzati in sola lettura `SorgentiTermodel/Library/output/Cened.cs`, `GestXml.cs` e lo stato del Service;
- definita come architettura raccomandata: Core C# puro → WebService orchestratore → runner Java isolato → Motore CENED esterno;
- non dichiarato headless: nessuna esecuzione reale del Motore è stata effettuata;
- dipendenze complete e configurazione Spring restano da inventariare sul kit locale/ufficiale;
- nessuna modifica a Termodel.Core, Termodel.WebService, frontend, Library operativa o `definizionedati.json`;
- nessun JAR proprietario copiato nel repository;
- nessuna compilazione o test runtime eseguiti, coerentemente con il perimetro di studio.


## CENED-0004 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** acquisire e consolidare nel repository i link ufficiali ARIA/CENED al Manuale d'uso Software CENED+2.0 e ai relativi moduli, per evitare future ricerche ripetitive.

**Ambito:**
1. registrare la pagina indice ufficiale del manuale;
2. registrare i link diretti ai PDF disponibili per Copertina/Indice e Moduli A-F;
3. registrare la pagina ufficiale Software CENED+2.0 come riferimento di versione corrente;
4. non copiare i PDF nel repository;
5. annotare data/versione riportata dalla documentazione e distinzione tra manuale storico e versione software corrente.


**Risultato CENED-0004:**
- creato `docs/RIFERIMENTI-CENED.md`;
- registrata la pagina indice ufficiale del Manuale d'uso Software CENED+2.0;
- registrati i link diretti ufficiali a Copertina/Indice e Moduli A, B, C, D, E, F;
- registrate la pagina ufficiale Software CENED+2.0 e la pagina generale Download come fallback;
- annotato che i moduli del manuale risultano datati 15/10/2019, mentre la versione software corrente verificata è Client/Motore 1.1.15 del 03/06/2026;
- per Appendice I è stato conservato il collegamento tramite la pagina indice ufficiale, evitando di inventare un URL diretto non verificato;
- nessun PDF ARIA è stato copiato nel repository.


## CENED-0005 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** registrare il cambio di fase del progetto: da questo momento si sviluppa e si discute esclusivamente la versione WebJS del Software Bridge.

**Decisione:**
- la versione WebJS diventa l'unica linea attiva di sviluppo e discussione;
- la versione Desktop viene sospesa e non deve essere modificata né sviluppata fino a nuova decisione esplicita;
- documentazione, specifiche e casi prova possono continuare a essere preparati in funzione della futura versione certificabile, ma ogni implementazione corrente deve riguardare soltanto WebJS;
- nessun lavoro sul runner Java Desktop/Service o sul percorso di certificazione operativo viene avviato senza nuova autorizzazione;
- la sospensione Desktop non annulla le decisioni architetturali già prese: le conserva per una futura riattivazione.


**Risultato CENED-0005:**
- registrata la decisione D-0008 in `docs/DECISIONI.md`;
- aggiornato `PROJECT-SUMMARY-CENED.md` indicando WebJS come unica linea attiva;
- la linea Desktop è sospesa fino a nuova decisione esplicita;
- nessuna implementazione Desktop, runner Java, Termodel.Core o WebService è stata avviata;
- nessun codice applicativo modificato in questa commissione.


## CENED-0006 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** acquisire come riferimento di progetto l'XML `output.xml` fornito dall'utente, dichiarato testato con la funzione di import di Blumatica e analogo al documento XML nazionale che il Software Bridge dovrà sviluppare in output.

**Vincoli:**
- il repository è pubblico;
- il file originale contiene dati personali e identificativi reali;
- non pubblicare il file grezzo nel repository;
- registrare hash, struttura, provenienza funzionale e valore come Golden Reference;
- distinguere sempre il fatto che il test di import Blumatica è un'evidenza fornita dall'utente e non una validazione rieseguita da questa sessione;
- usare il documento come riferimento per la struttura dell'output XML WebJS, senza assumere automaticamente che ogni campo sia richiesto da CENED Lombardia.


**Risultato CENED-0006:**
- verificato che il file fornito è XML ben formato;
- identificato il documento originale con SHA-256 `4988a0700ad1aeb60ef6906235411a176baee514f7a902533dfcc1ad86980647`;
- registrato come Golden Reference `BLUMATICA-XML-001`;
- creato `GoldenResults/BLUMATICA-XML-001.md`;
- aggiornati `GoldenResults/README.md`, `docs/DECISIONI.md` e `PROJECT-SUMMARY-CENED.md`;
- registrata la struttura principale `ape2015 + datiCalcolo` e i principali contenuti osservati;
- il file grezzo non è stato pubblicato perché contiene dati personali reali e il repository è pubblico;
- nessuna modifica a codice WebJS, Desktop, Core, Service, frontend o `definizionedati.json`;
- versione software invariata: `0.1.0-dev`, trattandosi di acquisizione documentale/riferimento.


## CENED-0007 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** acquisire il sorgente `GestXml.cs` usato da Termodel per generare l'XML nazionale come fonte di ispirazione per la WebJS, esplicitamente non vincolante.

**Regole:**
- il sorgente Termodel non diventa specifica del Software Bridge;
- non duplicare inutilmente il file se è già presente nel repository;
- registrare lo snapshot fornito dall'utente tramite hash e percorso di riferimento;
- estrarre soltanto principi, mapping e sequenze utili alla progettazione WebJS;
- non trascinare nella WebJS dipendenze Desktop/WPF/Xbim, stato globale, coupling con MainWindow/Polig3D o valori hard-coded senza verifica;
- in caso di conflitto prevalgono: specifiche normative/ARIA correnti, Golden Reference validati e specifica propria del Bridge.


**Risultato CENED-0007:**
- acquisito lo snapshot `GestXml.cs` fornito dall'utente;
- SHA-256 registrato: `906cde73c919fa90359daae0df0c00a1a088e318e3c2b9130b293ab1e51c0736`;
- verificato che il contenuto corrisponde sostanzialmente al sorgente già presente in `SorgentiTermodel/Library/GestXml.cs`, evitando duplicazioni;
- creato `docs/RIFERIMENTO-GESTXML-TERMODEL.md`;
- registrata la decisione D-0010;
- il sorgente è classificato come fonte di ispirazione tecnica non vincolante;
- nessun codice WebJS, Desktop, Core, Service o `definizionedati.json` modificato.


## CENED-0008 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** acquisire come riferimento di progetto l'anteprima APE prodotta da Blumatica, fornita in formato RTF, da usare come esempio di stampa/fac-simile per la futura WebJS.

**Vincoli:**
- il repository è pubblico;
- il file originale contiene dati personali e identificativi reali;
- non pubblicare l'RTF grezzo nel repository;
- registrare hash, struttura, sezioni e ruolo funzionale del documento;
- considerare il documento come riferimento di presentazione e contenuto, non come specifica grafica vincolante;
- mantenere distinta l'anteprima APE non ufficiale dall'APE ufficiale depositato;
- non copiare automaticamente grafica, loghi o layout proprietari di Blumatica.


**Risultato CENED-0008:**
- acquisito il file RTF di anteprima APE prodotto da Blumatica;
- SHA-256 registrato: `59e0300d1210a92cd31d5fe4e1e730797fa6d9ff0df6aabb61b41872de982e5f`;
- creato `GoldenResults/BLUMATICA-APE-PREVIEW-001.md`;
- registrata la decisione D-0011;
- documentate sezioni, ordine logico e ruolo del riferimento;
- stabilito che la futura WebJS userà una grafica originale e la dicitura `ANTEPRIMA APE — NON UFFICIALE`;
- il file originale non è stato pubblicato perché contiene dati personali reali;
- nessun codice WebJS, Desktop, Core, Service o `definizionedati.json` modificato.


## CENED-0009 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** realizzare la prima bozza WebJS navigabile del Software Bridge CENED da usare esclusivamente per discussione e consolidamento del prodotto.

**Perimetro:**
- solo `CenedPreprocessor/src/WebJS/`;
- nessuna modifica a Desktop, Termodel.Core, WebService o `definizionedati.json`;
- nessuna chiamata reale a CENED+2 Motore;
- usare dati demo fittizi, senza dati personali reali;
- UI originale, non copia del Client CENED né di Blumatica;
- riferimento strutturale: `BLUMATICA-XML-001`;
- riferimento di anteprima APE: `BLUMATICA-APE-PREVIEW-001`;
- riferimento tecnico non vincolante: `TERMODEL-GESTXML-001`.

**Funzioni della bozza:**
1. navigazione fra dati generali, zone/locali, involucro, serramenti, ponti termici, impianti, risultati;
2. indicatori di completezza/validazione;
3. modello dati JavaScript separato dalla UI;
4. anteprima XML nazionale dimostrativa;
5. anteprima APE marcata `ANTEPRIMA APE — NON UFFICIALE`;
6. nessun tentativo di calcolo energetico ufficiale;
7. versione visibile in caption/interfaccia.


**Risultato CENED-0009:**
- versione incrementata da `0.1.0-dev` a `0.1.1-dev`;
- creato `src/WebJS/index.html`, pagina autonoma HTML/CSS/JavaScript senza framework;
- aggiornato `src/WebJS/README.md`;
- implementati progetto demo, menu funzionale, validazione preliminare, tabelle del modello, risultati, anteprima APE e XML dimostrativo;
- implementato import locale di XML nazionale `<documento>` con lettura dei blocchi `ape2015` e `datiCalcolo`;
- JavaScript del file committato verificato sintatticamente con esito OK;
- parser provato in Chromium headless contro il file `output.xml` fornito dall'utente: letti correttamente Reggio di Calabria, zona B, 43,3 m², 148,41 m³, classe F, EPgl,nren 217,04, 1 zona, 5 locali, 39 opache, 25 vetrate, 184 ponti termici e 2 impianti;
- Motore CENED non chiamato;
- nessuna modifica a Desktop, Termodel.Core, WebService o `definizionedati.json`;
- nessun dato personale reale inserito nel progetto demo.


## CENED-0010 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** pubblicare la prima bozza WebJS 0.1.1-dev sul sito pubblico Termodel per consentirne la discussione diretta via browser.

**Modalità di pubblicazione:**
- sorgente autorevole resta `TermodelCened/CenedPreprocessor/src/WebJS/index.html`;
- la pubblicazione Web è una copia di deploy in `main/docs/cened-bridge/index.html`, secondo lo stesso modello già usato da Termodel Web;
- URL previsto: `https://www.termodel.it/cened-bridge/`;
- nessun altro file di `main` deve essere modificato;
- nessuna modifica a Core, Service, Desktop o `definizionedati.json`;
- verificare dopo il commit che l'URL pubblico risponda e mostri la versione 0.1.1-dev.


**Risultato CENED-0010:**
- pubblicata la copia di deploy della WebJS 0.1.1-dev in `main/docs/cened-bridge/index.html`;
- commit di deploy su `main`: `dbee4c4b78477821f2c1ff24942ba76b7d9980bc`;
- sorgente autorevole invariata in `TermodelCened/CenedPreprocessor/src/WebJS/index.html`;
- URL pubblico previsto: `https://www.termodel.it/cened-bridge/?v=0.1.1`;
- nessun altro file di `main` modificato;
- nessuna modifica a Core, Service, Desktop o `definizionedati.json`;
- il contenuto del deploy è stato verificato nel repository;
- la sessione non ha potuto verificare la raggiungibilità HTTP esterna di `www.termodel.it` per limite di accesso/rete degli strumenti.


## CENED-0011 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** consolidare il nuovo contratto di ingresso del Software Bridge come coppia obbligatoria di file complementari: **gbXML + XML nazionale**.

**Decisione richiesta:**
- il Bridge puro non riceve un solo file onnipotente;
- il **gbXML** è la fonte primaria del modello geometrico/termico e deve descrivere quanto possibile delle cause fisiche: spazi, superfici, aperture, orientamenti, relazioni e geometrie rilevanti, inclusi gli elementi di ombreggiamento quando disponibili;
- l'**XML nazionale** è la seconda fonte obbligatoria e integra i dati che il gbXML non contiene o non rappresenta con sufficiente specificità per il flusso italiano/CENED;
- i due file vengono importati insieme e fusi in un modello intermedio unico;
- il Bridge resta di controllo/normalizzazione: non corregge manualmente il modello;
- in presenza di dati duplicati discordanti il Bridge non deve scegliere silenziosamente, ma deve applicare autorità per dominio e segnalare la discordanza;
- gli eventuali risultati energetici già presenti nell'XML nazionale sono dati di confronto/riferimento, non devono sostituire le cause fisiche mancanti nel gbXML.


**Risultato CENED-0011:**
- registrata la decisione D-0012: ingresso duale obbligatorio `gbXML + XML nazionale`;
- aggiornato `docs/ARCHITETTURA.md`;
- aggiornato `spec/README.md`;
- aggiornato `PROJECT-SUMMARY-CENED.md`;
- definita l'autorità per dominio: gbXML per geometria/cause fisiche, XML nazionale per dati specifici nazionali mancanti;
- definita la gestione delle discordanti: segnalazione senza correzione silenziosa;
- confermato che i risultati energetici dell'XML nazionale sono dati di confronto e non sostituiscono informazioni causali;
- confermato il Bridge come componente di import/fusione/normalizzazione/controllo, non come editor tecnico;
- nessun codice applicativo modificato.


## CENED-0012 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** consolidare come principio di prodotto che il Software Bridge accetta **formati pubblici riconosciuti, separati per dominio**, evitando un formato proprietario unico e onnivoro.

**Decisione richiesta:**
- mantenere separati i file quando rappresentano domini diversi;
- usare formati pubblici, documentati e riconosciuti dal mercato/settore;
- prima applicazione concreta: `gbXML + XML nazionale`;
- il gbXML rappresenta il dominio geometrico/termico fisico;
- l'XML nazionale rappresenta il dominio nazionale/APE e integra i dati mancanti;
- il modello interno del Bridge può essere proprietario come struttura software, ma non deve essere imposto come formato di scambio esterno;
- futuri formati pubblici riconosciuti potranno essere aggiunti tramite adapter, senza cambiare il principio del Bridge;
- ogni formato importato deve avere schema/versione/provenienza verificabili e un mapping documentato verso il modello intermedio.


**Risultato CENED-0012:**
- registrata la decisione D-0013: formati pubblici riconosciuti separati per dominio;
- confermata la prima coppia `gbXML + XML nazionale`;
- stabilito che il modello intermedio è interno al Bridge e non viene imposto come formato di scambio esterno;
- introdotto il principio degli adapter per supportare in futuro altri formati pubblici riconosciuti;
- aggiornati `docs/ARCHITETTURA.md`, `spec/README.md` e `PROJECT-SUMMARY-CENED.md`;
- nessun codice applicativo modificato.


## CENED-0013 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** creare un sample gbXML pubblico e minimale da usare nei test del Bridge: una stanza rettangolare con due finestre.

**Requisiti del sample:**
- formato gbXML conforme alla struttura pubblica dello standard;
- riferimento alla versione corrente gbXML 8.01;
- unità SI;
- un solo edificio;
- una sola zona/spazio termico;
- stanza rettangolare 4,00 × 4,00 m, altezza 3,00 m;
- due finestre su una parete esterna;
- superfici di pavimento, copertura e quattro pareti esplicite;
- geometria tramite `PlanarGeometry/PolyLoop`;
- aperture esplicite tramite `Opening`;
- dati interamente fittizi;
- file collocato in `CenedPreprocessor/samples/`;
- documentare geometria attesa e uso nei test;
- nessuna modifica a WebJS/Desktop/Core/Service o `definizionedati.json`.


**Risultato CENED-0013:**
- creato `samples/GBXML-ROOM-2WINDOWS-001.xml`;
- formato dichiarato gbXML 8.01 con unità SI;
- geometria: stanza 4×4 m, h 3 m, area 16 m², volume 48 m³;
- modellate 6 superfici di involucro e 2 finestre sulla parete Sud;
- ogni finestra misura 1×1,2 m; area vetrata totale 2,4 m²;
- area opaca netta attesa della parete Sud: 9,6 m²;
- aggiunte 3 Construction schematiche e 1 Zone;
- aggiornato `samples/README.md`;
- creato `tests/GBXML-ROOM-2WINDOWS-001.md` con aspettative di regressione;
- aggiornato `tests/README.md`;
- controllati conteggi e riferimenti interni: nessun IDREF del sample risulta privo dell'ID corrispondente;
- struttura/campi/enumerazioni confrontati con lo XSD pubblico gbXML 8.01;
- validazione completa col validator ufficiale gbXML lasciata come controllo futuro della pipeline;
- nessun codice applicativo e nessuna versione software modificati.


## CENED-0014 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** creare un sample gbXML avanzato per validare lo studio di fattibilità del Bridge sugli ombreggiamenti geometrici.

**Caso prova richiesto:**
- edificio minimale con una stanza e due finestre;
- balcone/aggetto orizzontale davanti alla parete finestrata;
- setti verticali laterali;
- ostacolo remoto rappresentativo di un palazzo di fronte;
- geometrie espresse con elementi gbXML pubblici, senza estensioni proprietarie;
- uso di `Surface surfaceType="Shade"` per gli elementi ombreggianti, coerentemente con lo schema e i campioni/test pubblici gbXML;
- mantenere il caso deterministico e facilmente verificabile a mano;
- documentare coordinate, distanze e risultati geometrici attesi;
- creare il relativo documento di test;
- non modificare WebJS/Desktop/Core/Service o `definizionedati.json`.

**Scopo di fattibilità:**
dimostrare che il formato gbXML può trasportare le cause geometriche dell'ombreggiamento che l'XML nazionale tende a rappresentare solo tramite risultati/fattori derivati.


**Risultato CENED-0014:**
- creato `samples/GBXML-SHADING-001.xml`;
- modellati con geometria gbXML pubblica: balcone/aggetto orizzontale, due setti verticali e ostacolo remoto rappresentativo di un palazzo di fronte;
- usate 4 `Surface surfaceType="Shade"`, senza estensioni proprietarie;
- balcone: 3,50 × 1,20 m, quota 2,50 m;
- setti: profondità 0,80 m, altezza 1,90 m;
- ostacolo remoto: distanza 8,00 m, larghezza 12,00 m, altezza 10,00 m;
- creato `tests/GBXML-SHADING-001.md`;
- aggiornati `samples/README.md` e `tests/README.md`;
- registrata D-0014 come gate di fattibilità sugli ombreggiamenti geometrici;
- verificati 10 Surface totali, 4 Shade effettive, 2 Opening, 4 Construction, 1 Space, 1 Zone e nessun riferimento interno irrisolto;
- confrontato il principio con i test pubblici ASHRAE/gbXML Balcony e Roof With Extended Overhang, che richiedono la traduzione dell'aggetto come `Shade`;
- la validazione completa tramite validator ufficiale gbXML resta un gate futuro automatizzato;
- nessun codice applicativo e nessuna versione software modificati.


## CENED-0015 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** integrare nella WebJS del Software Bridge un viewer 3D read-only derivato dal renderer Three.js di Termodel Web e provarlo con il sample gbXML degli ombreggiamenti e con il Golden XML nazionale fornito dall'utente.

**Perimetro:**
- solo `CenedPreprocessor/src/WebJS/`, test e documentazione CENED;
- riuso selettivo del renderer/browser 3D di Termodel Web, senza CAD, editing, snap o archivi Termodel;
- viewer esclusivamente di controllo;
- parsing geometrico del gbXML;
- visualizzazione di involucro, finestre e superfici `Shade`;
- classificazione preliminare delle Shade in aggetto orizzontale, setto verticale e ostacolo remoto;
- selezione 3D con proprietà/provenienza;
- mantenere separati gbXML (geometria) e XML nazionale (dati complementari);
- incrementare versione WebJS e aggiornare caption;
- non modificare Desktop, Core, Service o `definizionedati.json`.

**Prove obbligatorie:**
1. `samples/GBXML-SHADING-001.xml`: devono risultare 6 superfici involucro, 2 finestre, 4 Shade e riconoscimento delle tre classi di ombreggiamento;
2. Golden XML nazionale fornito dall'utente, identificato in progetto come `BLUMATICA-XML-001`: deve continuare a essere importato senza regressioni dal parser nazionale e deve fornire i dati complementari già verificati; il file grezzo non va committato perché contiene dati personali;
3. verificare che l'XML nazionale da solo non venga usato per inventare geometria 3D mancante;
4. testare sintassi JavaScript e comportamento del parser in browser/headless dove disponibile.


**Risultato CENED-0015:**
- versione WebJS incrementata a `0.1.2-dev` e caption aggiornata;
- creato `src/WebJS/viewer3d.js`, renderer Three.js read-only derivato selettivamente da Termodel Web;
- aggiunto import separato gbXML accanto all'import XML nazionale;
- mantenuti separati stato geometrico gbXML e dati complementari XML nazionale;
- implementato parser gbXML per Surface, Opening e Shade;
- implementata classificazione preliminare Shade: aggetto/balcone, setto verticale, ostruzione esterna remota;
- implementata associazione geometrica preliminare delle Shade alla facciata finestrata;
- implementati viewer orbit/zoom/pianta/isometrica/spigoli/selezione e proprietà;
- l'XML nazionale non viene mai convertito artificialmente in geometria 3D;
- creato `tests/WEBJS-DUAL-INPUT-001.md` usando `GBXML-SHADING-001.xml` e il Golden Reference esterno `BLUMATICA-XML-001`;
- il raw BLUMATICA-XML-001 non è stato committato per privacy;
- sintassi JavaScript inline verificata OK;
- sintassi modulo viewer verificata OK;
- classificatore verificato sul sample: 6 superfici, 2 aperture, 4 Shade = 1 balcone + 2 setti + 1 ostacolo remoto a 8 m;
- registrata D-0015;
- deploy 0.1.2-dev eseguito su `main/docs/cened-bridge/`;
- commit deploy index: `5624d030842e8751cd2ffa489def5138f9e7a410`;
- commit deploy viewer: `54608dcc1ffd13f111daa5da7692495031c70767`;
- copia deploy verificata identica alla sorgente autorevole;
- URL previsto: `https://www.termodel.it/cened-bridge/?v=0.1.2`;
- verifica HTTP esterna non disponibile dagli strumenti della sessione;
- nessuna modifica a Desktop, Core, Service o `definizionedati.json`.


## CENED-0016 — 2026-09-22

**Stato:** COMMISSIONATO

**Oggetto:** consolidare nel progetto i file di prova e caricarli automaticamente nella WebJS, senza richiedere ogni volta il caricamento manuale.

**Requisiti:**
- usare come fixture geometrica consolidata `samples/GBXML-SHADING-001.xml`;
- derivare dal Golden Reference esterno `BLUMATICA-XML-001` una fixture XML nazionale sanificata, mantenendo i dati tecnici necessari ai test ma rimuovendo/sostituendo dati personali e identificativi;
- non pubblicare il file originale con dati personali;
- caricare automaticamente entrambe le fixture all'avvio della WebJS quando è disponibile la modalità prova;
- il viewer 3D deve aprirsi con geometria già disponibile, senza messaggio “Importa un file gbXML”;
- mantenere disponibili i pulsanti di import manuale per prove con file diversi;
- distinguere chiaramente in UI i file `fixture consolidata` dagli eventuali file importati manualmente;
- incrementare versione WebJS e aggiornare caption;
- aggiornare test, Summary e documentazione;
- deploy su `main/docs/cened-bridge/`;
- nessuna modifica a Desktop, Core, Service o `definizionedati.json`.
