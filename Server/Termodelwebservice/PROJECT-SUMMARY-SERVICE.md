# TERMODEL CORE + WEBSERVICE — PROJECT SUMMARY

> **IMPORTANTE — notifica obbligatoria degli incarichi GitHub Actions**
>
> Per ogni incarico significativo eseguito via GitHub Actions applicare
> `.github/TERMODEL-ACTION-NOTIFICATIONS.md`: Commit Status
> `Termodel/job` con `RUNNING -> SUCCESS/FAILED` e push telefono a
> SUCCESS/FAILED. La regola è permanente e già verificata end-to-end.

Ultimo aggiornamento: **2026-09-30**
Branch GitHub di riferimento: **main**
Repository: `https://github.com/Fetonte1960/Termodel`

Questo è il documento autorevole di continuità per **Termodel.Core** e
**Termodel.WebService**. Non sostituisce né deve modificare il
`PROJECT-SUMMARY.md` della linea Web JavaScript.

Il contratto condiviso con il frontend è mantenuto separatamente in:

```text
docs/TERMODEL-FRONT-SERVICE-CONTRACT.md
```

Endpoint, artifact e orchestrazione comuni devono essere definiti lì; questo
Summary registra invece lo stato di implementazione del Service.

Il contratto condiviso formalizza inoltre i due file principali della
comunicazione: il payload tecnico `TERMODEL-PROJECT-TEXT-V1`, filtrato delle
risorse esclusivamente frontend prima di `POST /api/calculations`, e
`TermodelWebModel v3` come artifact `model3d` destinato al redraw 3D. Lo
schema dettagliato e le regole di compatibilità sono mantenuti esclusivamente
in `docs/TERMODEL-FRONT-SERVICE-CONTRACT.md`.


## 1. Regole per una nuova chat AI

Prima di intervenire:

1. leggere integralmente questo documento;
2. verificare branch, stato Git e commit successivi all'ultimo stato registrato;
3. leggere `README.md`, `docs/copied-from-termodel.md` e i documenti desktop
   pertinenti in `SorgentiTermodel/Library`;
4. proporre l'intervento e attendere autorizzazione;
5. non modificare `definizionedati/definizionedati.json` né la sua copia senza
   autorizzazione specificamente riferita a quel file;
6. non modificare il frontend `docs/termodel-ui-demo` salvo richiesta esplicita;
7. non introdurre refactoring estesi durante la migrazione selettiva;
8. distinguere sempre proposta, implementazione, compilazione, prova HTTP e
   confronto golden;
9. aggiornare questo summary quando cambiano contratti, stato o prossimi passi.
10. **Regola permanente di autorizzazione:** quando l'utente autorizza modifiche al progetto, registrare prima in questo Summary (e nel contratto condiviso se pertinente) le decisioni/lo stato concordati, quindi applicare le modifiche al codice; al termine aggiornare nuovamente lo stato reale se implementazione, build o test cambiano.
11. **Registro incarichi obbligatorio:** ogni autorizzazione esplicita a procedere deve creare, prima delle modifiche, una voce nel registro incarichi con `Stato: COMMISSIONATO`, descrizione concreta del lavoro e criteri di completamento. Quando il lavoro è terminato, la stessa voce deve essere aggiornata a `Stato: ESEGUITO`, indicando risultato reale, build/test effettuati e commit. Se la chat termina durante il lavoro, la voce deve restare `COMMISSIONATO`: la chat successiva deve considerarla lavoro affidato ma non ancora concluso e riprenderla prima di dichiararla eseguita.
12. **Snapshot diagnostico permanente:** quando l'utente chiede di esaminare una sessione reale del Service, prima di chiedere copie manuali di SVG/DXF/JSON/report/log leggere
   `Server/Termodelwebservice/docs/SERVICE-SNAPSHOT-DIAGNOSTIC.md` e il branch
   `service-snapshots`. La sequenza standard è
   `service-snapshots/LATEST.json -> manifest.json -> artifact/log reali`.
   L'utente deve normalmente fare soltanto `Aggiorna Modello`, pubblicare
   lo snapshot e dire `esamina l'ultimo snapshot`.
13. **Debug avanzato permanente con GitHub Actions:** per problemi complessi che richiedono riproduzione reale leggere
   `Server/Termodelwebservice/docs/ADVANCED-GITHUB-ACTIONS-DEBUG.md`.
   Se la natura del problema non è già nota, chiedere quale anomalia va
   riprodotta; se serve un progetto reale e non è già disponibile, chiedere
   il `TERMODEL-PROJECT-TEXT-V1`. Usare GitHub Actions per compilare e
   avviare il Service, inviare il progetto, raccogliere response/artifact/log,
   aggiungere se necessario strumentazione diagnostica temporanea e ripetere
   il ciclo test -> analisi -> correzione -> nuovo test fino alla soluzione
   o a un impedimento concreto. Al termine rimuovere la strumentazione
   occasionale e lasciare solo correzioni/regression test utili.
14. **Notifica GitHub Actions — IMPORTANTE:** ogni Action usata per un incarico operativo o debug deve seguire `.github/TERMODEL-ACTION-NOTIFICATIONS.md`. All'avvio pubblicare `RUNNING` nel Commit Status `Termodel/job`; nello step finale `always()` pubblicare `SUCCESS` o `FAILED` e inviare una sola notifica push tramite il secret `TERMODEL_NTFY_TOPIC`. Non usare polling e non esporre mai il valore del secret.
15. **Protocollo anti-timeout chat — IMPORTANTE:** per incarichi lunghi applicare `.github/TERMODEL-CHAT-ANTI-TIMEOUT.md`. La chat è il punto di comando, GitHub è lo stato persistente: registrare subito `COMMISSIONATO`, **suddividere gli incarichi gravosi in fasi autonome e riprendibili**, lasciare checkpoint persistenti fra una fase e l'altra, demandare build/test lunghi a GitHub Actions, evitare di riversare log enormi nella chat e riprendere dopo timeout da Summary, commit, status e artifact senza rifare lavoro già verificato.
16. **Notifica fine fase con Issue #1 — IMPORTANTE:** alla conclusione di ogni fase significativa di un incarico gravoso aggiornare e chiudere la Issue #1 come `Completed` se riuscita o `Not planned` se fallita/non proseguibile. Non notificare ogni commit, micro-passaggio o singola build: le build hanno già le notifiche GitHub Actions. Issue #1 serve a segnalare la conclusione di una **fase di lavoro utile e autonoma**; alla fase successiva può essere riaperta e riutilizzata.

## 1.1 Registro incarichi autorizzati

### INCARICO 2026-09-30 — Richiesta direttive consulente spirali
Stato: ESEGUITO

Pubblicato sul canale comune l'obiettivo corrente:
- `Vittorio_revisionato = Mandata Vittorio + Return parallelo Vittorio + chiusura LG-051 separata dalla raccordatura`;
- `Vittorio` resta intoccabile;
- chiusura valutata su geometria rettilinea con soglia `2*P`, controllo angoli acuti e intersezioni, primo candidato valido e stop;
- nessun candidato valido = circuito aperto;
- raccordatura soltanto dopo la scelta della chiusura;
- `spiralClosure=false` resta lo strumento per osservare Mandata e Return aperti.

È stato chiesto al consulente di fornire la prossima direttiva tecnica/diagnostica precisa (Harness, SVG, misure, angoli, porzione di Return o modifica minima proposta).

Nessun sorgente modificato.

### INCARICO 2026-09-30 — Protocollo bidirezionale consulente spirali
Stato: ESEGUITO

Nuova regola operativa autorizzata dall'utente:
- il consulente può rispondere direttamente sul canale pubblico `docs/modulo-spirali/sorgenti-cruciali.md`;
- quando Diego scrive `aggiornati`, ChatGPT deve rileggere la pagina e individuare gli ultimi aggiornamenti del consulente;
- ad ogni aggiornamento ChatGPT deve fornire a Diego una breve sintesi prima di discutere o implementare;
- se ChatGPT pubblica una risposta sulla pagina, deve segnalarlo a Diego con `aggiornati` e una breve sintesi del contenuto pubblicato;
- il parere del consulente resta importante ma non vincolante; la decisione finale resta di Diego;
- nessuna proposta del consulente diventa automaticamente codice salvo autorizzazione già esplicita.

Nessun sorgente modificato.

### INCARICO 2026-09-30 — Riallineamento protocollo consulente spirali
Stato: ESEGUITO

Decisione consolidata dell'utente:
- il parere del consulente spirali è importante ma non vincolante;
- ogni proposta del consulente deve essere verificata sul repository reale e discussa con Diego prima di diventare una modifica;
- il canale pubblico canonico ChatGPT ↔ consulente è `docs/modulo-spirali/sorgenti-cruciali.md`;
- dopo ogni pubblicazione destinata al consulente ChatGPT segnala a Diego `aggiornati`, così Diego invita il consulente a rileggere la pagina;
- il consulente non deve dipendere da stato locale/server non pubblicato.

Riepilogo pubblico aggiunto alla pagina:
- ruoli Diego / consulente / ChatGPT;
- stato `Vittorio`, `Diego_Vittorio`, `Vittorio_revisionato`;
- obiettivo architetturale di `Vittorio_revisionato`;
- sequenza LG-051 e filtri attuali;
- uso di `spiralClosure=false` per osservare Mandata e Return aperti;
- punto di discussione corrente: verificare il Return Vittorio esistente prima di introdurre un nuovo `OffsetEngine.Parallel(...)`.

Nessun sorgente modificato.

### INCARICO 2026-09-30 — Fix UI Chiudi circuito / Vittorio_revisionato
Stato: ESEGUITO — PUBBLICATO E VERIFICATO

Problema reale:
- screenshot utente: `Chiudi circuito` disattivato ma selettore ancora `Predefinito Service`;
- lo stato runtime mostrava `motore Diego_Vittorio`; quindi il controllo non agiva su `Vittorio_revisionato`;
- causa frontend: `spiralClosure` veniva inviato solo quando il select valeva già `Vittorio_revisionato`, ma il checkbox non cambiava il motore.

Correzione:
- frontend v1.39;
- evento `change` di `helpSpiralClosure` imposta automaticamente `helpSpiralEngine.value = 'Vittorio_revisionato'` prima del prossimo `Aggiorna Modello`;
- `buildTermodelCalculationPath()` invia così `spiralEngine=Vittorio_revisionato&spiralClosure=true|false`;
- tooltip Help aggiornato;
- nessuna modifica ai motori geometrici o a `Vittorio`.

Verifica reale:
- GitHub Pages run `36710823681`: SUCCESS;
- TermodelService Build #1200: frontend JavaScript SUCCESS e build .NET SUCCESS;
- smoke `Vittorio_revisionato` chiuso: SUCCESS;
- smoke `Vittorio_revisionato` con `spiralClosure=false`: SUCCESS con `VITTORIO_REVISIONATO_OPEN_CIRCUITS_OK`;
- verifica pubblica del workflow: `publicFrontendVersion=1.39`, `PUBLIC_VITTORIO_REVISIONATO_DEPLOY_OK`, Service commit osservato `03046144240dbdedd9f909d1fcb553a26ed9ab3c`;
- il workflow complessivo conserva il fallimento separato dello smoke storage/lock già noto; i gate della correzione sono verdi.

Commit:
- `95a8bff8ba571a5ba07e00b24a58d0a0c81e227b` — fix evento checkbox;
- `ac4759a9c4c85e79d5441327dad1f1ebdd8f69a8` — tooltip/cache busting;
- `7ff6ae9eec7562c53eef4b573c7b2065eb85b4f0` — frontend v1.39;
- `d67759c26810fadadcbf7dec23f35bcc6fd99b1c` — CI marker v1.39/auto-selezione.


### INCARICO 2026-09-30 — Pubblicazione motore Vittorio_modificata con chiusura configurabile
Stato: ANNULLATO / SUPERATO

Motivo:
- l'utente ha chiarito che `Vittorio_modificata` non deve essere creato;
- la richiesta corretta riguarda una modifica a `Vittorio_revisionato`;
- nessun sorgente `Vittorio_modificata` è stato creato e nessun codice geometrico è stato modificato sotto quel nome.

### INCARICO 2026-09-30 — Chiusura configurabile su Vittorio_revisionato
Stato: ESEGUITO — IMPLEMENTATO, COMPILATO, TESTATO E PUBBLICATO

Autorizzazione utente:
- mantenere `Vittorio` intoccabile;
- modificare direttamente `Vittorio_revisionato`, senza introdurre un nuovo motore;
- rendere la chiusura finale configurabile dal frontend in Help, nello stesso gruppo dei settaggi spirali;
- quando la chiusura è disattivata mantenere Mandata e Return di `Vittorio_revisionato` ma lasciare aperte le due estremità, senza curva di collegamento finale;
- pubblicare Service/Core e frontend necessari, aggiornando il contratto condiviso;
- non modificare `definizionedati.json`.

Risultato implementato:
- nessun motore `Vittorio_modificata` creato; l'incarico precedente con quel nome resta annullato/superato;
- `SpiraliVittorio` invariata;
- `SpiraliVittorioRevisionato/Program.cs`: aggiunto `AggiornaSpiraliConChiusura(bool chiudiCircuito)`; `AggiornaSpirali()` conserva default `true`;
- `SpiraliVittorioRevisionato/ChiudiSpirale.cs`: con `chiudiCircuito=false` la Mandata e il Return restano presenti ma la combinatoria di chiusura non viene eseguita, `curvaCollegamento` resta vuota e `ChiusuraGPT` non viene emessa;
- `RadiantExecutiveGenerator.Generate(...)`: nuovo parametro opzionale `spiralClosure=true`, inoltrato al solo percorso `Vittorio_revisionato`;
- `POST /api/calculations`: nuovo parametro query `spiralClosure=true|false`, default `true`; risposta manifest con `spiralClosure` e header diretto `X-Termodel-Spiral-Closure`;
- frontend v1.38: Help → Motore spirali — test pubblico → checkbox `Chiudi circuito`; quando è selezionato `Vittorio_revisionato`, `Aggiorna Modello` invia `spiralClosure=true|false`; il valore non viene salvato nel progetto;
- contratto Front/Service, README revisionato e `TERMODEL-SYNC.md` aggiornati;
- pagina pubblica consulente `docs/modulo-spirali/sorgenti-cruciali.md` aggiornata.

Commit principali:
- `acc4513c55b45a56a546a05691ba7ec1f8d9f367` — ingresso pubblico con chiusura configurabile;
- `c54737cfa4a71b61a1ddd5bca5e90d95dfc8e0a2` — modalità Mandata/Return aperti;
- `95ed94a51db27aa87a1b9543432a293ba2a8c2fc` — propagazione Core;
- `1a572be34d966f7522896ec3c4e532c5f4b7d9dc` — contratto HTTP runtime;
- `68124362573d36c5ae96121637f950692b4db7d6`, `c47e422e4fae1f849405e1e137d747a584ef995e`, `a081f0f392ebafc85b02dd7bb0ce23de0e039c67` — frontend v1.38;
- `9c045895ef2f447bcde0f16729618794d7c56b3b` — smoke dedicato supporto `SpiralClosure`;
- `03e323b11c4c7d29f5e6ff55fd1c93b5ae29b260` — CI con smoke circuiti aperti.

Verifica reale:
- TermodelService Build #1196 / run `36705902144`: restore SUCCESS;
- `Check frontend JavaScript syntax`: SUCCESS;
- `Build`: SUCCESS;
- smoke `Vittorio_revisionato` default/chiuso: SUCCESS con `RADIANT_SPIRAL_ENGINE_REQUEST_OK engine=Vittorio_revisionato closure=True`;
- smoke `Vittorio_revisionato` aperto: SUCCESS con `RADIANT_SPIRAL_ENGINE_REQUEST_OK engine=Vittorio_revisionato closure=False` e `VITTORIO_REVISIONATO_OPEN_CIRCUITS_OK`;
- modalità aperta: layer Mandata e Return presenti; layer `_NumeriCircuiti_Output` assente;
- verifica pubblica: SUCCESS; Render osservato al commit `9c045895ef2f447bcde0f16729618794d7c56b3b`, default `Diego_Vittorio`, motore `Vittorio_revisionato` disponibile, frontend pubblico v1.38;
- il workflow complessivo #1196 conclude FAILURE esclusivamente nello smoke separato `HTTP project storage and exclusive locks`, che non è riuscito ad avviare il Service sulla propria porta di test (`Termodel.WebService non ha risposto a /health`); i gate spirali richiesti erano già tutti SUCCESS.

Limite diagnostico noto:
- nel progetto pubblico usato dallo smoke, output chiuso e aperto hanno lo stesso SHA-256 `7A697A282D1F4AE7102A579D3DB7C6772D6A4CE93828BF2B071C2A44CD2043D7`, perché in quel caso la geometria corrente non applicava comunque una chiusura;
- la CI dimostra quindi compilazione, propagazione del flag e modalità aperta priva di etichetta/collegamento finale; non dimostra su quella specifica fixture una differenza geometrica chiuso-vs-aperto.

Contratto:
- `POST /api/calculations?spiralEngine=Vittorio_revisionato&spiralClosure=false` lascia intenzionalmente aperti i due terminali;
- omissione di `spiralClosure` = `true`, quindi compatibilità retroattiva preservata.

### INCARICO 2026-09-30 — Verifica architetturale pubblica Vittorio_revisionato
Stato: ESEGUITO

Autorizzazione utente:
- rispondere alla richiesta del consulente esterno tramite la pagina pubblica `docs/modulo-spirali/sorgenti-cruciali.md`;
- verificare se `SpiraliVittorioRevisionato` è realmente una copia stretta di `Vittorio` con ritorno parallelo e sola correzione di chiusura, oppure se contiene astrazioni/importazioni proprie di `Diego_Vittorio`;
- non modificare geometria, motori, Golden o frontend;
- pubblicare sulla pagina pubblica i riscontri architetturali verificabili e i riferimenti ai file;
- al termine segnalare all'utente `aggiornati` per invitare il consulente a rileggere la pagina.

Risultato dell'analisi:
- il percorso pubblico di `Vittorio_revisionato` non effettua attualmente un secondo lancio autonomo del generatore per il Return;
- il Return pubblico nasce ancora da `CreaRientro(...)`; il corpo del metodo è uguale a quello di `SpiraliVittorio/ChiudiSpirale.cs`, quindi l'origine del Return resta parallela alla Mandata;
- `Spiralgenerator.cs` revisionato contiene però l'astrazione `SpiralGenerationInput` con `LineeCondizionamento`, `DistanzaCondizionamento` e `TerminalCenterline`, assenti in Vittorio;
- il percorso pubblico abilita `GeneraSpirale(terminalCenterline: true)`, quindi modifica la Mandata prima della chiusura e non è una derivazione stretta closure-only;
- `StrategiaVittorioRevisionatoBenchmark.CheckAbstraction()` esercita esplicitamente Return autonomi/condizionati con chiamate separate a `Generate(...)`; questa capacità non appartiene all'architettura desiderata del revisionato;
- `SpiraliVittorioRevisionato/ChiudiSpirale.cs` dipende direttamente da `SpiralHeatingDiegoVittorio.ChiudiSpirale.PreparaRitornoRettilineoVittorio(...)` e `ApplicaChiusuraCombinatoriaRettilineaVittorio(...)`; `Program.cs` conserva inoltre il metodo non usato `ChiudiSpiraleFilesDiegoVittorio()`;
- conclusione: la contaminazione architetturale Diego è confermata, ma va distinta dal runtime pubblico del Return, che è ancora parallelo Vittorio.

Obiettivo architetturale registrato:
- `Vittorio_revisionato = Vittorio invariato per Mandata + Return parallelo Vittorio + sola correzione LG-051 della chiusura/raccordatura`;
- una futura correzione dovrà eliminare dal percorso revisionato `TerminalCenterline`, l'astrazione Return neutra/condizionata e la dipendenza diretta dal namespace `SpiralHeatingDiegoVittorio`, preservando `CreaRientro` Vittorio.

Pubblicazione:
- pagina `docs/modulo-spirali/sorgenti-cruciali.md` aggiornata con la sezione `Verifica architetturale Vittorio_revisionato — 30/09/2026`;
- commit pubblico: `e9445a5ee88cbf9875c8ee7f91d496aa404c9c1a`.

Verifica:
- pagina riletta da GitHub dopo il commit: sezione e riferimenti presenti;
- nessun file sorgente, Golden, Harness o frontend modificato;
- nessuna build/esecuzione necessaria per questa fase di sola analisi documentale.

### INCARICO 2026-09-30 — Documentazione pubblica sorgenti cruciali Harness Spirali
Stato: ESEGUITO

Autorizzazione utente:
- creare `docs/modulo-spirali/sorgenti-cruciali.md` per la documentazione pubblica;
- rendere navigabili i sorgenti cruciali di Harness, motori, linee guida e regression senza necessità di clonare il repository;
- usare una tabella a tre colonne `Area | Path Repo | Ruolo`;
- includere i casi `locale_1`, `locale_5`, `locale_8`, `locale_9` e il quadrato baseline;
- includere la regola di non aggiornare alla cieca il Golden Diego_Vittorio;
- non modificare codice, motori, Golden o frontend.

Risultato:
- creata `docs/modulo-spirali/sorgenti-cruciali.md`;
- aggiunto indice navigabile e tabella `Area | Path Repo | Ruolo`;
- aggiunti link GitHub diretti a Harness, test, workflow Fast, tre motori e linee guida;
- documentati LG-048, LG-049 e LG-051;
- documentati i casi `locale_1`, `locale_5`, `locale_8`, `locale_9`, quadrato Diego_Vittorio e quadrato Vittorio_revisionato;
- verificato che nel repository corrente la directory Golden effettiva è `tests/radiant-harness/baselines/`, non `goldens/`, e usato il path reale;
- aggiunta nota esplicita: **non aggiornare il Golden Diego_Vittorio alla cieca**;
- nessun sorgente, Golden o frontend modificato.

Commit pagina pubblica:
- `be35a98bc958b3f63d3d3a512cdd31775df22923`.

Verifica:
- file riletto da GitHub: tabella, indice e warning Golden presenti;
- GitHub Pages build avviata per il commit della pagina;
- il CNAME corrente del repository `docs/` è `www.termodel.it`; nessuna modifica al dominio/CNAME eseguita in questo incarico.

### INCARICO 2026-09-30 — Implementazione LG-051 e pubblicazione Vittorio_revisionato
Stato: ESEGUITO — PUBBLICATO SU MAIN; DEPLOY SERVICE NON CERTIFICATO

Autorizzazione utente:
- implementare le decisioni consolidate in LG-051 per `Vittorio_revisionato`;
- pubblicare su `main`;
- evitare notifiche operative aggiuntive durante questa pubblicazione.

Risultato implementato:
- chiusura scelta e validata esclusivamente sulla geometria rettilinea;
- segmento di chiusura `>=2P`, esclusione angoli acuti e intersezioni con la
  geometria risultante dal candidato;
- sequenza deterministica e arresto al primo candidato valido;
- se nessun candidato è valido, Mandata e Return restano separati;
- eliminata dal percorso pubblico la seconda Bézier finale;
- raccordatura separata sull'intero percorso continuo mediante archi circolari
  tangenti;
- raggio locale configurabile, default `0,10 m`, non ridotto per adattarsi ai
  tratti corti;
- raccordo omesso e spigolo vivo conservato quando il raggio non è contenibile;
- discretizzazione adattiva per sagitta con tolleranza locale configurabile,
  default `0,005 m`;
- identità grafica Mandata/Chiusura/Return conservata nell'output;
- `SpiraliVittorio` invariata;
- `TERMODEL-SYNC.md` e README revisionato aggiornati.

Pubblicazione:
- commit funzionale principale: `9efb363822f953892e915b2c9864b129c7d6f381`;
- fix helper raccordi: `dc8af4d95542e9d7770ab4afc4f63893b6343457`;
- HEAD funzionale/test workflow: `7634d4e939556d9b23933f4b7cb5a4d9c488f9e3`.

Verifica reale:
- Fast Harness #121 / run `36666975115`: restore e **Build Harness + Core SUCCESS**;
- gate `Harness quadrato Vittorio_revisionato public closure`: **SUCCESS**;
- nel caso quadrato corrente LG-051 non trova un candidato rettilineo valido e
  lascia intenzionalmente il circuito aperto, comportamento previsto dalla
  specifica;
- equivalenza iniziale Vittorio/Vittorio_revisionato: **SUCCESS**;
- equivalenza multi-progetto (6 casi): **SUCCESS**;
- check astrazione strutturale: **SUCCESS**;
- quadrato sintetico Diego_Vittorio: **SUCCESS**;
- il workflow complessivo resta rosso sul Golden del quadrato pubblico
  Diego_Vittorio: hash attuale `5ddd0ffd...` contro Golden
  `fa8e6106...`. Il confronto con l'artifact SUCCESS del run
  `36383265029` mostra che tale geometria Diego_Vittorio era già cambiata
  fra il riferimento `932fce5` e lo stato precedente a LG-051
  `cad2c29c`; il Golden **non è stato aggiornato** e il controllo non è stato
  indebolito.
- Service Build #1183 / run `36666543124`: restore e sintassi JavaScript
  SUCCESS, ma il workflow si arresta prima di `dotnet build` per il controllo
  frontend preesistente `Cache-busting MyHome3D v1.35 non aggiornato`; il
  frontend pubblico è già v1.37. Il controllo deploy dello stesso run attende
  inoltre frontend 1.36 e pertanto non certifica il deploy.
- conseguenza: **Termodel.Core/Harness compilati e gate LG-051 eseguito**;
  **build completa Termodel.WebService e deploy Render non certificati in
  questa fase**.

Vincoli mantenuti:
- nessuna modifica al Golden Diego_Vittorio;
- nessuna modifica al frontend per aggirare il controllo;
- il controllo distanza minima fra chiusura e tubi resta solo un possibile
  perfezionamento futuro, come deciso in LG-051.

### INCARICO 2026-09-30 — Registrazione audit chiusura/raccordatura Vittorio_revisionato
Stato: ESEGUITO

Autorizzazione utente:
- registrare integralmente le decisioni dell'audit finale di `Vittorio_revisionato` nelle linee guida sviluppo spirali;
- registrare lo stesso checkpoint nel registro di recupero chat `docs/RECOVERY-ACTIVE.md`;
- attingere ai criteri già approvati di `Diego_Vittorio` senza modificare codice geometrico in questa fase.

Risultato:
- creata la nuova regola **LG-051** in
  `docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md`;
- formalizzata la separazione vincolante fra chiusura rettilinea e raccordatura successiva;
- formalizzati: segmento di chiusura `>=2P`, controllo intersezioni sulla geometria risultante, esclusione angoli acuti, arresto al primo candidato valido, circuito aperto come feedback visivo se nessun candidato è valido;
- formalizzato il percorso geometricamente unico con identità grafica/semantica dei tratti conservata;
- formalizzati raccordi circolari tangenti su tutti gli spigoli, raggio configurabile localmente con default corrente `0,10 m`, nessuna riduzione del raggio quando non contenibile e spigolo vivo accettabile;
- formalizzata discretizzazione adattiva degli archi con tolleranza locale configurabile, default `5 mm`;
- registrato come possibile perfezionamento futuro il controllo della distanza minima dagli altri tubi, non incluso nella prima implementazione;
- esplicitati i criteri riusabili da `Diego_Vittorio` e quelli da non trasferire (Bézier nella decisione di chiusura, `>=2P` sulla curva, riduzione automatica del raggio, conteggio fisso dei segmenti);
- registrato il debito tecnico corrente: bridge revisionato ancora non conforme a LG-051 e workflow da riallineare;
- aggiunto checkpoint completo in `docs/RECOVERY-ACTIVE.md` con recovery point esatto per la prossima chat.

Commit:
- registrazione iniziale incarico: `0349b2f26c942e5cb5342c539cfffabf351fc63a`;
- linee guida / LG-051: `99f796e44b5c66df03cc0d237f390f70c7ed203f`;
- recovery chat: `30f6592d2b977f7942e4b139d5320a952b7679ce`.

Verifica:
- rilettura GitHub di LG-051 e del nuovo checkpoint Recovery: contenuti presenti;
- nessun file sorgente del motore modificato;
- build/test non eseguiti perché l'incarico è esclusivamente documentale;
- stato LG-051: **progettato/documentato**, non implementato, non compilato, non testato.

### INCARICO 2026-09-28 — Istruzioni debug avanzato Harness rapido
Stato: ESEGUITO

Autorizzazione utente:
- creare, se assente, un documento Git del progetto Termodel dedicato alle istruzioni di debug;
- nome documento: `Server/Termodelwebservice/docs/ISTRUZIONI_DEBUG.md`;
- registrare il setup concordato con chiave esatta `Debug_Avanzato_harness_rapido`;
- il setup deve riusare `TermodelLog`, categorie selettive e Harness rapido, senza introdurre sistemi diagnostici paralleli.

Risultato:
- documento creato su `main` nel commit `70411ac00260048e8763f2553d9acfb32f210f20` e chiave resa univoca nel commit `80913c103c26bc8a430975eaac86ce350e21a633`;
- chiave `Debug_Avanzato_harness_rapido` presente come setup operativo permanente;
- documentati `TermodelLog`, `SpiraliDiegoVittorio`, parametri Service `logEnabled/logCategories`, equivalenti Harness `--log-enabled/--log-categories`, sottotag stabili e ciclo esegui -> leggi log -> aggiungi solo il log mancante -> riesegui;
- registrata la regola di non modificare geometria/strategie durante la sola osservazione e di consolidare poi con regression;
- riferimento autorevole: `Server/Termodelwebservice/docs/ISTRUZIONI_DEBUG.md`.

### INCARICO 2026-09-28 — SVG pre-chiusura diagnostico locale_1
Stato: ESEGUITO

- aggiunto all'Harness Diego_Vittorio il flag diagnostico `--skip-close`, commit `50e8808769343f5500af095a5f62fd656e045173`;
- il flag riusa `TERMODEL_DIEGO_VITTORIO_DRAW_CLOSURE=false`: mantiene Supply + Return autonomo e sospende esclusivamente la chiusura centrale;
- workflow Fast commit `39c83fd1194acacbb5a9e129418c2f4eb828d8ac`;
- run `36441043047` SUCCESS, artifact `DV-LOCALE1-T6-PRECLOSE.svg`, SHA-256 `8620835cf47f6b47f55942f55ae5b628db53033557beb0eb862aaa0104bec5db`;
- confronto verificato: Return pre-chiusura 66 punti SVG contro 54 dopo chiusura; la chiusura M4/RP3 dichiara `tagli=0/3` e 3,81 m rimossi dal Return;
- nessuna modifica alla geometria produttiva; modalità destinata al debug avanzato.

### INCARICO 2026-09-28 — Indagine locali esempio pannelli radianti uno per uno
Stato: COMMISSIONATO

Origine:
- il quadrato base dell'esempio 1 è giudicato corretto dall'utente;
- il secondo esempio pubblico **Pannelli radianti** mostra risultati non ripetibili e più locali con geometrie gravemente errate;
- l'indagine deve procedere **locale per locale**, iniziando dai locali rettangolari più semplici, usando il Fast Harness.

Vincolo di regressione prioritario:
- il risultato corrente del **quadrato base esempio 1** è il riferimento protetto;
- ogni correzione candidata deve essere verificata contro il quadrato base;
- se modifica il risultato geometrico del quadrato base, la correzione deve essere respinta o resa più circoscritta prima di essere consolidata;
- nessuna modifica strutturale generale del motore senza nuovo accordo umano.

Fasi anti-timeout:
- **FASE 1 — estrazione casi reali:** partire dal vero progetto pubblico `Pannelli radianti`, produrre il medesimo `RadiantPanelInputXml` del Service, classificare i locali e creare fixture Harness indipendenti iniziando dai rettangolari;
- **FASE 2 — primo locale rettangolare:** riprodurre il risultato attuale, tracciare Supply/Return e isolare il primo errore causale; applicare soltanto correzioni locali che lascino invariato il quadrato base;
- **FASE 3+ — locali successivi:** procedere uno per volta, aggiungendo ogni caso risolto alla regression Fast prima di passare al successivo;
- ogni fase significativa termina con checkpoint persistente e Issue #1; le singole build restano notificate dalle Actions e non richiedono Issue dedicate.

Stato fasi:
- **FASE 1 — ESEGUITA:** input reale del progetto pubblico estratto tramite il vero `GeneraModello`, SHA-256 `15E9F73DEB570F4E17385FF3CD7335916DD8023C69A630925CF083C24A41109A`. Classificati 9 locali, 6 con circuito/ingresso pannello e 4 rettangolari con pannello: `locale_1` (T6, 3,09×5,50 m), `locale_5` (T1, 5,43×4,24 m), `locale_8` (T3, 3,91×4,24 m), `locale_9` (T5, 2,57×4,41 m). Salvata una sola fixture condivisa `tests/radiant-harness/prepared/PannelliRadiantiPublic.pannelli.xml`; aggiunto al Harness il filtro `localeId/--locale` nel commit `3b1193fbdd814af6598a4bf08ba8fd800b7cff1c` e creati quattro case indipendenti. Il quadrato approvato è bloccato da baseline esatta SVG SHA-256 `fa8e61061050a1f18026b3d2150270c013d2b4ca1d72e1f72f5fb7c21375fa39`, 16 punti; Fast Harness run `36385818334` SUCCESS.
- **FASE 2 — ESEGUITA (`locale_1`):** il trace dei portali ha escluso l'ipotesi “varco superato troppo presto”. La causa Return era un corridoio Supply largo esattamente `2p=0,60 m`: il campionamento storico a `p/2` non colpiva l'unica mezzeria valida. Commit `9c0aa251250fd2058e34189b225aa96c3bbd1601`: fallback geometrico, attivo solo se la ricerca esistente fallisce, sulle coordinate critiche `estremo mandata ± distanzaCondizionamento`. Return `locale_1`: 6→18 punti e offset 2/3 completati. Restava la chiusura: tutte le configurazioni LG-048 dirette fallivano realmente, ma esisteva una proiezione ortogonale di 0,60 m dal terminale Supply `(0,82;3,54)` al tratto Return a `x=0,22`. Commit `401bd0c7e018553800a0378ecdf9a4516a69ccca`: fallback di chiusura proiettata soltanto dopo il fallimento delle configurazioni dirette; accettato `M4/RP3`, 0,60 m. Fast Harness run `36402218998` SUCCESS: `DIEGO_VITTORIO_PUBLIC_PANELS_LOCALE1_OK` e quadrato approvato byte-identico (`DIEGO_VITTORIO_APPROVED_SQUARE_BASELINE_OK`). Stato: tecnicamente risolto e SVG Harness ispezionato; resta conferma visiva utente nel progetto completo.
- **FASE 3 — ESEGUITA (`locale_5`):** il trim del terminale Return (commit `ab09475b8afb482b6fa948aebb828f7356ad225e`) porta il Return da 6 a **16 punti** e completa i 3 offset utili senza rilassare autointersezioni o distanze. La chiusura storica `M3/R5` obliqua da 2,454 m è risultata visivamente troppo lunga; la diagnostica ha enumerato anche `M2/RP3` ortogonale da 1,24 m. L'utente ha autorizzato un cambio circoscritto LG-048. La prima preferenza assoluta per l'ortogonale (`aedf756a`) ha correttamente fatto fallire il Golden del quadrato nel run `36405315739` per una variazione marginale 0,753 -> 0,740 m. Correzione finale `fb26ed054149a222c54cf706c099af9c066837ea`: sostituire il primo candidato storico soltanto quando è obliquo e una chiusura ortogonale valida lo accorcia di almeno un passo `p`; altrimenti comportamento storico invariato. Regression `locale_5` aggiunta nel commit `a6507361ef69fa8dcb7e3520888814abeb2396ec`. Fast Harness `36405693422` SUCCESS: quadrato pubblico byte-identico SHA-256 `fa8e61061050a1f18026b3d2150270c013d2b4ca1d72e1f72f5fb7c21375fa39`, `locale_1` invariato, `locale_5` = Return 16 punti + `M2/RP3` ortogonale 1,24 m. SVG artifact ispezionato: eliminata la precedente diagonale centrale lunga.
- **FASE 4 — ESEGUITA (`locale_8`):** causa isolata nella classificazione topologica dei dogleg locali del Return. Un segmento A-B, seguito dal solo raccordo B-C e dal candidato C-D, veniva trattato come ramo remoto anche quando la distanza minima A-B/C-D coincideva esclusivamente con la lunghezza del raccordo corto B-C e i due rami divergevano sui lati opposti. Diagnostica `d10e31d2b02b39b504dcde8db9e0d92f94e09619`, Fast Harness `36406990692`: Return 3→18 punti e due dogleg locali riconosciuti; SVG ispezionato e percorso ordinato. Correzione finale `18cd798a22c72d39d5dfbbfaba647e1e91fdcf5a`: la sola adiacenza dogleg locale è attiva per default e disattivabile con `TERMODEL_DIEGO_VITTORIO_LOCAL_DOGLEG_ADJACENCY=false`; tutti gli altri controlli Return-Return restano invariati. Regression dedicata nel commit `109dac86a8703f8d21b04b6486e00cda0fd49a01`. Fast Harness `36407499506` SUCCESS senza flag diagnostici: quadrato approvato byte-identico, `locale_1`, `locale_5`, `locale_8` e fitting regression verdi; `locale_8` Return 18 punti e chiusura 0,971 m.
- **FASE 5 — ESEGUITA (`locale_9`):** sul codice corrente il caso produce Return **13 punti**, 2 offset utili e nessun arresto. La regola LG-048 già consolidata seleziona `M3/RP2` ortogonale da **0,77 m** al posto della precedente `M3/R5` obliqua da 1,875 m. Fast Harness inspection `36407962757` SUCCESS e SVG ispezionato: geometria ordinata, nessuna nuova correzione del motore necessaria. Regression dedicata aggiunta nel commit `3f055f37132643e4e09b9ec0bc3dc3615b122b75`; Fast Harness `36408292815` SUCCESS con quadrato approvato, `locale_1`, `locale_5`, `locale_8`, `locale_9` e fitting regression tutti verdi.
- **FASE 6 — VALIDATA TECNICAMENTE / ATTESA CONFERMA VISIVA UTENTE:** commit `a4f478c9a44c7764df45b8ce8b2801938c96fde7`; Room Extraction run `36408840730` SUCCESS. Il vero progetto pubblico è stato ricostruito attraverso `GeneraModello`; input SHA-256 `15E9F73DEB570F4E17385FF3CD7335916DD8023C69A630925CF083C24A41109A` invariato. Sul medesimo input reale sono confermati `locale_1` Return 18 + `M4/RP3` 0,60 m, `locale_5` Return 16 + `M2/RP3` 1,24 m, `locale_8` Return 18 + `M3/R5` 0,971 m, `locale_9` Return 13 + `M3/RP2` 0,77 m; marker `FULL_PROJECT_RECTANGULAR_REGRESSION_OK`. Artifact finale ispezionato: nessuna ricomparsa della diagonale patologica di `locale_5`. Restano da ottenere soltanto la conferma visiva dell'utente sul frontend e poi la chiusura definitiva del recovery. Durante `GeneraModello` compaiono inoltre messaggi preesistenti sul valore `Solaio piano` usato come colore copertura; non compromettono il test pannelli e sono lasciati fuori da DV-TEST-002. Prima del collaudo finale è stata inoltre completata la sottofase frontend FASE 6A: v1.34 mostra nel CAD2D una zona discreta di provenienza dell'esecutivo. Gli asset statici dichiarano esplicitamente GPT/SpiraliGPT, Service `aba9bd29` e consolidamento `9a4c0b7d`; gli artifact runtime leggono invece `serviceCommit` e `spiralEngine` reali da `/health`. Commit frontend finale `90bb914e7bcdb0cff17d9bd19d1bf2701ccf8424`; marker `CAD_EXECUTIVE_PROVENANCE_OK` e build Service SUCCESS nel run `36411206078`; GitHub Pages `36411205191` SUCCESS. Il fallimento terminale dello stesso workflow è il Golden Darcy sintetico già noto e indipendente.
- **FASE 6B — COMPLETATA:** congelati nei due esempi pubblici gli esecutivi approvati Diego_Vittorio. Commit asset `e0121145ca88014edb6204e2d97bf99366497989`; frontend/catalogo v1.35 `ed87c6ad59cd60d008e7ffe2ed13885bea3dcaf3`. `Pannelli radianti` usa lo statico SHA-256 `6a1c79ed23b8dcfde6fcffb484a029f54d5355793b32422e30c6e19cca0f2a3d` dal run `36411641717`; `Quadrato con pannelli` usa `1cd73beba29edb1c44adc7dd4719123872ed58de5f9f5c901a88f39a3f52f8f6` dal run `36383027266`. Gli esempi possono essere ispezionati senza Service; `Aggiorna Modello` resta il confronto runtime. Run `36414512616`: provenance/static executives/progetto pubblico/build tutti SUCCESS prima del Golden Darcy indipendente; Pages `36414512118` SUCCESS.
- **FASE 6C — DIAGNOSI SUPPLY COMPLETATA / CORREZIONE NON ANCORA AUTORIZZATA:** introdotta modalità Harness `--supply-only` nel commit `b2d9511a2721637bddeb838272163ca15e255513`, che esegue la sola mandata prima di Return/LG-048. Fast run `36416240750` SUCCESS: l'arresto è già presente nella Supply grezza e avviene durante generazione/ammissione del livello interno successivo, non nella percorrenza. Trace approfondito `3bc7fae41e643a3baa1273a5cc3694da04d7ebb7`, run `36417080491` SUCCESS: il limite storico è `anello chiuso completo oppure stop`. Nei rettangoli `locale_1/5/8` l'ultimo anello ha lato corto 1,59/1,54/1,21 m: con passoMandata 0,60 m un singolo asse centrale resta geometricamente possibile (semilarghezze 0,795/0,77/0,605 m), mentre quadrato approvato 1,04 m e `locale_9` 1,07 m non lo consentono e restano fuori dal candidato. Nei concavi `locale_2/6` un solo lato corto (0,36/0,29 m) fa scartare globalmente un offset a 6 vertici altrimenti in parte sviluppabile. La stessa logica `ComputeOffset` e la stessa finalizzazione sono presenti nel riferimento Desktop/Vittorio. Registrata inoltre l'omissione storica del lato di chiusura nel calcolo `minEdgeLength`; non causa l'arresto corrente. Prossimo passo solo previa autorizzazione: prototipo Harness di asse terminale rettangolare, senza attivazione Service.
- **FASE 6D / STEP 4C — ACCESSO T6, PRIMO ERRORE CAUSALE IDENTIFICATO:** Fast Harness run `36438139064` SUCCESS. Nel vero `R001 / locale_1` il tratto interno T6 va da `(1,57000;4,74316)` a `(1,31155;4,74316)`. Dopo il tratto iniziale comune e il primo raccordo adiacente, il primo ramo superiore della Supply `(1,42;5,27)->(-1,37;5,27)` passa a **0,52684 m** da T6 contro distanza Supply-Supply richiesta **0,60 m**, ma viene accettato con `respectSelf=true`. Causa: `SpiralGenerator.Generate` storicamente conserva solo lo startPoint e `SegmentoRispettaSpirale` non vede la geometria T6. Anche il primo sviluppo dell'offset 2 arriva a 0,496965 m dal terminale T6. Nessuna correzione ancora applicata; prossimo passo da concordare: includere il tratto interno d'accesso nella validazione Supply con eccezioni di adiacenza iniziale e definire la scelta del verso quando il corridoio iniziale è più stretto di 2p.\n- **FASE 6D — AUTOPSIA SUPPLY `locale_1` IN CORSO:** unico caso ammesso `locale_1` reale/T6; Return e LG-048 esclusi. Percorso Harness -> benchmark -> `AggiornaSoloMandata` -> `Generate` verificato; normalizzazione conserva correttamente il rettangolo 3,09×5,50 m. L'aborto L3 è stato ricostruito: con offset 0,60 m i due lati da 1,59 m attivano la regola storica `edgeLength <= 3*offset && shrink > offset`, gli `skipIndices` diventano `{0,1,2,3}` e `ComputeOffset` restituisce null. Il raw matematico sarebbe 0,39×2,80 m, ma come anello chiuso completo è realmente troppo stretto: 0,39 m < distanza Supply-Supply 0,60 m, e verrebbe respinto anche dal successivo `minEdgeLength < passoMandata`. Per l'indagine è stato adottato il logger esistente: nuova categoria Service/Core `SpiraliDiegoVittorio`, commit `e35f05099179aae5f1af6df80527c00d0704c1c5`, filtrabile con `logEnabled/logCategories`; Harness supporta `--log-enabled`/`--log-categories`. Fast run `36422697579` SUCCESS. Dopo lettura log sono stati aggiunti esclusivamente i dettagli mancanti di percorrenza nel commit `49f28610128096e87db27fbea58f5d7f73f9d27d`; Fast run `36423105809` SUCCESS con tutte le regression verdi. Il percorso reale dell'offset 2 termina in `(0,82;3,54316)` e lascia un varco di 0,60 m; tutti i segmenti ammessi rispettano i controlli. Limite strutturale ora da verificare: gli offset chiusi vengono pre-generati prima della spirale reale, quindi l'aborto del livello successivo avviene senza conoscere terminale/varco. Prossimo passo: solo `locale_1`, diagnosticare segmento per segmento una transizione non applicata verso il raw L3 e trovare il primo tratto che viola davvero 0,60 m. Build Service `36423105927`: 0 errori; stop successivo solo sul Golden Darcy indipendente (1,31367490344266 vs 1,343675 Pa).
- linee guida `DV-TEST-002` aggiornate con causa/correzioni `locale_1` e avvio `locale_5` nel commit `e115641959fc14a67e9f91eeb9fb70d5999aa30f`.


Regole:
- usare il percorso locale/Fast Harness come banco primario e GitHub Actions solo per consolidamento;
- preservare `SpiraliVittorio`;
- `StrategiaDiego` resta PARKED;
- nessuna modifica frontend o `definizionedati.json`, salvo interventi frontend esplicitamente autorizzati come FASE 6A;
- non usare il risultato corretto di un locale per mascherare regressioni in altri: ogni locale deve avere fixture, log e regression propri;
- aggiornare le linee guida spirali con i casi e le cause realmente accertate.

Criteri FASE 1:
- input reale del progetto pubblico estratto senza ricostruzione manuale;
- elenco dei locali con perimetro, ingresso e classificazione geometrica;
- fixture indipendenti per i locali rettangolari;
- baseline del quadrato base protetta nel Fast Harness.


### INCARICO 2026-09-28 — Pubblicazione correzione quadrato e aggiornamento Render
Stato: ESEGUITO

Autorizzazione utente:
- la correzione `DV-TEST-001` del quadrato `Diego_Vittorio` è giudicata soddisfacente;
- autorizzata la pubblicazione dello stato corrente e l'aggiornamento del Service pubblico su Render.

Fasi:
- **FASE 1 — consolidamento/pubblicazione:** registrare l'approvazione umana e lasciare su `main` lo stato approvato, senza ulteriori modifiche geometriche;
- **FASE 2 — deploy e verifica pubblica:** lasciare partire il normale auto-deploy Render da `main`, verificare `/health` e, se possibile, riprodurre il quadrato pubblico sul Service ospitato per confermare che il Return aggiornato sia effettivamente in esecuzione.

Stato fasi:
- **FASE 1 — ESEGUITA:** approvazione umana registrata; stato approvato pubblicato su `main`. Allineato il controllo CI di `/health` al default `Diego_Vittorio` nel commit `264cd2c7beee303d9dbfca20bd8444cc10ee768d`; aggiornato il contratto runtime nel commit `456d6577c278a94afdc55db715cbbe4f695f6bc5`. Nessuna modifica geometrica aggiuntiva.
- **FASE 2 — ESEGUITA:** il normale auto-deploy Render ha pubblicato lo stato approvato. Aggiunto il verificatore remoto leggero `.github/workflows/termodel-render-verify.yml`; il run `36384533237` ha letto l'ultimo commit che tocca `Server/Termodelwebservice` e ha verificato al primo tentativo `https://termodel.onrender.com/health`: `status=ok`, `serviceCommit=be300830608f428170f0c6dadefd60866cf2c0ee`, `serviceCommitShort=be300830`, `spiralEngine=Diego_Vittorio`. Il verificatore usa il commit Service e non l'ultimo commit globale del repository, perché modifiche solo a `.github`/frontend possono non richiedere deploy Render.


Vincoli:
- nessuna ulteriore modifica strutturale o geometrica in questa pubblicazione;
- `SpiraliVittorio` invariata;
- `StrategiaDiego` resta PARKED;
- nessuna modifica frontend o `definizionedati.json`;
- distinguere approvazione utente, commit pubblicato, deploy Render e verifica HTTP reale.

Criteri di completamento:
- approvazione umana registrata;
- `main` contiene lo stato approvato;
- auto-deploy Render attivato dal push su `main`;
- Service pubblico verificato almeno via `/health`; preferibile verifica funzionale del quadrato sul Service remoto;
- Issue #1 chiusa per ogni fase significativa.

Esito:
- correzione `DV-TEST-001` approvata esplicitamente dall'utente per la pubblicazione;
- nessuna ulteriore modifica geometrica introdotta durante il deploy;
- controllo CI `/health` corretto dal vecchio default `Diego` a `Diego_Vittorio` nel commit `264cd2c7beee303d9dbfca20bd8444cc10ee768d`;
- contratto Front↔Service allineato all'identità runtime `Diego_Vittorio` nel commit `456d6577c278a94afdc55db715cbbe4f695f6bc5`;
- Render verificato realmente via GitHub Actions nel run `36384533237`: commit Service `be300830`, motore `Diego_Vittorio`, stato `ok`;
- la build del progetto Service compila correttamente; la suite ordinaria GitHub `TermodelService Build` resta rossa in uno smoke successivo e indipendente per il Golden Darcy sintetico fuori tolleranza. Questo errore non è nel motore spirali né impedisce il deploy Docker/Render e non viene corretto in questo incarico;
- il nuovo verificatore Render è serializzato per evitare esecuzioni/notifiche duplicate e può essere riusato per controllare in modo economico il runtime pubblico;
- la regression funzionale del quadrato `Diego_Vittorio` resta quella già verificata in GHA sullo stesso input reale (`36383027266` e Fast Harness `36383265029`); la verifica Render corrente certifica che il Service pubblico sta eseguendo il commit contenente quella correzione.


### INCARICO 2026-09-28 — Indagine anomalie quadrato `Diego_Vittorio` e Harness rapido
Stato: ESEGUITO

Obiettivo:
- eliminare le anomalie osservate nel disegno spirali dell'esempio quadrato sul Service, pur essendo il quadrato apparso corretto nel precedente Harness locale;
- verificare come primo sospetto differenze di approssimazione/tolleranza e perdita di spazio di manovra del Return autonomo quando resta confinato nel “budello” generato dalla mandata;
- non introdurre modifiche strutturali a `Diego_Vittorio` senza accordo esplicito dell'utente; sono autorizzati soltanto interventi circoscritti, diagnostici, di Harness/test o correzioni locali chiaramente motivate;
- ricostruire e aggiornare il banco Harness/Git in modo da rendere il ciclo umano `modifica -> esegui -> osserva` il più rapido possibile, minimizzando commit/push/Action non necessari;
- aggiornare le linee guida spirali con questa modalità operativa;
- procedere con l'indagine fino alla prima causa riproducibile o fino a una decisione strutturale che richieda consenso umano.

Suddivisione anti-timeout:
- **FASE 1 — ricostruzione banco e stato reale:** leggere Harness, workflow, fixture quadrato, direttive e sorgenti pertinenti; definire il percorso rapido e il caso canonico corrente;
- **FASE 2 — Harness rapido:** applicare solo modifiche circoscritte agli strumenti di test/workflow per ridurre tempi e dipendenza da GitHub, mantenendo riproducibilità;
- **FASE 3 — indagine quadrato:** riprodurre e confrontare Harness/Service, isolare tolleranze/decisioni/stop del Return e proporre o applicare solo correzioni locali autorizzate;
- ogni fase significativa termina con checkpoint persistente e notifica tramite Issue #1; le singole build restano coperte dalle notifiche Actions e non generano Issue dedicate.

Stato fasi:
- **FASE 1 — ESEGUITA:** ricostruito il banco corrente e accertato che il precedente quadrato sintetico Harness non è equivalente al quadrato pubblico: la fixture Harness usa ingresso verticale `(2,-1)->(2,1)`, mentre l'esempio Web usa ingresso orizzontale da sinistra `(-0,5,2)->(0,5,2)`. Accertato inoltre che l'esecutivo statico pubblico era stato generato forzando `GPT`, quindi non è Golden di `Diego_Vittorio`. Registrata la campagna `DV-TEST-001` nelle linee guida nel commit `b370a42b894a40eedc1a33a38c0a4e332be4c8f9`.
- **FASE 2 — ESEGUITA:** `LocalRadiantHarness.ps1` usa ora per default working tree diretto + stamp leggero e build incrementale, con `-NoBuild`, `-PreparedInput` e mirror legacy solo con `-UseMirror` (commit `89da0bd5cc6872c40bf445db65f7ea9a08b61873`). Il progetto quadrato pubblico può essere preparato una sola volta nel vero percorso `GeneraModello` e poi rieseguito direttamente nell'Harness (commit `f3df3663cc755d81b8d129746ad3a802580d8b4c`, `a1054fc37ca76d3687d6de4a68c8a1be051fb7d6`). Creato il workflow leggero `Termodel Diego_Vittorio Fast Harness`; il workflow completo StrategiaDiego, PARKED, è ora manuale e il suo benchmark è escluso dalla build Service ordinaria. Primo Fast Harness verificato SUCCESS nel run `36381719445`.
- **FASE 3 — ESEGUITA:** estratto dal vero progetto pubblico il medesimo `RadiantPanelInputXml`, SHA-256 `EE34962A077971B81E00EE64186A1A52881159303E20230A6FBC8D87FAB47C44`, e riprodotto lo stesso stop in Service/Harness, escludendo frontend e conversione progetto. Il trace ha respinto l'ipotesi precisione come causa primaria: i deficit erano `0,08–0,30 m` contro tolleranza `1e-6 m`. Isolato invece un errore locale di classificazione dell'adiacenza Return-Return: la prosecuzione collineare del raccordo veniva confrontata contro il segmento immediatamente precedente al gomito come se fosse un ramo remoto. Corretti il candidato di lunghezza zero (commit `abbfc149bfb99eac8193a42a244704612c4877ab`) e l'adiacenza collineare (commit `7f87d36a717bea7608452d8d6d550fb9f6fafbb7`), senza backtracking, nuove euristiche, variazione delle distanze o delle tolleranze. La correzione è attiva per default e disattivabile con `TERMODEL_DIEGO_VITTORIO_COLLINEAR_ADJACENCY=false`.
- **VALIDAZIONE FASE 3:** workflow completo sul progetto quadrato pubblico, run `36383027266`: SUCCESS con configurazione default, Return da 6 a **17 punti**, scomparsa degli stop offset 2/3, input invariato. Nuova fixture reale `DiegoVittorioPublicSquareLeft.locale.xml` + case `DV-PUBLIC-SQUARE-LEFT-P030-DIEGO-VITTORIO`; Fast Harness run `36383265029`: **SUCCESS** su build Core/Harness, quadrato storico, quadrato pubblico, Return 17 punti, chiusura rapida e raccordi. Il workflow diagnostico completo progetto -> Service -> Harness è stato poi reso manuale nel commit `ca8c851efadca9e22cc399edebfb2b9628b1e8f9`.
- **DOCUMENTAZIONE:** README Core aggiornato nel commit `46e757f00a887506212f61b65feb61ade0261eee`; linee guida consolidate con causa, correzione, rollback e regression nei commit `8e218ec1866eead86cfc1122a65029da7d13c7fe` e `c6cb751a2078b1b0c67f3ce7345dc9bd3c34c120`.

Vincoli rispettati:
- `SpiraliVittorio` invariata;
- `StrategiaDiego` resta PARKED;
- nessuna modifica al frontend o a `definizionedati.json`;
- nessun cambio strutturale dell'algoritmo `Diego_Vittorio`: la correzione riguarda soltanto la classificazione topologica locale di un segmento adiacente collineare;
- `DV-KNOWN-001` resta aperto per i veri casi di Return intrappolato: la correzione del quadrato elimina un falso stop specifico, non introduce una strategia generale di fuga dal “budello”.

Verifica reale:
- implementato, compilato ed eseguito in GitHub Actions;
- confrontato sul medesimo input pannelli estratto dal progetto quadrato Web;
- **non ancora dichiarato verificato sul processo Render pubblico post-deploy**: il collaudo finale sul Service ospitato resta distinto dalle prove GHA e potrà essere confermato dal normale test utente dopo il deploy.


### INCARICO 2026-09-28 — Direttiva fasi anti-blocco e notifiche Issue #1
Stato: ESEGUITO

Commissionato:
- rendere permanente la regola che gli incarichi gravosi devono essere suddivisi prima dell'esecuzione in fasi coerenti, autonome e riprendibili;
- ogni fase deve lasciare un checkpoint persistente sufficiente a permettere a una nuova chat di continuare senza rifare il lavoro precedente;
- alla conclusione di ogni fase significativa usare la Issue #1 per notificare esito riuscito/fallito;
- evitare notifiche eccessive: non usare Issue #1 per ogni commit, micro-passaggio o build, perché le build dispongono già delle notifiche GitHub Actions;
- mantenere distinta la notifica di fase dalla notifica automatica delle build.

Criteri di completamento:
- protocollo anti-timeout aggiornato;
- regola riportata nel Summary autorevole;
- nessuna modifica a codice applicativo o `definizionedati.json`.

Esito:
- `.github/TERMODEL-CHAT-ANTI-TIMEOUT.md` aggiornato nel commit `87da7b30d4d9431c05748a5f0beab11255ca6742`;
- gli incarichi gravosi devono ora essere suddivisi preventivamente in fasi coerenti, autonome e riprendibili;
- ogni fase significativa deve lasciare un checkpoint persistente e terminare con notifica tramite Issue #1;
- Issue #1 non va usata per ogni commit o build, per evitare duplicazioni con le notifiche GitHub Actions già attive;
- nessuna modifica a codice applicativo, frontend o `definizionedati.json`; nessuna build necessaria.


### INCARICO 2026-09-28 — Stato strategie spirali e limite ritorno autonomo
Stato: ESEGUITO

Commissionato:
- registrare `StrategiaDiego` come linea attualmente parcheggiata per costo computazionale molto elevato, con lavoro futuro orientato a ridurne il costo per l'uso su locali geometricamente molto complessi;
- registrare `Diego_Vittorio` come derivazione da Vittorio con varie correzioni e una modifica strutturale fondamentale: il Return non è più il riflesso/parallelo della mandata ma viene generato autonomamente;
- specificare che il Return autonomo è condizionato dal perimetro dell'edificio/locale, dalla mandata e dalla propria geometria già costruita;
- registrare il principale limite osservato nel collaudo: la mandata può creare corridoi o “budelli” nei quali il Return autonomo resta imprigionato e può produrre arresti prematuri/non corretti;
- trattare questo comportamento come limite noto da raccogliere in casi reali e future regression, senza modificare in questo incarico il motore.

Criteri di completamento:
- Summary e registri spirali allineati a questa distinzione architetturale;
- nessuna modifica al codice geometrico, frontend o `definizionedati.json`;
- incarico chiuso con commit documentali tracciati.

Esito:
- `STRATEGIADIEGO-DEVELOPMENT-REGISTER.md` marcato **PARKED** e corretto il ruolo futuro della linea nel commit `cfd5a18cb6ba7814517d9560dbde7bb10b048128`;
- registro strategie aggiornato con distinzione `StrategiaDiego` / `Diego_Vittorio`, architettura del Return autonomo e problema del “budello” nel commit `827112662e37bdea037b0ecb61bd19ad6225795c`;
- linee guida aggiornate nel commit `de9308fb4c794c1e19a8b8898df2df36f01da529`, includendo `DV-ARCH-001` e `DV-KNOWN-001`, e corretti i riferimenti obsoleti che indicavano StrategiaDiego come default;
- README della derivazione Core aggiornato nel commit `e787ac9424632594f08679c2fed5d5653b29f2e4` per chiarire che il parallelo gemello riguarda solo il collegamento iniziale e non la generazione dell'intero Return;
- nessuna modifica al codice geometrico, frontend o `definizionedati.json`; incarico esclusivamente documentale, quindi nessuna nuova build necessaria.


### INCARICO 2026-09-28 — Registrazione avvio test server `Diego_Vittorio`
Stato: ESEGUITO

Commissionato:
- verificare se Codex ha già registrato l'avvio dei test manuali sul Service pubblico della strategia spirali corrente;
- se manca, aggiornare i registri autorevoli senza modificare il motore;
- allineare il registro strategie allo stato reale: `Diego_Vittorio` è il default operativo del Service, mentre `SpiraliVittorio` resta il riferimento invariato;
- distinguere i test automatici/harness già eseguiti dal collaudo manuale sul server iniziato dall'utente.

Criteri di completamento:
- Summary e registro spirali coerenti con la fase di collaudo reale iniziata;
- nessuna modifica al codice geometrico o a `definizionedati.json`;
- commit GitHub tracciato e incarico chiuso come `ESEGUITO`.

Esito:
- verificato che Codex aveva già consolidato e attivato `Diego_Vittorio` sul Service, ma non era ancora registrato esplicitamente l'avvio del **collaudo manuale sul Service pubblico** comunicato dall'utente;
- aggiornato `docs/spirali-strategy-register/README.md` nel commit `9fb08fd3a290a564471c1f50efbe36f888b29b94`, eliminando il riferimento ormai obsoleto alla sola futura StrategiaDiego e registrando `Diego_Vittorio` come default corrente in test;
- aggiornato `docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md` nel commit `84d5c51da601ee6a6ce486ec4d88583520d573dd`: stato runtime portato al 28/09/2026 e nuova sezione dedicata all'avvio del collaudo manuale sul Service pubblico;
- distinta esplicitamente la fase di test manuale reale dalle prove Harness/locali/GitHub Actions già eseguite;
- aggiornato anche `docs/STRATEGIADIEGO-DEVELOPMENT-REGISTER.md` nel commit `50946c5cd91c7836ab443074687717335223f217`, chiarendo che quel registro resta autorevole per lo storico del motore `Diego` ma non rappresenta più il default del Service;
- nessuna modifica al motore, al frontend o a `definizionedati.json`; nessuna build necessaria per questo incarico esclusivamente documentale.


### INCARICO 2026-09-28 — Consolidamento e attivazione Service di `Diego_Vittorio`
Stato: ESEGUITO

Commissionato:
- consolidare su GitHub lo stato corrente della strategia indipendente
  `Diego_Vittorio`, considerata la migliore disponibile per i casi ortogonali;
- mantenere `SpiraliVittorio` rigorosamente invariata come riferimento e
  possibilità di confronto/ripristino;
- impostare `Diego_Vittorio` come motore predefinito del WebService, lasciando
  disponibili gli override `Vittorio | GPT | Diego | Diego_Vittorio`;
- attivare nel percorso Service corrente ritorno autonomo, chiusura rapida
  LG-048 e raccordi adattivi LG-049, conservando i flag per il debug;
- verificare build e regression del quadrato ortogonale, quindi eseguire commit
  e push su `main`;
- usare la GitHub issue #1 se è necessario un intervento umano.

Criteri di completamento:
- sorgenti `Diego_Vittorio`, test e linee guida pubblicati;
- default Service e capability coerenti con `Diego_Vittorio`;
- build senza errori e prove geometriche correnti superate;
- commissione chiusa come `ESEGUITO` con risultati e commit registrati.

Esito:
- consolidamento funzionale registrato nel commit
  `9c311cb96738c2c82d3da5a1f5d3b4c533f036b0`;
- `SpiraliVittorio` verificata invariata;
- `RadiantExecutiveGenerator` usa `Diego_Vittorio` quando
  `TERMODEL_SPIRAL_ENGINE` non è valorizzata; gli override storici restano
  disponibili;
- ritorno autonomo, chiusura LG-048 e raccordi LG-049 sono attivi per default
  nel motore, con flag `false` disponibili per il debug;
- build Release completa: 0 errori, 494 warning storici;
- `/health` verificato localmente con `spiralEngine: Diego_Vittorio`;
- quadrato canonico p=0,30 m: distanze, ritorno autonomo, chiusura rettilinea,
  chiusura raccordata e raccordi sintetici 30°/90°/150° superati;
- SVG raccordato finale: 59 punti mandata, 51 ritorno, chiusura a 7 punti,
  nessuna intersezione e SHA-256
  `69193E08D795A184D54F4BBC7FDEF9A86C48F691054ED20622026E1A6A594962`.
- il primo run cloud ha mostrato che lo step `Run Diego_Vittorio current
  apartment copy` verificava ancora il precedente default con raccordi
  disattivati; il workflow è stato allineato al nuovo default nel commit
  `4f30bf29082aad07c54375169a688fcdc8750be3` e lo step corretto è stato
  riprodotto localmente con esito `WORKFLOW_DIEGO_VITTORIO_STEP_OK`;
- i fallimenti cloud residui `Run Decision Reject Replay` e `Benchmark
  StrategiaDiego regression fixtures` sono preesistenti e compaiono invariati
  anche nei run precedenti, su sorgenti `StrategiaDiego` non modificati da
  questo incarico.


### INCARICO 2026-09-27 — Help Web PC e istruzione AI Termodel Web
Stato: ESEGUITO — FRONTEND v1.33 / TERMODEL WEB AI v0.1 PUBBLICATI

Esito:
- verificato il contenuto pubblico esistente in `docs/termodel-ui-demo`: erano presenti `IndiceAI`, `TermodelGenerale`, `CreaProgettoDaDescrizione` e `CreaPianoTermodelDaRaster`, ma **non esisteva una istruzione autonoma specifica denominata Termodel Web PC**; `info_termodelwebservice.md` è documentazione tecnica frontend/backend e non un'istruzione AI utente;
- creata la nuova sorgente pubblica dedicata `docs/termodel-ui-demo/TermodelWeb.md`, versione **Termodel Web AI 0.1**, con corrispondente pagina leggibile `TermodelWeb.html`;
- la nuova istruzione Web mantiene la struttura modulare e rimanda alle istruzioni già esistenti:
  - `TermodelGenerale.html` per le regole comuni;
  - `CreaProgettoDaDescrizione.html` per la generazione da descrizione testuale;
  - `CreaPianoTermodelDaRaster.html` per la generazione da sfondo bitmap/raster;
- la nuova istruzione definisce esplicitamente il contesto **Termodel Web PC**, il CAD 2D Web, `DisegnoInput.svg`, pianta pulita, modello 3D, disegni esecutivi e `TERMODEL-PROJECT-TEXT-V1`;
- le istruzioni storiche/modulari preesistenti sono rimaste **invariate**: `TermodelGenerale.md/html`, `IndiceAI.md/html`, `CreaProgettoDaDescrizione.md/html` e `CreaPianoTermodelDaRaster.md/html` non sono state modificate; in particolare non è stata alterata la linea di istruzioni riferita alla vecchia versione Desktop installabile;
- frontend portato a **v1.33**;
- aggiunto nel menu **Help** della versione Web PC il comando **Help Termodel Web** come prima voce;
- il nuovo pannello **Termodel Web — Help** è un vero Help generale, leggibile e scorrevole, simile concettualmente all'Help Mobile;
- nel pannello è in evidenza il comando **Istruisci AI per Termodel Web**;
- il pannello descrive esplicitamente i due flussi AI richiesti: **da descrizione** e **da sfondo bitmap/raster**;
- il comando AI copia ora un bootstrap specifico della versione Web che rimanda a `https://www.termodel.it/termodel-ui-demo/TermodelWeb.html?v=0.1`, quindi l'istruzione può essere aggiornata sul sito senza modificare il programma;
- mantenuta separata l'istruzione MyHome3D Mobile;
- il menu Help è stato escluso dal gate del modello iniziale, così l'Help resta disponibile anche quando l'esempio corrente non è esplorabile;
- `definizionedati.json` non modificato.

Verifica reale:
- commit istruzione AI Web: `6e9e5dddf4f4d3e92a0c2729a6a0531995b3f280`;
- commit wiring frontend: `bb270ae949b416a33242b0b5646f57f0ca62d2ce`;
- commit pannello Help: `4038d383fd3d2cc997596aa3b54a6257c9f6561b`;
- commit regression: `ebc24b787c61ecc8eb825bef53eacab8953966f7`;
- commit versione frontend: `f12d4596a6438938b65380d7cc35555b83467258`;
- verifica sintassi JavaScript sul frontend finale: **OK**;
- GitHub Pages run `36327418535`: **SUCCESS**;
- GitHub Action run `36327418949`: **Check frontend JavaScript syntax SUCCESS**, **Check radiant executive auto-load wiring SUCCESS** incluse le nuove regression `TERMODEL_WEB_HELP_OK` / `TERMODEL_WEB_AI_DEDICATED_OK`, **Build SUCCESS**, smoke pubblico Pannelli radianti **SUCCESS**; il benchmark StrategiaDiego successivo è separato da questo incarico;
- verifica SHA delle fonti storiche: invariati `TermodelGenerale.md` `4b66271ec3f72004ffb25eca100e07cae501e867`, `TermodelGenerale.html` `ae9d6d1cc47f257f559c2f8959aff028d0629053`, `IndiceAI.html` `2e68acc3013b79be22d06f1aa7dbdbad517a920b`;
- prova manuale del pannello Help su browser PC da eseguire lato utente.

Commissionato:
- verificare se sul sito esiste già una istruzione AI **specifica e autosufficiente per Termodel Web PC**; se esiste, verificarne la completezza prima di crearne una concorrente;
- lasciare **invariata** l'istruzione AI collegata alla main page `termodel.it`, perché resta destinata alla vecchia versione Desktop installabile;
- creare o completare una sezione/istruzione pubblica specifica **Termodel Web**, aggiornabile sul sito senza modificare il programma;
- l'istruzione Termodel Web deve comprendere le regole necessarie della versione Web e consentire i flussi AI di generazione della pianta/progetto:
  - da **descrizione testuale**;
  - da **sfondo bitmap/raster**;
- aggiungere alla versione Web PC un vero **Help** simile concettualmente a quello Mobile: pannello leggibile e scorrevole, con comando AI in evidenza e testo introduttivo;
- il comando AI del nuovo Help deve copiare/fornire il collegamento alla nuova istruzione **Termodel Web**, non all'istruzione Desktop storica;
- sostituire nel percorso Help Web la semplice copia istruzioni con il pannello Help, preservando il resto della UI e i flussi AI già esistenti;
- mantenere separata l'istruzione Mobile MyHome3D;
- aggiornare frontend, documentazione Web, regression e versione; non modificare `definizionedati.json`;
- a fine lavoro aggiornare Summary e chiudere Issue #1 come Completed per la notifica.



### INCARICO 2026-09-27 — Filtri Mobile, guida Istruisci AI e accessi MyHome3D
Stato: ESEGUITO — FRONTEND v1.32 / MYHOME3D AI v0.25 PUBBLICATI

Esito:
- corretto il funzionamento dei **Filtri Mobile** introducendo uno stato canonico `filterState`, indipendente dal pannello desktop nascosto;
- i checkbox desktop e Mobile leggono/scrivono lo stesso stato tramite `getFilterState()` / `setFilterState()`;
- premendo **Applica** nella finestra Mobile le selezioni vengono consolidate nello stato reale, sincronizzate ai checkbox desktop e applicate con `applyFilters()`;
- la finestra viene ricostruita dallo stato consolidato prima della chiusura: alla successiva apertura ripropone le scelte applicate;
- **Annulla**, X e chiusura continuano a non consolidare modifiche;
- frontend portato a **v1.32**;
- form **Istruisci AI** ampliata e resa più visibile, con procedura in tre passaggi e corpo scorrevole;
- aggiunto esempio testuale **Meta AI in WhatsApp**: apertura chat, pressione prolungata nel campo messaggio, **Incolla**, **Invia**; nessun logo/icona/asset grafico di terzi incorporato;
- aggiornato il bootstrap Web all'IndiceAI **v0.25**;
- istruzione MyHome3D portata a **v0.25** e mantenuta esclusivamente informativa;
- registrato il modello di accesso MyHome3D:
  - senza registrazione: modello base in Termodel Web PC + anteprima 3D, senza server avanzato, consolidamento o link condivisibile;
  - con registrazione: consolidamento, link condivisibile per fornitori/terzi e possibilità di richiedere consigli su miglioramenti termici, impianti e isolamento;
  - abbonamento **100 € + IVA/anno** per server di calcolo e modelli avanzati (più piani, tetti/coperture avanzati, locali mansardati e funzioni analoghe);
- aggiornati `MyHome3D.md`, `MyHome3D.html`, `IndiceAI.html` e `LINEE-GUIDA-MOBILE.md`;
- `definizionedati.json` non modificato.

Verifica reale:
- commit funzionale/documentale: `33fac9e66256d81612bd60619d422b9c2c19113b`;
- verifica sintassi JavaScript sul commit: **OK**;
- GitHub Action run `36326256450`: **Check frontend JavaScript syntax SUCCESS**, regression frontend/MyHome3D **SUCCESS**, **Build SUCCESS**, smoke pubblico Pannelli radianti **SUCCESS**; il benchmark StrategiaDiego successivo è separato da questo incarico;
- GitHub Pages run `36326255718`: **SUCCESS**;
- regression aggiunte: `MOBILE_FILTER_STATE_PERSISTENCE_OK` e `AI_INSTRUCT_VISIBLE_GUIDE_OK`;
- prova manuale dei Filtri su smartphone ancora da eseguire lato utente.

Commissionato:
- correggere i **Filtri Mobile**: le scelte effettuate nella finestra devono consolidarsi nello stato reale dei filtri e produrre immediatamente l'effetto sul modello 3D dopo **Applica**; riaprendo la finestra devono risultare mantenute;
- mantenere **Annulla** e X senza applicazione;
- registrare nelle linee guida e nell'istruzione AI pubblicata MyHome3D il modello di accesso concordato:
  - senza registrazione l'utente può usare Termodel Web PC per costruire un modello base e vedere l'anteprima 3D, ma non usare il server per funzioni avanzate né consolidare/condividere il modello;
  - con registrazione può consolidare il modello, ottenere un link condivisibile con fornitori/terzi e richiedere consigli su miglioramenti termici, impianti e isolamento;
  - per modelli avanzati che richiedono server di calcolo (più piani, tetti, locali mansardati e funzioni analoghe) è necessario un abbonamento di **100 € + IVA/anno**;
- migliorare la form aperta da **Istruisci AI** rendendola molto visibile e spiegando in modo pratico cosa fare dopo la copia negli appunti;
- includere un esempio d'uso con **Meta AI in WhatsApp** usando solo testo, simboli e descrizioni generiche dell'interfaccia, senza incorporare asset grafici o loghi di terzi;
- aggiornare frontend, istruzioni Web/IndiceAI, linee guida Mobile e regression;
- non modificare `definizionedati.json`;
- a fine lavoro aggiornare il Summary e chiudere Issue #1 come Completed per la notifica.



### INCARICO 2026-09-27 — Filtri Home e AI informativa MyHome3D
Stato: ESEGUITO — FRONTEND v1.31 / MYHOME3D AI v0.24 PUBBLICATI

Esito:
- nella Home Mobile 3D il pulsante **Filtri** è stato spostato fuori dal menu **Esplora** ed è ora un comando diretto della barra principale;
- **Filtri** resta attivo anche quando `initialModelExplorationLocked` è vero: apre direttamente la finestra filtri e non dipende dalla disponibilità delle altre funzioni Esplora;
- rimosso il vecchio controllo `androidExploreFilters`; nuovo controllo `androidHomeFilters`;
- il comportamento filtri non è cambiato: copia temporanea delle selezioni, **Applica** -> `applyFilters()`, Annulla/X senza applicazione;
- frontend portato a **v1.31**;
- istruzione pubblica MyHome3D portata a **v0.24** e riscritta come istruzione **esclusivamente informativa**;
- eliminate dall'istruzione Mobile le procedure di generazione progetto da descrizione testuale e da immagini; non contiene i moduli/protocolli operativi di generazione;
- dopo il caricamento l'AI deve rispondere soltanto: **“Perfetto adesso sono in grado di darti informazioni su Myhome 3d e Termodel”**;
- `IndiceAI.html` aggiornato a **v0.24**: la modalità MyHome3D è descritta come informativa e non richiama le modalità di creazione progetto;
- `LINEE-GUIDA-MOBILE.md` aggiornato con posizione/sempre-attivo dei Filtri e nuova regola AI informativa;
- `definizionedati.json` non modificato.

Verifica reale:
- commit funzionale/documentale: `1ea5848142247d4d54efcb4c9f3a60569e5d26c8`;
- verifica sintassi JavaScript sul commit: **OK**;
- controllo statico: `androidHomeFilters` presente, `androidExploreFilters` assente, URL AI `MyHome3D.md?v=0.24` presente;
- controllo contenuto `MyHome3D.md`: frase di conferma presente e assenti `Creazione da descrizione testuale`, `CreaPianoTermodelDaRaster`, `TERMODEL-SVG-TEXT-V1`, `TERMODEL-STRATIGRAFIA-V1`, `bitmap`, `raster`;
- GitHub Pages run `36323456666`: **SUCCESS**;
- GitHub Action run `36323456359`: **Check frontend JavaScript syntax SUCCESS**, regression frontend/MyHome3D **SUCCESS**, **Build SUCCESS**, smoke pubblico Pannelli radianti **SUCCESS**; il workflow prosegue nel benchmark StrategiaDiego separato da questo incarico;
- prova manuale su smartphone da eseguire lato utente.

Commissionato:
- nella Home Mobile 3D spostare **Filtri** fuori dal menu **Esplora** e inserirlo come pulsante diretto nella barra principale;
- il pulsante **Filtri** deve restare sempre utilizzabile, anche quando il modello visualizzato è un esempio non esplorabile, perché i filtri grafici restano applicabili;
- il comportamento della finestra filtri resta quello già consolidato: copia temporanea delle scelte, **Applica** -> `applyFilters()`, Annulla/X senza modifiche;
- l'istruzione AI Mobile **MyHome3D** deve diventare esclusivamente informativa e non deve contenere istruzioni per creare/generare progetti né da descrizione testuale né da bitmap/raster;
- dopo aver acquisito l'istruzione, l'AI deve rispondere soltanto con: **“Perfetto adesso sono in grado di darti informazioni su Myhome 3d e Termodel”**;
- aggiornare frontend, istruzioni pubbliche Web/IndiceAI, linee guida Mobile e regression;
- non modificare `definizionedati.json`;
- a fine lavoro aggiornare il Summary e chiudere Issue #1 come Completed per la notifica.



### INCARICO 2026-09-27 — Correzione Modalità esplorazione Web PC
Stato: ESEGUITO — FRONTEND v1.30 PUBBLICATO

Esito:
- la **Modalità esplorazione** desktop ora viene forzata esplicitamente a **OFF** a ogni caricamento/paginehow;
- il checkbox `helpExplorationMode` non è più lasciato al ripristino automatico dello stato da parte del browser: HTML con `autocomplete="off"`, `defaultChecked=false` e `checked=false` impostati da JavaScript;
- quando la modalità è attiva, un listener globale in capture intercetta i controlli desktop cliccabili (button/input/select/summary/label/tab) solo per mostrare l'Help, senza fare `preventDefault()` né fermare l'azione originale;
- le funzioni già documentate continuano a usare `COMMAND_HELP`;
- per funzioni/comandi non ancora presenti in `COMMAND_HELP` viene mostrato un fallback contestuale, così il clic non resta privo di spiegazione;
- i comandi archivio, CAD 2D, checkbox/radio, select e tab hanno fallback specifici;
- il pannello Help desktop è stato portato a z-index 2100 per restare visibile anche sopra dialog/modali;
- Mobile/MyHome3D e sistema log non modificati; `definizionedati.json` non modificato;
- frontend portato a **v1.30**.

Verifica reale:
- commit funzionale: `46433a39ebbab43cc80eff62a4296f92a592e00b`;
- verifica sintattica JavaScript eseguita sul file del commit: **OK**;
- controllo statico: default OFF presente, checkbox HTML senza `checked`, reset su `pageshow`, listener globale Help e fallback presenti;
- GitHub Pages run `36317580284`: **SUCCESS**;
- GitHub Action `36317580489` accodata dietro al precedente workflow al momento della chiusura; le regression permanenti `DESKTOP_EXPLORATION_DEFAULT_OFF_OK` e `DESKTOP_EXPLORATION_GLOBAL_HELP_OK` sono state aggiunte al workflow;
- prova manuale su browser PC da eseguire lato utente.

Commissionato:
- verificare la **Modalità esplorazione** del menu Help nella versione Web PC;
- il default deve essere esplicitamente **disattivato** a ogni caricamento della pagina, senza dipendere dal ripristino automatico dello stato dei controlli da parte del browser;
- quando la modalità è attiva, ogni funzione/comando cliccato nell'interfaccia desktop deve mostrare una spiegazione nel pannello Help e l'azione normale deve continuare;
- usare le descrizioni specifiche già presenti in `COMMAND_HELP` quando disponibili e fornire un fallback informativo per controlli/comandi non ancora documentati, in modo da evitare clic silenziosi;
- non trasformare la Modalità esplorazione in un blocco delle funzioni;
- preservare la versione Mobile/MyHome3D, il sistema log e `definizionedati.json`;
- aggiornare frontend/versione e regression, pubblicare e chiudere Issue #1 come Completed a fine lavoro.


### INCARICO 2026-09-27 — Istruzione AI pubblicata MyHome3D Mobile
Stato: ESEGUITO — ISTRUZIONE PUBBLICATA / HELP COLLEGATO / FRONTEND v1.29

Esito:
- creata la sorgente autorevole pubblica `docs/termodel-ui-demo/MyHome3D.md`, versione **0.23**, costruita sulle regole generali `TermodelGenerale.md` e armonizzata con il flusso MyHome3D Mobile;
- creata la pagina leggibile sul sito `docs/termodel-ui-demo/MyHome3D.html`;
- `IndiceAI.html` portato a **v0.23** con la nuova voce **5 — MyHome3D Mobile — help e lavoro da smartphone** e collegamento alla pagina pubblica;
- per MyHome3D la sorgente grafica operativa è definita come **input unifilare della versione Web / CAD 2D** (`DisegnoInput.svg`);
- l'istruzione Mobile descrive inoltre sfondo, pianta pulita, modello 3D, disegni esecutivi, pannelli radianti, `TERMODEL-SVG-TEXT-V1` e `TERMODEL-PROJECT-TEXT-V1`;
- rimossi dalla specifica Mobile i riferimenti operativi al vecchio flusso CAD desktop esterno: regression esplicita vieta `AutoCAD`, `DXF`, `lettore desktop` e `Termodel desktop` nella nuova istruzione;
- frontend portato a **v1.29**;
- **Help -> Chiedi informazioni ad AI** non costruisce più una copia locale dell'istruzione nel JavaScript: carica `MyHome3D.md?v=0.23` dal sito Termodel con `cache: no-store` e ne copia il testo integrale negli appunti;
- il pannello guida l'utente all'apertura di ChatGPT/AI dopo la copia; nessuna modifica al progetto viene eseguita dall'Help;
- `definizionedati.json` non modificato.

Verifica reale:
- commit documentazione commissione: `a0f19e9b5ba86ad4d74f6b116e20a80b13f4fe17`, `882ef9357d766d098ec68d4fd6661523764e1693`;
- commit funzionale/pubblicazione: `a1ed8c3ae50dca8f656d3173473c4b2a1bacebeb`;
- GitHub Pages run `36315672409`: **SUCCESS**;
- GitHub Action run `36315672702`: **Check frontend JavaScript syntax SUCCESS**, **Check radiant executive auto-load wiring SUCCESS** con regression `MYHOME3D_AI_PUBLISHED_INSTRUCTION_OK` / `MYHOME3D_WEB_UNIFILAR_ONLY_OK`, **Build SUCCESS**, smoke pubblico Pannelli radianti **SUCCESS**;
- il workflow generale prosegue successivamente nel benchmark StrategiaDiego, separato da questa funzione e già noto come possibile causa indipendente di esito rosso;
- prova fisica del tasto clipboard su smartphone ancora da eseguire.

Commissionato:
- creare sul sito Termodel una sezione/istruzione AI dedicata a **MyHome3D**, completa delle regole generali Termodel necessarie e armonizzata con il flusso Mobile;
- nella versione Mobile riferirsi all'**input unifilare della versione Web / CAD 2D** come sorgente e oggetto di modifica del modello, evitando di indirizzare l'utente verso AutoCAD o un flusso desktop DXF;
- includere i concetti collegati al flusso Web: `DisegnoInput.svg`/input unifilare, pianta pulita, esecutivi, modello 3D e progetto `TERMODEL-PROJECT-TEXT-V1`, senza alterare i protocolli esistenti;
- collegare la nuova istruzione all'indice AI pubblico del sito;
- fare in modo che **Help Mobile -> Chiedi informazioni ad AI** copi negli appunti il testo della nuova istruzione pubblicata, usandola come sorgente autorevole invece di una istruzione duplicata nel JavaScript;
- preservare il frontend desktop e le funzioni Mobile esistenti; non modificare `definizionedati.json`;
- aggiornare versione frontend/regression, pubblicare e notificare a fine lavoro.


### INCARICO 2026-09-27 — Prima funzione Help MyHome3D
Stato: ESEGUITO — FRONTEND v1.28 PUBBLICATO / REGRESSION HELP VERIFICATA

Esito:
- frontend portato a **v1.28**;
- aggiunto pulsante **Help** direttamente nel minipannello mobile della vista **3D**, accanto a Esplora;
- aggiunto pulsante **Help** direttamente nel minipannello mobile della vista **CAD 2D**, accanto a Home/Esplora;
- il pannello **MyHome3D — Help** mostra come primo comando in alto **Chiedi informazioni ad AI** e mantiene il testo esplicativo in un'area scorrevole;
- il comando genera un'istruzione AI dedicata a MyHome3D, contestualizzata sulla vista 3D o CAD 2D, e la copia negli appunti usando il helper con fallback `copyTextToClipboard()`;
- l'istruzione ricorda che MyHome3D è la versione Mobile, che Termodel è lo strumento per costruire il modello della casa e degli impianti, che il modello è riutilizzabile nel dialogo con aziende per preventivi e che gli approfondimenti devono seguire `TERMODEL_AI_INDEX_URL`;
- dopo la copia il pannello guida l'utente ad aprire ChatGPT/AI, incollare il testo e formulare la domanda;
- la funzione Help non modifica il progetto;
- layout Help adattato anche a smartphone landscape con body scorrevole;
- `definizionedati.json` non modificato.

Verifica reale:
- linee guida Help: commit `7483a5e617488bbc8b9f16a7828867c3cd755b18`;
- implementazione frontend/regression/versione: commit `a9faa270f2db7d7bce291df4e1318118668953e3`;
- GitHub Pages run `36305751811`: **SUCCESS**;
- GitHub Action run `36305751843`: **Check frontend JavaScript syntax SUCCESS**, **Check radiant executive auto-load wiring SUCCESS** (include i marker `MYHOME3D_MOBILE_HELP_OK`), **Build SUCCESS**, smoke pubblico Pannelli radianti **SUCCESS**;
- al momento della chiusura il workflow generale prosegue nel benchmark StrategiaDiego, che è separato dalla funzione Help e può mantenere il noto esito indipendente;
- prova fisica sul telefono non ancora eseguita.

Commissionato:
- aggiungere un pulsante **Help** al minipannello mobile con **Esplora** sia nella vista **3D** sia nella vista **CAD 2D**;
- il pulsante apre un pannello Help mobile con un primo messaggio di spiegazione a contenuto scorrevole;
- il primo comando in alto nel pannello deve essere **Chiedi informazioni ad AI**;
- il comando deve guidare l'utente nell'uso dell'assistenza AI e copiare negli appunti un'istruzione AI dedicata alla versione Mobile/MyHome3D;
- l'istruzione deve essere coerente con le linee guida: MyHome3D è la versione Mobile, Termodel è lo strumento per realizzare il modello della casa e degli impianti, e le istruzioni AI di Termodel sono il riferimento per gli approfondimenti;
- preservare il comportamento desktop e le funzioni mobile esistenti;
- aggiornare versione frontend e regression pertinenti, senza modificare `definizionedati.json`;
- a fine lavoro aggiornare Summary e chiudere Issue #1 come Completed per la notifica.



### INCARICO 2026-09-27 — Termodel come strumento e riferimento AI di MyHome3D
Stato: ESEGUITO — SOLO REGISTRAZIONE DOCUMENTALE

Esito:
- registrato che **Termodel è lo strumento utilizzato per la realizzazione del modello MyHome3D**;
- registrato che le **istruzioni AI di Termodel** sono il riferimento per generare help e istruzioni di approfondimento su richiesta dell'utente;
- nessuna modifica funzionale, build o test eseguiti;
- commit linee guida: `80485aa49d90fd19817b1db39cfba0724ef510ab`.



Commissionato:
- registrare nelle linee guida MyHome3D che **Termodel è lo strumento utilizzato per la realizzazione del modello**;
- stabilire che, per la generazione di help o di istruzioni richieste dall'utente per approfondire una funzione, si farà riferimento alle **istruzioni AI di Termodel**;
- non introdurre modifiche funzionali o altre decisioni non esplicitamente concordate.



### INCARICO 2026-09-27 — Definizione Mobile come MyHome3D
Stato: ESEGUITO — SOLO REGISTRAZIONE DOCUMENTALE

Esito:
- aggiornato `docs/termodel-ui-demo/LINEE-GUIDA-MOBILE.md` con identità e scopo concordati di **MyHome3D**;
- nessuna modifica funzionale, implementazione, build o test eseguiti;
- commit linee guida: `126ba7f3c94d0ee4357a433d8c017885cf19e12e`;
- nessun'altra operazione applicativa autorizzata o eseguita.



Commissionato:
- registrare nelle sole linee guida Mobile che la versione Mobile viene da ora definita e presentata come **MyHome3D**;
- fissare come scopo del progetto permettere a chiunque di creare un modello della propria casa, compresi gli impianti;
- il modello deve servire per interagire con aziende di costruzione e di installazione/impiantistica, così da ottenere rapidamente preventivi senza dover riprogettare quanto è già stato progettato;
- non eseguire modifiche funzionali, implementazioni o altre operazioni sul progetto fino a richiesta contraria dell'utente.


### INCARICO 2026-09-27 — Linee guida della versione Mobile
Stato: ESEGUITO — DOCUMENTO VUOTO CREATO / DEFINIZIONE DA COSTRUIRE IN COLLOQUIO

Commissionato:
- creare su Git un documento dedicato alla **versione Mobile di Termodel Web**;
- collocarlo nella linea frontend `docs/termodel-ui-demo/`;
- partire volutamente da un documento vuoto, senza precompilare regole, audit o conclusioni;
- definire il contenuto progressivamente tramite colloquio con l'utente, inserendo nel documento soltanto quanto viene concordato;
- non modificare comportamento applicativo né `definizionedati.json`.

Esito:
- creato il file vuoto `docs/termodel-ui-demo/LINEE-GUIDA-MOBILE.md`;
- commit: `8d81b56d368259114cc7fba45fd8880ec0de6371`;
- nessuna regola Mobile è stata ancora inserita;
- il precedente mandato di audit automatico è superato dalla rettifica dell'utente: la definizione parte ora dal colloquio.



### INCARICO 2026-09-27 — Filtri grafici flottanti nel pannello Esplora mobile
Stato: ESEGUITO — FRONTEND v1.27 PUBBLICATO / FILTRI MOBILE VERIFICATI

Commissionato:
- nella versione mobile/Android aggiungere al pannello principale **Esplora** del modello 3D un pulsante **Filtri**;
- il pulsante deve aprire una form flottante centrata con i filtri grafici esistenti: Piani, Componenti, Confini e Separazione tra vani;
- le modifiche nella form devono essere temporanee finché l'utente non preme **Applica**;
- premendo **Applica** copiare le selezioni nei filtri reali, aggiornare il 3D con `applyFilters()` e chiudere la form;
- chiusura/Annulla non devono modificare il modello;
- la form deve essere ordinata e completamente utilizzabile su smartphone sia portrait sia landscape, con contenuto scrollabile e dimensioni entro la viewport;
- preservare il pannello filtri desktop esistente e il comportamento mobile già consolidato;
- aggiornare frontend/version marker e regression, pubblicare su `main`;
- non modificare `definizionedati.json`;
- a fine lavoro aggiornare il Summary e chiudere Issue #1 `Completed` per la notifica.

Esito:
- frontend portato a **v1.27**;
- aggiunto nel menu mobile principale **Esplora** il pulsante **Filtri**;
- `openAndroidFilterDialog()` apre una form flottante centrata che replica lo stato corrente dei filtri reali senza modificarli;
- gruppi esposti: **Piani**, **Componenti**, **Confini**, **Separazione tra vani**;
- le checkbox della form sono copie temporanee senza listener su `applyFilters()`: cambiare una selezione non modifica immediatamente il 3D;
- **Applica** trasferisce le selezioni ai filtri reali, esegue `applyFilters()` e chiude la form;
- **Annulla**, pulsante X e tap sullo sfondo chiudono la form senza applicare variazioni;
- il pannello filtri desktop esistente non è stato modificato;
- `definizionedati.json` non modificato.

Layout mobile:
- portrait: form centrata, larghezza `min(520px, 100vw - 24px)`, altezza massima `100dvh - 24px`, corpo scrollabile;
- landscape con altezza <= 520 px: larghezza `min(720px, 100vw - 16px)`, altezza massima `100dvh - 16px`, sezioni disposte su due colonne e righe più compatte;
- header e footer restano fissi nella griglia della form mentre scorre solo il corpo centrale.

Verifica reale:
- commit funzionale: `f8c4f1e542faeac011389065a95c87ebf2973d15`;
- frontend/version marker: `53fe2228ae3fb8b87ba235d6213f5bf6665860f8`, `7e0199481e7c0dd882f4094670c4f672a0b235b9`;
- regression workflow: `b226fba17870e8b542b4ce86c4071084b04ff88b`;
- GitHub Action run `36304031007`: `Check frontend JavaScript syntax` **SUCCESS**, `Check radiant executive auto-load wiring` **SUCCESS**, `Build` **SUCCESS**, smoke progetto pubblico Pannelli radianti **SUCCESS**; il check wiring include i marker dei filtri mobile portrait/landscape;
- GitHub Pages run `36304030775`: **SUCCESS**;
- il successivo benchmark StrategiaDiego resta separato e può conservare il noto stato rosso per carico computazionale.



### INCARICO 2026-09-27 — Gate globale desktop sul modello iniziale non esplorabile
Stato: ESEGUITO — FRONTEND v1.26 PUBBLICATO / GATE DESKTOP VERIFICATO

Commissionato:
- estendere alla versione **non mobile/desktop** il comportamento del modello iniziale non esplorabile;
- finché `initialModelExplorationLocked=true`, qualunque funzione attivata da pulsanti, tab o menu deve mostrare la stessa form di selezione esempio già introdotta;
- uniche eccezioni operative: **File -> Nuovo** e **File -> Apri...**, che devono continuare a funzionare normalmente;
- il menu **File** deve restare apribile per consentire l'accesso a Nuovo e Apri; le altre voci File, incluso `Apri esempio...`, possono aprire la stessa form esempi;
- gli altri menu principali, le relative voci, i pulsanti della barra inferiore e i tab devono essere intercettati prima dell'esecuzione della loro funzione;
- non alterare il comportamento mobile già approvato;
- dopo apertura/creazione progetto o caricamento esempio il gate deve disattivarsi come già previsto;
- aggiornare frontend/version marker e regression, pubblicare su `main`;
- non modificare `definizionedati.json`;
- a fine lavoro aggiornare il Summary e chiudere Issue #1 `Completed`.

Esito:
- frontend portato a **v1.26**;
- aggiunto un gate desktop in capture phase su `#app`: quando `initialModelExplorationLocked=true` intercetta pulsanti, input, select, summary, label e tab prima dei rispettivi handler;
- il gate non viene applicato ad Android, quindi il comportamento mobile v1.25 resta invariato;
- le uniche eccezioni sono `newProjectButton`, `openProjectButton`, il relativo file input e il pulsante principale **File**, che deve restare apribile per raggiungere Nuovo/Apri;
- qualunque altro comando desktop, comprese le altre voci del menu File, i menu Modifica/Visualizza/Calcoli/Help, tab, barra inferiore e controlli attivi, apre `openProjectExploreDialog()` e non esegue la funzione originale;
- i pulsanti normalmente disabilitati perché manca un progetto vengono temporaneamente resi cliccabili durante il gate e ripristinati al termine, così anche essi danno la stessa risposta invece di restare muti;
- dopo `Nuovo`, `Apri` o caricamento di un esempio, `setStructuredProjectState(true)` disattiva il gate e ripristina il comportamento normale;
- `index.html`, `app.js` e `frontend-version.txt` sono allineati a **1.26**;
- `definizionedati.json` non modificato.

Verifica:
- commit funzionale principale: `b0f1625caf1538b55414edcc2e7b353328b01ea9`;
- commit pubblicazione/versione: `a5530c143dfacfb9c5a3aa8d2e0f73a95a045477`, `b5ac358f82de38734c0c51e467e42d79f1e54330`;
- regression workflow: `b8c535064f2de1310a0dea120804df8ea8ce9bcb`;
- GitHub Action run `36303222139`: `Check frontend JavaScript syntax` **SUCCESS**, `Check radiant executive auto-load wiring` **SUCCESS**, `Build` **SUCCESS**, smoke progetto pubblico pannelli **SUCCESS**; il check wiring include `PROJECT_BROWSER_DESKTOP_GLOBAL_GATE_OK`;
- GitHub Pages run `36303222370`: **SUCCESS**;
- l'eventuale esito rosso successivo del workflow generale resta separato e dovuto al benchmark StrategiaDiego già noto.



### INCARICO 2026-09-27 — Setup iniziale CAD2D esempi e gate esplorazione
Stato: ESEGUITO — FRONTEND v1.25 PUBBLICATO / GATE E SETUP CAD VERIFICATI

Commissionato:
- frontend `docs/termodel-ui-demo`: quando viene caricato un esempio, inizializzare CAD2D con **Esecutivo pannelli ON**, **Input OFF**, **Sfondo OFF**;
- definire il modello iniziale `TermodelWebModel.json` come **non esplorabile** nel ProjectBrowser;
- al primo tentativo di esplorazione del modello iniziale mostrare una form con il messaggio:
  `Modello realizzato con gli strumenti avanzati di Termodel non esplorabile, selezionare un esempio per esplorare il disegno di input ed i disegni esecutivi`;
- sotto il messaggio mostrare l'elenco degli esempi pubblici con selezione e caricamento dell'esempio scelto;
- riusare la stessa form anche per l'apertura esplicita di un esempio da desktop, evitando il prompt numerico;
- verificare layout e dimensioni della form su smartphone, incluse viewport portrait e landscape;
- preservare il caricamento locale degli esecutivi consolidati senza interrogare il Service durante l'esplorazione;
- non modificare `definizionedati.json`;
- aggiungere regression frontend e pubblicare su `main`;
- a fine lavoro aggiornare questo Summary e chiudere Issue #1 `Completed` per la notifica.

Esito:
- il modello iniziale `TermodelWebModel.json` viene marcato `data-explorable=false` e mantiene `initialModelExplorationLocked=true`;
- su Android il primo tocco di **Esplora** sul modello iniziale apre la nuova form di scelta esempio invece del piccolo menu CAD;
- `File -> Apri esempio...` su desktop usa la stessa form, eliminando il precedente `window.prompt` numerico;
- la form contiene il testo richiesto e genera dinamicamente un pulsante per ciascun esempio di `examples/catalog.json`, con nome e descrizione;
- dopo il caricamento di un esempio viene applicato `applyProjectBrowserCadInitialSetup()`: **Esecutivo pannelli ON**, **Input OFF**, **Sfondo OFF**;
- **Disegno unifilare** commuta esplicitamente a Esecutivo OFF / Input ON / Sfondo OFF;
- **Disegno esecutivo** commuta esplicitamente a Esecutivo ON / Input OFF / Sfondo OFF;
- gli esecutivi consolidati dei due esempi continuano a essere caricati localmente da GitHub Pages; l'esplorazione non interroga Render;
- frontend portato a **v1.25**; `index.html`, `app.js` e `frontend-version.txt` sono allineati a 1.25, evitando reload da marker versione obsoleto;
- `definizionedati.json` non modificato.

Form smartphone:
- portrait <= 760 px: larghezza `min(520px, 100vw - 24px)`, altezza massima `100dvh - 24px`, corpo scrollabile;
- landscape <= 760 px: larghezza `min(680px, 100vw - 16px)`, altezza massima `100dvh - 16px`, corpo scrollabile e righe esempio più compatte;
- verifica dimensionale statica eseguita su viewport rappresentative: 320x568 -> 296x544 px max; 360x800 -> 336x776; 390x844 -> 366x820; 740x360 landscape -> 680x344. Con `box-sizing:border-box` la form resta entro la viewport. La prova fisica sul telefono resta distinta dalla verifica CSS automatica.

Regression/verifica:
- controllo sintattico JavaScript sul sorgente v1.25: **OK**;
- workflow finale `36302557023`, commit `3476833ce31a658b45282976fcf6bcddf837735b`: `Check frontend JavaScript syntax` **SUCCESS** e `Check radiant executive auto-load wiring` **SUCCESS**; quest'ultimo verifica anche gate iniziale, default CAD, form mobile e marker `frontend-version.txt=1.25`;
- build Service già **SUCCESS** sul commit funzionale `2605936d7b86f7bfa6c362e18222992822e24a55`; i commit successivi del frontend hanno riguardato CSS/version marker/regression e non sorgenti C#;
- GitHub Pages finale run `36302556969`, commit `3476833ce31a658b45282976fcf6bcddf837735b`: **SUCCESS**;
- gli eventuali fallimenti successivi del workflow Service restano riconducibili al benchmark StrategiaDiego già noto e separato da questo incarico frontend.

Commit principali:
- `8faf911ecbd57eab984764f82bc62f2a234d6b99` — gate modello iniziale, form esempi e setup CAD;
- `2605936d7b86f7bfa6c362e18222992822e24a55` — coerenza viste unifilare/esecutivo;
- `51fe31e6b919f9e7f84011b7183b73de2214dd09` — dimensionamento smartphone;
- `4d626db676a6125620a1a3ba87697fcc7bb25836` — allineamento `frontend-version.txt`;
- `3476833ce31a658b45282976fcf6bcddf837735b` — regression del marker versione.



### INCARICO 2026-09-27 — Consolidare esecutivo pannelli nei due esempi pubblici
Stato: ESEGUITO — ESECUTIVI STATICI VERSIONATI / ESPLORAZIONE SENZA SERVICE

Commissionato:
- rendere i due esempi pubblici `Pannelli radianti` e `Quadrato con pannelli` esplorabili anche nell'esecutivo pannelli **senza interrogare il Service**;
- generare e versionare nei file pubblici gli SVG esecutivi reali dei due esempi;
- estendere il catalogo esempi con il riferimento locale all'esecutivo consolidato;
- modificare il frontend affinché, per gli esempi consolidati, carichi prima l'esecutivo statico locale e non chiami `/api/calculations` per la sola esplorazione;
- mantenere `Aggiorna Modello` come azione esplicita separata per ricalcolare col Service;
- non modificare `definizionedati.json`;
- aggiungere regression che verifichi presenza/formato dei due SVG e wiring frontend senza Service;
- pubblicare su `main`, aggiornare Summary e chiudere Issue #1 Completed solo a verifica riuscita.

Esito:
- generati con il vero Service e versionati in `docs/termodel-ui-demo/examples/`:
  - `pannelli-radianti-esecutivo.svg`, formato `TERMODEL-PANNELLI-ESECUTIVO-SVG-V1`, 87 primitive;
  - `quadrato-con-pannelli-esecutivo.svg`, formato `TERMODEL-PANNELLI-ESECUTIVO-SVG-V1`, 8 primitive;
- entrambi contengono i layer canonici `PiantaPulita_Output`, `PannelliMandata_Output` e `PannelliRitorno_Output`;
- `examples/catalog.json` espone per entrambi `executiveSvg` locale;
- frontend v1.22: `loadProjectBrowserStaticExecutive()` carica l'SVG statico con `fetch` locale e lo usa come overlay CAD; per questi due esempi `ensureProjectBrowserExecutive()` non invoca `loadCalculatedModelFromService()`;
- all'apertura dell'esempio l'esecutivo consolidato viene precaricato localmente; il comando `Disegno esecutivo` può quindi essere esplorato senza interrogare Render;
- `Aggiorna Modello` resta invariato come azione esplicita per un nuovo calcolo Service;
- mantenuto il fallback Service soltanto per eventuali esempi futuri dichiarati `executive:true` ma privi di `executiveSvg`;
- aggiunta regression permanente nel workflow: presenza e formato dei due SVG statici, layer obbligatori, riferimenti catalogo e wiring frontend;
- `definizionedati.json` non modificato.

Verifica reale:
- generazione quadrato con motore runtime sostenibile `GPT/SpiraliGPT`: **SUCCESS** nel run di preparazione branch `36301010185`;
- consolidamento automatico dei due SVG: **SUCCESS** nello stesso run;
- PR #10 `Consolida esecutivi pannelli nei due esempi` integrata su `main`;
- merge commit: `641dbd41cbb85922566ef0510d3c3974ace28ab5`;
- GitHub Action main `36301209603`: syntax frontend **SUCCESS**, regression wiring/esecutivi statici **SUCCESS**, Build **SUCCESS**, smoke progetto pubblico Pannelli radianti **SUCCESS**; il benchmark StrategiaDiego successivo resta separato e può mantenere il noto stato rosso per carico computazionale;
- GitHub Pages run `36301209387`: **SUCCESS**, frontend v1.22 e SVG statici pubblicati.



### INCARICO 2026-09-27 — Esempio pannelli: rigenerazione 3D mostra solo schema/ponteggi
Stato: ESEGUITO — VIEWER 3D CORRETTO / REGRESSION PUBBLICA PASSATA

Commissionato:
- riprodurre il difetto segnalato sul progetto esempio **Pannelli radianti**: dopo `Rigenera/Aggiorna Modello` il 3D mostra soltanto lo schema verde tipo ponteggi, pur con nessun filtro di visualizzazione attivo;
- verificare l'intera catena progetto esempio -> payload Service -> `model3d` -> redraw frontend e distinguere un difetto dell'artifact da un difetto di stato/filtro del viewer;
- correggere la causa con modifica minima e retrocompatibile;
- non modificare `definizionedati.json`;
- aggiungere/verificare una regression reale sul progetto esempio;
- pubblicare su `main` e lasciare attivo il normale deploy;
- aggiornare Summary e chiudere Issue #1 Completed solo dopo verifica riuscita.

Diagnosi:
- aggiunta una regression che esegue realmente il progetto pubblico `docs/termodel-ui-demo/examples/pannelli-radianti.tmdl.txt`, lo canonicalizza come il frontend, invoca il Service e legge l'artifact `model3d`;
- il Service **non perde il modello edilizio**: artifact verificato con 438 mesh totali, di cui 96 `Parete`, 18 `Pavimento`, 18 `Soffitto`, 18 `Finestra`, 288 `Ponte`; tutte le mesh hanno vertici/indici triangolari validi;
- il difetto era quindi nel viewer/stato dei filtri: `Pannelli` è una modalità speciale che, quando rimane selezionata, mostra soltanto `Pannelli + Ponte`; poiché il pannello filtri può essere chiuso senza azzerare le selezioni interne, tale modalità poteva restare attiva durante un successivo `Aggiorna Modello`, producendo esattamente lo scheletro verde osservato.

Correzione:
- aggiunta `resetPannelliOnlyModeForServiceModel()` nel frontend; prima di renderizzare un nuovo `model3d` proveniente dal Service viene disattivata soltanto la modalità speciale `Pannelli`, senza alterare gli altri filtri ordinari;
- frontend portato a **v1.20** con cache-busting `app.js?v=1.20`;
- esteso `tools/smoke-radiant-reference.ps1` con parametro `-ProjectPath` e controllo reale dell'artifact `model3d`;
- workflow Service esegue ora il test del progetto pubblico subito dopo la build e prima del benchmark StrategiaDiego, così la regression resta verificabile anche se il successivo benchmark Diego supera i budget noti;
- `definizionedati.json` non modificato.

Verifica reale:
- GitHub Action `TermodelService Build` run `36299819874`, commit `2efc24e199f51f54a86a51f1f32ba404e2954f16`: frontend JavaScript syntax **SUCCESS**, wiring frontend **SUCCESS**, Build **SUCCESS**, `Smoke public Pannelli radianti model3d` **SUCCESS**, upload diagnostica **SUCCESS**;
- artifact diagnostico: `pannelli-radianti-public-model3d` id `10924859395`;
- GitHub Pages run `36299819473`: **SUCCESS**, quindi frontend v1.20 pubblicato;
- gli step successivi del workflow generale continuano a comprendere il benchmark StrategiaDiego e possono terminare rossi per il carico computazionale già noto; ciò è successivo e separato dalla regression di questo difetto.

Commit principali:
- `63d69367200b4e72da9039c2bde6e80b6008168a` — diagnostica model3d progetto pubblico;
- `a178db82029d57cf35e8fb7a6a71cc61b2e7fd88` — regression anticipata prima del benchmark Diego;
- `d2784e57f2e0bad0b9d5d77d6ab130cac9ebcb7b` — reset modalità speciale Pannelli;
- `e5812adb50cfb97630d8a14320607b0fee21025e` — frontend v1.20;
- `fd072e8e08317b51ac8d2c0654b84fd272b6593f`, `2efc24e199f51f54a86a51f1f32ba404e2954f16` — regression/CI allineata.



### INCARICO 2026-09-27 — Ripristino Service con SpiraliGPT come motore predefinito
Stato: ESEGUITO — GPT RIPRISTINATO COME DEFAULT / PUBBLICATO SU MAIN

Commissionato:
- considerare StrategiaDiego temporaneamente non sostenibile sul Service per carico computazionale;
- ripristinare il comportamento della versione server precedente al commit `9e96b43ce70af9082c3ba3ccdcfb73fad8f5f9e8`, nella quale il motore spirali predefinito era **SpiraliGPT / GPT**;
- mantenere nel Core StrategiaDiego, Diego_Vittorio e gli strumenti di sviluppo: il rollback riguarda il motore predefinito del Service, non la cancellazione del lavoro;
- preservare l'override `TERMODEL_SPIRAL_ENGINE` per confronti futuri;
- pubblicare su `main` per il normale auto-deploy Render;
- verificare build GitHub Actions;
- aggiornare Summary e Issue #1 a fine lavoro.

Esito:
- verificata la modifica storica `9e96b43ce70af9082c3ba3ccdcfb73fad8f5f9e8`: il passaggio a Diego aveva cambiato esclusivamente il default da `RadiantSpiralEngine.GPT` a `RadiantSpiralEngine.Diego` quando `TERMODEL_SPIRAL_ENGINE` non è valorizzata;
- ripristinato in `RadiantExecutiveGenerator.ResolveSpiralEngine()` il default `RadiantSpiralEngine.GPT`;
- aggiornata la documentazione Service: valori ammessi `Vittorio | GPT | Diego | Diego_Vittorio`, con **SpiraliGPT** di nuovo default operativo;
- StrategiaDiego e Diego_Vittorio restano nel Core e selezionabili tramite `TERMODEL_SPIRAL_ENGINE`: nessun lavoro sperimentale è stato cancellato;
- commit pubblicato su `main`: `a9164c75f04a9a5a17431101dbfaeb309011c2f4`;
- il push su `main` attiva il normale auto-deploy Render;
- GitHub Action `TermodelService Build` run `36296591604`: Restore, controlli preliminari e **Build SUCCESS** sul commit di rollback; gli step successivi continuano a includere benchmark/regression StrategiaDiego indipendenti dal motore runtime predefinito e possono mantenere il noto stato rosso per il carico computazionale Diego;
- verifica sorgente post-commit: senza override il metodo restituisce `RadiantSpiralEngine.GPT`;
- verifica HTTP diretta di `https://termodel.onrender.com/health` non disponibile dagli strumenti della sessione; il runtime pubblico potrà essere confermato dall'endpoint `/health`, campo `spiralEngine`, dopo il completamento dell'auto-deploy.


### INCARICO 2026-09-27 — Distanze geometriche `Diego_Vittorio` conformi alle linee guida
Stato: ESEGUITO — DISTANZE E REGRESSION QUADRATO VERIFICATE LOCALMENTE

Commissionato:
- operare soltanto sulla derivazione `Diego_Vittorio`, mantenendo intatto il riferimento `SpiraliVittorio`;
- prima dei test recuperare da Git il precedente progetto quadrato 4x4/T1/p=0,30 m e conservarne provenienza e SHA-256;
- separare il distacco iniziale dalla parete dal passo delle evoluzioni della mandata: tubo-architettura `p/2`, Supply-Supply `2p`;
- costruire il ritorno sul lato interno della mandata a distanza `p`, evitando l'attuale offset esterno a `p/2`;
- applicare come riferimento più recente LG-046: Return-Return `p`, dichiarando però esplicitamente il limite del ritorno ancora derivato e non autonomo;
- aggiungere verifiche diagnostiche delle distanze reali e confrontare prestazioni prima/dopo sul quadrato storico;
- collaudare almeno quadrato, appartamento corrente e locale concavo, con raccordi OFF e ON, usando l'Harness locale indipendente da GitHub quando possibile;
- non includere nel commit le modifiche sperimentali locali preesistenti in `StrategiaDiegoBenchmark.cs`, `StrategiaDiegoEngine.cs` e `Harness/Program.cs`;
- a lavoro concluso notificare esito, commit, metriche e intervento umano richiesto mediante commento alla GitHub Issue `#1`.

Esito:
- recuperata da Git la fixture canonica `tests/fixtures/StrategiaDiegoSquare4x4.locale.xml`, introdotta dal commit `4bf2e2b`, 541 byte, SHA-256 `9EC497979E89D87C9145B9527D171A23CDA691454DDB86B53B84FAB8B2165516`;
- creati i case Harness espliciti `LG041-SQUARE4X4-T1-P030-DIEGO-VITTORIO.json` e `CONCAVE-L-P030-DIEGO-VITTORIO.json`;
- in `SpiralGenerator.Generate` separati il primo offset architettonico `p/2` e gli offset Supply successivi `2p`;
- `Program` centralizza e registra nel log `p=0,30`, parete `0,15`, Supply-Supply `0,60`, Supply-Return `0,30` e minimo Return-Return `0,30 m`;
- `CreaRientro` usa la normale interna alla mandata CCW e distanza `p`, sostituendo il precedente ritorno esterno a `p/2`;
- aggiunta regression locale `Test-DiegoVittorioDistances.ps1` sul vero SVG del quadrato;
- il ritorno resta derivato: sul quadrato la distanza Return-Return osservata è `0,60 m`, quindi rispetta il minimo LG-046 `p=0,30 m` ma non sfrutta ancora autonomamente corridoi più fitti;
- `SpiraliVittorio` è rimasto byte-per-byte invariato e conserva le quattro impronte SHA-256 registrate;
- le tre modifiche sperimentali locali preesistenti sono rimaste fuori dall'intervento.

Verifiche locali:
- snapshot pre-modifica: `20260927-110315-202-prima-distanze-lg`;
- build Release nel mirror esterno al repository: riuscita, 0 errori;
- regression quadrato raccordi OFF e ON: riuscita; parete-Supply `0,15`, Supply-Supply `0,60`, Supply-Return `0,30`, parete-Return `0,45`, Return-Return osservato `0,60 >= 0,30 m`;
- quadrato finale OFF: 18 punti, 120 ms, SVG SHA-256 `B5D289381B0466E8070DC90F0A75921AD9BC14214ED113E8FF0C4BA194950B43`; ON: 18 punti, 285 ms;
- concavo finale OFF: 9 punti, 327 ms, SVG SHA-256 `F998CB343B76A527BD250B6C9FA7643F09155178E1FB99D57B73526C246B470E`; ON: 9 punti, 395 ms;
- appartamento finale OFF: 12 punti, 225 ms, SVG SHA-256 `E2CD1E745BD5738DA16B22FE2D010FA19F0CBEDD588E31CABEC492C95D7094B1`; ON: 12 punti, 316 ms;
- benchmark isolato quadrato, 6 run misurati dopo warm-up: mediana OFF `178,5 -> 125,5 ms` (-29,7%); mediana ON `326,5 -> 251,5 ms` (-23,0%); la riduzione deriva anche dalla geometria corretta a `2p`, passata da 35 a 18 punti Supply;
- frontend, `definizionedati.json`, WebService 5080 e sorgenti Vittorio non modificati.

### INCARICO 2026-09-27 — Modalità Harness locale rapida e ripristinabile
Stato: ESEGUITO — CICLO LOCALE, CACHE, SNAPSHOT E SERVER 5081 VERIFICATI

Commissionato:
- creare un ciclo operativo locale per `Diego_Vittorio` il più possibile indipendente da GitHub e GitHub Actions;
- mantenere il WebService ordinario sulla porta `5080` e usare una porta separata, `5081`, per il server loopback di anteprima Harness;
- eseguire direttamente il vero Core tramite l'Harness, con build incrementale conservata fuori dal repository e riuso dei binari quando i sorgenti non cambiano;
- produrre una cartella `Latest` locale con SVG, XML, metriche e log, visualizzabile dal browser e aggiornata rapidamente a ogni prova;
- predisporre snapshot locali con manifest e SHA-256, ripristinabili soltanto mediante comando esplicito; prima di ogni ripristino deve essere salvato automaticamente lo stato corrente;
- preservare `SpiraliVittorio`, non modificare il frontend Web e non includere nel commit le modifiche sperimentali locali già presenti su Diego/Harness;
- fornire comandi CMD dai nomi non ambigui, che mantengano visibile la finestra al termine;
- verificare realmente snapshot, build/esecuzione, artifact e risposta HTTP del server locale prima di segnare l'incarico `ESEGUITO`.

Esito:
- aggiunto `tools/local-radiant-harness/LocalRadiantHarness.ps1` con azioni `run`, `snapshot`, `restore`, `serve` e `status`;
- sorgenti Core/Harness copiati e compilati nel mirror esterno `%LOCALAPPDATA%\Termodel\RadiantHarness\SourceMirror`, senza scritture nelle cartelle `bin`/`obj` del repository;
- impronta SHA-256 complessiva usata per saltare completamente la build quando i sorgenti non cambiano; quando cambiano, il mirror conserva `bin`/`obj` e MSBuild può eseguire una build incrementale;
- output normalizzato in `Latest` con `latest.svg`, XML risultante, metriche, log e pagina con aggiornamento automatico;
- server statico minimale vincolato a `127.0.0.1:5081`, distinto dal WebService su `localhost:5080`;
- snapshot esterni al repository con manifest, commit, dimensioni e SHA-256; il ripristino richiede ID e conferma, crea prima uno snapshot `pre-restore` e non elimina file aggiuntivi;
- aggiunti quattro comandi CMD numerati e non ambigui, tutti con pausa finale; `SpiraliVittorio`, frontend e `definizionedati.json` non sono stati modificati;
- le modifiche sperimentali locali preesistenti in `StrategiaDiegoBenchmark.cs`, `StrategiaDiegoEngine.cs` e `Harness/Program.cs` sono state conservate e tenute fuori dal consolidamento di questo incarico.

Verifiche locali:
- snapshot `20260927-061118-470-verifica-iniziale`: 14 file, manifest valido e commit sorgente `bf47916b38d5a84fb3f3a45a269f0a502dbf434d`;
- prima build Release nel mirror: riuscita; seconda esecuzione: messaggio verificato `riuso del binario locale (sorgenti invariati)`;
- ricompilazione forzata fuori repository: riuscita;
- Harness reale `Diego_Vittorio`, raccordi OFF: 18 punti; prove riuscite rispettivamente in 149, 111 e 162 ms;
- artifact SVG finale: 3.272 byte, SHA-256 `E8213C3F474AECB1DCE43A77CEB654DBFDAC2DDEBF638A42F1EF45AA5E103507`;
- prova HTTP sulla porta 5081: `GET /health`, `GET /` e `GET /latest.svg` tutti `200`; tipo SVG `image/svg+xml`;
- il server di prova è stato arrestato al termine; il ripristino non è stato eseguito intenzionalmente.

### INCARICO 2026-09-27 — Sospensione raccordi grafici `Diego_Vittorio` durante il debug
Stato: ESEGUITO — MODALITÀ DEBUG OFF E RIPRISTINO ON VERIFICATI

Commissionato:
- intervenire esclusivamente su `Diego_Vittorio` e non modificare `Vittorio`;
- disattivare per impostazione predefinita, durante l'attuale fase di debug, il calcolo/disegno dei raccordi arrotondati per velocizzare generazione e lettura dell'SVG;
- mantenere mandata, ritorno e collegamento rappresentati con segmenti rettilinei a spigolo vivo;
- permettere la riattivazione completa tramite il flag `TERMODEL_DIEGO_VITTORIO_DRAW_FILLETS=true`;
- rendere lo stato del flag riconoscibile nell'SVG e nei log;
- verificare modalità raccordi OFF e ON su appartamento corrente e locale concavo.

Esito:
- `TERMODEL_DIEGO_VITTORIO_DRAW_FILLETS` è falso per default nell'attuale fase di debug; `true`, `1`, `yes` o `on` riattivano integralmente i raccordi;
- l'SVG dichiara `data-termodel-fittings="disabled|enabled"` e il log comunica esplicitamente lo stato;
- in modalità OFF la mandata viene disegnata con i vertici originali, il ritorno resta calcolato sulla geometria arrotondata necessaria al contratto Vittorio ma viene semplificato per la sola presentazione, e il collegamento finale è rettilineo;
- una prima prova che eliminava anche il calcolo interno è stata respinta perché `CreaRientro` dipende dalla campionatura arrotondata (`Count - 24`) e faceva scomparire il ritorno; la correzione definitiva mantiene visibile la linea blu;
- workflow Harness esteso per verificare default OFF, presenza del ritorno, riduzione del peso SVG e riattivazione ON.

Verifiche locali:
- build Core + Harness Release temporanea: riuscita, 0 errori;
- appartamento OFF: 21 punti rossi + 36 blu, 3.272 byte, 108 ms; ON: 205 rossi + 166 blu, 12.890 byte, 269 ms;
- concavo OFF: 30 punti rossi + 56 blu, 3.907 byte, 171 ms; ON: 304 rossi + 265 blu, 18.768 byte, 308 ms;
- XML risultanti identici nelle modalità OFF e ON e invariati rispetto alla base;
- anteprima OFF 1200x800 verificata: contorno, mandata, ritorno e collegamento sono presenti con spigoli leggibili.

### INCARICO 2026-09-27 — SVG `Diego_Vittorio` con contorno architettonico e adattamento alla finestra
Stato: ESEGUITO — SVG RESPONSIVO E CONTORNO VERIFICATI LOCALMENTE

Commissionato:
- intervenire esclusivamente sulla derivazione `Diego_Vittorio`, mantenendo `Vittorio` intatto;
- rappresentare nell'SVG finale il contorno architettonico dei locali;
- rendere l'SVG adattabile alla finestra di presentazione senza deformare la geometria;
- correggere la serializzazione non invariant di dimensioni, `viewBox` e trasformazione, che in cultura italiana produce separatori decimali incompatibili con SVG;
- produrre e presentare l'SVG reale dell'Harness sul progetto appartamento corrente;
- verificare anche il locale concavo e accertare che XML e geometria delle spirali non vengano modificati.

Esito:
- modificato esclusivamente `SpiraliDiegoVittorio/ChiudiSpirale.cs`; i quattro sorgenti `SpiraliVittorio` conservano le impronte SHA-256 registrate;
- propagato il `PerimetroInterno` alla sola serializzazione finale e aggiunto il gruppo SVG `architecture` con un `polygon.architectural-contour` per locale;
- radice SVG resa responsiva con `width="100%"`, `height="100%"`, `viewBox` geometrico e `preserveAspectRatio="xMidYMid meet"`;
- corretta la serializzazione di `viewBox` e trasformazione con `InvariantCulture`: eliminati i separatori decimali italiani non validi per SVG;
- aggiunta al workflow Harness la regressione su contorno, adattamento e assenza di virgole nel `viewBox`.

Verifiche locali:
- build Core + Harness Release temporanea: riuscita, 0 errori;
- appartamento corrente: SVG XML-valido, un contorno, `viewBox="3.33082 1.07362 5.30066 5.02547"`, 18 punti spirale;
- concavo L: SVG XML-valido, un contorno, `viewBox="-0.5 -1.5 7 7"`, 27 punti spirale;
- hash XML risultanti invariati rispetto alla base: appartamento `07221BD4633D0A2726054EF6D578B67C414779C7B1EB5383C9AD389CAA410442`, concavo `3187DCA854CEE0BF7FA8313FCDC1640EF12C6F8E1A3886B4DBD4403ED0387E23`;
- anteprima 1200x800 renderizzata con Chrome headless: contorno, spirale e adattamento proporzionale visivamente verificati.

### INCARICO 2026-09-27 — Creazione strategia derivata `Diego_Vittorio`
Stato: ESEGUITO — COPIA INDIPENDENTE E PARITÀ INIZIALE VERIFICATE

Commissionato:
- creare una copia completa e indipendente del motore `SpiraliVittorio`, denominata `Diego_Vittorio`, come base delle successive sperimentazioni;
- mantenere i quattro sorgenti originali `SpiraliVittorio` byte-per-byte intatti per confronti e ripristini;
- isolare la copia con namespace e selettore propri, senza introdurre in questa prima fase variazioni geometriche;
- registrare provenienza e impronte SHA-256 dei sorgenti di partenza;
- integrare il selettore nel Service e nell'Harness senza cambiare il caso corrente `Vittorio`;
- verificare build e parità iniziale degli SVG sui casi rettangolare e concavo.

Esito:
- creata `CopiedFromTermodel/SpiraliDiegoVittorio/` con i quattro sorgenti Vittorio e il solo namespace iniziale cambiato in `SpiralHeatingDiegoVittorio`;
- registrati nel `README.md` provenienza, commit base e SHA-256 dei quattro originali;
- aggiunti selettore `Diego_Vittorio`, facciata benchmark e caso Harness dedicato, mantenendo `CURRENT-APARTMENT-P030.json` su `Vittorio`;
- esteso il workflow con smoke e artifact separato `strategia-diego-vittorio-current-apartment`;
- verificato nuovamente dopo le modifiche che le impronte dei quattro file `SpiraliVittorio` coincidono con quelle iniziali.

Verifiche locali:
- build Core + Harness Release in directory temporanea: riuscita, 0 errori; restano gli avvisi nullable già propri dei sorgenti copiati;
- rettangolare/appartamento: 18 punti, SVG e XML di `Vittorio` e `Diego_Vittorio` identici SHA-256;
- concavo L: 27 punti, SVG e XML di `Vittorio` e `Diego_Vittorio` identici SHA-256;
- SVG rettangolare: `D8D573211BD189D86740615D3BFB3E98BFAA34D75037D4D430CE24071FF9BFC1`;
- SVG concavo: `39F159A4FD390D9F59EB9CF9A20ABA49B98CD57583AB6931DA01B0F344743B74`.

### INCARICO 2026-09-26 — Rendere auto-riprendibile il debug spirali da Linee Guida
Stato: ESEGUITO — LINEE GUIDA AUTOSUFFICIENTI PER RIPRESA R31

Commissionato:
- verificare perché un agente/Codex, leggendo `LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md`, non riesce a riprendere correttamente il test corrente;
- confrontare Linee Guida con stato reale di Core, Harness, Prefix Lock R30, checkpoint R31, workflow e pubblicazione su `main`;
- completare le Linee Guida con un punto di ripresa operativo autosufficiente: branch/commit di riferimento, fixture/case, cwd, file Prefix Lock, comandi esatti, output attesi, marker, artifact e distinzione fra run condizionato Harness e free run Service;
- correggere informazioni obsolete che possono sviare un agente, senza modificare Core/frontend;
- chiudere Issue #1 Completed se riuscito, Not planned se fallito.

Esito:
- individuate tre cause principali della mancata ripresa: checkpoint fermo a R30, `STRATEGIADIEGO_TEST_CONTEXT_CURRENT` ancora puntato al vecchio contesto LG046 e stato motore dichiarato obsoletamente come non implementato; inoltre mancavano comandi riproducibili e la distinzione esplicita fra Harness con Prefix Lock e Service free-run;
- aggiornato `LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md` con checkpoint R31 verificato, diagnosi/correzione del nodo 15, run/artifact/marker canonici e SVG/report attesi;
- aggiunta sezione `RIPRESA OPERATIVA OBBLIGATORIA — per ChatGPT / Codex / nuova chat` con repository, branch, working directory, file Core, case LG041, Prefix Lock R30 a 14 Decision Key, comandi PowerShell, verifiche R30/R31 e protocollo di ripresa;
- chiarito che PR #8 è già integrata su `main`, Core R31 pubblicato nel commit `77ae7b81dd82afb157b4f54a15a45c77cf9d1d63`, artifact canonico `radiant-harness-fast` id `10908514063`, run `36250164600`;
- aggiornato il contesto corrente a `LG041-R31-FREE-RUN-SELECTION-SQUARE4X4-T1-P030`;
- prossimo obiettivo reso esplicito: confrontare baseline free-run senza lock con R30/R31 condizionato e trovare la **prima Decision Key divergente**; vietato inserire il Prefix Lock nel runtime come hardcode;
- nessuna modifica a Core, frontend, Library o `definizionedati.json`;
- commit Linee Guida: `94581ea3cd55565d66005af44b4f066ec09b6a83`.



### INCARICO 2026-09-26 — Pubblicazione su Render dello stato sperimentale StrategiaDiego
Stato: ESEGUITO — PUBBLICATO SU MAIN / AUTO-DEPLOY RENDER ATTIVATO

Commissionato:
- pubblicare su `main` e quindi sul Service Render tutte le modifiche fin qui realizzate e verificate sul branch sperimentale PR #8, per una prova più ampia;
- preservare un riferimento di rollback del `main` precedente alla pubblicazione;
- includere il motore reale StrategiaDiego, Harness e condizionamenti diagnostici già sviluppati, senza modificare il frontend;
- considerare la pubblicazione una **prova ampia sperimentale**, non una promozione a Golden definitivo;
- verificare compilazione GitHub e raggiungibilità del Service pubblico dopo il deploy;
- aggiornare Summary/registro con lo stato reale;
- chiudere Issue #1 Completed se pubblicazione e verifica riescono, Not planned se falliscono.

Esito:
- creato rollback branch `backup/pre-render-r31-20260926` sullo stato di `main` precedente alla pubblicazione;
- PR #8 integrata su `main` nel commit `77ae7b81dd82afb157b4f54a15a45c77cf9d1d63`;
- il push su `main` attiva il normale auto-deploy Render già configurato per `https://termodel.onrender.com`;
- frontend non modificato;
- GitHub Action `TermodelService Build` run `36250164693`: restore e **Build SUCCESS, 0 errori**; workflow finale rosso esclusivamente nel benchmark StrategiaDiegoSquare4x4, con 73.123 nodi e P95 7290 ms oltre i budget correnti;
- GitHub Action `Termodel Radiant Harness` run `36250164600`: build Harness/Core e checkpoint R30/R31 fino alla continuazione del nodo 15 **SUCCESS**; failure successiva nel Decision Reject Replay cumulativo per superamento del limite tecnico di ricerca già noto;
- la pubblicazione è quindi destinata a **prova ampia sperimentale**, non a rilascio Golden;
- la sessione non dispone di accesso rete affidabile al runtime Render per una verifica HTTP indipendente di `/health`; non viene quindi dichiarata una verifica runtime diretta del commit, ma il percorso di pubblicazione resta quello normale GitHub `main` -> auto-deploy Render.



### INCARICO 2026-09-26 — Correzione arresto immotivato dopo nodo 15
Stato: COMMISSIONATO

Commissionato:
- considerare **approvato** il setup R30 fino al nuovo nodo 15 `(0,75;3,25)`;
- spiegare perché il Supply termina al nodo 15 e correggere il comportamento se il terminale è prodotto da una semantica geometrica errata;
- preservare integralmente il Prefix Lock già approvato fino al nodo 15;
- verificare in particolare la continuazione parallela verso il basso, mantenendo le distanze di progetto invece di collidere col tratto esistente;
- applicare una correzione generale al motore solo se supportata dai log e non un hardcode sul nodo;
- rieseguire Harness, produrre lo SVG standard aggiornato e confrontarlo col checkpoint R30;
- aggiornare linee guida con lo stato corrente del debug e la diagnosi/correzione;
- aggiornare registro, Summary e PR #8;
- nessun merge in main senza autorizzazione separata;
- chiudere Issue #1 Completed se riuscito, Not planned se fallito.


### INCARICO 2026-09-26 — Debug nodo 22 verso tratto 5→6→7 a distanza 2p
Stato: ESEGUITO — HARNESS SUCCESS / CHECKPOINT MEMORIZZATO

Commissionato:
- partire dal setup ansa buona + miglior completamento top-5;
- analizzare le scelte reali al nodo 22 secondo la numerazione dello SVG corrente;
- individuare e attuare l'opzione più vicina a 2p=0,60 m dal tratto SVG 5→6→7;
- visualizzare il risultato con SVG del vero motore;
- memorizzare questa posizione di debug nelle linee guida per una chat successiva;
- nessuna modifica alla funzione di merito o alle regole geometriche normali.

Riferimenti SVG di partenza:
- nodo 5=(0,15;3,85), nodo 6=(0,15;3,25), nodo 7=(0,15;0,15);
- nodo 22=(1,40;3,25); p=0,30 m, quindi 2p=0,60 m.

Analisi nodo 22:
- PROSEGUI_DRITTO fisico -> (0,75;3,25): ACCEPT, distanza esatta 0,60 m da 5→6→7;
- PROSEGUI_DRITTO laterale -> (0,80;3,25): ACCEPT, distanza 0,65 m;
- PARALLELA_B -> (1,40;1,35): ACCEPT ma più lontana;
- PARALLELA_A: nessun candidato geometrico valido.

Decision Key scelta:
`DIEGO_DECISION family=Supply choice=PROSEGUI_DRITTO start=(1.400000,3.250000) target=(0.750000,3.250000) refFamily=Supply ref=((0.150000,3.250000)->(0.150000,3.850000)) d=0.600000 type=physical`

Implementazione/collaudo:
- `adca010d75dd63b5d4c1f42589113b31cb3824a8`: Branch Inspector compatibile con Prefix Lock;
- `0f503eab6c7f88dab33a00ad4dd75eb45d227c40`: test automatico nodo22, selezione per distanza dalla polilinea 5→6→7 ed estensione Prefix Lock;
- Prefix Lock esteso a 14 Decision Key;
- Harness run `36240642880`, job `108400565235`: **SUCCESS**;
- artifact `radiant-harness-fast` id `10904919361`;
- output: SupplyNodes 15, SupplyTerminals 1, ReturnNodes 2893, AcceptedTerminals 656;
- SVG SHA-256 `0325c4f3cc54d4e1614353e5384acba59b6ac1ffa774e06769fa432734df3f0b`;
- Build generale run `36240642868`: Build **SUCCESS**, 0 errori; workflow finale rosso solo per benchmark LG-046 noto, 44.044 nodi, P95 2708 ms > budget 2000 ms.

Rinumerazione dopo la potatura:
- il vecchio nodo 22 `(1,40;3,25)` diventa nodo **14** nel nuovo SVG;
- il nuovo target `(0,75;3,25)` diventa nodo **15**.

Documentazione:
- linee guida checkpoint commit `aa3571dbee9f50000545e8c83ed55fc140bd72a4`;
- registro R30 commit `a54219287064a2c993facbeed5a04e6e962971f0`.

Posizione corrente del debug:
- ansa buona preservata;
- scelta vecchio nodo22→(0,75;3,25) fissata a 2p dal tratto 5→6→7;
- prossima chat deve ripartire dallo SVG R30 e usare la **nuova numerazione** per analizzare le scelte successive.

### INCARICO 2026-09-26 — Prefix Lock e ricerca setup ansa buono
Stato: ESEGUITO — HARNESS SUCCESS / SETUP ANSA BUONO ISOLATO

Commissionato:
- introdurre sulla PR #8 un meccanismo diagnostico Prefix Lock complementare al Decision Reject Replay;
- preservare una sequenza iniziale di Decision Key del vero albero e lasciare libera l'esplorazione dopo il prefisso;
- usare il lock per trovare/visualizzare il ramo che risolve correttamente la prima ansa;
- confrontare le decisioni successive senza modificare funzione di merito o geometria;
- produrre SVG standard del vero motore e fotografia riproducibile;
- nessun merge in main.

Implementazione:
- `c23a1f2949a32b5547c83ac0d2f9de83fc493040`: Prefix Lock nel vero `BuildTree` Supply;
- `82fc399c678ac5d4a5125592d3d761618191b85c`: facciata Benchmark;
- `0a98ceae0bcea666741d5b90164240b9d72ca28d`: Harness `--lock-supply-prefix <file.txt>`;
- scelte fuori prefisso loggate come `DIEGO_PREFIX_LOCK REJECT_NOT_IN_PREFIX`;
- rami incompatibili potati con `PRUNED_BY_PREFIX_LOCK ... terminalCreated=false`;
- dopo l'ultima chiave l'albero torna libero;
- senza lock il comportamento normale resta invariato.

Ramo ansa buono individuato:
- baseline Supply rank 21, terminale storico 74;
- prefisso storico umano `47 -> 48 -> 50`, persistito come 9 Decision Key canoniche;
- tratto caratteristico `(0,75;0,15) -> (1,40;0,15) -> (1,40;0,75)`;
- il Return riesce a sfruttare l'apertura della prima ansa;
- Harness run `36238346531`: **SUCCESS**;
- con lock: 48 nodi Supply, 15 terminali Supply;
- normale selezione sotto lock ricostruisce esattamente il vecchio rank 21;
- SVG locked SHA-256 `5e66496004a65a0a9ba6d60a54b705c2bd4e146a0e8a2218a501490b5f0abae6`;
- artifact `radiant-harness-fast` id `10904813175`.

Confronto completamenti dello stesso prefisso:
- commit test `cdb593fd765d8ea3d497425547fc3441e6179ffc`;
- Harness run `36238654776`: **SUCCESS**;
- locked rank 1: Supply 25,45 m / goodness 0,954375; Return 14,90 m; combined merit 41,9808 m;
- locked rank 3: stessa qualità Supply 25,45 m / 0,954375; Return 19,35 m / goodness 0,725625; closure 1,0440 m; combined merit **46,4440 m**;
- il locked rank 3 è un completamento nettamente migliore dello stesso prefisso ansa, ma non è scelto dal ranking Supply corrente;
- SVG migliorato SHA-256 `3cdab768960a2328ef67d77275b56b4f27a8805000b08016f7da997dd56d94e1`;
- artifact `radiant-harness-fast` id `10905531133`.

Build generale:
- `TermodelService Build` run `36238656696`: Restore/Build **SUCCESS**, 0 errori;
- workflow finale failure solo sul benchmark LG-046 già noto: 44.044 nodi, P95 4538 ms > budget 2000 ms.

Documentazione:
- linee guida aggiornate commit `839affc8066d01a93533c17329b0216b0a0f9520`;
- registro R29 commit `b162a739cb2fd312e9a03a1fe372c2021e9014a1`.

Conclusione consolidata:
- **il problema dell'ansa è stato separato dal problema del seguito**;
- il ramo con ansa buona è ora riproducibile tramite Prefix Lock;
- il prossimo problema è la selezione fra discendenti a pari qualità Supply: il locked rank 3 produce un Return molto migliore del locked rank 1 ma non viene preferito dal selettore Supply-first corrente.

### INCARICO 2026-09-26 — Problema corrente: ramo ansa buono con prosecuzione disastrosa
Stato: ESEGUITO — PROBLEMA OPERATIVO CONSOLIDATO

Commissionato:
- registrare il caso in cui un ramo risolve correttamente la prima ansa ma viene classificato male a causa di decisioni successive sfavorevoli;
- rendere esplicito che il prossimo debug deve visualizzare quel circuito, preservare il prefisso buono e correggere soltanto il seguito;
- non modificare ancora funzione di merito o geometria.

Risultato:
- aggiunta nelle linee guida la sezione `Problema operativo attuale — ramo ansa buono, prosecuzione cattiva`;
- consolidato il principio: **qualità della prima ansa/prefisso e merito finale del circuito devono essere osservati separatamente**;
- workflow di debug previsto: individuare il ramo che lascia spazio sufficiente al Return -> visualizzare il circuito completo anche se rank basso -> preservare il prefisso fino all'ansa -> usare Branch Inspector/Decision Reject Replay sulle scelte successive;
- aggiornata `STRATEGIADIEGO_TEST_CONTEXT_CURRENT.CondizionePrincipale` con questo obiettivo;
- linee guida commit `f1bfaf1c0626120390ebd776f8f8e7ec7b6200cf`;
- registrata R28 nel registro sviluppo, commit `849f738f2818df285de3211d2b2e4ef2f35d3ca9`;
- nessuna modifica al motore o alla funzione di merito.

### INCARICO 2026-09-26 — Consolidamento linee guida: Problema dell'ansa
Stato: ESEGUITO — PRINCIPIO GEOMETRICO CONSOLIDATO

Commissionato:
- registrare nelle linee guida StrategiaDiego il fenomeno denominato **Problema dell'ansa**;
- descrivere l'ansa di scavalcamento che nasce dopo il primo giro;
- registrare che il Return la sfrutta quando geometricamente accessibile e che nei giri successivi l'ansa può restringersi fino a non essere più percorribile;
- registrare il fenomeno come miglioramento concettuale della StrategiaDiego ad albero rispetto alla StrategiaVittorio;
- non introdurre ancora una regola matematica o modifica della funzione di merito.

Risultato:
- aggiunta sezione autorevole `Problema dell'ansa — principio geometrico StrategiaDiego` nelle linee guida;
- commit linee guida `fd498d74b4831280f7eb9622cbf061032782403f`;
- registrata R27 in `STRATEGIADIEGO-DEVELOPMENT-REGISTER.md`, commit `0f0dc1c8ea8760201ff16b63154ead608c8b4df8`;
- principio consolidato: l'ansa iniziale deve poter essere utilizzata dal Return finché lo spazio lo consente; il progressivo restringimento nei giri successivi deve emergere naturalmente dalla geometria dell'albero;
- nessuna modifica al motore, alla geometria o alla funzione di merito;
- criterio matematico di perfezione ancora aperto e da derivare tramite confronto di rami reali con Explorer/Inspector/Replay.

### INCARICO 2026-09-26 — Reject scelta nodo 47 del rank 1 corrente
Stato: ESEGUITO — HARNESS SUCCESS / REPLAY REALE

Commissionato:
- usare come base il rank 1 corrente del caso quadrato LG041 senza esclusioni;
- individuare nel percorso del rank 1 la Decision Key della scelta **uscente dal nodo 47** del run corrente;
- usare il numero di nodo solo per localizzare la scelta nel run, quindi applicare il reject tramite Decision Key canonica;
- rieseguire il vero motore StrategiaDiego con quella sola esclusione;
- restituire lo SVG standard risultante e identificare il nuovo top residuo;
- non modificare geometria, funzione di merito o algoritmo;
- registrare esito reale e chiudere Issue #1 come Completed se il collaudo riesce.

Risultato:
- Decision Key estratta automaticamente dal percorso del rank 1 al nodo 47:
  `DIEGO_DECISION family=Supply choice=PARALLELA_B start=(0.750000,0.150000) target=(0.750000,0.750000) refFamily=Supply ref=((2.000000,0.150000)->(3.850000,0.150000)) d=0.600000 type=lateral`;
- il numero 47 è stato usato solo per localizzare la decisione nel run corrente; il reject effettivo usa la chiave canonica;
- workflow commit `ba60d261ca90167f507cc0de542a406ee9c2a119`;
- Harness run `36237004819`, job `108390500611`: **SUCCESS**;
- step dedicato `Reject rank1 choice at current node 47`: **SUCCESS**;
- il log contiene `DIEGO_DECISION_REPLAY REJECT_BY_INPUT` con la Decision Key richiesta;
- nuovo top residuo = precedente **rank 2** della baseline;
- terminal node baseline residuo: `290`;
- active length `28.05 m`, goodness `1.051875`, total length `28.2 m`;
- artifact `radiant-harness-fast`, id `10904393213`;
- SVG standard risultante SHA-256 `6e1a8bf2c78df44aa3ead66788cd72d10246e223384800f7cbc10d0520c3bcd6`;
- nessuna modifica alla geometria, funzione di merito o algoritmo; PR #8 resta sperimentale.

### INCARICO 2026-09-26 — Completamento sistema debug albero StrategiaDiego + reject cumulativo
Stato: ESEGUITO — HARNESS SUCCESS / INFRASTRUTTURA CONSOLIDATA

Commissionato:
- completare l'infrastruttura di debug della StrategiaDiego basata sul vero albero di ricerca e sul Decision Reject Replay;
- mantenere il lavoro algoritmico sul branch sperimentale PR #8, senza merge in `main`;
- verificare in CI il rifiuto cumulativo di più setup Supply consecutivi;
- conservare invariato il comportamento senza reject e continuare a produrre lo SVG standard del motore;
- consolidare in un documento unico il flusso Albero -> Explorer/Inspector -> Decision Key -> reject -> nuova soluzione reale;
- correggere la documentazione storica R23 dopo l'implementazione R24;
- aggiornare registro/Summary e notificare con Issue #1.

Risultato:
- documento operativo unico creato in `docs/STRATEGIADIEGO-TREE-DEBUG.md`;
- R23 riallineata a stato implementato/verificato; R25 chiude il sistema di debug ad albero;
- workflow Harness PR #8 esteso nel commit `b31e2faf2d0ca25a5cd23cf347f56716d3b64b5d`;
- Harness run `36235621367`, job `108386726433`: **SUCCESS**;
- primo reject Supply: rank1 -> precedente rank2;
- secondo reject cumulativo, mantenendo il primo: precedente rank2 -> precedente rank3;
- file cumulativo con 2 Decision Key distinte;
- il log osserva entrambi i `REJECT_BY_INPUT`;
- replay dal solo file cumulativo riproduce lo stesso SVG byte-per-byte del secondo reject interattivo;
- marker CI `RADIANT_HARNESS_DECISION_REPLAY_CUMULATIVE_OK`;
- artifact Harness `radiant-harness-fast`, id `10903972542`;
- PR #8 aggiornata con commento di tracciabilità;
- nessuna modifica alla geometria/funzione di merito e nessun merge algoritmico in `main`.

Verifica build generale:
- `TermodelService Build` run `36235621362`: Restore e Build Release **SUCCESS**, 0 errori;
- workflow finale rosso esclusivamente sul benchmark di sostenibilità LG-046 già noto: `44.044` nodi, P95 `5289 ms` > budget `2000 ms`;
- artifact benchmark id `10904326425`;
- il limite prestazionale è separato dal collaudo funzionale del Decision Reject Replay.

Uso futuro consolidato:
- frase `scarta questo setup mandata` = aggiungere la Decision Key terminale del setup attualmente mostrato ai reject già attivi e rieseguire;
- ulteriori richieste accumulano i reject e presentano il nuovo top reale della classifica residua;
- Explorer e Branch Inspector osservano l'albero; Replay lo filtra; lo SVG mostrato resta sempre quello standard del vero motore.

Problema aperto emerso nel terzo reject cumulativo:
- una sola Decision Key terminale può comparire in più setup con percorsi differenti;
- nel quadrato, il rank 4 originale condivide la Decision Key terminale già usata per escludere il rank 1;
- di conseguenza, dopo aver escluso rank 1, 2 e 3 il successivo setup reale è il precedente rank 5, non il rank 4;
- il replay resta corretto come rifiuto di una **decisione**, ma la scorciatoia `scarta questo setup mandata` non garantisce ancora l'esclusione di un solo setup quando la Decision Key terminale collide;
- per una navigazione strettamente setup-per-setup servirà una firma canonica dell'intero percorso (o equivalente identificatore stabile di setup), distinta dalla singola Decision Key terminale;
- probe CI temporaneo rimosso; workflow Harness ripristinato alla versione verde precedente.

### INCARICO 2026-09-26 — Implementazione Decision Reject Replay
Stato: ESEGUITO — HARNESS SUCCESS / PROTOTIPO PR #8

Commissionato:
- implementare sul branch sperimentale PR #8 l'architettura `Decision Reject Replay` già consolidata nelle linee guida R23;
- ogni scelta reale dell'albero Supply/Return deve avere una Decision Key canonica, stabile e copiabile;
- la chiave non deve dipendere da timestamp, GUID o node ID progressivi;
- introdurre input Harness `--reject-decisions <file.txt>` con zero o più Decision Key, una per riga;
- se una Decision Key corrente coincide con una chiave di input, la scelta deve essere rifiutata prima della creazione del figlio e registrata come `REJECT_BY_INPUT`;
- senza reject file, comportamento e ranking devono restare invariati;
- il replay deve usare il vero BuildTree e produrre il normale SVG standard del motore, non una ricostruzione esterna;
- verificare sul quadrato corrente almeno un reject Supply e confrontare il risultato con la classifica Supply Explorer per assicurarsi che la soluzione residua sia coerente;
- preparare il flusso operativo per richieste future del tipo `scarta questo setup mandata`, così da presentare il setup immediatamente meno performante senza modifiche ad hoc al sorgente;
- aggiornare linee guida/registro/Summary e PR #8 dopo il collaudo;
- nessun merge in `main` senza successiva autorizzazione;
- chiudere Issue #1 `Completed` al termine se il collaudo riesce.


Risultato:
- implementato il Decision Reject Replay sul branch `experiment/lg041-supply-first-return-after`, PR #8;
- ogni scelta reale Supply/Return dispone di Decision Key canonica con coordinate/distanze a 6 decimali e firma geometrica del riferimento normalizzata; nessuna dipendenza da GUID, timestamp o node ID;
- il matching è esatto e il rifiuto avviene prima di `AddNode()`, con log `DIEGO_DECISION_REPLAY REJECT_BY_INPUT`;
- i nodi potati esclusivamente dal replay non vengono trasformati in nuovi terminali: log `PRUNED_BY_REPLAY ... terminalCreated=false`; questo preserva l'insieme delle soluzioni originali meno i rami esplicitamente esclusi;
- Harness implementa `--reject-decisions <file.txt>` e la scorciatoia `--reject-current-supply`;
- `--reject-current-supply` prende la Decision Key terminale del primo setup Supply residuo, la aggiunge ai reject attivi e riesegue il vero motore;
- Supply Explorer e Solution Explorer esportano Decision Key del percorso e terminal key, così una chat futura può applicare reject senza cambiare sorgente;
- Harness run `36234542311`, job `108383827746`: **SUCCESS** completo;
- test quadrato: scartato Supply rank1 terminale 123 (`active=28.05 m`, `goodness=1.051875`), nuovo top residuo = esattamente il precedente rank2 terminale 290 con stesso active/goodness (pari merito); quindi il meccanismo restituisce il successivo nell'ordinamento originale;
- il reject file prodotto automaticamente è stato riusato con `--reject-decisions`; il normale SVG StrategiaDiego risultante è byte-identico a quello del reject automatico;
- baseline senza reject conserva SVG SHA-256 `ca3ba4bbda4a6e95398f3d155f7009d05e0e378843b06b26b86f9fe0a82e8ce0`, identico al checkpoint precedente;
- build completa run `36234542357`: step Release Build **SUCCESS**; workflow rosso solo per benchmark LG-046 già noto (`44044` nodi, P95 `4559 ms` > budget `2000 ms`);
- linee guida aggiornate commit `153cb6e11bfeda53833ca5fd8f903d3d1b6f3adf`; registro sviluppo R24 commit `afb79b149b8d4e423358baa6402b1e051d15ef46`;
- uso futuro concordato: richiesta `scarta questo setup mandata` = accumulare la Decision Key terminale del setup mostrato e presentare il nuovo top residuo; se c'è parità di merito si presenta il successivo nell'ordinamento;
- nessun merge in `main`; PR #8 resta sperimentale.

### INCARICO 2026-09-26 — Fotografia architettura debug Decision Reject Replay
Stato: ESEGUITO — DOCUMENTAZIONE CONSOLIDATA / NON IMPLEMENTATA

Decisione consolidata:
- prima di implementare il nuovo meccanismo di debug, fotografarne l'architettura nelle linee guida affinché qualsiasi chat futura possa applicarla rapidamente e senza reinventare strumenti ad hoc;
- nome architettura: `Decision Reject Replay`;
- ogni decisione di ramo dovrà disporre di una Decision Key canonica e copiabile dal log;
- un input opzionale di debug conterrà le Decision Key da rifiutare;
- quando la key corrente coincide con una riga di input, la scelta viene respinta (`REJECT_BY_INPUT`) e il normale albero continua sulle alternative residue;
- senza input di replay il motore deve mantenere comportamento invariato;
- la Decision Key deve essere basata su geometria/semantica stabile e non su timestamp, GUID o node ID progressivi;
- file di replay previsto: testo UTF-8, una key per riga; opzione Harness prevista `--reject-decisions <file.txt>`;
- più reject possono essere cumulati per guidare progressivamente il vero motore verso soluzioni alternative;
- il risultato da osservare deve essere sempre lo SVG standard prodotto da StrategiaDiego, non una ricostruzione o immagine generata;
- Supply Explorer, Solution Explorer e Branch Inspector restano strumenti di osservazione; Decision Reject Replay sarà lo strumento preferito per ottenere una vera soluzione alternativa;
- primo collaudo previsto: quadrato corrente, escludendo la decisione geometrica che nel run attuale corrisponde al ramo umano `62->65`, senza dipendere dai numeri di nodo.

Tracciabilità:
- linee guida: commit `4ee05ae37b14fd92856425971b464dd4e224baef`;
- registro sviluppo R23: commit `0b63c9011748dab59b49a4b5f63b10aaca3d4e43`;
- nessuna modifica al motore o al Service in questo incarico.


### INCARICO 2026-09-26 — Branch Inspector diagnostico per nodo 63
Stato: ESEGUITO — HARNESS VERIFICATO / PROTOTIPO PR #8

Commissionato:
- implementare sul prototipo PR #8 uno strumento diagnostico generico per ispezionare un nodo/ramo dell'albero StrategiaDiego senza alterare algoritmo o funzione di merito;
- caso iniziale: ramo Supply scartato `61->62->63`, dove `62->63` arriva correttamente a distanza `2p` dal riferimento `43->44`, confrontato con il ramo scelto `62->65`;
- lo strumento deve mostrare la geometria del percorso fino al nodo target e tutte le continuazioni tentate da quel nodo;
- distinguere visivamente almeno: percorso accettato fino al target, candidati accettati, candidati rifiutati e ramo alternativo che ha prodotto la soluzione meglio classificata;
- per ogni candidato mostrare tipo (`PROSEGUI_DRITTO`, `PARALLELA_A/B` o altro), endpoint teorico/reale quando disponibile e motivo di rifiuto ricavato dal motore;
- mantenere lo strumento diagnostico separato dal Service e riusare il vero motore/BuildTree, senza sorgente geometrico alternativo;
- aggiungere comando Harness riutilizzabile per target node o branch, con output SVG e JSON;
- collaudare sul quadrato LG-046 e produrre una vista specifica del nodo 63;
- nessun merge algoritmico in `main` senza ulteriore approvazione;
- Issue #1 chiusa `Completed` al termine del collaudo.


Risultato:
- implementato Branch Inspector riutilizzabile sul branch `experiment/lg041-supply-first-return-after` / PR #8;
- `TryExtend()` emette log diagnostici `TRYEXT CHECK/ACCEPT/REJECT` con intersezione `I`, target `T`, distanza `d`, riferimento e tipo fisico/laterale; nessuna modifica alla logica di scelta;
- Harness supporta `--inspect-node N [--compare-node M]` e produce SVG, JSON e finestra log del nodo;
- primo run `36232610173`: failure di compilazione per conflitto di nome locale nel solo codice diagnostico; nessuna simulazione eseguita;
- fix commit `1ebe2e24efb8739f78c68ace778dc352406bb749`;
- Harness run `36232724318`, job `108378795597`: **SUCCESS** completo; Branch Inspector nodo 63, Explorer esistenti, appartamento e artifact tutti SUCCESS;
- artifact `radiant-harness-fast`, id `10902842432`;
- percorso target nodo 63: `1,3,41,42,43,44,45,47,48,50,52,59,61,62,63`; confronto nodo 65: stesso prefisso fino a 62, poi `62->65`;
- dal nodo 63 `(0.75,3.25)` vengono osservate tre candidate reali:
  - `PROSEGUI_DRITTO` a `(0.15,3.25)`: REJECT `distance=0 required=0.6`;
  - `PARALLELA_A`: `I=(0.75,0.75)`, `T=(0.75,0.15)`, `d=0.60`, REJECT `distance=0 required=0.6`;
  - `PARALLELA_B`: `I=(0.75,3.85)`, `T=(0.75,4.45)`, REJECT fuori locale;
- nodo 63 termina con activeLength `21,65 m`, goodness `0,812`;
- diagnosi confermata: `62->63` raggiunge correttamente la posizione a `2p` dal verticale `43->44`; la successiva parallela verso il basso usa però la semantica laterale `oltre I`, arriva fino a `y=0.15` e collide, invece di arrestarsi prima del fronte interno;
- la build completa compila; resta il failure benchmark quadrato LG-046 già noto per P95 oltre budget, non causato dal Branch Inspector;
- linee guida aggiornate nel commit `f3113354d772592b616dae3ef644aefa7984d8a1`; registro R22 nel commit `e2905647024f84dbd8fa311d9f7ae2557790f5db`;
- nessun merge in `main`; PR #8 resta sperimentale.

### INCARICO 2026-09-26 — Solution Explorer: rank mandata + miglior ritorno
Stato: ESEGUITO — HARNESS VERIFICATO / PROTOTIPO PR #8

Commissionato:
- estendere il `Termodel.RadiantPanels.Harness` sul prototipo PR #8 senza modificare il comportamento normale del Service;
- mantenere la classifica delle mandate pure come ordinamento principale e immutabile;
- per ogni Supply rank richiesto, congelare quella mandata, costruire tutti i ritorni compatibili e selezionare soltanto il miglior Return associato;
- il ritorno non deve rimescolare il rank della mandata;
- se nessun ritorno è fattibile, esportare comunque la mandata e marcare `RETURN NON FATTIBILE`;
- produrre SVG combinato rosso+blu per ogni rank, più manifest JSON con metriche Supply, metriche Return, nodo terminale Return, chiusura e merito combinato;
- supportare almeno `--solution-top N`, `--skip-top N --solution-top M` e `--solution-rank N`;
- mantenere disponibili le modalità Supply-only esistenti;
- collaudo iniziale sul quadrato LG-046 con almeno top 20 e confronto specifico del rank 21 contenente `47->48`;
- nessun merge in `main` senza ulteriore approvazione visuale;
- Issue #1 chiusa `Completed` al termine della simulazione.


Risultato:
- implementata sul branch `experiment/lg041-supply-first-return-after` / PR #8 la modalità combinata `rank Supply + miglior Return`, senza modificare l'ordinamento delle mandate;
- estratta `TryFindBestReturnForSupply()` e riusata sia dal flusso normale supply-first sia dal Solution Explorer, evitando una seconda implementazione del Return;
- aggiunti `StrategiaDiegoEngine.ExploreRankedSolutions()` e `StrategiaDiegoBenchmark.ExploreRankedSolutions()`;
- Harness esteso con `--solution-top N`, `--skip-top N --solution-top M` e `--solution-rank N`; modalità Supply-only precedenti mantenute;
- output: `solution-rank-NNN.svg` rosso+blu, `solutions.json` con metriche Supply/Return/chiusura/merito e `index.html` a galleria;
- Harness run `36231049216`, job `108374280776`: **SUCCESS** completo; Top 3 combinati, rank 21 combinato, appartamento e artifact tutti SUCCESS;
- artifact `radiant-harness-fast`, id `10902548566`;
- rank Supply 1: active `28,05 m`, goodness `1,051875`; Best Return active `21,05 m`, goodness `0,789375`, closure `0,30 m`, combined merit `50,00 m`, 43.670 nodi Return esplorati;
- rank Supply 2: stessa qualità del rank 1, soluzione speculare con radice Return `Destra`;
- rank Supply 3: Supply active `27,95 m`, goodness `1,048125`; Best Return active `5,60 m`, goodness `0,21`, closure `1,030776 m`, combined merit `35,1808 m`; peggioramento prevalentemente lato Return;
- rank Supply 21, primo con `47->48`: Supply active `25,45 m`, goodness `0,954375`; Best Return active `14,90 m`, goodness `0,55875`, total Return `15,35 m`, closure `1,030776 m`, combined merit `41,9808 m`; 90.901 nodi Return esplorati;
- il confronto conferma che il rank 21 perde sia per mandata più corta sia perché il miglior ritorno compatibile riempie meno efficacemente le anse;
- build completa run `36231049256`: compilazione Release SUCCESS; benchmark quadrato `not-sustainable` per il problema già noto LG-046, 44.044 nodi e P95 `4.197 ms` > budget 2.000 ms; failure non attribuibile al Solution Explorer diagnostico;
- linee guida aggiornate nel commit `0e39a9064711e0237484e9205496ddf3cd590809`; registro R21 nel commit `9b910330bdda49612da819e04aaa4e13052114d8`;
- nessun merge in `main`; PR #8 resta sperimentale.

### INCARICO 2026-09-26 — Solution Explorer StrategiaDiego
Stato: ESEGUITO — HARNESS VERIFICATO / PROTOTIPO PR #8

Commissionato:
- implementare sul prototipo PR #8 uno strumento diagnostico nel `Termodel.RadiantPanels.Harness` per visualizzare anche soluzioni non vincenti;
- non modificare funzione di merito, regole geometriche o comportamento normale del Service;
- esporre la classifica delle mandate pure prodotte prima del ritorno, con almeno rank, terminal node, activeLength, goodness, totalLength e firma/percorso nodi;
- aggiungere modalità Harness `--supply-top N` per esportare le migliori N mandate pure in SVG separati e un indice/manifest JSON;
- aggiungere selezione `--supply-rank N` per renderizzare una specifica mandata pura senza ritorno;
- quando praticabile predisporre struttura estendibile a future classifiche Return per una mandata scelta, ma il primo collaudo deve concentrarsi sulle mandate pure;
- generare Top 20 sul banco `LG046-RETURN-STEP-P-SQUARE4X4-T1-P030` e identificare il rank del ramo che contiene `47->48`;
- produrre artifact leggibili rapidamente e mantenere il tool separato dall'output standard del Service;
- aggiornare linee guida/registro/Summary con uso e risultati;
- nessun merge algoritmico in `main` senza ulteriore approvazione;
- Issue #1 chiusa `Completed` al termine della simulazione.

Risultato:
- implementato sul branch `experiment/lg041-supply-first-return-after` / PR #8 un percorso diagnostico Supply-only che riusa il vero `BuildTree`, `TerminalGoodness`, `ActiveSpiralLength` e lo stesso ordinamento del motore;
- `StrategiaDiegoEngine.ExploreSupply()` produce la classifica delle mandate pure senza costruire il ritorno e senza modificare la selezione normale;
- `StrategiaDiegoBenchmark.ExploreSupply()` espone la facciata diagnostica al Harness;
- Harness supporta `--supply-top N`, `--skip-top N --supply-top M` e `--supply-rank N`;
- output per il Solution Explorer: un `supply-rank-NNN.svg` per soluzione, `solutions.json` con metriche/percorso nodi, e `index.html` a galleria;
- Harness run `36229900092`: **SUCCESS** completo; build Core+Harness, run quadrato, Top 40, prova `--skip-top 20 --supply-top 5`, appartamento e artifact tutti SUCCESS;
- artifact finale `radiant-harness-fast` id `10901942162`;
- quadrato: 374 nodi Supply, 110 terminali Supply classificati;
- rank 1: terminale 123, activeLength `28,05 m`, goodness `1,052`, totalLength `28,20 m`;
- nessuna delle prime 20 mandate contiene il ramo `47->48`;
- prima comparsa del ramo `47->48`: **rank 21**, terminale 74, activeLength `25,45 m`, goodness `0,954375`, totalLength `25,60 m`, percorso `1,3,41,42,43,44,45,47,48,50,52,59,61,62,65,67,69,73,74`;
- il ramo `47->48` compare anche ai rank 22 e 25;
- prova skip-top verificata realmente: `--skip-top 20 --supply-top 5` esporta solo rank 21..25 e non rank 20;
- linee guida aggiornate nel commit `4a891a06325862ea1b989a8ef85c7454ba6df4b0`; registro R20 nel commit `fa477ea4568cb4c7d141bf6e09c5980ea8e042aa`;
- lo strumento è diagnostico e non altera funzione di merito o Service; resta sul prototipo PR #8 insieme alle modifiche algoritmiche sperimentali.


### INCARICO 2026-09-26 — Return/Return a passo p
Stato: ESEGUITO — SIMULAZIONE POSITIVA / NON INTEGRATA

Commissionato:
- proseguire la simulazione sul prototipo `experiment/lg041-supply-first-return-after` / PR #8, senza merge in `main`;
- modificare la matrice delle distanze StrategiaDiego secondo il ruolo delle due famiglie:
  - Supply/Supply = `2p`;
  - Return/Return = `p`;
  - Supply/Return = `p`;
  - Return/Supply = `p`;
  - qualunque tubo rispetto all'architettura = `p/2`;
- mantenere LG-042 supply-first: il ritorno viene costruito solo dopo la mandata completa;
- mantenere LG-043: raccordo entrante promosso a normale `Return sequence 0`;
- usare la nuova distanza Return/Return anche nei candidati LG-041 e nelle normali validazioni geometriche;
- verificare sul quadrato se il ritorno riempie più naturalmente le anse lasciate dalla mandata;
- confrontare nodi, terminali, activeLength/goodness, SVG e log con LG-045;
- eseguire appartamento preconfezionato e regression completa senza alzare limiti o introdurre potature;
- nessuna modifica a frontend, Library Desktop, Vittorio/GPT o `definizionedati.json`;
- Issue #1 aperta durante il lavoro e chiusa `Completed` al termine della simulazione.

Risultato:
- modifica sperimentale sul branch `experiment/lg041-supply-first-return-after`, commit `db380ea6af1fad8de4fed1df45aca64b395372c1`, PR #8; nessun merge in `main`;
- `RequiredDistance()` usa ora `p` per Return/Return; Supply/Supply resta `2p`, Supply/Return e Return/Supply restano `p`, architettura resta `p/2`;
- Radiant Harness run `36228623930`: **SUCCESS** su quadrato e appartamento;
- quadrato: 374 nodi Supply, 43.670 Return, 44.044 totali, 12.545 terminali combinati, 8.192 accettati, maxDepth 35;
- la mandata selezionata resta invariata: activeLength `28,05 m`, goodness `1,052`;
- il ritorno selezionato migliora da activeLength `20,15 m`, goodness `0,756` a `21,05 m`, goodness `0,789`; guadagno `+0,90 m` attivi;
- nel log risultano 7.328 candidati Return/Return accettati con `d=0,30 m` e nessuno con `d=0,60 m`; la nuova matrice è quindi effettivamente applicata;
- SVG quadrato SHA-256 `ca3ba4bbda4a6e95398f3d155f7009d05e0e378843b06b26b86f9fe0a82e8ce0`;
- appartamento preconfezionato: SUCCESS, 43 Supply + 198 Return = 241 nodi totali, 4 terminali accettati, 117 ms diagnostici;
- build completa PR: compilazione SUCCESS; benchmark quadrato 20/20 deterministico con 44.044 nodi, P95 `3.904 ms`, memoria delta max ~12,62 MB e 8.192 terminali accettati;
- benchmark quadrato `not-sustainable` per P95 oltre budget 2.000 ms pur restando sotto budget nodi 50.000; la regression si ferma sul quadrato e non verifica i fixture successivi;
- nessun limite alzato e nessuna potatura euristica introdotta;
- LG-046 registrata nelle linee guida nel commit `e66346aecb5b4feb5944e8236033dec010c7a1ab`; registro R19 nel commit `b4ce9e98a73c08d794f770c03a32e2506e33b18a`;
- conclusione: la regola `Return/Return=p` migliora realmente il riempimento delle anse e la bontà del ritorno, ma aumenta fortemente la combinatoria; integrazione in `main` rinviata in attesa di deduplicazione esatta degli stati Return.


### INCARICO 2026-09-26 — Analisi efficienza ramo 47→49 rispetto a 47→48
Stato: ESEGUITO — DIAGNOSI / NESSUNA MODIFICA CODICE

Risultato:
- il ramo `47->49` risulta più efficiente solo perché il ramo `47->48` non riesce a completare lo sviluppo normotico successivo;
- miglior terminale `47->48`: nodo 74, activeLength `25,45 m`, goodness `0,954`;
- miglior terminale `47->49`: nodo 123, activeLength `28,05 m`, goodness `1,052`; differenza `+2,60 m`;
- nel ramo `47->48`, al nodo 62 viene generato correttamente `PROSEGUI_DRITTO 62->63` fino a `(0.75,3.25)`, ma da nodo 63 le parallele vengono respinte;
- causa: la linea interna a `y=0.75` è lì soltanto un prolungamento laterale; `TryExtend()` applica la semantica LG-034/LG-035 `oltre I` anche alla svolta parallela, portando il candidato da `y=3.25` fino a `y=0.15` invece di fermarlo a `y=1.35`; il candidato sovra-esteso collide con la mandata inferiore e viene respinto;
- nel ramo `47->49` la stessa linea `y=0.75` è invece fisicamente presente sotto `x=0.75`, quindi la svolta viene troncata `prima di I` a `y=1.35` e la spirale interna può completarsi;
- il vantaggio `+2,60 m` si scompone in circa `+0,65 m` sul traverso alto, `+0,70 m` sulla corsia `y=1.35` e `+1,25 m` sulla corsia `y=2.65`;
- conclusione: la maggiore bontà del ramo anticipato è un artefatto del mancato sviluppo normotico del ramo `47->48`, non una superiorità geometrica reale;
- prossimo tema da discutere: separare la semantica dei laterali `PROSEGUI_DRITTO` (oltre il prolungamento quando richiesto) dalle svolte `PARALLELA_A/B`, che in un normale circuito normotico devono poter usare la retta estesa come fronte di arresto `prima di I`;
- diagnosi registrata nel registro R18, commit `1da3603dca01e3672a3b2b6e6b052641177cab9b`; nessuna modifica al motore.


### INCARICO 2026-09-26 — Analisi distanza 45→47 rispetto a 1→3
Stato: ESEGUITO — DIAGNOSI / NESSUNA MODIFICA CODICE

Risultato:
- percorso selezionato: nodo 45 `(0.15,0.15)` -> nodo 47 `(0.75,0.15)`, collineare al tratto iniziale nodo 1 `(2.00,0.15)` -> nodo 3 `(3.85,0.15)`;
- il vuoto fra nodo 47 e nodo 1 è `1,25 m`, quindi maggiore dei `2p=0,60 m` attesi;
- al nodo 47 il motore genera e accetta correttamente `PROSEGUI_DRITTO 47->48`, con 48 `(1.40,0.15)`: distanza da nodo 1 esattamente `0,60 m = 2p`;
- nello stesso nodo viene accettato anche `PARALLELA_B 47->49`, `(0.75,0.15)->(0.75,0.75)`;
- il sottoalbero via 47->48 raggiunge al meglio activeLength `25,45 m`, goodness `0,954`;
- il sottoalbero via 47->49 raggiunge activeLength `28,05 m`, goodness `1,052` e produce il terminale Supply selezionato 123;
- quindi la distanza non è calcolata male e il ramo corretto non è scartato geometricamente: perde per il merito finale, che premia la maggiore copertura e non impone di completare il tratto diritto prima di una nuova svolta;
- diagnosi registrata nel registro R17, commit `49c4bb8feb56a751359b44139e73c4ee2fcc87e0`;
- nessuna modifica al prototipo in questa fase.


### INCARICO 2026-09-26 — Correzione cambio guida prematuro su catena collineare
Stato: ESEGUITO — SIMULAZIONE POSITIVA / NON INTEGRATA

Diagnosi di partenza:
- al nodo 95 il motore segue ancora il riferimento verticale atteso, ma `FindSequenceContinuation()` seleziona `48->50` con `rayTravel=0`;
- `48->50` è collineare e contiguo con il segmento di arrivo `50->95`, quindi appartiene alla stessa evoluzione rettilinea di provenienza;
- l'esclusione LG-044 per solo ID del segmento corrente non basta.

Commissionato:
- modificare sul prototipo PR #8 la ricerca della continuazione affinché, nei candidati `at-node`, escluda l'intera catena collineare e contigua della stessa evoluzione di arrivo;
- non eliminare genericamente tutti i `rayTravel=0`, perché restano necessari a LG-034/LG-035;
- mantenere validi gli `at-node` appartenenti a un fronte geometricamente distinto;
- non introdurre preferenze di merito o potature euristiche per ottenere il risultato;
- verificare sul quadrato che al nodo 95 `48->50` venga escluso come `same-arrival-chain` e che il percorso selezionato continui secondo il circuito normotico atteso;
- eseguire Radiant Harness su quadrato e appartamento preconfezionato; recuperare SVG/log/metriche;
- eseguire regression completa e registrare eventuale impatto combinatorio senza alzare limiti;
- nessun merge in `main` senza ulteriore approvazione visuale;
- chiudere Issue #1 `Completed` al termine della simulazione.

Risultato:
- modifica sperimentale sul branch `experiment/lg041-supply-first-return-after`, commit `1a734a98bc699d585c4fe80ad5dc791b913c5da1`, PR #8; nessun merge in `main`;
- aggiunta esclusione `same-arrival-straight-chain`: negli `at-node`, `FindSequenceContinuation()` ignora la componente collineare/contigua della stessa evoluzione di arrivo, non gli altri fronti geometricamente distinti;
- marker diagnostico: `SEQUENCE skip-same-arrival-chain`;
- Radiant Harness run `36226870346`: **SUCCESS**;
- quadrato: 374 nodi Supply, 110 terminali Supply, 8.854 nodi Return, 9.228 nodi totali, 2.560 terminali accettati, maxDepth 30;
- percorso rosso vincente nella zona critica: `(2.60,0.75)->(3.25,0.75)->(3.25,3.25)->(1.40,3.25)->(0.75,3.25)->(0.75,1.35)`; il circuito torna normotico e il cambio guida spurio su `48->50` scompare;
- benchmark quadrato 20/20 deterministico: P95 788 ms, memoria delta max 16.769.936 byte, SVG SHA-256 `e1e7565aa0007e7530175879cdf3589966a32e9ef7cc2b5c3b85e157e264f4cf`;
- appartamento preconfezionato: SUCCESS, 43 Supply + 50 Return = 93 nodi totali, 4 terminali accettati, 61 ms nel run diagnostico;
- build completa PR: compilazione SUCCESS; benchmark `ConcaveL` completa 20/20 ma è `not-sustainable`: 99.419 nodi, 4 terminali accettati, P95 6.812 ms, oltre budget 50.000 nodi / 2.000 ms;
- il caso concavo non supera più il limite tecnico di 250.000 nodi, ma resta troppo costoso; la workflow si ferma su ConcaveL e non verifica i fixture successivi in questa run;
- nessun limite alzato e nessuna potatura euristica introdotta;
- LG-045 registrata nelle linee guida nel commit `e66dac6fe6b9bc16e4fdd4b2f94b4942d35767e9`; registro R16 nel commit `eada863cb8900ac97acacb9a3cdf6d40eb7fc5f3`;
- conclusione: correzione geometrica riuscita; integrazione in main rinviata finché non viene ridotta in modo esatto la crescita degli stati sul concavo.


### INCARICO 2026-09-26 — Analisi log nodo 95/97 dopo LG-044
Stato: ESEGUITO — DIAGNOSI / NESSUNA MODIFICA CODICE

Risultato:
- nel percorso selezionato `...48->50->95->97->99...`, il cambio guida avviene al nodo 95;
- al nodo 95 il `front` è ancora sequence 2, corrispondente al riferimento del tratto `3->39`, ma `FindSequenceContinuation()` sceglie sequence 10 (`48->50`) con `rayTravel=0` perché la sua retta estesa passa sul nodo;
- `48->50` è collineare/contiguo con la corsa di arrivo `50->95`; l'esclusione LG-044 per ID del solo segmento corrente non lo elimina;
- il motore costruisce quindi `95->97` come `EXTEND beyond-extended-front` a `2p` rispetto a `48->50` e il nodo 97 eredita questo fronte orizzontale;
- a 97 esistono entrambe le alternative: `PROSEGUI_DRITTO 97->98` verticale fino a `(3.25,3.25)` e `PARALLELA_B 97->99` orizzontale fino a `(1.40,1.35)`;
- il ramo verticale `97->98` non è scartato: produce terminali con activeLength `29,25 m`, goodness `1,097`, length totale `29,40 m`, uguali ai valori visualizzati del ramo vincente via `97->99`;
- il terminale selezionato `1098` discende da `97->99`; i log arrotondano a tre decimali e l'ordinamento corrente non contiene alcuna preferenza normotica, quindi un eventuale micro-delta floating-point può rompere il pareggio;
- diagnosi strutturale: cambio guida prematuro su un segmento appartenente alla stessa evoluzione rettilinea di arrivo; ipotesi successiva da discutere è escludere la catena collineare/contigua del segmento di arrivo dagli `at-node` usati come nuovo fronte, non tutti gli `at-node` in generale;
- registro sviluppo R15: commit `a709454d2f5f9e97600c8dc4cb10377a28234867`.


### INCARICO 2026-09-26 — Correzione eco 1→3: escludere il segmento di arrivo dalla continuazione
Stato: ESEGUITO — SIMULAZIONE POSITIVA / NON INTEGRATA

Diagnosi consolidata dal log reale:
- al nodo 32 il riferimento guida orizzontale `1→3` è già correttamente conservato in `node.Front`;
- `PARALLELA_A/B` vengono quindi generate con direzione corretta parallela a `1→3`;
- `FindSequenceContinuation()` sceglie però come `requiredFront` il segmento appena percorso `30→32`, che passa per il nodo corrente (`rayTravel=0`);
- `TryExtend()` esclude correttamente il `previousSegment`, perciò entrambe le parallele vengono rifiutate prima della funzione di merito;
- il difetto non è perdita del riferimento guida ma mancata esclusione del segmento di arrivo nella ricerca del fronte successivo.

Commissionato:
- sul prototipo PR #8, modificare `FindSequenceContinuation()` affinché escluda sempre il segmento corrente/di arrivo dalla ricerca della continuazione;
- non introdurre un nuovo stato `GuideReference` se `node.Front` già conserva il riferimento corretto;
- mantenere LG-041, LG-042 supply-first e LG-043 Return sequence 0;
- simulare con Radiant Harness sul quadrato e verificare esplicitamente il nodo corrispondente a 32: almeno una parallela a `1→3` deve diventare candidata reale e non essere respinta per `requiredFront=previousSegment`;
- verificare se il ramo viene poi scelto o scartato dalla normale funzione di merito;
- recuperare SVG/log/metriche reali e confrontare con la simulazione precedente;
- eseguire appartamento preconfezionato e osservare le regression senza alzare limiti;
- nessun merge in `main` senza ulteriore approvazione visuale;
- Issue #1 aperta durante il lavoro e chiusa `Completed` al termine della simulazione.

Risultato:
- modifica sperimentale commit `8664e780dc810d6d9ff34cbaa7c9b82e671a2fcf` sul branch `experiment/lg041-supply-first-return-after`, PR #8; nessun merge in `main`;
- `FindSequenceContinuation()` esclude ora il segmento corrente/di arrivo dalla ricerca del fronte successivo; `node.Front` continua a fungere da riferimento guida senza introdurre nuovo stato;
- Radiant Harness run `36225982580`: **SUCCESS** su quadrato e appartamento;
- quadrato: 8.940 nodi Supply, 3.642 terminali Supply, 6.317 Return, 15.257 nodi totali, 12 terminali accettati, maxDepth 30;
- benchmark quadrato 20/20 deterministico: P95 1.055 ms, memoria delta max ~17,77 MB, SVG SHA-256 `52ca8f50765ea10beda90dc24c320f90134f910173739f39633f7c1ff37827d5`;
- il percorso mandata selezionato contiene finalmente l'eco a `2p`: `(1.40,0.75)->(2.60,0.75)` parallelo al tratto iniziale `1->3`; quindi l'opzione non è soltanto generata ma entra nel percorso vincente;
- sequenza locale selezionata: `(0.15,0.15)->(0.75,0.15)->(1.40,0.15)->(1.40,0.75)->(2.60,0.75)->(3.25,0.75)`;
- mandata vincente: activeLength `29,25 m`, goodness `1,097`;
- appartamento preconfezionato: SUCCESS, 61 Supply + 5 Return = 66 nodi totali, 2 terminali accettati, 81 ms diagnostici;
- build completa PR compila ma benchmark `ConcaveL` supera nuovamente il limite tecnico di 250.000 nodi; la correzione geometrica riapre molte alternative e aumenta la combinatoria;
- nessun limite alzato e nessuna potatura euristica introdotta;
- LG-044 registrata nelle linee guida nel commit `db2a3f86fe4b350cf3d17309fdaeb3b3e38672f7`; registro R14 nel commit `7b2886dd1405a9eb53f3ba669151282951e5fff4`;
- conclusione: difetto geometrico dello scavalcamento individuato e corretto nel prototipo; integrazione rinviata finché non viene affrontata la deduplicazione esatta degli stati equivalenti.


### INCARICO 2026-09-26 — Raccordo entrante ritorno come segmento Return normale
Stato: ESEGUITO — SIMULAZIONE POSITIVA / NON INTEGRATA

Commissionato:
- proseguire la simulazione sul prototipo `experiment/lg041-supply-first-return-after` senza integrare in `main`;
- eliminare la persistenza strategica della famiglia speciale `ReturnConnection` dopo la costruzione del raccordo entrante;
- il raccordo prodotto da `TryBuildEntryConnector` deve restare un normale segmento `Return` con `SequenceIndex=0`, quindi entrare nella sequenza strategica del ritorno;
- dalla prima evoluzione successiva il raccordo deve poter essere usato come riferimento/prolungamento LG-041 come gli altri segmenti Return;
- le distanze rispetto alle mandate devono restare quelle normali Supply/Return = `p`; le distanze fra tratti Return restano `2p`;
- verificare esplicitamente se il blu può occupare il corridoio centrale fra due mandate distanti `2p`, cioè `p` da entrambe;
- mantenere supply-first LG-042: durante la costruzione della mandata il ritorno continua a non esistere;
- eseguire Radiant Harness su quadrato e appartamento preconfezionato, recuperare SVG/log/metriche reali e confrontare con la simulazione supply-first precedente;
- osservare anche crescita combinatoria e regressioni; non aumentare limiti e non introdurre potature euristiche;
- nessun merge in `main` senza ulteriore approvazione visuale;
- Issue #1 aperta durante il lavoro e chiusa `Completed` al termine della simulazione.

Criteri di completamento:
- raccordo entrante visibile nel log come `Return` normale e non `ReturnConnection`;
- almeno un riferimento LG-041 al raccordo/segmento Return verificabile quando geometricamente pertinente;
- Harness quadrato e appartamento eseguiti;
- SVG/log/metriche confrontabili;
- esito e limiti registrati in Summary/registro/linee guida.
Risultato:
- modifica sperimentale sul branch `experiment/lg041-supply-first-return-after`, commit `7946cc0096cec52db7611a42f21402185ae72414`, PR #8; nessun merge in `main`;
- il raccordo entrante blu resta `GeoFamily.Return`, `SequenceIndex=0`, con log `promotedTo=Return sequence=0 strategic=true`; non viene più mantenuto come `ReturnConnection` speciale;
- Radiant Harness run `36225285732`, job `108358001545`: **SUCCESS** su quadrato e appartamento;
- quadrato: 290 nodi Supply, 1.046 Return, 1.336 totali, 400 terminali combinati, 16 accettati, 375 ms nel run diagnostico;
- benchmark quadrato senza diagnostica estesa: 20/20 deterministico, 1.336 nodi, P95 250 ms, memoria delta max 3.556.896 byte, SVG SHA-256 `19b46b7906ef6bd830f7bab10fd8af4aee42e6d3478b5760b78624c3c75ff403`;
- 42 candidati LG-041 hanno usato `D-RETURN-0` come riferimento: 32 ACCEPT, 8 REJECT, 2 DUPLICATE; quindi il raccordo è effettivamente estensibile/strategico come gli altri Return;
- esempio reale: nodo Return 300, riferimento `D-RETURN-0`, candidato laterale `(2.95,3.55)->(1.10,3.55)`, distanza `2p=0,60 m`;
- la soluzione blu vincente percorre `x=1,05` fra due mandate verticali `x=0,75` e `x=1,35`, cioè esattamente a `p=0,30 m` da entrambe;
- geometria finale selezionata del quadrato invariata rispetto alla simulazione supply-first precedente, sia rossa sia blu; la modifica aumenta soltanto le alternative Return (1.016 -> 1.336 nodi totali);
- appartamento preconfezionato: SUCCESS, 80 nodi totali, 3 terminali accettati, 33 ms diagnostici;
- regression completa PR: build SUCCESS; `ConcaveL` sostenibile 4.455 nodi / 72 accettati / P95 362 ms; `ObliqueTrapezoid` sostenibile 1.931 nodi / 36 accettati / P95 224 ms; `ConnectionTerminal` resta oltre 250.000 nodi e mantiene la build completa in failure;
- conclusione: il trattamento `ReturnConnection` speciale era una limitazione strategica reale, ma **non era la causa del mancato eco rosso dopo 29->30**; in supply-first il ritorno nasce dopo la mandata e l'SVG rosso resta identico;
- LG-043 registrata nelle linee guida nel commit `398c2fa01ab18a1d174a9b2607f1d0b9d37d2453`; contesto test aggiornato nel commit `c40d05fda53fa28c05fca91768d8d17873bd79ff`; registro R13 nel commit `3754dfd5dda2254cb935173b2870ac8e4d70bc53`.


### INCARICO 2026-09-26 — Simulazione mandata completa prima del ritorno
Stato: ESEGUITO — SIMULAZIONE POSITIVA / NON INTEGRATA

Commissionato:
- simulare una variante strutturale di StrategiaDiego in cui la mandata viene costruita completamente prima che esista qualsiasi geometria di ritorno;
- durante l'albero della mandata usare soltanto architettura, collegamenti esterni e mandata già costruita; nessun `ReturnConnection`, nessuna radice di ritorno e nessun tratto Return devono entrare nei vincoli o nel merito della mandata;
- ordinare i terminali di mandata con il criterio proprio della mandata (`TerminalGoodness`, poi lunghezza attiva) e provare il ritorno soltanto dopo il completamento della mandata;
- per ogni terminale di mandata, costruire successivamente le configurazioni di ingresso ritorno e relativo albero usando la mandata completa come geometria fissa;
- il ritorno può invalidare una mandata fisicamente incompatibile; in tal caso si prova il terminale di mandata successivo, ma il ritorno non deve modificare né favorire la costruzione della mandata;
- per una stessa mandata fattibile scegliere la migliore configurazione di ritorno con il merito corrente del ritorno/chiusura;
- usare il prototipo LG-041 multi-candidato come base della simulazione, senza merge in `main` prima della valutazione visuale;
- banco principale: `LG041-SQUARE4X4-T1-P030`; controllo visuale specifico del tratto mandata 28→29;
- eseguire anche il caso appartamento preconfezionato e osservare l'impatto sulla crescita combinatoria;
- produrre SVG/log/metriche tramite Radiant Harness;
- Issue #1 aperta durante il lavoro e chiusa `Completed` a fine simulazione.

Criteri di completamento:
- mandata dimostrabilmente indipendente dal ritorno nel prototipo;
- Harness quadrato eseguito con SVG reale;
- comportamento 28→29 confrontabile con il precedente;
- metriche nodi/tempo registrate;
- nessuna integrazione in main senza ulteriore approvazione visuale.
Risultato:
- prototipo branch `experiment/lg041-supply-first-return-after`, PR #8, commit `6b596ab872a7822c900dc9b281bc9a1480030447`; non integrato in `main`;
- durante la mandata non vengono più create radici/raccordi/segmenti del ritorno; l'albero rosso è costruito con architettura + collegamenti esterni + mandata corrente;
- i terminali mandata sono ordinati per `TerminalGoodness`, lunghezza attiva e lunghezza totale; il ritorno viene generato solo dopo il terminale in esame;
- Harness run `36224330125`: **SUCCESS** su quadrato e appartamento preconfezionato;
- quadrato: percorso rosso contiene `27 -> 28 -> 29 -> 30`; il tratto `28 -> 29` è verticale e non condizionato dal blu;
- quadrato: 290 nodi mandata, 64 terminali mandata, 726 nodi ritorno, 1.016 nodi totali, 16 terminali accettati, maxDepth 25;
- benchmark quadrato 20/20 deterministico: P95 313 ms, memoria delta max ~10,95 MB, SVG SHA-256 `d2af75acfb1b717c6d08ad82dfb0bfa89fc5dd6fd9b2ebfaa1d9db8e3b84bc7f`;
- rispetto al prototipo LG-041 precedente (17.616 nodi) il quadrato scende a 1.016 nodi (~94,2% in meno);
- appartamento preconfezionato: 80 nodi totali, 3 terminali accettati, ~65 ms nel run diagnostico;
- regression estesa: `ConcaveL` ora sostenibile con 4.455 nodi / 72 accettati / P95 382 ms; `ObliqueTrapezoid` sostenibile con 1.587 nodi / 24 accettati / P95 312 ms;
- `ConnectionTerminal` resta non sostenibile e supera il limite tecnico di 250.000 nodi; per questo la build completa PR non è SUCCESS e la modifica non viene integrata;
- LG-042 registrata nelle linee guida come approvata e simulata nel commit `72af8c357f6f7cb630312bd5a6d672095d7f7823`; registro R12 nel commit `64ec7b33ecbfc67433f127483d1e151f784c15a8`;
- `STRATEGIADIEGO_TEST_CONTEXT_CURRENT` aggiornato a `LG042-SUPPLY-FIRST-SQUARE4X4-T1-P030`;
- nessuna modifica a frontend, Library Desktop, Vittorio/GPT o `definizionedati.json`.


### INCARICO 2026-09-26 — Implementazione e test LG-041 con Radiant Harness
Stato: ESEGUITO — TEST COMPLETATO / PROTOTIPO NON INTEGRATO

Commissionato:
- implementare la specifica consolidata LG-041 nel vero `StrategiaDiegoEngine` usando il nuovo `Termodel.RadiantPanels.Harness` come ciclo rapido;
- `PROSEGUI_DRITTO` deve generare 0..N candidati validi, uno per ogni riferimento pertinente dello scenario corrente, invece di conservare soltanto il più corto;
- riferimenti strategici ammessi: architettura e tubi Supply/Return fisicamente già costruiti; `Connection` e `ReturnConnection` restano vincoli fisici ma non generatori strategici;
- conservare nel nodo figlio il riferimento che ha generato il candidato, così le successive `PARALLELA_A/B` possono derivare da tale fronte senza euristiche;
- distinguere in diagnostica candidato `physical` e `lateral`, con riferimento, I, T, d e lunghezza;
- i candidati laterali validi devono essere visitati in ordine di lunghezza decrescente senza potatura; nessun verso speciale di scavalcamento;
- riusare le verifiche fisiche esistenti (`IsSegmentValid`) e le distanze LG-006/LG-037;
- eseguire prima il case rapido `LG041-SQUARE4X4-T1-P030`, poi almeno appartamento preconfezionato; misurare nodi, tempo e memoria rispetto alla baseline corrente;
- se il comportamento è sostenibile, aggiornare linee guida/registro a IMPLEMENTATA e lanciare la build completa Service;
- non modificare frontend, Library Desktop, Vittorio/GPT o `definizionedati.json`;
- Issue #1 resta aperta durante il lavoro e viene chiusa `Completed` solo a verifica completa; `Not planned` se il job fallisce definitivamente.

Baseline disponibile dal Harness precedente:
- quadrato: 1328 nodi, 46 terminali accettati, 290 ms runtime interno;
- appartamento preconfezionato: 151 nodi, 15 terminali accettati, 44 ms runtime interno.

Criteri di completamento:
- LG-041 implementata nel Core senza procedura speciale di scavalcamento;
- Harness quadrato SUCCESS con diagnostica multi-candidato verificabile;
- Harness appartamento SUCCESS;
- crescita computazionale misurata e registrata;
- build completa main SUCCESS;
- Summary/registro/linee guida aggiornati;
- Issue #1 chiusa con esito coerente.
Esito del collaudo:
- prototipo implementato esclusivamente sul branch `feature/lg041-multi-straight-candidates`, PR #7; nessuna modifica algoritmica LG-041 è stata integrata in `main`;
- Harness PR run `36223457471`, job `108352924546`: **SUCCESS**; build Core+Harness, quadrato e appartamento preconfezionato tutti eseguiti;
- quadrato LG-041: 17.616 nodi totali (312 mandata + 17.304 ritorno), 66 terminali mandata, 5.808 combinazioni, 412 terminali accettati, maxDepth 25;
- benchmark quadrato senza diagnostica estesa: 20/20 iterazioni deterministiche, P95 1.039 ms, memoria delta max ~4,56 MB, entro i budget correnti; SVG SHA-256 `37ba2ccaf728f3ee20b2a1e8220d552df912dd72913422c4c8b2be58dbd3e644`;
- rispetto alla baseline Harness precedente del quadrato (1.328 nodi), l'albero cresce di circa 13,3x; la crescita è concentrata soprattutto nel ritorno (17.304 nodi contro 1.164 baseline);
- diagnostica LG-041 verificata: 3.606 nodi con almeno 2 candidati accettati, 3.724 nodi con almeno un candidato laterale; massimo 4 candidati accettati sullo stesso nodo; nessuna violazione dell'ordine decrescente dei candidati laterali rilevata;
- esempio reale sul percorso mandata: al nodo 66 risultano contemporaneamente un candidato laterale da `D-INITIAL-Supply` lungo 1,25 m e un candidato fisico lungo 1,90 m; entrambi restano nell'albero;
- appartamento preconfezionato: **SUCCESS**, 160 nodi, 16 terminali accettati, ~40 ms nel run Harness;
- la diagnostica dettagliata del quadrato ha prodotto ~465.000 messaggi / ~76 MB di log; il valore memoria del run diagnostico (~174 MB) non è rappresentativo del motore puro, come confermato dal benchmark senza log (~4,56 MB max delta);
- build completa PR run `36223457467`: compilazione **SUCCESS**, ma benchmark regression **FAILED** sulla fixture `StrategiaDiegoConcaveL.locale.xml` perché la ricerca supera il limite tecnico di 250.000 nodi già durante il warm-up;
- per questo motivo LG-041 non viene dichiarata implementata e il PR #7 viene chiuso senza merge; la specifica resta valida come obiettivo geometrico, ma richiede una strategia di contenimento/deduplicazione esatta prima dell'integrazione;
- nessun limite è stato alzato e nessuna potatura euristica è stata introdotta per mascherare l'esplosione combinatoria.


### INCARICO 2026-09-26 — Harness pannelli minimale e base dati test preconfezionata
Stato: ESEGUITO

Commissionato:
- registrare nelle linee guida il nuovo setup preferenziale per i test rapidi StrategiaDiego;
- creare un eseguibile Console .NET minimale dedicato ai pannelli, separato da ASP.NET, che referenzi direttamente `Termodel.Core`;
- il Harness deve usare il vero codice del Core/StrategiaDiego, non duplicare il motore;
- predisporre una base dati di test pannelli preconfezionata a partire dalla fixture/progetto esempio corrente, evitando ogni modifica a `definizionedati.json`;
- il primo dataset deve rappresentare il banco quadrato 4x4 / ingresso T1 / `p=0,30 m` e poter essere lanciato senza parsing del progetto Web completo;
- output minimo: SVG diagnostico, log e metriche essenziali del percorso;
- il Harness deve poter accettare una fixture/input esplicita e una directory di output, così da riusare lo stesso eseguibile per futuri casi;
- preferire build limitata a `Termodel.Core` + Harness per accorciare il ciclo di prova;
- aggiornare `STRATEGIADIEGO_TEST_CONTEXT_CURRENT` affinché indichi il Harness come setup preferito quando disponibile;
- aggiornare registro StrategiaDiego e documentazione del dataset;
- eseguire build reale del progetto Harness; se possibile aggiungere un smoke rapido separato dal Service completo;
- non modificare frontend, Library Desktop o `definizionedati.json`;
- chiudere Issue #1 `Completed` solo dopo build/test riusciti; `Not planned` se l'incarico fallisce definitivamente.

Criteri di completamento:
- progetto Console Harness presente e referenziato a `Termodel.Core`;
- base dati test presente e documentata;
- esecuzione Harness produce SVG/log/metriche sul quadrato;
- build reale verificata;
- linee guida e registro aggiornati;
- Issue #1 chiusa con esito coerente.
Risultato reale:
- creato `tools/Termodel.RadiantPanels.Harness`, Console .NET 8 che referenzia direttamente `Termodel.Core` e usa `StrategiaDiegoBenchmark.Run()`, quindi esegue il vero `StrategiaDiegoEngine` senza duplicazioni;
- comando `run` produce SVG, log diagnostico e metriche JSON da fixture/case o input pannelli esplicito;
- comando `prepare` usa il vero `GeneraModello` per estrarre `RadiantPanelInputXml` da un progetto completo; aggiunta canonicalizzazione in-memory dello SVG legacy solo per rendere la snapshot progetto consumabile dal Core corrente;
- base dati creata in `tests/radiant-harness/`; case sintetico `LG041-SQUARE4X4-T1-P030.json` e case reale `CURRENT-APARTMENT-P030.json`;
- input reale preconfezionato versionato in `tests/radiant-harness/prepared/StrategiaDiegoCurrentApartment.pannelli.xml`, derivato da `StrategiaDiegoCurrentApartment.project.tmdl`, SHA-256 `b31b5c2bac4dbd8a13507daef4022c5ad2301fb6503ff6d666e427a2eb5d4a80`;
- workflow focalizzata `.github/workflows/termodel-radiant-harness.yml`: restore/build soltanto Core + Harness e lancio diretto dei due case preconfezionati;
- run di preparazione `36222504481`: **SUCCESS** completo; Core+Harness compilati, quadrato eseguito, progetto appartamento preparato, input pannelli rieseguito;
- nella stessa run: quadrato 1328 nodi / 46 terminali accettati / 290 ms runtime interno / SVG SHA `46d2ec137be52ef350a62a6497bd6bb4f3cb58603339874cc03657163c62f8f2`; appartamento preconfezionato 151 nodi / 15 terminali accettati / 44 ms runtime interno / SVG SHA `5678620a7a895d56886c2108ae9f3f8eab50e2aaaeff9deb1f3f1dea03e2ec96`;
- artifact della preparazione: `radiant-harness-fast`, id `10899108905`;
- dopo il versionamento dell'input preconfezionato la workflow è stata alleggerita: non rigenera più il progetto completo ad ogni iterazione;
- run finale PR `36222745007` / Harness #16: **SUCCESS**; build Core+Harness, quadrato e appartamento preconfezionato tutti SUCCESS;
- PR #6 integrato su `main` nel merge `9764218dfaceceb2ebbf73602ce28e1adf1b97c7`;
- main Action `36222822652`, job `108351158157`: **SUCCESS** completo; build Release, benchmark StrategiaDiego e tutti gli smoke di integrazione completati con successo;
- linee guida aggiornate nel commit `6a2fea0115401657ca6efe09f84b440dd1c3b68c`; registro R10 finalizzato nel commit `91f28438709409047c14e78dfeef62d03b93a0ce`;
- nessuna modifica a `StrategiaDiegoEngine`, frontend, Library Desktop o `definizionedati.json`;
- stato LG-041 invariato: consolidata ma non ancora implementata; il nuovo Harness è il setup preferenziale per il prossimo collaudo rapido.



### INCARICO 2026-09-26 — Collaudo preliminare in chat e contesto di test corrente
Stato: ESEGUITO

Commissionato:
- registrare nelle linee guida un protocollo permanente di collaudo preliminare delle nuove strategie geometriche prima dell'implementazione GitHub/Core;
- il collaudo preliminare deve poter essere eseguito in chat con un simulatore temporaneo indipendente, preferibilmente C#/.NET quando serve massima fedelta al motore finale;
- il simulatore deve usare gli stessi dati di input del caso di test quando disponibili, le stesse distanze, tolleranze, primitive geometriche e criterio di merito definiti dalle LG;
- produrre per ogni iterazione almeno log dei candidati/nodi e SVG diagnostico numerato quando la modifica influisce sul disegno;
- distinguere sempre simulazione preliminare da verifica definitiva: la simulazione valida la strategia, mentre build/esecuzione del `StrategiaDiegoEngine` reale resta necessaria prima di dichiarare implementazione verificata;
- usare il collaudo in chat per iterazioni rapide e GitHub Actions solo dopo consolidamento della strategia o quando serve confronto col motore reale;
- introdurre nelle linee guida una variabile documentale canonica `STRATEGIADIEGO_TEST_CONTEXT_CURRENT`, da mantenere aggiornata ad ogni cambio del progetto/caso/condizione di test corrente;
- la variabile deve identificare almeno: fixture/input, geometria sintetica o progetto reale, valore `p`, regola/LG sotto test, condizioni specifiche e output diagnostico atteso;
- inizializzare il contesto corrente sul quadrato 4x4 / ingresso T1 / `p=0,30 m` per il collaudo LG-041;
- aggiornare il registro StrategiaDiego;
- nessuna modifica al motore, frontend, Library Desktop o `definizionedati.json`;
- chiudere Issue #1 `Completed` al termine del lavoro documentale.

Criteri di completamento:
- protocollo preliminare registrato come direttiva permanente;
- `STRATEGIADIEGO_TEST_CONTEXT_CURRENT` presente e valorizzata;
- responsabilita di aggiornamento della variabile esplicitata;
- registro sviluppo aggiornato;
- nessuna build richiesta per il solo intervento documentale.
Risultato:
- linee guida aggiornate nel commit `bcd0b0d2d211ba8f822712e61524de3e90bab329` con il protocollo permanente di collaudo preliminare;
- definita la sequenza `simulazione rapida -> consolidamento -> implementazione Core -> verifica GitHub -> confronto finale`;
- preferenza C#/.NET per simulazioni a massima fedelta, con Python ammesso per esplorazioni geometriche semplici;
- fissati input, primitive, tolleranze, distanze, log minimo e SVG diagnostico richiesti;
- introdotta la variabile documentale canonica `STRATEGIADIEGO_TEST_CONTEXT_CURRENT`; non è una variabile runtime e non modifica il Service;
- valore iniziale: `LG041-SQUARE4X4-T1-P030`, fixture quadrato 4x4, ingresso T1, `p=0,30 m`, LG-041, output log candidati/nodi + SVG numerato;
- obbligo di aggiornare il contesto prima di ogni cambio di fixture, locale, geometria, `p`, regola o condizione di test;
- registro StrategiaDiego aggiornato con R9 nel commit `bf51d5fe8792438eb98176eb6aa10dc2d57d566e`;
- nessuna modifica al motore, frontend, Library Desktop o `definizionedati.json`; nessuna build dichiarata.



### INCARICO 2026-09-26 — Consolidamento LG-041 come regola universale
Stato: ESEGUITO

Commissionato:
- consolidare la discussione successiva alla proposta LG-041 senza modificare ancora il motore;
- `PROSEGUI_DRITTO` diventa generatore di candidati associati alle linee pertinenti dello scenario corrente;
- sono pertinenti: contenimento architettonico, mandata fisicamente gia costruita e ritorno fisicamente gia costruito nello scenario del ramo;
- escludere soltanto il segmento da cui si proviene, intersezioni dietro al nodo, casi paralleli senza intersezione e duplicati geometrici entro tolleranza;
- ogni candidato conserva l'identita della linea che lo ha generato, affinche il riferimento resti disponibile al nodo successivo;
- per fronti fisici il terminale rispetta la distanza prima del vincolo; per prolungamenti laterali il candidato prosegue oltre il riferimento alla distanza `d` corrente;
- per geometrie oblique usare la costruzione offset coerente con LG-034/LG-035;
- nessun verso di scavalcamento viene imposto: le alternative geometricamente valide restano nell'albero;
- nessuna procedura speciale dedicata al tubo entrante: il caso deve emergere dalla stessa regola universale;
- ordinare i candidati laterali per lunghezza decrescente solo come priorita di esplorazione, senza potatura; il merito finale resta autorevole;
- regola identica per mandata e ritorno;
- aggiornare anche il registro di sviluppo StrategiaDiego;
- non modificare codice, frontend, Library Desktop o `definizionedati.json`;
- a conclusione chiudere Issue #1 `Completed`.

Criteri di completamento:
- LG-041 marcata CONSOLIDATA nel principio e nei dettagli sopra;
- precedente procedura specifica di scavalcamento dichiarata superata sul piano strategico, non implementata;
- registro sviluppo aggiornato;
- nessuna build necessaria per il solo consolidamento documentale.

Risultato:
- LG-041 consolidata nel commit `bd661bd284b87308a2b6c969b24536a5de5c6bde`;
- registro StrategiaDiego aggiornato con R8 nel commit `b72ee29f3561ac25c19d84cb7968aef99c7b3b83`;
- confermati candidati `0..N`, riferimenti architettura/mandata/ritorno, esclusioni minime, memoria del riferimento generatore e validazione fisica tramite `TrattoPossibile`;
- confermata priorità di esplorazione per lunghezza decrescente senza potatura;
- eliminata dalla specifica la necessità di imporre un verso speciale di scavalcamento;
- la procedura specifica del tubo entrante è superata come strategia separata; LG-039 resta valida come vincolo fisico;
- nessuna modifica al codice, frontend, Library Desktop o `definizionedati.json`;
- nessuna compilazione/esecuzione dichiarata per questo incarico esclusivamente documentale.


### INCARICO 2026-09-26 — Registrazione proposta universale PROSEGUI_DRITTO multi-candidato
Stato: ESEGUITO

Commissionato:
- registrare nelle linee guida, senza modificare il motore, la nuova proposta utente di generalizzazione universale di `PROSEGUI_DRITTO`;
- il ramo diritto deve poter generare candidati non soltanto verso un contenimento frontale fisicamente intersecato, ma anche verso le intersezioni teoriche con i prolungamenti laterali destro e sinistro delle linee pertinenti di architettura, mandata e ritorno;
- per un'intersezione laterale teorica il punto terminale candidato è posto oltre l'intersezione, lungo la direzione corrente, applicando la distanza di rispetto `d` determinata dalla matrice corrente delle famiglie geometriche;
- il numero dei rami non è fissato a tre: è determinato dal numero dei candidati geometrici validi presenti nello scenario corrente;
- l'ordine di esplorazione privilegia i candidati laterali che producono il tratto diritto valido più lungo, senza potare gli altri; la funzione di valutazione finale resta responsabile della scelta del percorso migliore;
- la stessa regola deve essere simmetrica per mandata e ritorno;
- discutere e consolidare i dettagli prima di qualsiasi implementazione;
- sospendere l'implementazione specifica della precedente procedura di scavalcamento del tubo entrante finché questa regola universale non è consolidata.

Criteri di completamento:
- nuova LG registrata come proposta da consolidare, non implementata;
- nessuna modifica a codice, frontend, Library Desktop o `definizionedati.json`;
- precedente incarico di scavalcamento esplicitamente sospeso in attesa della discussione;
- Issue #1 chiusa Completed al termine del solo lavoro documentale.

Risultato documentale:
- LG-041 aggiunta a `docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md` come proposta universale, non implementata;
- `PROSEGUI_DRITTO` formalizzato come generatore di `0..N` candidati, includendo fronti fisici e prolungamenti laterali delle linee pertinenti;
- priorità di esplorazione dei candidati laterali per lunghezza decrescente, senza potatura e senza alterare la funzione di merito finale;
- regola dichiarata simmetrica per mandata e ritorno;
- incarico specifico precedente sullo scavalcamento del tubo entrante sospeso in attesa della discussione LG-041;
- nessuna modifica al motore, frontend, Library Desktop o `definizionedati.json`;
- commit linee guida: `ec60a4cf9e66db5d978dec62fdf26bef2c3b3dac`.


### INCARICO 2026-09-26 — Procedura di scavalcamento tubo entrante: limite fisico, corsia 2p e verso opposto
Stato: SUPERATO — non implementare come procedura separata; sostituito da LG-041

Commissionato:
- consolidare la correzione validata nella simulazione sul quadrato pannelli senza snaturare l'albero StrategiaDiego;
- introdurre la fase denominata **Procedura di scavalcamento del tubo entrante e successivi**;
- il raccordo entrante del ritorno resta non-strategico, ma deve poter agire come fronte fisico di troncamento: mandata-ritorno = `p`;
- quando il raccordo di ritorno tronca un tratto, non deve essere prevaricato da una costruzione virtuale `I+2p` più corta sul prolungamento di una mandata;
- dopo il troncamento, il normale albero deve poter agganciare la corsia parallela alla precedente mandata alla distanza stessa-famiglia `2p`;
- il primo tratto percorso sulla corsia dopo l'aggancio deve avere verso opposto al segmento di mandata usato come riferimento orientato;
- mantenere collisioni e distanze sulla geometria fisica reale; il raccordo del ritorno non entra nella normale sequenza strategica LG-033;
- aggiungere marker diagnostici e regression sul quadrato per verificare troncamento a `p`, aggancio corsia e verso opposto;
- aggiornare linee guida e registro StrategiaDiego;
- eseguire build/smoke GitHub Actions, recuperare SVG/log reale, integrare su `main` e attivare il normale auto-deploy Render;
- non modificare GPT/Vittorio, frontend, Library Desktop o `definizionedati.json`;
- a conclusione aggiornare questo Summary e chiudere Issue #1 `Completed` se riuscito, `Not planned` se fallito.

Criteri di completamento:
- sorgente compilabile e regression GitHub Actions SUCCESS;
- log reale con marker della procedura di scavalcamento;
- SVG reale del quadrato disponibile per verifica visuale;
- revisione integrata su `main`;
- Issue #1 chiusa con esito coerente e notifica finale `urgent`.


### INCARICO 2026-09-26 — LG-034/LG-035: oltre linea estesa a 2p e verifica nuova copertura
Stato: ESEGUITO

Commissionato:
- consolidare e pubblicare la correzione discussa sul quadrato pannelli al nodo 8;
- rendere realmente disponibile il caso già previsto da LG-034/LG-035 in cui la retta/prolungamento del riferimento interseca il nodo corrente e il nuovo tratto deve potersi collocare oltre tale linea alla distanza di rispetto `d`;
- nel caso stessa famiglia mandata/mandata usare `d=2p`; con `p=0,30 m` il passaggio atteso è quindi `+0,60 m`;
- non scartare automaticamente un riferimento strategico solo perché l'intersezione teorica con la semiretta corrente è a distanza zero entro tolleranza, quando l'intersezione è sul prolungamento e la costruzione `I+d` produce un tratto possibile;
- conservare la distinzione LG-035 fra geometria teorica (rette/prolungamenti per il punto strategico) e geometria fisica (collisioni/distanze sui segmenti reali);
- preservare l'albero delle alternative: la nuova possibilità deve essere sottoposta alle normali validazioni, non forzata come scelta unica;
- aggiornare linee guida e registro StrategiaDiego precisando lo stato implementativo reale;
- aggiornare lo smoke quadrato per verificare il marker del passaggio oltre linea estesa e registrare numero tratti, lunghezza attiva, superficie empirica e Fattore di Bontà del miglior terminale mandata;
- eseguire build/smoke GitHub Actions, produrre nuovo SVG/log reale con numerazione nodi, integrare su `main` e attivare il normale auto-deploy Render;
- non modificare GPT/Vittorio, frontend, Library Desktop o `definizionedati.json`;
- a conclusione aggiornare questo Summary e chiudere Issue #1 `Completed` se riuscito, `Not planned` se fallito.

Risultato reale:
- autorizzazione registrata nel commit `668b56a83a101366a9e77c499cb3ed613b7db3c1`;
- sorgente: `FindSequenceContinuation()` conserva ora anche le intersezioni teoriche a distanza circa zero; `TryExtend()` consente il caso su prolungamento e genera il punto oltre-linea alla distanza di rispetto;
- marker diagnostico aggiunto: `EXTEND beyond-extended-front`;
- LG-034/LG-035 aggiornate dichiarando implementato questo caso ortogonale specifico, senza dichiarare completa la futura geometria offset/miter per angoli arbitrari;
- prima PR Action `36210011831` (#571): build e benchmark SUCCESS; smoke esecutivo fallito unicamente perché la simulazione prevedeva `B>=1,00`, mentre il runtime ha misurato `B=0,882`;
- la simulazione in memoria da circa `1,105` non è stata quindi confermata nella lunghezza; il dato runtime ha prevalso come da regola di verifica reale;
- regression definitiva: presenza del marker oltre-linea, almeno 15 tratti attivi e Fattore di Bontà almeno `0,88`;
- PR #4 head finale `c79f2aa73cce7fd5c8986b24d46846dd21d531d3`;
- PR Action `36210173917` (#575): **SUCCESS** completo;
- merge funzionale su `main`: `b02c692b160bac34961ac1af775a81a20f02cfea`;
- main Action `36210449283`, job `108315651971`: **SUCCESS** completo;
- Commit Status finale del merge: `Termodel/job=SUCCESS`; la notifica build usa priorità ntfy `low`;
- artifact main quadrato `strategia-diego-square-executive`, id `10896115041`;
- miglior terminale mandata reale, per entrambi i lati ritorno: **15 tratti attivi**, lunghezza attiva `20,56 m`, superficie empirica `12,336 m²`, superficie effettiva locale `13,988 m²`, Fattore di Bontà **0,882 = 88,2%**;
- soluzione complessiva selezionata dal criterio di merito corrente: mandata attiva `17,72 m`, bontà `0,760`; ritorno attivo `11,88 m`, bontà `0,510`; merito complessivo `32,758 m`;
- SVG SHA-256 `875042179e3d2df58e38f2e9c5867e67b2caa5aff3bb8879e34bb3d107f63d0a`;
- DXF SHA-256 `18444400dc3ba48b7730b90d094934ce101b28d8972f2ea537fbb2b1ce974f82`;
- SVG diagnostico con 22 node-id; log e SVG reali disponibili per verifica visuale LG-036;
- smoke progetto radiante reale, banco appartamento corrente e snapshot GitHub: **SUCCESS**;
- nessuna modifica a GPT/Vittorio, frontend, Library Desktop o `definizionedati.json`;
- il merge/push su `main` ha attivato il normale auto-deploy Render;
- registro R7 finalizzato nel commit `92bbf649b8a2e843af3ac0fc275f1d47ed13756d`;
- a fine incarico Issue #1 viene chiusa `Completed`, generando la notifica ntfy `urgent`.

### INCARICO 2026-09-26 — Correzione nodo 8: inseguimento geometrico mandata e nuova release
Stato: ESEGUITO

Commissionato:
- consolidare la correzione discussa in simulazione sul quadrato pannelli dopo il nodo 8;
- quando la mandata riaggancia una propria evoluzione precedente, non scegliere il riferimento successivo con il solo `SequenceIndex+1`: cercare invece la prima linea pertinente incontrata DAVANTI nella direzione corrente, usando la geometria teorica delle rette come già previsto per l'inseguimento;
- preservare collisioni e distanze sulla geometria fisica reale e la distanza stessa-famiglia `2p`;
- applicare la stessa regola di inseguimento della propria famiglia anche al ritorno, in coerenza con LG-027, senza modificare GPT/Vittorio;
- aggiornare le linee guida chiarendo il significato operativo di “successivo riferimento” in LG-033/LG-035;
- aggiungere regression sul quadrato che impedisca il ritorno al terminale prematuro del nodo 8 e misuri numero tratti/fattore di bontà della mandata;
- eseguire build e smoke GitHub Actions, produrre nuovo SVG/log reale con numerazione nodi, pubblicare su `main` per il normale auto-deploy Render;
- non modificare frontend, Library Desktop o `definizionedati.json`;
- a conclusione aggiornare questo Summary e chiudere Issue #1 `Completed` se riuscito, `Not planned` se fallito.

Criteri di completamento:
- sorgente e direttive coerenti con la correzione;
- sul quadrato reale la mandata supera il precedente arresto del nodo 8;
- regression registra almeno numero tratti attivi e Fattore di Bontà del miglior terminale mandata;
- build/smoke GitHub Actions SUCCESS;
- artifact SVG/log reale disponibile per verifica visuale;
- revisione integrata su `main` e notifica finale tramite Issue #1.

Risultato reale:
- commit autorizzazione `1a130e13fdf15de25c3de19d51908b62ba6e56f0`;
- sorgente corretto in `StrategiaDiegoEngine.FindSequenceContinuation()`: per l'inseguimento della propria famiglia il successore è la prima retta pertinente davanti, non il semplice `SequenceIndex+1`;
- LG-033/LG-035 aggiornate e fase R6 registrata;
- regression quadrato aggiunta a `smoke-radiant-executive.ps1`: richiede marker `SEQUENCE own-family geometric-continuation`, almeno 10 tratti attivi e Fattore di Bontà >= 0,80;
- PR #3 head `820a390cee4184d888af6d7149a2b567f932e5eb`;
- PR Action `36207700577` (#562), job `108307606275`: **SUCCESS**;
- merge funzionale su `main`: `599a980aca95af14d982e25911a1507aece0c21c`;
- main Action `36207858838`, job `108308085490`: **SUCCESS**; build Release, benchmark, smoke esecutivo, progetto radiante reale, banco appartamento e snapshot tutti SUCCESS;
- Commit Status `Termodel/job=SUCCESS`; la notifica build usa la nuova priorità ntfy `low`;
- artifact main quadrato `strategia-diego-square-executive`, id `10894901931`;
- miglior terminale di mandata reale, per entrambi i lati ritorno: **10 tratti attivi**, lunghezza `19,96 m`, superficie empirica `11,976 m²`, superficie effettiva `13,988 m²`, Fattore di Bontà **0,856**;
- confermata quindi esattamente la simulazione in memoria: il vecchio arresto prematuro dopo 6 tratti / bontà 0,564 viene superato e il secondo giro viene esplorato;
- la soluzione complessiva attualmente selezionata dal criterio di merito LG-003 non coincide col terminale di sola mandata più buono: usa mandata attiva `17,72 m` con fattore `0,760`, ritorno attivo `11,88 m` con fattore `0,510`, merito complessivo `32,758 m`;
- SVG SHA-256 `5e5e04b7c1f88956bd9dbef14e1b8e8eb3981b9ee430551ac03458c63b0f50d4`; DXF SHA-256 `d70039f2504f18fe7148179b141adab22ca1f905cfa0d722ef0187ffd02ac1e1`; 19 node-id diagnostici nell'SVG;
- commit registro R6 finale `ea76e7b206a90327f7b75cd1cac1f8d830a77f65`;
- nessuna modifica a GPT/Vittorio, frontend, Library Desktop o `definizionedati.json`;
- il merge/push su `main` ha attivato il normale auto-deploy Render; la verifica HTTP indipendente del runtime viene riportata separatamente solo se disponibile;
- artifact SVG/log reale disponibile per controllo visivo dell'utente secondo LG-036;
- a fine incarico Issue #1 viene chiusa `Completed`, generando la sola notifica ntfy `urgent`.


### INCARICO 2026-09-26 — Differenziazione intensità notifiche ntfy
Stato: ESEGUITO

Commissionato:
- rendere tutte le notifiche operative/build a bassa intensità;
- mantenere alla massima intensità esclusivamente la notifica di chiusura della Issue #1, sia in caso di successo sia in caso di insuccesso;
- conservare messaggi/tag distinti fra successo e fallimento;
- non modificare logica applicativa, frontend, Library Desktop o `definizionedati.json`;
- aggiornare il protocollo canonico delle notifiche;
- chiudere Issue #1 `Completed` al termine se riuscito, `Not planned` se fallito.

Criterio operativo:
- GitHub Actions/build: priorità ntfy `low` indipendentemente dall'esito;
- chiusura Issue #1: priorità ntfy `urgent` sia `completed` sia `not_planned`.

Risultato:
- `.github/workflows/termodel-service-build.yml`: tutte le notifiche terminali build usano ora `Priority: low`, mantenendo tag diversi SUCCESS/FAILED;
- `.github/workflows/issue-work-notify.yml`: la chiusura della Issue #1 usa sempre `Priority: urgent`, sia per successo sia per insuccesso;
- protocollo canonico `.github/TERMODEL-ACTION-NOTIFICATIONS.md` aggiornato: il suono forte identifica esclusivamente la fine reale dell'incarico;
- commit build notification: `5e5df3194a350e910db590c54319e4c393bf55f3`;
- commit issue notification: `7198ba278aed4b2ba5c7f105c2f149ddac70f75e`;
- commit documentazione: `37864a81644a92b507f2cf3723e946fe6a5e9290`;
- nessuna modifica alla logica applicativa, frontend, Library Desktop o `definizionedati.json`;
- la chiusura della Issue #1 costituisce anche la prova operativa della notifica `urgent` di fine incarico.


### INCARICO 2026-09-26 — Consolidamento debug StrategiaDiego, build e pubblicazione
Stato: ESEGUITO

Commissionato:
- consolidare nel sorgente e nelle linee guida tutte le correzioni validate nella sessione di debug in memoria sul quadrato pannelli;
- rettificare LG-012: la distanza lungo la parete fra nodo di mandata e radice del ritorno è sempre `p`, eliminando la vecchia costante fissa `0,50 m`;
- generare preliminarmente il raccordo entrante del ritorno prima dell'albero di mandata e usarlo come geometria fisica limitante: distanza mandata-ritorno `p`; il raccordo di collegamento limita collisioni/distanze ma non diventa automaticamente una linea strategica di inseguimento;
- eliminare l'eccezione runtime che sopprime `PROSEGUI_DRITTO` nel primo nodo dopo il raccordo tecnico: raccordo tecnico ed evoluzione restano oggetti distinti e ogni nodo valuta le normali alternative geometriche;
- formalizzare il Fattore di Bontà del terminale come rapporto fra superficie empiricamente coperta e superficie effettiva del locale; per una sola mandata/ritorno: `Aeq = 2 * Lattiva * p`, escludendo collegamenti e raccordi tecnici dalla lunghezza attiva;
- aggiungere una modalità diagnostica Service `numerazioneSpirali=true|false`, default `true`, che nell'SVG mostra un numero per ogni nodo della soluzione Diego, con lo stesso identificativo presente nel log `SpiraliDiego`; la numerazione deve essere solo diagnostica e non modificare geometria/calcolo né il DXF;
- aggiornare regression/smoke pertinenti;
- eseguire build e test reali GitHub Actions, recuperare almeno SVG/log del quadrato e registrare l'esito reale;
- pubblicare la revisione riuscita tramite il normale auto-deploy Render collegato a `main`;
- non modificare motori GPT/Vittorio, frontend, Library Desktop o `definizionedati.json`;
- a conclusione aggiornare questo Summary e chiudere Issue #1 `Completed` se riuscito, `Not planned` se fallito.

Criteri di completamento:
- direttive e sorgente coerenti con le decisioni sopra;
- build Release GitHub Actions SUCCESS;
- smoke StrategiaDiego/quadrato SUCCESS con artifact diagnostico reale;
- SVG di verifica con numerazione nodi di default e log con ID corrispondenti;
- revisione finale su `main` pubblicata verso Render;
- stato finale documentato e Issue #1 chiusa con esito coerente.

Risultato reale:
- autorizzazione registrata nel commit `176749401c706bac5600d6461a00574e5e03222a`;
- sviluppo consolidato sul branch `ai/strategiadiego-consolidamento-20260926` e integrato tramite PR #2;
- PR head finale `e0118fc0e3cde43def856836669c89e95adf2a6d`;
- PR Action `TermodelService Build` run `36205218493` (#550): **SUCCESS**;
- merge su `main`: `a15d29e6407f41d3b245c418bc02103ba08227f6`;
- main Action run `36205436426`, job `108300854209`: **SUCCESS**;
- nello stesso run sono risultati SUCCESS build Release, benchmark StrategiaDiego, smoke HTTP/storage, feedback bridge, esecutivo SVG/DXF, progetto radiante reale, banco appartamento corrente, snapshot e step finale `Finalize Termodel job status and notify phone`;
- Commit Status finale `Termodel/job=SUCCESS`;
- artifact main del quadrato `strategia-diego-square-executive`, id `10893840445`;
- artifact main banco appartamento `strategia-diego-current-apartment`, id `10892724316`;
- SVG quadrato SHA-256 `6d8f8c281af51ccceeb20f082f58fe5b00a80ee497d66f7e1d4ef3843c9b511a`;
- DXF quadrato SHA-256 `a159bb6529ad84d6415538a6adc82535edb844f89ff60d6c4fd7df9cdb06d7b9`;
- numerazione diagnostica di default verificata realmente: 13 node-id nell'SVG e corrispondenza con il log `SpiraliDiego`; overlay escluso dal DXF e dal conteggio tecnico;
- log reale: radici ritorno Sinistra/Destra distanti `p=0,30 m` lungo la parete; raccordo blu preliminare presente con `limit=true strategicFront=false`;
- terminale di mandata con miglior bontà nello scenario reale del quadrato: 6 tratti attivi, 13,16 m, superficie empirica 7,896 m², superficie effettiva locale 13,988 m², fattore `0,564`;
- soluzione selezionata corrente: merito 24,405 m, 8 punti mandata, 8 punti ritorno; bontà mandata `0,564`, bontà ritorno `0,317`;
- node-id selezionati: mandata `1,3,4,5,6,7,8`; ritorno `15,17,19,25,26,27`;
- aggiornato il registro StrategiaDiego R5 nel commit `795985c83ba41718341892fbf810778bd1330669`;
- nessuna modifica a GPT/Vittorio, frontend, Library Desktop o `definizionedati.json`;
- i push su `main` hanno attivato il normale auto-deploy Render; gli strumenti di rete della sessione non riescono a interrogare direttamente `https://termodel.onrender.com/health`, quindi non viene dichiarata una verifica HTTP indipendente del commit runtime;
- l'SVG reale viene restituito all'utente per la verifica geometrica visuale richiesta da LG-036; il successo tecnico non equivale alla sua approvazione geometrica.

### INCARICO 2026-09-26 — Rettifica evoluzioni iniziali StrategiaDiego
Stato: ESEGUITO

Commissionato:
- rettificare la specifica StrategiaDiego eliminando il concetto di una "prima evoluzione" con regola speciale: tutte le evoluzioni della spirale devono seguire le stesse regole geometriche e di distanza;
- distinguere soltanto il raccordo iniziale proveniente dal tubo di collegamento dalla successiva evoluzione utile della spirale;
- consolidare la geometria corretta all'ingresso: mandata rossa a distanza `p/2` dalla parete, ritorno blu a distanza `1,5p` dalla parete, quindi distanza mandata-ritorno pari a `p`;
- fare derivare tali quote dalle regole generali di distanza (LG-006 e regole correlate), non da uno status speciale della prima evoluzione;
- aggiornare coerentemente il sorgente `StrategiaDiegoEngine.cs` e le Linee guida sviluppo spirali;
- non modificare Vittorio, GPT, frontend, Library Desktop o `definizionedati.json`;
- per esplicita modalità di lavoro richiesta dall'utente, pubblicare su GitHub senza compilare né eseguire GitHub Actions in questo incarico; lo stato finale dovrà quindi distinguere chiaramente implementato da compilato/testato.

Criteri di completamento:
- direttive aggiornate senza ambiguità su "prima evoluzione";
- sorgente Diego aggiornato in coerenza con le direttive;
- nessuna compilazione o Action avviata;
- Summary aggiornato con commit e stato reale;
- Issue #1 chiusa `Completed` a pubblicazione Git conclusa.

Risultato finale:
- la fase iniziale è stata pubblicata senza compilazione come richiesto;
- il successivo incarico di consolidamento ha incorporato e verificato le stesse rettifiche;
- `main` commit funzionale `a15d29e6407f41d3b245c418bc02103ba08227f6`;
- main Action `36205436426`, job `108300854209`: **SUCCESS**;
- raccordo mandata `p/2`, ritorno `1,5p`, separazione mandata-ritorno `p` verificati dai regression/smoke aggiornati;
- la vecchia esclusione arbitraria di `PROSEGUI_DRITTO` al primo nodo è stata rimossa nel consolidamento;
- l'output SVG reale è disponibile per controllo visuale dell'utente.


### INCARICO 2026-09-25 — Pubblicazione ultima build + direttive anti-timeout
Stato: ESEGUITO

Commissionato:
- pubblicare su Render l'ultima revisione del Service che risulta compilata con successo;
- propagare nel repository una regola permanente anti-timeout per le chat operative Termodel;
- usare GitHub come stato persistente del lavoro e GitHub Actions per build/test/elaborazioni lunghe;
- prevedere checkpoint frequenti e ripresa sicura dopo interruzione della chat;
- non modificare algoritmi, frontend, Library Desktop o `definizionedati.json` per questo incarico;
- verificare build GitHub Actions e, quando interrogabile, il commit realmente esposto da Render;
- al termine aggiornare questa voce con l'esito reale e chiudere la Issue #1 come `Completed` se riuscito, `Not planned` se fallito.

Criteri di completamento:
- direttive anti-timeout pubblicate e richiamate dal Summary Service;
- commit finale su `main`;
- GitHub Actions SUCCESS sul commit finale operativo;
- Render avviato sul normale auto-deploy collegato a `main`;
- Issue #1 aggiornata e chiusa con esito coerente.

Risultato reale:
- pubblicato il protocollo permanente `.github/TERMODEL-CHAT-ANTI-TIMEOUT.md`;
- il Summary Service richiama esplicitamente il protocollo come regola n. 15;
- `.github/TERMODEL-ACTION-NOTIFICATIONS.md` richiama il protocollo anti-timeout e chiarisce che timeout/sospensione chat non cambiano lo stato tecnico dell'Action;
- nessuna modifica a algoritmi, frontend, Library Desktop o `definizionedati.json`;
- revisione funzionale del motore rimasta quella già corretta e compilata con successo a partire da `1187212c5dfef1430a4ab66b366bc2a5a67e9c2d`;
- commit di registrazione/deploy `1f80643f1f5b4b7dc06a12a19d8c6037ae6c4f0f`: GitHub Actions SUCCESS;
- commit che propaga la regola nel Summary `aef1e57749f6ced68aa8b359c64a623f7a84e57b`: workflow `TermodelService Build` run `36164785404`, job `108170084305`: **SUCCESS**;
- nello stesso run sono risultati SUCCESS build Release, benchmark StrategiaDiego, smoke HTTP/storage, feedback bridge, esecutivo SVG/DXF, progetto radiante reale, banco appartamento corrente, snapshot e step finale di stato/notifica;
- commit `0cdf986b73a706cf539e4108c5580232a7b572be`: aggiunge il protocollo anti-timeout;
- commit `e8b55b3723c4520586f5dddac1823e6c3a998747`: collega le notifiche al protocollo; è documentale e non modifica il Service;
- i push su `main` hanno attivato il normale auto-deploy Render. Gli strumenti di rete disponibili in questa sessione non riescono a interrogare direttamente `https://termodel.onrender.com/health`, quindi non viene dichiarata una verifica HTTP indipendente del commit runtime;
- la versione pubblicata su Render è funzionalmente la stessa revisione Service verificata dalla Action SUCCESS; gli ultimi commit successivi sono esclusivamente documentali.

### INCARICO 2026-09-25 — Pubblicazione Render ultima build riuscita
Stato: ESEGUITO

Commissionato:
- pubblicare su Render la revisione più recente di TermodelService che risulta compilata e verificata con successo su GitHub Actions;
- revisione sorgente individuata prima del deploy: `1187212c5dfef1430a4ab66b366bc2a5a67e9c2d`, Commit Status `Termodel/job=success`, run `36161472437`;
- non modificare algoritmi, frontend, Library Desktop o `definizionedati.json` per questo incarico;
- usare il normale auto-deploy Render collegato a `main` e verificare l'esito disponibile;
- al termine aggiornare questa voce con l'esito reale e chiudere la Issue #1 come `Completed` se riuscito, `Not planned` se fallito.

Criteri di completamento:
- commit di deploy su `main` senza modifiche funzionali al motore;
- GitHub Actions SUCCESS sul commit pubblicato;
- deploy Render avviato dalla nuova revisione e, se interrogabile dalla sessione, `/health` coerente con il commit runtime;
- Issue #1 aggiornata e chiusa con esito coerente.


Risultato reale:
- revisione funzionale di partenza: `1187212c5dfef1430a4ab66b366bc2a5a67e9c2d`, già verificata `Termodel/job=SUCCESS` nel run `36161472437`;
- creato commit documentale di deploy `af4462ecf1a6c6d70f3fd77c5285296bfeccbf99`, senza modifiche funzionali al motore, per pubblicare la stessa revisione runtime tramite il normale auto-deploy Render collegato a `main`;
- GitHub Actions run `36163775436`, job `108166428280`: **SUCCESS**;
- SUCCESS: build Release, benchmark StrategiaDiego, smoke HTTP/storage, feedback, esecutivo SVG/DXF, progetto radiante reale, banco appartamento corrente, snapshot e step finale di notifica;
- Commit Status finale `Termodel/job=SUCCESS`;
- il push su `main` ha attivato il normale percorso di auto-deploy Render; il runtime pubblico `/health` non è interrogabile dagli strumenti di rete disponibili in questa sessione, quindi non viene dichiarata una verifica HTTP indipendente del deploy;
- nessuna modifica a algoritmi, frontend, Library Desktop o `definizionedati.json`.


### INCARICO 2026-09-25 — Correzione selezione closure StrategiaDiego sul quadrato
Stato: COMMISSIONATO

Commissionato:
- usare il log reale `SpiraliDiego` del quadrato 4x4 per individuare perché
  le soluzioni più sviluppate vengono scartate mentre sopravvive una closure
  prematura con pochi punti;
- correggere esclusivamente `StrategiaDiego`, mantenendo invariati GPT e
  Vittorio;
- non introdurre euristiche specifiche del solo quadrato se il difetto può
  essere corretto con una regola generale di terminale/closure;
- preservare le linee guida già consolidate, inclusi vincoli geometrici,
  troncature e comportamento concavo/convesso;
- eseguire GitHub Actions sul banco quadrato con categoria
  `SpiraliDiego` attiva;
- recuperare e confrontare `pannelli-esecutivo.svg` e
  `TermodelLog-SpiraliDiego.md` reali prima/dopo.

Criteri di completamento:
- Action SUCCESS;
- SVG quadrato realmente recuperato;
- la soluzione finale non deve più essere la closure prematura da 4+4 punti
  se esiste una soluzione geometricamente valida più sviluppata;
- log sufficiente a spiegare la nuova selezione;
- verificare e, se necessario, correggere il seed iniziale: il tubo di ingresso deve restare connessione al locale e non determinare direttamente la posizione della prima traccia parallela; la prima traccia utile deve essere agganciata alla maglia `distacco iniziale + n*passo`; aggiungere log più dettagliati se necessari per provarlo;
- Summary aggiornato e Issue #1 chiusa Completed.


### INCARICO 2026-09-25 — Logging diagnostico SpiraliDiego + Copia log
Stato: ESEGUITO

Commissionato:
- introdurre una categoria log dedicata **SpiraliDiego** nei punti strategici di `StrategiaDiegoEngine`;
- registrare almeno: ingresso locale, radice mandata/ritorno, espansione nodo, scelte candidate, rifiuti geometrici principali, terminali, closure preliminari, scelta finale;
- integrare la categoria `SpiraliDiego` nelle opzioni log già esposte dal Service;
- aggiornare il frontend affinché mostri la nuova voce nel menu Help > LOG AGGIORNA MODELLO;
- aggiungere al frontend il comando **Copia log negli appunti**, abilitato quando è disponibile un log aggiornato;
- preservare le categorie log esistenti e la retrocompatibilità del contratto;
- usare GitHub Actions per eseguire un test con log SpiraliDiego attivo sul caso quadrato e recuperare l'artefatto log reale;
- non modificare gli algoritmi Vittorio/GPT/Diego in questa attività oltre all'instrumentazione diagnostica.

Criteri di completamento:
- categoria SpiraliDiego selezionabile dal frontend;
- log Diego realmente scritto dal Service;
- Copia log negli appunti operativa;
- GitHub Actions SUCCESS;
- artifact log recuperato e ispezionato;
- Summary aggiornato e Issue #1 chiusa Completed.



Risultato reale:
- aggiunta nel Core headless la categoria Service-only `SpiraliDiego`;
- la Library Desktop resta invariata con le nove categorie storiche;
- `StrategiaDiegoEngine` registra, quando la categoria è attiva:
  - START e parametri ricerca;
  - locale e tubo di collegamento;
  - ENTRY con punto/direzione/parete;
  - radice iniziale mandata e ritorno;
  - espansione nodi e scelte `PROSEGUI_DRITTO/PARALLELA_A/PARALLELA_B`;
  - candidati accettati/rifiutati;
  - motivi geometrici principali di rifiuto;
  - terminali;
  - closure accettate/rifiutate;
  - aggiornamenti BEST;
  - soluzione SELECT finale;
- scoperto durante la prima Action che il buffer AsyncLocal di
  `GeneraModello` non può essere riletto dal chiamante dopo l'await:
  corretto il wiring inizializzando un secondo buffer, con la stessa
  configurazione, esclusivamente per l'esecutivo/StrategiaDiego e concatenando
  poi `result.Diagnostics + executiveDiagnostics`;
- `logCategories=all` abilita ora 10 categorie headless:
  9 Desktop + `SpiraliDiego`;
- frontend portato a **v1.19**:
  - checkbox Help > LOG AGGIORNA MODELLO > `spiralidiego`;
  - comando `Copia log negli appunti`;
  - il comando resta disabilitato finché non esiste un log aggiornato per il
    projectId corrente;
  - dopo `Aggiorna Modello` con almeno una categoria selezionata, il frontend
    legge `GET /api/projects/{projectId}/logs/termodel`, conserva il testo in
    cache e abilita il comando;
  - il click copia il buffer già recuperato, senza richiedere una nuova fetch
    asincrona prima dell'accesso clipboard;
- contratto Frontend-Service aggiornato a v1.26;
- documentata esplicitamente in `docs/copied-from-termodel.md` la natura
  Service-only della categoria.

Verifica reale:
- GitHub Actions finale run `36153837051`, job `108134090327`:
  **SUCCESS**;
- SUCCESS: frontend syntax/wiring, build Release, benchmark StrategiaDiego,
  smoke HTTP/log, feedback bridge, esecutivo quadrato, progetto radiante reale,
  appartamento corrente, snapshot e notifica terminale;
- smoke quadrato eseguito con
  `logEnabled=true&logCategories=SpiraliDiego`;
- artifact `strategia-diego-square-executive`, id `10872328670`,
  retention 90 giorni;
- artifact contiene:
  `StrategiaDiegoSquare4x4.project.tmdl`,
  `pannelli-esecutivo.svg`,
  `pannelli-esecutivo.dxf`,
  `TermodelLog-SpiraliDiego.md`,
  `test-metadata.json`;
- log reale recuperato: 1493 righe, 190239 byte,
  SHA-256 `58f705155feacc02564011393b7db2cb0531125fc20afd405f20831214e66a08`;
- marker reali del quadrato:
  90 scelte mandata, 222 scelte ritorno, 38 terminali,
  28 closure rifiutate, 2 closure accettate, 1 BEST update, 1 SELECT finale;
- il log rende immediatamente visibile la causa del risultato geometrico
  corrente: la soluzione finale scelta ha
  `merit=3.84m supplyPoints=4 returnPoints=4`, nonostante l'albero esplori
  percorsi molto più estesi; questo dato sarà il punto di partenza del prossimo
  audit della selezione/closure, senza modifiche algoritmiche in questo incarico.

Commit principali:
- `b4f7724df5a4f3604e3afc9f41c1c24e4b72fd3f` — categoria;
- `891148d3f1fbe7e2549cbdfcb5e4052595fddb14` — instrumentazione Diego;
- `8dcd1855ca40454b7465cdd80c9d84267ba6e64d` — buffer log esecutivo;
- `e4263cb7908f4223eb233729c434b6120085784f` /
  `dc64d3d2d8e3fa0a4cf84d7678a9bd00cd82f07a` — frontend v1.19;
- `6c5704ce01c5f8a99b2e5f7d5c9410452cf60d03` /
  `9e053ebc20d9afad5bdc66ada5ec86e547625a29` — smoke/artifact quadrato;
- `61a04038d3336bf9d87d0c1264d731d59a49f6a6` — all=10 categorie;
- `7e011b74b4b136ff4ae17a9058d868aa51159d25` — contratto v1.26.

### INCARICO 2026-09-25 — Secondo esempio frontend “Quadrato con pannelli”
Stato: ESEGUITO

Commissionato:
- consolidare il quadrato 4x4 già usato come test pannelli come esempio frontend stabile;
- esporlo nell'elenco `Apri esempio` con nome **Quadrato con pannelli**;
- posizionarlo come **secondo esempio** dell'elenco;
- riutilizzare il progetto/test autorevole esistente, evitando di creare un modello divergente;
- preservare il primo esempio esistente e la compatibilità degli altri esempi;
- verificare tramite GitHub Actions che il catalogo esempi e il caricamento frontend restino validi;
- non modificare `definizionedati.json` né la Library Desktop.

Criteri di completamento:
- “Quadrato con pannelli” compare come secondo elemento;
- il progetto si apre rapidamente dal frontend;
- il progetto contiene la geometria 4x4 e il tubo/rete pannelli necessari al calcolo;
- frontend build/smoke SUCCESS;
- Summary aggiornato;
- Issue #1 chiusa `Completed` per notifica ntfy.



Risultato reale:
- aggiunto `docs/termodel-ui-demo/examples/quadrato-con-pannelli.svg`;
- la geometria coincide con il banco rapido 4x4:
  - pareti E001..E004, quadrato 400×400 cm;
  - tubo T001 da (-50,200) a (50,200) cm;
  - layer `Unico_tubipannelli`;
  - rete `RAD-DEFAULT`;
  - locale R001 `Quadrato con pannelli`;
- il catalogo `docs/termodel-ui-demo/examples/catalog.json` espone ora:
  1. `Pannelli radianti`;
  2. **`Quadrato con pannelli`**;
- il secondo esempio usa `geometry: ./examples/quadrato-con-pannelli.svg`
  ed `executive: true`, quindi viene aperto dal percorso frontend
  `createStructuredProjectFromSvg()` e può richiedere l'esecutivo pannelli;
- nessuna copia concorrente della logica pannelli è stata introdotta;
- `definizionedati.json` e Library Desktop invariati.

Verifica reale:
- GitHub Actions run `36148860861`, job `108117367303`: **SUCCESS**;
- frontend JavaScript syntax: SUCCESS;
- regression catalogo: SUCCESS, inclusa posizione esatta come secondo esempio;
- build Release: SUCCESS;
- benchmark StrategiaDiego: SUCCESS;
- smoke esecutivo SVG/DXF: SUCCESS;
- progetto radiante reale: SUCCESS;
- banco appartamento corrente: SUCCESS;
- snapshot e notifica terminale: SUCCESS.

Commit principali:
- `e4e7d4e8809891640699bb448d4510cd01fe0576` — SVG esempio;
- `ee6ef269bf51ea6fa34d2aa67087b6c585420fc0` — secondo elemento catalogo;
- `1477c454f56cb0bf79db974f0dd4aed1426e85e4` — regression CI.

### INCARICO 2026-09-25 — Status bar Server <commit> · <strategia>
Stato: ESEGUITO

Commissionato:
- esporre dal Service l'identificativo breve del commit realmente in esecuzione;
- esporre dal Service il motore spirali effettivamente selezionato;
- far leggere questi dati al frontend all'avvio;
- mostrare nella status bar, quando il Service è pronto, il formato:
  `Server fc287c9b · Diego`;
- preferire il commit runtime fornito dall'ambiente Render quando disponibile;
- mantenere fallback locale/CI senza inventare un commit;
- non modificare il contratto dei calcoli né gli algoritmi Vittorio/GPT/Diego.

Criteri di completamento:
- endpoint/metadata Service espone commit e strategia effettiva;
- frontend mostra il testo richiesto;
- GitHub Actions SUCCESS;
- compatibilità con ambiente locale/CI verificata;
- Summary aggiornato e Issue #1 chiusa Completed.



Risultato reale:
- `GET /health` espone ora:
  `serviceCommit`, `serviceCommitShort` e `spiralEngine`;
- il commit runtime viene risolto nell'ordine
  `RENDER_GIT_COMMIT -> GITHUB_SHA -> SOURCE_VERSION`;
- il motore spirali è letto dal resolver autorevole del Core tramite
  `RadiantExecutiveGenerator.GetSelectedSpiralEngineName()`;
- il frontend è stato portato a **v1.18** e, dopo il collegamento al Service,
  mostra nella status bar il formato:
  `Server <8-char-commit> · <strategia>`;
- in ambiente senza commit runtime il fallback visuale è
  `Server locale · <strategia>`;
- contratto Frontend↔Service aggiornato a v1.25.

Verifica reale:
- GitHub Actions run `36138057522`, job `108080839413`: **SUCCESS**;
- build Release: SUCCESS;
- regression frontend: SUCCESS;
- smoke runtime identity: SUCCESS;
- output smoke:
  `service=20c9057a engine=Diego`;
- benchmark StrategiaDiego, smoke HTTP/storage, esecutivo SVG/DXF,
  progetto radiante reale, banco appartamento e snapshot: tutti SUCCESS;
- notifica terminale GitHub Actions: SUCCESS.

Commit principali:
- `1e0d7b3aef98c4fa6348f0b9ab7e8ba603c030e7` — espone strategia runtime;
- `aa168760340313c00b12d8cb065f2a450b37774a` — health commit + strategia;
- `049cdc6a8bb2955c0514a566908de27361c401a8` — status bar frontend;
- `200053dcd181e9726043a7692a9e013bfc397bbc` — frontend v1.18;
- `73128b8df4e37344ddd80da415e7c354098154c0` e
  `20c9057a9d2b2f5d4fb056b452b38ab57c7910dd` — regression CI finale;
- `bdad003838c391c0ecf38153ebafa66dc3eed182` — contratto v1.25.

Nota deploy pubblico:
- la modifica è consolidata su `main`;
- il comportamento runtime è verificato in GitHub Actions;
- il redeploy Render/GitHub Pages resta dipendente dai rispettivi sistemi di
  deploy e non viene dichiarato verificato dal solo CI.

### INCARICO 2026-09-25 — Verifica ottimizzazioni Codex StrategiaDiego su quadrato
Stato: ESEGUITO

Commissionato:
- verificare le ottimizzazioni realizzate da Codex su `StrategiaDiego`;
- usare come caso di riscontro il quadrato 4x4 già presente nelle fixture;
- verificare metriche, determinismo e geometria prodotta;
- recuperare l'SVG realmente prodotto dalla GitHub Action e mostrarlo all'utente;
- fornire feedback tecnico distinguendo ciò che è verificato da ciò che resta da validare;
- non modificare Vittorio/GPT, frontend, fixture autorevoli o `definizionedati.json`.

Criteri di completamento:
- ultime modifiche Codex identificate e confrontate col Summary/audit;
- Action reale verificata sul quadrato;
- `StrategiaDiegoSquare4x4.svg` recuperato dall'artifact;
- feedback tecnico conclusivo registrato.



Risultato reale:
- confrontato il delta Codex da `845bdcdd63e8c3f17979c517653fd643f329aea2`
  a `fc287c9b7ae9cfe30f8bfa1c7a8818962e54d392`: 7 commit, con modifiche
  concentrate su `StrategiaDiegoEngine`, benchmark, nuove fixture e workflow;
- audit `STRATEGIADIEGO-GPT-FUNDAMENTALS-AUDIT.md` verificato coerente con
  il codice: controllo segmento deterministico al posto dei 24 campioni,
  selezione del tratto terminale della rete di ingresso, linee di collegamento
  non assegnate come vincoli anti-attraversamento;
- confermata come scelta corretta la rinuncia ad applicare LG-035 tramite
  `node.Front`: senza uno stato orientato esplicito `S_k`, i run intermedi
  eliminavano terminali validi;
- l'albero Diego e il criterio di merito massimo LG-003 non sono stati
  sostituiti da euristiche GPT.

Verifica benchmark quadrato:
- rerun reale della build #495, run `36133802860`, nuovo job
  `108073316238`: **SUCCESS**;
- artifact nuovo `strategia-diego-benchmark`, id `10865175059`;
- fixture `StrategiaDiegoSquare4x4.locale.xml`, 20/20 iterazioni;
- 104 nodi massimi, 2 terminali accettati, profondità massima 10;
- p95 8 ms, memoria massima circa 508 kB;
- output deterministico e dentro tutti i budget;
- SHA-256 SVG motore:
  `257a97a5e831a5a56827dec6dd0ba3a22d26a20ca61aee76f40f99a314043df7`;
- hash identico alla precedente esecuzione #495: nessuna regressione
  geometrica sul quadrato causata dalle ottimizzazioni Codex.

Verifica esecutivo Service quadrato:
- esteso esclusivamente il test harness, senza modificare l'algoritmo, per
  pubblicare il vero `pannelli-esecutivo.svg` del progetto quadrato 4x4;
- commit harness `b8cd3f7589ac25db1ac52248bd410da435065ecb`;
- commit workflow `a2eec9074de9161e76b743531f6a7e6265cb5a99`;
- GitHub Actions run `36136180456`, job `108075400109`: **SUCCESS** su
  tutta la suite;
- artifact `strategia-diego-square-executive`, id `10865521237`, contiene
  il progetto TMDL realmente usato, SVG e DXF esecutivi;
- SVG esecutivo SHA-256:
  `26b202d7c9e923b542574499d46b06511f007e3ae324de71efca8da9cedf6aed`;
- l'esecutivo contiene 4 primitive: 2 contorni pianta pulita + mandata +
  ritorno; parete esterna 13 cm visibile;
- verifica distanze sul risultato reale:
  - prima evoluzione mandata: 0,45 m dalla faccia interna di ingresso;
  - arresto rosso rispetto alla parete frontale: 0,15 m = p/2;
  - ritorno blu rispetto alla parete laterale: 0,15 m = p/2.

Feedback tecnico:
- le ottimizzazioni Codex sui fondamentali geometrici sono confermate come
  miglioramenti di robustezza e non introducono regressioni sul quadrato;
- il quadrato a singolo ingresso non esercita da solo le due novità sulla rete
  ramificata; queste restano coperte dalle fixture
  `StrategiaDiegoConnectionTerminal` e dal progetto reale, entrambi SUCCESS;
- il disegno 4x4 mostra però chiaramente che **la strategia di copertura non è
  ancora completa**: la soluzione selezionata percorre soltanto una zona
  laterale del locale e chiude presto mandata/ritorno, lasciando gran parte
  del quadrato senza spirale;
- questo non è un difetto delle ottimizzazioni R3, che agiscono su
  `TrattoPossibile?` e vincoli geometrici; è un limite residuo del livello
  strategico/terminale/chiusura e non va trasformato in Golden Result;
- prossima analisi consigliata: capire perché sul quadrato il criterio
  terminale + chiusura preliminare accetta una soluzione con merito 4,1 m
  invece di proseguire nella copertura dell'intero locale.

Nessuna modifica a Vittorio/GPT, frontend, fixture autorevoli o
`definizionedati.json`.

### INCARICO 2026-09-25 — Riallineamento fondamentali geometrici GPT in StrategiaDiego
Stato: ESEGUITO

Commissionato:
- confrontare sistematicamente il motore `SpiraliGPT` con
  `StrategiaDiegoEngine` usando LG-001..LG-036 come specifica autorevole;
- distinguere i fondamentali geometrici riutilizzabili dalle euristiche di
  scelta che devono restare proprie dell'albero Diego;
- correggere esclusivamente StrategiaDiego affinché ogni ramo operi su
  geometria interna robusta, raccordi validi, distanze reali e continuità
  topologica, senza sostituire il criterio di merito massimo LG-003;
- aggiungere regression automatiche per ogni differenza corretta;
- non modificare i motori Vittorio/GPT, il frontend, la fixture appartamento o
  `definizionedati.json`;
- eseguire la suite GitHub Actions e la verifica visuale obbligatoria LG-036
  sul banco appartamento corrente.

Criteri di completamento:
- inventario differenze documentato con classificazione
  `fondamentale | differenza intenzionale | ancora da definire`;
- correzioni conformi alle LG e commentate secondo le regole del repository;
- benchmark quadrato/concavo e banco appartamento conclusi con successo;
- SVG reale prodotto dalla Action recuperato e condiviso con l'utente;
- stato `ESEGUITO` soltanto dopo verifica tecnica e visuale disponibile.

Risultato:
- creato `docs/STRATEGIADIEGO-GPT-FUNDAMENTALS-AUDIT.md` con classificazione
  `fondamentale | differenza intenzionale | ancora da definire`;
- sostituito il campionamento fisso a 24 punti con controllo deterministico di
  estremi, intersezioni col bordo e punto medio del segmento;
- la selezione dell'ingresso scarta ora i tratti che proseguono in un altro
  ramo e sceglie il terminale della rete LG-011;
- i tubi diversi dal collegamento assegnato sono vincoli
  anti-attraversamento; il collegamento assegnato resta il varco del locale;
- mantenuti invariati albero Diego, merito massimo LG-003, Vittorio e GPT;
- aggiunte fixture `StrategiaDiegoObliqueTrapezoid.locale.xml` e
  `StrategiaDiegoConnectionTerminal.locale.xml`;
- il benchmark verifica anche `ExpectedConnectionId` e il workflow fallisce
  realmente quando un `dotnet run` restituisce exit code non zero;
- nessuna modifica a frontend, fixture appartamento o
  `definizionedati.json`.

Verifica reale finale:
- GitHub Actions `TermodelService Build` run `36133802860`, build #495, job
  `108066963980`: **SUCCESS**;
- quadrato 4x4: 20 iterazioni, 104 nodi, 2 terminali, p95 8 ms,
  deterministico;
- concavo a L: 20 iterazioni, 183 nodi, 2 terminali, p95 21 ms,
  deterministico;
- trapezio obliquo: 20 iterazioni, 104 nodi, 2 terminali, p95 9 ms,
  deterministico;
- rete ramificata: 20 iterazioni, 56 nodi, 4 terminali, p95 5 ms,
  `T-B` selezionato come ingresso terminale, deterministico;
- build, smoke HTTP, esecutivo SVG/DXF, progetto radiante reale e banco
  appartamento StrategiaDiego: SUCCESS;
- artifact visuale `strategia-diego-current-apartment`, id `10862238283`,
  contenente il `pannelli-esecutivo.svg` realmente prodotto.

Diagnostica e correzioni intermedie:
- run #491 ha rivelato che PowerShell non propagava il fallimento dei
  benchmark nativi; il workflow è stato reso bloccante;
- run #492 ha quindi esposto correttamente la perdita dei terminali;
- run #493/#494 hanno dimostrato che applicare LG-035 usando `node.Front` come
  sostituto di `S_k` orientato è scorretto;
- il criterio offset precedente è stato conservato finché il nodo non
  memorizzerà esplicitamente lo stato orientato richiesto da LG-035;
- run #495 ha validato la correzione del varco di ingresso e l'intera suite.

Limiti dichiarati:
- R3 non copia da GPT arrotondamento, punteggio composito, offset concentrici
  o forcina avanzata, perché violerebbe LG-001/LG-003 o anticiperebbe LG-029;
- `STRATEGY-001`, chiusura avanzata e stato orientato completo LG-035 restano
  incarichi successivi dedicati.

### INCARICO 2026-09-25 — Rettifica arresto frontale Diego: 15 cm; quota ingresso mandata 45 cm
Stato: ESEGUITO

Rettifica utente consolidata dopo verifica:
- **0,45 m = 1,5p** resta la quota della prima evoluzione di mandata rispetto
  alla parete d'ingresso; serve a lasciare all'esterno la guida del ritorno;
- **0,15 m = p/2** è invece la distanza corretta di arresto del primo tratto
  quando questo arriva frontalmente a una parete architettonica;
- il bug introdotto nella correzione precedente consisteva nell'ereditare
  erroneamente i 0,45 m anche rispetto alla parete frontale successiva;
- rimossa quindi la logica speciale di "offset ereditato" alla prima svolta;
- il normale troncamento LG-006/LG-017 torna ad arrestare il tratto a p/2.

Criterio di completamento:
- ingresso mandata sul banco appartamento: circa 0,45 m dalla parete d'ingresso;
- primo tratto verso la parete destra: arresto a circa 0,15 m dalla parete;
- nessuna propagazione dei 0,45 m alla parete frontale;
- suite completa GitHub Actions SUCCESS;
- SVG reale del banco appartamento recuperato.

Risultato reale:
- codice finale: `d7c90f6b44d8153322548a37c115e0555bc46b4c`;
- regression finale: `c3f9409dd63169d4176c67dedeeb693668d2566b`;
- documentazione LG-013 rettificata in
  `bdf9e4b9bf350e3200d8d780ac00b03e27113744`;
- GitHub Actions run `36124421565`, job `108037147214`: **SUCCESS**;
- SUCCESS: build Release, benchmark StrategiaDiego, smoke HTTP, smoke
  esecutivo SVG/DXF, progetto radiante reale, banco appartamento corrente,
  snapshot e notifica finale;
- SVG reale: SHA-256
  `cd7d3d3c110c5f8f93c9f22b3b0323a483710aa46468c4e1002353bdcb83a28b`;
- artifact `strategia-diego-current-apartment`, id `10859711767`;
- geometria verificata nell'SVG reale:
  - parete destra interna: `x=8,13148`;
  - terminale rosso del primo tratto verso destra: `x=7,98148`;
  - distanza reale dalla parete destra: **0,15 m**;
  - tratto d'ingresso rosso: da `y=2,70628` a `y=2,25628`,
    quindi lunghezza **0,45 m**;
- fixture autorevole invariata; nessuna modifica a frontend, Library Desktop o
  `definizionedati.json`.


### INCARICO 2026-09-25 — Correzione primo tratto StrategiaDiego secondo LG-013/LG-017
Stato: SUPERATO — rettificato dall'incarico successivo sui 15 cm

**NOTA AUTOREVOLE DI RETTIFICA:** le conclusioni di questo blocco che indicano 0,45 m come distanza corretta dalla parete frontale sono errate e non devono più essere usate. Il valore corretto di arresto dalla parete frontale è `p/2 = 0,15 m`; i 0,45 m restano soltanto la quota della prima evoluzione di mandata rispetto alla parete d'ingresso.

Commissionato:
- correggere StrategiaDiego sul primo tratto che prosegue dal tubo di collegamento dentro il locale;
- applicare la regola già consolidata in LG-013: direzione uguale al tubo entrante, **estremo finale non preassegnato**;
- il primo tratto deve essere prolungato fino alla prima geometria frontale e poi troncato alla distanza di rispetto applicabile secondo LG-017/LG-006, invece di usare una lunghezza fissa;
- confrontare i motori GPT e Vittorio come riferimento algoritmico per il principio intersezione/offset + accorciamento, senza modificarli;
- aggiungere regression sul banco appartamento corrente affinché il primo tratto non torni a una lunghezza fissa `1,5p`;
- eseguire GitHub Actions con StrategiaDiego e restituire l'SVG reale prodotto dal Service.

Criteri di completamento:
- eliminata dal primo tratto la lunghezza iniziale preassegnata;
- prima linea frontale realmente ricercata nella direzione del collegamento;
- estremo reale arretrato della distanza prevista;
- build e smoke GitHub Actions SUCCESS;
- banco appartamento corrente SUCCESS;
- SVG reale recuperato e mostrato all'utente.



Risultato reale:
- l'anomalia è stata localizzata nel **primo tratto tracciato dopo il tubo di
  collegamento**, non nella pianta pulita;
- sul banco appartamento la mandata entra portandosi a `1,5p = 0,45 m`
  dalla parete superiore, ma alla prima svolta Diego usava il minimo
  architettonico generale `p/2 = 0,15 m` anche verso la parete destra;
- il tratto orizzontale terminava quindi a `x=7,98148 m`, cioè 0,15 m dalla
  parete interna destra `x=8,13148 m`;
- confrontati i motori Vittorio e GPT: entrambi ottengono il cambio di lato
  attraverso la geometria degli offset/intersezioni e quindi accorciano il
  tratto mantenendo l'offset dell'evoluzione;
- StrategiaDiego ora, **soltanto sulla prima svolta dopo il collegamento**,
  eredita la distanza architettonica raggiunta dal tratto di ingresso e la
  usa come distanza di troncamento rispetto alla parete successiva;
- sul banco corrente il terminale della prima svolta passa quindi a
  `x=7,68148 m`, pari a `8,13148 - 0,45`, mantenendo 45 cm dalla parete;
- l'estensione iniziale della stessa regola a tutte le evoluzioni è stata
  provata e scartata perché rendeva troppo restrittivo il progetto radiante
  reale (`locale_8` senza terminale accettabile);
- la correzione finale è pertanto minima e specifica della prima svolta;
- LG-013 è stata precisata con questo comportamento runtime e con il confronto
  concettuale Vittorio/GPT;
- nessuna modifica a fixture autorevole, frontend, Library Desktop o
  `definizionedati.json`.

Verifica reale:
- build Release GitHub Actions: SUCCESS;
- benchmark sintetici StrategiaDiego: SUCCESS;
- smoke esecutivo SVG/DXF: SUCCESS;
- progetto radiante reale: SUCCESS;
- banco appartamento corrente StrategiaDiego: SUCCESS;
- GitHub Actions finale run `36121714784`, job `108028934122`:
  **SUCCESS**;
- regression banco appartamento verifica:
  - primo ingresso mandata circa `0,45 m`;
  - primo tratto dopo la svolta termina a `x≈7,68148 m`, quindi a 0,45 m
    dalla parete destra;
- artifact `strategia-diego-current-apartment`, id `10857442717`;
- SVG reale prodotto dal Service:
  SHA-256 `af73fe2fda67423339b62df5d55f2c50d7d0e327f8a3ffad197c0889f31c1515`;
- Commit Status finale e notifica telefono: SUCCESS.

Iterazioni diagnostiche:
- `83d87dd1f6d04489fda78b3c02db54f65b883c71`:
  prima interpretazione troppo estesa del primo tratto, regression sintetiche
  fallite;
- `f9c49f1076c5e5ab743099f7edf6ad83099e3369`:
  conservazione offset su tutte le svolte, sintetiche riuscite ma progetto
  radiante reale fallito su `locale_8`;
- `cd208c8c629c018bd34794c2ec722343b5edb877`:
  correzione finale limitata alla prima svolta, suite completa SUCCESS;
- `08cc65df25ce89f8553a3dcd0640c2363cf952a2`:
  precisazione documentale LG-013.

### INCARICO 2026-09-25 — Esecutivo pannelli con pianta pulita spessorata
Stato: ESEGUITO

Commissionato:
- modificare il Service/Core affinché l'artifact `pannelli-esecutivo.svg` non contenga più soltanto spirali e geometria edilizia a linee, ma inglobi come sfondo la **pianta pulita reale** prodotta dal percorso headless `GeneraPianta`;
- la pianta pulita incorporata deve conservare gli **spessori reali delle pareti** ricavati dai dati del progetto/archivi, così l'esecutivo consente di valutare direttamente i distacchi delle tubazioni dai muri;
- mantenere spirali e pianta pulita nello stesso sistema di coordinate, senza ricostruzioni grafiche occasionali esterne al Service;
- non modificare la fixture autorevole dell'appartamento, `definizionedati.json`, frontend o Library Desktop;
- mantenere invariato il nome/contratto dell'artifact `pannelli-esecutivo-svg`; cambia soltanto il suo contenuto, che diventa composito;
- eseguire GitHub Actions sul banco prova corrente StrategiaDiego e recuperare l'SVG realmente restituito dal Service, da mostrare all'utente come verifica visuale.

Criteri di completamento:
- `pannelli-esecutivo.svg` contiene la pianta pulita spessorata sotto le spirali;
- gli spessori derivano dal progetto e non da valori grafici inventati nell'esecutivo;
- build e smoke GitHub Actions SUCCESS;
- test appartamento corrente con `TERMODEL_SPIRAL_ENGINE=Diego` SUCCESS;
- SVG prodotto dalla Action recuperato e restituito all'utente.




Risultato reale:
- `RadiantExecutiveGenerator.Generate(...)` riceve ora le
  `CleanFloorPlans` prodotte dalla stessa elaborazione `GeneraModello`;
- per ogni piano l'esecutivo importa l'SVG canonico
  `TERMODEL-CLEAN-FLOOR-SVG-V1` prima delle spirali, convertendo le unità
  della pianta pulita in metri e mantenendo lo stesso modello grafico neutro
  usato sia dall'SVG sia dal DXF;
- i contorni architettonici sono pubblicati su
  `<Piano>_PiantaPulita_Output` e gli eventuali simboli lineari su
  `<Piano>_PiantaPulitaSimboli_Output`;
- `<Piano>_Edificio_Output` resta esclusivamente fallback per progetti
  legacy nei quali la pianta pulita non sia disponibile;
- lo spessore non viene inventato nell'esecutivo: la pianta pulita deriva dal
  percorso headless `GeneraPianta -> GeometriaHelper.ParalleloPoligono ->
  DXFLineCheck.SpessoreParete`, che legge il valore dell'archivio Pareti
  associato alle linee del progetto;
- la fixture autorevole non è stata modificata e non sono stati modificati
  frontend, Library Desktop o `definizionedati.json`;
- sul banco prova corrente la parete `Parete esterna isolata` dell'archivio
  operativo risulta spessa 13 cm; l'SVG finale contiene due contorni della
  pianta pulita separati coerentemente di 0,13 m, quindi lo spessore è
  effettivamente visibile sotto le spirali.

Verifica reale:
- le prime Action hanno evidenziato due aspettative obsolete nei regression
  test (richiesta del vecchio layer `Edificio_Output` e soglia fissa di
  primitive); i test sono stati aggiornati alla nuova semantica composita;
- GitHub Actions finale run `36115694955`, job `108009152767`:
  **SUCCESS**;
- SUCCESS: restore, build Release, benchmark StrategiaDiego, smoke esecutivo
  SVG/DXF, progetto radiante reale, banco appartamento corrente StrategiaDiego
  e snapshot;
- il banco appartamento verifica esplicitamente la presenza di
  `Unico_PiantaPulita_Output`, l'assenza del fallback
  `Unico_Edificio_Output` e almeno due contorni distinti della pianta pulita;
- artifact CI `strategia-diego-current-apartment`, id `10854544021`;
- SVG reale `pannelli-esecutivo.svg` recuperato dall'Action, SHA-256
  `cd7d3d3c110c5f8f93c9f22b3b0323a483710aa46468c4e1002353bdcb83a28b`;
- Commit Status finale e notifica telefono: SUCCESS.

Commit principali:
- `7a2a46f0aad16950f82428fb657c06cb80e60a6e` — commissione;
- `92e327001597813370fbbf4c554295e0a0d44514` — contratto;
- `d957fa371b5ea9d9a13960968785485654eaaa95` — import pianta pulita nel Core;
- `e5b61b8cca935e82edc7f0e070f4c1137f1a6071` — wiring WebService;
- `e64e9f7fc89b15e7de49443627f447e2b40e6eaf` — regression banco appartamento;
- `1256c6ab202105937d765a17328c2c1e9a564485` e
  `f189a3dae9d846fcef24452ea98be794d7839316` — adeguamento regression
  esecutivo composito.

### INCARICO 2026-09-25 — Direttiva verifica visuale obbligatoria StrategiaDiego
Stato: ESEGUITO

Commissionato:
- aggiungere alle **Linee guida per lo sviluppo del disegno spirali** una
  direttiva permanente per tutte le modifiche che possono cambiare il disegno
  prodotto da StrategiaDiego;
- ogni modifica a codice, regole strategiche, geometria, troncature, distanze,
  selezione dei rami o altri parametri capaci di alterare l'esecutivo deve
  essere verificata tramite **GitHub Actions** sul banco prova operativo
  corrente `tests/fixtures/StrategiaDiegoCurrentApartment.project.tmdl`;
- la verifica deve forzare `TERMODEL_SPIRAL_ENGINE=Diego` e produrre la
  risposta/artifact reale `pannelli-esecutivo.svg` usando
  `responseArtifact=pannelli-esecutivo-svg`;
- al termine della modifica la chat deve recuperare e **restituire all'utente
  un SVG visualizzabile** del risultato, non limitarsi a hash, metriche o log;
- una modifica che può cambiare il disegno non può essere dichiarata
  verificata/completata se la relativa Action non è riuscita oppure se l'SVG
  reale non è stato recuperato;
- quando utile, conservare e confrontare SVG prima/dopo; l'SVG prodotto è
  evidenza visuale del test ma non diventa automaticamente un Golden
  geometrico approvato;
- le sole modifiche documentali o tecniche che non possono alterare il disegno
  non richiedono questo ciclo visuale;
- la fixture autorevole resta immutabile: eventuale canonicalizzazione avviene
  soltanto sulla copia temporanea già prevista dall'harness.

Criteri di completamento:
- nuova regola consolidata come `LG-036`;
- documento operativo aggiornato da `LG-001..LG-035` a
  `LG-001..LG-036`;
- banco prova, Action e restituzione SVG esplicitamente vincolanti per i
  futuri cambiamenti visuali;
- nessuna modifica a motore, frontend, Library Desktop o
  `definizionedati.json` in questo incarico esclusivamente documentale.



Risultato:
- consolidata `LG-036 — Verifica visuale obbligatoria delle modifiche che
  cambiano il disegno` in
  `docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md`;
- lo stato operativo della specifica è aggiornato a `LG-001..LG-036`;
- per ogni futura modifica con possibile impatto geometrico sono ora
  obbligatori: GitHub Actions sul banco appartamento corrente, motore Diego,
  produzione/retrieval di `pannelli-esecutivo.svg` e restituzione
  dell'SVG visualizzabile all'utente;
- esplicitato che SUCCESS, hash, metriche e log non sostituiscono la verifica
  visuale del disegno;
- esplicitato che un SVG di test non diventa automaticamente Golden geometrico;
- le modifiche esclusivamente documentali o tecniche senza possibile impatto
  sul disegno sono escluse dal ciclo Action+SVG;
- nessuna modifica a Core, WebService runtime, frontend, Library Desktop o
  `definizionedati.json`.

Verifica:
- file Linee guida riletto da `main` dopo il commit e LG-036 presente con
  stato `CONSOLIDATA`;
- questa commissione è esclusivamente documentale e **non modifica il
  disegno**, quindi non è stata eseguita una GitHub Action: LG-036 si applica
  dalla prossima modifica capace di alterare l'output grafico;
- commit Linee guida:
  `2461d63de20e6c2bd777f8ed63b67982ca1ab40b`.

### INCARICO 2026-09-25 — Banco prova corrente StrategiaDiego: appartamento reale
Stato: ESEGUITO

Commissionato:
- consolidare su GitHub **senza modificarlo** il progetto
  `TERMODEL-PROJECT-TEXT-V1` fornito dall'utente il 25/09/2026 come
  **banco prova corrente autorevole** per lo sviluppo di StrategiaDiego;
- conservarne una copia immutabile sotto `Server/Termodelwebservice/tests/fixtures/`,
  con SHA-256 del file originale;
- usarlo come fixture primaria dei successivi test GitHub Actions delle
  spirali con risposta diretta `pannelli-esecutivo-svg`;
- mantenere quadrato 4x4 e concavo a L come regression sintetiche rapide,
  non più come banco operativo principale;
- registrare direttiva, stato algoritmo e lavoro corrente nelle Linee guida
  spirali e nel registro sviluppo StrategiaDiego;
- non modificare frontend, Library Desktop o `definition/definizionedati.json`.

Risultato consolidato:
- fixture autorevole:
  `tests/fixtures/StrategiaDiegoCurrentApartment.project.tmdl`;
- snapshot originale conservata senza modifiche; confronto testo sorgente/GitHub
  verificato identico;
- SHA-256 originale:
  `1a5855490adcbac25e5585f9ba89c624eb2381874eb2de8bdc74821a40d2a9a5`;
- projectId originale:
  `07bf8dca-dc86-41ea-8844-1aaca58888f0`;
- piano: `Unico`; timestamp manifest: `2026-09-25T06:16:04.350Z`;
- README dedicato:
  `tests/fixtures/README-StrategiaDiegoCurrentApartment.md`;
- harness dedicata:
  `tools/smoke-strategia-diego-current-apartment.ps1`;
- workflow standard pubblica l'artifact
  `strategia-diego-current-apartment` con retention 90 giorni;
- harness forza `TERMODEL_SPIRAL_ENGINE=Diego` e usa
  `responseArtifact=pannelli-esecutivo-svg`;
- la fixture locale resta immutata; soltanto una copia temporanea viene
  canonicalizzata come `buildTermodelServerPayload()` prima del Service;
- le Linee guida Spirali contengono ora una sezione autorevole
  `Stato operativo corrente — 25/09/2026` con stato algoritmo, banco prova e
  ciclo locale-per-locale;
- il registro StrategiaDiego è passato allo stato generale
  `IN SVILUPPO — BANCO PROVA APPARTAMENTO REALE CORRENTE` e contiene R2
  ancora `IN CORSO`, perché la validazione geometrica continua.

Verifica reale:
- Action #468, run `36102716657`: SUCCESS sulla fixture consolidata;
- Action #473, run `36103180758`: primo collaudo harness FAILED con HTTP 422
  perché la snapshot locale era stata inviata direttamente e mancava la
  canonicalizzazione `TERMODEL-PROJECT-SVG-V1`; nessun difetto Diego dimostrato;
- correzione harness commit
  `a789f85f433959dddeeff9e60a65a180d69416f5`, senza modificare fixture;
- GitHub Actions **#474**, run `36103622680`, job `107971255939`: **SUCCESS**;
- build Release, benchmark sintetici, smoke Service precedenti e banco
  appartamento: SUCCESS;
- marker: `STRATEGIA_DIEGO_CURRENT_APARTMENT_OK`;
- fixture SHA verificato uguale all'originale;
- `spiralEngine=Diego`; risposta diretta SVG HTTP 200;
- SVG baseline SHA-256:
  `71921972d16085fab3071e56cd53a0695661536436678b2c64e7051f1312ecb8`;
- `generatedFileCount=8`; calculation: 1 circuito pannelli, 6 primitive
  esecutivo, 1 piano;
- artifact CI `strategia-diego-current-apartment`, id `10850671585`,
  dimensione archivio 163.814 byte, ispezionato: contiene
  `server-payload.tmdl`, `pannelli-esecutivo.svg`, DXF, `pannelli.json`,
  `generated-files.json`, `test-metadata.json`, TermodelLog/diagnostics,
  calculation log e stdout/stderr Service;
- Commit Status finale `SUCCESS` e notifica telefono `SUCCESS`.

Direttiva operativa da proseguire:
1. screenshot utente + numero locale;
2. riproduzione sulla fixture corrente;
3. individuazione della prima decisione strategica errata;
4. distinguere violazione di una LG esistente da regola mancante;
5. se manca, consolidare LG-036 o successiva prima della correzione;
6. correzione minima soltanto su StrategiaDiego salvo diversa decisione;
7. rieseguire la stessa Action e confrontare prima/dopo;
8. trasformare i casi significativi in regression permanenti.

Nota: l'SVG della #474 è una **baseline tecnica**, non un Golden geometrico
approvato dell'intero progetto.

Commit principali:
- `997356301df3bff63a73118dd778c8d479f0a72d` — commissione;
- `7110bec407d1d3426483c4bc05747b8f7a253ac8` — fixture;
- `3fd40ddf849d9b895792374907babb374d3a4786` — README fixture;
- `7d74c5dcc3888468a5ba7e339fb8ae6b7c094e55` — harness iniziale;
- `6c5c8664b7e1298dc0f26d50a1eda4fcaea5704a` — integrazione workflow;
- `ebf749cb41622a23451bfb0244bd7692d9d61107` — Linee guida;
- `3a5ca15c02ff48ac2c7b11278fcb4494b33132f8` — apertura R2;
- `a789f85f433959dddeeff9e60a65a180d69416f5` — canonicalizzazione harness.


### INCARICO 2026-09-25 — Risposta artifact diretta da Aggiorna Modello
Stato: ESEGUITO

Commissionato:
- estendere `POST /api/calculations` con il parametro query opzionale
  `responseArtifact`;
- in assenza di `responseArtifact` mantenere **identica** la risposta corrente:
  manifest JSON `TERMODEL-FRONT-SERVICE-V1` con `projectId`, artifact e href;
- se `responseArtifact` è presente, eseguire comunque una sola elaborazione
  completa e atomica del progetto, quindi restituire direttamente nel body
  l'artifact richiesto;
- supportare almeno `model3d`, `pannelli`,
  `pannelli-esecutivo-svg`, `pannelli-esecutivo-dxf` e
  `pianta-pulita`; per `pianta-pulita` usare anche `responseFloor`;
- restituire HTTP 400 per nomi artifact non riconosciuti e HTTP 404 quando
  l'artifact richiesto è riconosciuto ma non prodotto da quel progetto;
- aggiungere header di correlazione con projectId e nome artifact;
- usare questa modalità nei regression GitHub Actions dei pannelli/spirali e
  conservare come artifact CI almeno la risposta SVG diretta, così le chat
  successive possono esaminare l'esecutivo prodotto senza una seconda GET;
- non modificare frontend, `definizionedati.json` o Library Desktop.

Risultato:
- contratto condiviso aggiornato a **v1.24**;
- implementato `responseArtifact` su `POST /api/calculations`;
- valori correnti:
  `model3d | pannelli | pannelli-esecutivo-svg | pannelli-esecutivo-dxf | pianta-pulita`;
- `pianta-pulita` richiede anche `responseFloor=<nomePiano>`;
- senza parametro la risposta resta il manifest JSON
  `TERMODEL-FRONT-SERVICE-V1`, quindi il frontend corrente è retrocompatibile
  e non è stato modificato;
- con parametro il Service completa e pubblica comunque l'intero workspace
  atomico, poi restituisce direttamente il body dell'artifact selezionato;
- le risposte dirette espongono `X-Termodel-Project-Id`,
  `X-Termodel-Response-Artifact` e `X-Termodel-Artifact-Stale: false`;
- artifact sconosciuto: HTTP 400; artifact conosciuto ma non prodotto: HTTP 404;
- il regression reale pannelli salva la risposta diretta come
  `response-pannelli-esecutivo.svg` nell'artifact CI
  `radiant-reference-regression`.

Verifica reale:
- GitHub Actions **#466**, run `36100728060`, job `107962873006`:
  **SUCCESS**;
- build .NET: SUCCESS;
- benchmark StrategiaDiego: SUCCESS;
- smoke HTTP/storage, feedback, esecutivo SVG/DXF, progetto radiante reale e
  snapshot: SUCCESS;
- chiamata diretta
  `POST /api/calculations?responseArtifact=pannelli-esecutivo-svg`: SUCCESS;
- marker CI: `CALCULATION_DIRECT_ARTIFACT_OK`;
- SHA-256 della risposta SVG:
  `A51BB21F38293D4E6538FEE241C8AFE7A225D7A126A2978FE101320D46D1A9D3`;
- lo SHA-256 coincide byte-per-byte con
  `artifacts/pannelli-esecutivo.svg` persistito dalla stessa elaborazione;
- richiesta `responseArtifact=artifact-inesistente`: HTTP 400 verificato;
- artifact Actions `radiant-reference-regression`, id `10848733383`,
  contiene realmente `response-pannelli-esecutivo.svg` (5.921 byte);
- Commit Status finale `SUCCESS` e notifica telefono `SUCCESS`.

Commit operativi:
- `d46bd3945c6c12a7f669e9cddcf296c685b18f67` — registrazione incarico;
- `2446cace1620e2f33772a7615dceb8e21a92ca9c` — contratto v1.24;
- `6de84b2af2f700ab1c2eafd10704f1ae8eeb01b4` — implementazione endpoint;
- `2e6085ede366ce62b1a85e24da311917443cd48c` — documentazione README;
- `66a5e2d2724f7006fa47613461e91c0f54bd43e2` — regression risposta SVG diretta.



### INCARICO 2026-09-25 — Forzatura StrategiaDiego e stato attesa Service nel frontend
Stato: ESEGUITO

Commissionato:
- rendere **StrategiaDiego** il motore spirali usato dal Service quando
  `TERMODEL_SPIRAL_ENGINE` non è configurata;
- mantenere l'override esplicito `Vittorio | GPT | Diego` tramite variabile
  d'ambiente, così la scelta resta reversibile;
- aggiornare la documentazione Service che descrive ancora GPT come default;
- nel frontend `docs/termodel-ui-demo`, mostrare nella status bar CAD il
  testo esatto **"In Attesa di una risposta del server"** mentre è pendente
  una chiamata al Termodel Service;
- applicare il feedback di attesa in modo centralizzato alle chiamate Service
  e gestire correttamente eventuali richieste concorrenti;
- non modificare `definizionedati.json`, Library Desktop o il contratto
  `TERMODEL-PROJECT-TEXT-V1`.

Criteri di completamento:
- fallback del dispatcher verificato nel sorgente come `Diego`;
- chiamate Service del frontend instradate attraverso il feedback di attesa;
- build/check automatici GitHub Actions conclusi con successo;
- diagnostica interna dell'esecutivo continua a costruire il messaggio con il
  motore selezionato;
- incarico marcato `ESEGUITO` soltanto dopo verifica reale dell'Action.

Risultato:
- `RadiantExecutiveGenerator.ResolveSpiralEngine()` restituisce ora
  `RadiantSpiralEngine.Diego` quando `TERMODEL_SPIRAL_ENGINE` è assente o
  vuota;
- l'override esplicito `Vittorio | GPT | Diego` resta disponibile;
- README Service aggiornato al nuovo default operativo;
- frontend portato a **v1.17**;
- tutte le chiamate al Termodel Service nel flusso principale usano il wrapper
  `fetchTermodelService(...)`;
- durante una o più richieste pendenti la status bar CAD e lo stato della vista
  mostrano esattamente **"In Attesa di una risposta del server"**;
- il wrapper usa un contatore delle richieste pendenti e ripristina lo stato
  precedente soltanto dopo l'ultima risposta, senza sovrascrivere messaggi più
  recenti;
- il workflow protegge con regression statica i marker del nuovo feedback di
  attesa.

Verifica reale:
- prima Action #461, run `36099815059`: FAILED nel solo controllo statico
  frontend perché il cache-busting era stato portato a v1.17 mentre
  `APP_VERSION`/workflow attendevano ancora v1.16; sintassi JavaScript già
  SUCCESS; notifica terminale FAILED eseguita;
- correzione di coerenza versione nel commit
  `452d8b26b8b2a279a2185d5d2aefdce12165c322`;
- GitHub Actions **#462**, run `36100018101`, job `107960320636`:
  **SUCCESS**;
- SUCCESS: restore, sintassi frontend, wiring frontend, build .NET, benchmark
  StrategiaDiego, smoke HTTP/storage, feedback, esecutivo pannelli SVG/DXF,
  progetto radiante reale e snapshot GitHub;
- il workflow non imposta `TERMODEL_SPIRAL_ENGINE`, quindi gli smoke del
  Service hanno esercitato il nuovo fallback Diego;
- step finale Commit Status/notifica telefono: SUCCESS;
- GitHub Pages run `36100017851`: **SUCCESS** per il frontend v1.17.

Commit operativi:
- `4cd5cbf22c718f7b8f7e9a7c560f8569e1712716` — registrazione incarico;
- `9e96b43ce70af9082c3ba3ccdcfb73fad8f5f9e8` — Diego default + wrapper
  attesa Service + frontend v1.17;
- `452d8b26b8b2a279a2185d5d2aefdce12165c322` — allineamento APP_VERSION e
  regression CI del feedback attesa.



### INCARICO 2026-09-25 — Visualizzazione esecutivo StrategiaDiego quadrato 4x4
Stato: SUPERATO

Nota:
- l'utente ha cambiato strategia di verifica: i test proseguono sul corrente
  esempio appartamento, analizzando screenshot e numero locale;
- l'eventuale Action già avviata per il quadrato resta una prova tecnica, ma
  non costituisce più il criterio operativo richiesto dall'utente.

Commissionato:
- rieseguire tramite GitHub Actions il caso test `StrategiaDiegoSquare4x4.locale.xml`;
- usare la StrategiaDiego corrente senza modificare Vittorio/GPT;
- recuperare l'SVG prodotto dalla Action per il quadrato 4x4 con unico tubo entrante;
- mostrare all'utente il disegno prodotto, insieme all'esito reale del benchmark;
- non modificare frontend, `definizionedati.json` o Library Desktop.

Criteri di completamento:
- GitHub Action conclusa;
- artifact `strategia-diego-benchmark` recuperato;
- `StrategiaDiegoSquare4x4.svg` estratto e visualizzato;
- metriche della nuova esecuzione registrate;
- incarico marcato `ESEGUITO` soltanto dopo verifica reale dell'Action.



### INCARICO 2026-09-25 — StrategiaDiego regressione geometrie complesse R1
Stato: ESEGUITO

Commissionato:
- riprendere lo sviluppo di StrategiaDiego dal limite residuo registrato dopo
  F6;
- introdurre una fixture minima riproducibile con locale concavo a L e un
  unico ingresso;
- eseguire sulla nuova fixture lo stesso benchmark ripetuto, deterministico e
  soggetto ai budget già adottati per il caso quadrato 4x4;
- integrare la regressione nel workflow GitHub Actions senza modificare i
  motori Vittorio/GPT, il frontend o `definizionedati.json`;
- mantenere distinta questa prova di concavità dalla futura regressione reale
  di strettoia/imbottigliamento collegata a `STRATEGY-001`.

Criteri di completamento:
- fixture e relativa scheda documentale presenti nel repository;
- benchmark capace di produrre artifact distinguibili per più fixture;
- build e benchmark quadrato + concavo conclusi con successo in GitHub
  Actions;
- metriche reali della nuova fixture registrate nel Summary e nel registro di
  sviluppo;
- commissione marcata `ESEGUITO` soltanto dopo la verifica dell'Action.

Risultato:
- aggiunte la fixture `tests/fixtures/StrategiaDiegoConcaveL.locale.xml` e la
  relativa scheda `README-StrategiaDiegoConcaveL.md`;
- il benchmark genera ora report JSON e SVG nominati in base alla fixture,
  evitando collisioni fra casi diversi;
- il workflow esegue 20 iterazioni sia sul quadrato 4x4 sia sul locale concavo
  e pubblica metriche nel Job Summary e come annotazioni `notice` consultabili
  senza scaricare artifact autenticati;
- GitHub Actions `TermodelService Build` run `36097485997`, build #458, job
  `107952701779`: **SUCCESS**;
- quadrato 4x4: 104 nodi, 2 terminali accettati, p95 23 ms, 360.576 byte,
  deterministico;
- locale concavo a L: 183 nodi, 2 terminali accettati, p95 48 ms,
  720.896 byte, deterministico;
- entrambe le fixture rispettano i budget F5 (50.000 nodi, p95 2.000 ms,
  memoria 128 MiB);
- nessuna modifica ai motori Vittorio/GPT, al frontend o a
  `definizionedati.json`.

Valutazione:
- la sostenibilità di StrategiaDiego è ora verificata anche su una prima
  geometria concava, oltre al quadrato 4x4;
- non è ancora dimostrata la gestione selettiva della strettoia di
  `STRATEGY-001`, né sono coperti più ingressi/circuiti o più locali.

Commit operativi:
- `78f9f3a5b27e2472fee7686d0ac163eec25aa19b` — registrazione R1;
- `78b0529ecbbcbe2eda5baa763e74844a9c4ec60e` — fixture concava e doppio
  benchmark;
- `cabacac1715c97adf01c22596dfd08032e615c10` — metriche pubbliche nel
  workflow.


### INCARICO 2026-09-25 — Implementazione, attivazione e benchmark StrategiaDiego
Stato: ESEGUITO

Risultato consolidato:
- completato audit comparativo sui sorgenti Vittorio/GPT e specifica code-ready;
- implementato nel Core il terzo motore headless `StrategiaDiegoEngine`;
- mantenute disponibili le alternative `Vittorio | GPT | Diego`;
- selezione Service tramite `TERMODEL_SPIRAL_ENGINE`; dal commit `9e96b43ce70af9082c3ba3ccdcfb73fad8f5f9e8` il default operativo è `Diego`, con override esplicito `Vittorio | GPT | Diego` ancora disponibile;
- Vittorio copiato temporaneamente byte-identical nel Core e tracciato in
  `CopiedFromTermodel/TERMODEL-SYNC.md`; Library Desktop non modificata;
- aggiunta fixture `tests/fixtures/StrategiaDiegoSquare4x4.locale.xml`
  (quadrato 4x4 m, unico tubo entrante);
- aggiunto benchmark ripetuto e integrato nel workflow GitHub Actions;
- completato allineamento LG-033..LG-035: i rami paralleli che inseguono un
  tratto precedente usano il successore `S_k+1` tramite `SequenceIndex`;
  `PROSEGUI_DRITTO` resta alternativa separata;
- nessuna modifica a frontend o `definizionedati.json`.

Fasi:
- F0 — registrazione incarico e registro di sviluppo: ESEGUITO;
- F1 — audit finale Vittorio/GPT e specifica code-ready: ESEGUITO;
- F1B — audit implementazione vs LG-033..LG-035: ESEGUITO;
- F2 — implementazione/dispatcher `Vittorio|GPT|Diego`: ESEGUITO;
- F2B — allineamento inseguimento sequenziale `S_k -> S_k+1`: ESEGUITO
  (`90f76ff47e4822b00d7ba3d57b524017e377f092`);
- F3 — build reale della soluzione: ESEGUITO;
- F4 — fixture quadrato 4x4 m / un ingresso: ESEGUITO;
- F5 — batteria benchmark GitHub Actions e metriche: ESEGUITO
  (`64177c1651ef36dfddd6eb92c1973ea7c16691a5`);
- F6 — consolidamento Summary e stato finale: ESEGUITO.

Verifica reale finale:
- GitHub Actions `TermodelService Build` run `36096201896`, build #453;
- job build `107949117086`: SUCCESS;
- Commit Status `Termodel/job=SUCCESS`;
- notifica telefono finale: SUCCESS;
- benchmark: 20 iterazioni sulla fixture 4x4;
- nodi totali massimi: **104**;
- terminali preliminarmente accettati: **2**;
- p95: **22 ms**;
- max memory delta: **368.800 byte**;
- output deterministico verificato;
- budget benchmark rispettati (50.000 nodi, p95 2.000 ms, memoria 128 MiB).

Baseline precedente all'allineamento sequenziale:
- run #450: 1176 nodi, p95 98 ms, 7.408.856 byte, 2 terminali;
- il passaggio a `S_k -> S_k+1` riduce fortemente lo spazio di ricerca senza
  introdurre potatura predittiva.

Valutazione:
- StrategiaDiego è **implementata, compilata, eseguita e testata** sul caso
  campione 4x4/un ingresso;
- la sostenibilità è verificata per questo caso, non ancora generalizzabile a
  geometrie complesse;
- prossimi regression necessari: concavità, strettoie/imbottigliamenti,
  più ingressi/circuiti e più locali.



### INCARICO 2026-09-25 — Linee guida sviluppo disegno spirali / futura StrategiaDiego
Stato: COMMISSIONATO

Commissionato:
- creare un documento vivo denominato **Linee guida per lo sviluppo del disegno spirali**, costruito progressivamente durante il confronto con l'utente;
- per ogni nuovo punto proposto dall'utente, aggiungere commento tecnico, formulazione verificabile e registrazione Git;
- usare il documento come specifica funzionale della futura classe/strategia **StrategiaDiego**;
- mantenere StrategiaDiego concorrente, e non sostitutiva, rispetto ai motori/strategie **Vittorio** e **GPT** già conservati nel progetto;
- prevedere come obiettivo architetturale una selezione esplicita della strategia richiesta: `Vittorio | GPT | Diego`, con input/output confrontabili;
- non implementare ancora StrategiaDiego né modificare gli algoritmi Vittorio/GPT in questa fase documentale;
- collegare le linee guida al registro strategie geometriche già presente in `docs/spirali-strategy-register/`;
- non modificare Library Desktop, frontend, `definizionedati.json` o contratto HTTP finché la discussione non produce una richiesta esplicita di implementazione.

Criteri di avanzamento:
- il documento deve distinguere chiaramente principi consolidati, commenti tecnici e punti ancora da definire;
- ogni principio dovrà essere traducibile in un criterio di test/regressione per la futura StrategiaDiego;
- le tre strategie dovranno restare confrontabili sullo stesso caso geometrico senza alterarsi reciprocamente.

Avanzamento iniziale:
- creato `docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md` come specifica viva;
- consolidata `LG-001 — Strategie concorrenti e selezionabili`;
- definito l'obiettivo futuro `Vittorio | GPT | Diego` con selezione esplicita e output confrontabile;
- registrato che StrategiaDiego non deve sovrascrivere né modificare silenziosamente Vittorio/GPT;
- collegato il documento all'indice `docs/spirali-strategy-register/README.md`;
- nessuna classe StrategiaDiego o modifica algoritmica implementata in questa fase;
- incarico mantenuto **COMMISSIONATO** perché il documento deve continuare a ricevere i punti successivi dall'utente.
- consolidata e successivamente rettificata `LG-002 — StrategiaDiego come albero decisionale`: nodi = situazioni con scelta strategica, rami = alternative esplicite, foglie/terminali = situazioni senza ulteriori scelte strategiche e con esito/comportamento deterministico;
- la rettifica esclude il modello a grafo generico: ogni nodo non radice ha un solo padre, rami distinti non si ricongiungono e non sono ammessi cicli;
- richiesto che il percorso radice -> nodi -> rami -> foglia sia diagnosticabile e riproducibile nei regression test.
- consolidata `LG-003 — Fattore di merito dei terminali e scelta della soluzione`: per ogni terminale valido il merito è la lunghezza totale di tubo producibile; viene selezionato il terminale con lunghezza massima;
- separata concettualmente la fase di esplorazione/valutazione dell'albero dalla materializzazione finale: la spirale definitiva viene prodotta ripercorrendo dalla radice il cammino del terminale vincente e applicando nell'ordine le scelte registrate nei nodi;
- esclusi dal confronto i terminali geometricamente invalidi; parità di merito e dettaglio di misura di raccordi/tratti tecnici restano da definire.
- consolidata `LG-004 — Struttura geometrica di contenimento`: lo stato geometrico minimo di StrategiaDiego è composto da tre famiglie semanticamente distinte, `LineeArchitettoniche`, `LineeMandata` e `LineeRitorno`;
- registrato che i nodi devono poter interrogare separatamente le tre famiglie e che i nuovi tratti generati aggiornano la famiglia mandata/ritorno corrispondente;
- non ancora definite in LG-004 regole di collisione, attraversamento, distanze di rispetto o precedenze fra le tre famiglie.
- consolidata `LG-005 — Concetto di tratto possibile`: un tratto è possibile solo se rispetta tutte le regole di tracciamento applicabili e genera un segmento con lunghezza strettamente maggiore di zero;
- un tratto non possibile non deve aprire un ramo valido dell'albero; diagnostica futura distinta fra lunghezza nulla e violazione di una regola di tracciamento;
- elenco completo delle regole di tracciamento e tolleranza numerica sulla lunghezza restano da definire.
- consolidata `LG-006 — Passo p e distanze minime di tracciamento`: `p` è la distanza minima tubo-tubo di riferimento; distanza minima da linee architettoniche `p/2`, fra tubi dello stesso colore `2p`, fra tubi di colore diverso `p`;
- interpretazione corrente: colori = famiglie mandata/ritorno e distanze misurate fra le linee/assi geometrici rappresentativi dei tubi;
- queste soglie diventano regole applicabili a `TrattoPossibile`; previste regression sulle condizioni `<`, `=` e `>` rispetto a `p/2`, `p`, `2p`.
- consolidata `LG-007 — Scelta di nodo possibile`: una scelta di nodo è un `TrattoPossibile` che non interseca linee già generate, è parallelo a una linea esistente di riferimento e si trova alla distanza minima applicabile di LG-006;
- distinto esplicitamente `TrattoPossibile` da `SceltaNodoPossibile`: non ogni tratto geometricamente ammesso costituisce automaticamente un ramo dell'albero;
- restano da definire selezione della linea di riferimento, ordinamento di più scelte ammissibili e tolleranze su parallelismo/distanza/intersezioni agli estremi.
- consolidata `LG-008 — Terminale accettabile`: un terminale è accettabile quando l'estremo della mandata e l'estremo della ripresa/ritorno possono essere collegati senza intersecare altre linee già presenti;
- distinto il semplice terminale dell'albero dal terminale accettabile; solo i terminali accettabili partecipano alla selezione per massimo fattore di merito di LG-003;
- LG-008 introduce soltanto il vincolo di non-intersezione del collegamento finale; forma del collegamento, eventuali distanze minime e caso senza terminali accettabili restano da definire.
- precisata LG-008: la valutazione `TerminaleAccettabile` avviene soltanto dopo il completamento dell'intero albero decisionale; l'accettabilità non viene usata per scegliere o potare anticipatamente i rami;
- sequenza consolidata: costruzione completa albero -> raccolta terminali -> valutazione accettabilità -> filtro terminali accettabili -> confronto fattore di merito -> scelta terminale vincente.
- consolidata `LG-009 — Configurazione iniziale e direzione principe`: l'albero parte dall'estremo interno del tubo di collegamento di mandata che entra nella stanza; sono previste configurazioni ritorno a sinistra/destra;
- per `RitornoSinistra`, destra/sinistra sono definite esclusivamente rispetto alla direzione convenzionale del tubo di collegamento `esterno -> stanza`; la direzione principe è il tratto parallelo sul lato destro di tale verso;
- non ancora definita per deduzione la regola `RitornoDestra`; resta da stabilire anche se la direzione principe sia solo priorità di esplorazione o vincolo più forte.
- consolidata `LG-010 — Lato di ritorno associato al singolo tubo di collegamento`: ogni ingresso conserva il proprio `LatoRitorno = Sinistra | Destra`, indipendente dagli altri ingressi dello stesso progetto;
- esclusa una configurazione globale unica del lato di ritorno: verso `esterno -> stanza` e lato di ritorno vengono valutati separatamente per ogni tubo di collegamento.
- consolidata `LG-011 — Albero di collegamento idraulico collettore-ingressi`: prima della costruzione delle spirali interne viene definita la rete fisica di collegamento dal collettore ai tratti di entrata;
- distinta tale rete dall'albero decisionale LG-002: la rete/albero di mandata è input autorevole dell'utente, mentre l'albero di ritorno viene costruito dall'algoritmo;
- la rete di collegamento completa alimenterà `LineeMandata` e `LineeRitorno` della struttura geometrica LG-004; algoritmo concreto del ritorno, diramazioni e priorità restano da definire.
- consolidata `LG-012 — Radice dell'albero di ritorno`: per ogni nodo di mandata d'ingresso, l'algoritmo colloca la radice del ritorno a `0,50 m`; il vettore mandata->ritorno è parallelo alla parete architettonica più vicina e il verso è coerente con il `LatoRitorno` dell'ingresso;
- restano da definire gestione di pareti equidistanti, dettaglio della distanza da segmenti finiti e comportamento se la posizione teorica della radice viola altri vincoli geometrici.
- consolidata `LG-013 — Primo tratto a inclinazione libera`: il primo tratto della costruzione può avere inclinazione libera e costituisce deroga al solo requisito di parallelismo; dal secondo tratto in poi si applicano integralmente le regole di parallelismo di LG-007;
- il primo tratto resta comunque soggetto a validità geometrica, non-intersezione e distanze minime LG-005/LG-006; direzione concreta del primo tratto e rapporto con la direzione principe restano da definire.
- consolidata `LG-014 — Il ritorno segue la mandata nel corridoio quando possibile`: la mandata utente può coprire aree del corridoio; il ritorno tenta di seguirne ordinatamente le evoluzioni con tratti paralleli ammessi;
- se una specifica evoluzione della mandata non può essere seguita senza intersezioni o viola le regole geometriche, il ritorno non viene forzato: quella evoluzione viene saltata e la ricerca riprende dalla successiva evoluzione seguibile;
- il fallimento su una singola evoluzione non interrompe l'intera costruzione del ritorno; resta da definire come assicurare geometricamente la continuità fra due tratti seguibili separati da evoluzioni saltate.
- consolidata `LG-015 — Configurazione terminale mandata/ritorno e scelta iniziale della spirale`: solo dopo il completamento della rete di ritorno, per ogni ingresso terminale viene determinato se la mandata è a destra o a sinistra nel riferimento locale `esterno -> stanza`;
- tale configurazione terminale costituisce l'input per la scelta iniziale della spirale; `MandataDestra <=> RitornoSinistra` e `MandataSinistra <=> RitornoDestra` descrivono la stessa coppia geometrica;
- la tabella completa che traduce il lato della mandata nella concreta prima scelta geometrica della spirale resta da definire.
- consolidata `LG-016 — Scelta di prosecuzione nella direzione di provenienza`: ad ogni nodo con direzione entrante viene valutata l'alternativa `PROSEGUI_DRITTO`, cioè continuare lungo la stessa direzione fino alla prima geometria frontale;
- il tratto non interseca la geometria frontale ma si arresta alla distanza minima applicabile secondo LG-006 e genera un ramo solo se resta `TrattoPossibile`/`SceltaNodoPossibile`;
- restano da definire le altre scelte concorrenti del nodo e l'ordine con cui verranno enumerate.
- precisata LG-016: `PROSEGUI_DRITTO` deroga esplicitamente al requisito di parallelismo con un'altra linea esistente; la sua ammissibilità deriva dalla continuità della direzione di provenienza, restando soggetta a lunghezza positiva, distanze minime e non-intersezione.
- consolidata `LG-017 — Ogni nuovo tratto deve avere una linea frontale di arresto`: la semiretta teorica della direzione candidata deve incontrare un'altra linea della struttura geometrica; il segmento reale viene troncato prima dell'intersezione alla distanza di rispetto applicabile;
- distinta esplicitamente l'intersezione della direzione teorica dalla non-intersezione del segmento costruito; senza linea frontale o con arretramento che produce lunghezza <= 0, il tratto non viene generato.
- consolidata `LG-018 — Flusso generale della StrategiaDiego`: 1) costruzione ritorno dei tubi di collegamento, 2) costruzione spirali di mandata, 3) costruzione spirali di ritorno, 4) potatura dei rami non ammissibili dell'albero, 5) generazione definitiva;
- dopo la potatura si valutano i terminali accettabili (LG-008), quindi si seleziona quello con massimo fattore di merito (LG-003), infine si genera la soluzione definitiva ripercorrendo deterministicamente il cammino radice->terminale vincente;
- il termine operativo resta `albero decisionale` secondo LG-002; criteri completi di potatura e regole specifiche della spirale di ritorno restano da definire.
- consolidata `LG-019 — Evoluzione delle linee guida attraverso i casi di test`: il documento resta una specifica viva, da correggere/estendere quando i casi reali o di regression evidenziano ambiguità, limiti o regole mancanti;
- i casi `STRATEGY-NNN` devono alimentare le regole generali `LG-NNN`; una differenza osservata va compresa prima di aggiornare risultati attesi o comportamento;
- le rettifiche strategiche devono essere documentate esplicitamente prima dell'implementazione, mantenendo tracciabilità e trasformando i casi significativi in regression test quando possibile.
- consolidata `LG-020 — Riferimento sussidiario a Spirali Vittorio e Spirali GPT`: per gli aspetti non ancora definiti esplicitamente da StrategiaDiego si consultano entrambi i motori esistenti come riferimento;
- una regola Diego esplicita prevale sempre; se Vittorio e GPT concordano il comportamento vale come riferimento provvisorio, se divergono la differenza deve essere documentata e risolta con una nuova LG-NNN senza scelta implicita;
- il fallback documentale non autorizza copie o modifiche dei motori Vittorio/GPT e decade sul singolo punto quando StrategiaDiego lo formalizza esplicitamente.
- audit pre-sviluppo avviato un quesito alla volta; consolidata `LG-021 — Enumerazione completa delle linee di riferimento a ogni nodo`: ogni nodo considera tutte le linee architettoniche, di mandata e di ritorno come riferimenti candidati, applicando rispettivamente le distanze `p/2`, `2p` o `p` secondo famiglia/colore del nuovo tratto;
- nessun filtro preliminare per sola vicinanza: le alternative vengono eliminate dalle successive verifiche geometriche; resta aperta la gestione di candidati equivalenti generati da riferimenti diversi.
- consolidata `LG-022 — Direzione di provenienza ed estremo libero del tubo di collegamento`: ogni nodo dispone di `DirezioneProvenienza`; nel caso iniziale il tubo di collegamento ha direzione nota ma estremo interno libero, determinato dall'intersezione con la direzione del prossimo tratto scelto;
- resta da definire la gestione dei casi in cui direzione di provenienza e nuovo tratto risultino paralleli, dell'intersezione posta dietro al verso orientato e di eventuali correzioni/raccordi sul punto geometrico di intersezione.
- audit: rettificata `LG-021` tramite `LG-023 — Linea di riferimento determinata dal troncamento del tratto precedente`; per un cambio di direzione ordinario non si enumerano più tutte le linee come riferimenti di parallelismo;
- la nuova linea deve essere la parallela alla linea frontale che ha troncato il tratto precedente e deve passare per il terminale di quel tratto; questo determina univocamente il lato della parallela;
- `PROSEGUI_DRITTO` resta l'eccezione: usa `DirezioneProvenienza` e non richiede parallelismo con la linea di troncamento; la struttura geometrica completa resta comunque usata per trovare ostacolo frontale, distanze e intersezioni.
- audit: consolidata `LG-024 — Entrambi i versi della nuova parallela generano rami`: una volta determinata la parallela di LG-023, vengono esplorati entrambi i versi come rami distinti se immediatamente geometricamente ammissibili;
- vietata la potatura anticipata basata sulla previsione che un ramo possa bloccare il ritorno: anche scelte potenzialmente catastrofiche devono essere costruite e potranno essere eliminate solo quando il blocco viene realmente verificato nella costruzione del ritorno/potatura/accettabilità terminale;
- previsto regression case con un ramo di mandata inizialmente valido ma successivamente incompatibile con il ritorno, che deve sopravvivere fino alla fase corretta di esclusione.
- audit: consolidata `LG-025 — Condizione di terminale dell'albero di mandata`: un nodo è terminale solo quando, dopo aver valutato `PROSEGUI_DRITTO` e i due versi della parallela di LG-023/LG-024, nessuna alternativa produce un `TrattoPossibile`;
- la terminalità deriva quindi dall'assenza completa di prosecuzioni ammissibili, non da euristiche o previsioni sul ritorno; se almeno un candidato è valido il nodo resta non terminale e ogni candidato valido genera un ramo.
- audit: consolidata `LG-026 — Origine della costruzione della spirale di ritorno`: la spirale di ritorno non parte dal terminale della mandata ma dall'estremo interno del tubo di collegamento di ritorno già generato nella fase iniziale della rete di collegamento;
- per ogni circuito restano quindi distinte `OrigineMandata` e `OrigineRitorno`; il terminale della mandata rimane geometria da raggiungere/chiudere compatibilmente nelle fasi successive, non origine del ritorno;
- audit: consolidata `LG-027 — Mandata e ritorno usano la stessa strategia di nodo`: una volta definita la rispettiva origine, entrambe le famiglie valutano `PROSEGUI_DRITTO` e i due versi della parallela determinata dal troncamento precedente;
- la logica decisionale deve essere condivisa; cambiano soltanto origine, famiglia/colore e quindi le distanze applicabili rispetto alla geometria presente;
- eventuali future eccezioni specifiche del ritorno dovranno essere introdotte esplicitamente con nuove linee guida.
- audit: consolidata `LG-028 — Ogni terminale della mandata prosegue con il proprio albero dei ritorni`: ciascun terminale mandata conserva il proprio percorso/geometria e avvia una distinta esplorazione del ritorno dalla stessa `OrigineRitorno` del circuito;
- nessun terminale mandata viene escluso per motivi di ottimizzazione preventiva; il costo computazionale potrà crescere combinatoriamente e dovrà essere misurato sui casi di test tramite numero nodi/terminali, profondità, tempo e memoria;
- eventuali ottimizzazioni future dovranno preservare lo spazio delle soluzioni ammissibili oppure essere prima formalizzate come nuova regola StrategiaDiego.
- audit: consolidata `LG-029 — Valutazione preliminare della chiusura e verifica avanzata successiva`: nella prima implementazione la chiusura mandata/ritorno viene valutata tramite segmento rettilineo diretto e non-intersezione;
- tale esito è solo preliminare: in seguito verrà definita una verifica avanzata delle chiusure realmente realizzabili/irrealizzabili, eventualmente con forme non rettilinee, raccordi e vincoli costruttivi;
- il test preliminare positivo o negativo non va confuso con una certificazione definitiva della fattibilità della chiusura.
- audit: consolidata `LG-030 — StrategiaDiego come strategia computazionalmente pesante e selezionabile`: Diego viene classificata come motore esplorativo pesante, selezionabile esplicitamente dall'utente o utilizzabile/proponibile quando la complessità del progetto è stimata sostenibile;
- la classificazione di pesantezza governa la selezione del motore, non introduce potature euristiche interne e non modifica le regole geometriche di Diego;
- restano da definire soglie/metriche concrete di compatibilità, comportamento UI/fallback ed eventuali limiti assoluti di nodi, tempo o memoria.
- audit: consolidata `LG-031 — Geometria vincolante durante la costruzione del ritorno`: per ogni terminale mandata, il relativo ritorno viene valutato contro `LineeArchitettoniche + intero PathMandata del terminale + PathRitornoCorrente`;
- geometrie appartenenti a rami alternativi non contaminano lo stato corrente; per il ritorno valgono distanze `p/2` da architettura, `p` da mandata e `2p` da ritorno.
- audit: consolidata `LG-032 — Geometria vincolante durante la costruzione della mandata`: ogni ramo mandata vede soltanto `LineeArchitettoniche + PathMandataCorrente`; i rami alternativi sono scenari indipendenti e non costituiscono ostacoli reciproci;
- ogni nuovo tratto valido entra subito nello stato geometrico del proprio ramo; per la mandata valgono `p/2` da architettura e `2p` da mandata già presente.
- audit: rettificate `LG-013` e `LG-022`: il primo tratto, sia di mandata sia di ritorno, **non ha inclinazione libera** ma mantiene la direzione del rispettivo tubo di collegamento entrante; è libero il punto finale, non la direzione;
- il punto finale del primo tratto viene determinato dalla prima linea frontale utile e dal conseguente troncamento alla distanza di rispetto; la regola vale simmetricamente per mandata e ritorno.
- audit: consolidato il principio `LG-033 — Inseguimento progressivo dell'evoluzione precedente nei percorsi convessi`: dopo il primo giro, la spirale può riagganciarsi alla propria evoluzione precedente e seguirne ordinatamente i tratti `S1 -> S2 -> S3 -> ...`;
- la troncatura può usare anche il prolungamento geometrico di un tratto precedente come marcatore di aggancio, mentre le collisioni restano verificate sulla geometria fisica reale;
- per supportare l'inseguimento convesso la futura implementazione dovrà mantenere identità e sequenza dei segmenti del path; resta da definire se il successivo segmento della sequenza precedente abbia priorità assoluta o resti una delle alternative dell'albero.
- audit: consolidata `LG-034 — Troncatura con segno opposto nei casi concavi e convessi`: rispetto all'intersezione teorica `I`, misurando lungo `DirezioneProvenienza`, il terminale vale `I - d` nei casi concavi e `I + d` nei casi convessi;
- LG-017 viene quindi precisata: il troncamento non è sempre un arretramento; nei percorsi convessi l'avanzamento oltre l'intersezione permette l'inseguimento progressivo della precedente evoluzione definito in LG-033;
- audit: confronto diretto eseguito sui motori Desktop `Termodel-Vittorio-main/Termodel_new/Spiralgenerator.cs` e `SpiraliGPT/Spiralgenerator.cs`; Vittorio costruisce gli offset mediante normali/bisettrici, GPT mediante buffer negativo NetTopologySuite con `JoinStyle.Mitre` e validazione dei raccordi;
- precisata `LG-034`: la formula `I-d` concavo / `I+d` convesso resta esatta nel caso ortogonale, ma per angoli arbitrari il terminale va ottenuto come intersezione fra la linea corrente e la parallela offset del segmento successivo della precedente evoluzione; il modulo dello spostamento non è in generale `d`;
- consolidata `LG-035 — Criterio computabile di inseguimento concavo/convesso`: dato `S_k -> S_k+1`, si costruiscono `I` (intersezione con la retta non offset) e `T` (intersezione con la parallela offset), quindi `delta = dot(T-I, DirezioneProvenienza)`; `delta<0` concavo, `delta>0` convesso, con criterio equivalente `q*side*turn` per diagnostica;
- separati esplicitamente geometria teorica (segmenti + prolungamenti per aggancio/troncatura) e geometria fisica (segmenti reali per collisioni e validità); la sequenza ordinata `S_k -> S_k+1` è autorevole nell'inseguimento convesso.

Commit iniziali:
- `4b7be0d6762fec6baad84fda2d7fe9f226684042` — registrazione incarico;
- `a7d1b5f0558bd4d4f4ed03f392a6866d305ce0ea` — creazione Linee guida e LG-001;
- `8866e03763010c1c003f524e1e4239375eca748c` — collegamento dal registro strategie.
- `3d7ed48b8259b03d6ad959552e7521b951aeefb3` — LG-002, struttura a grafo decisionale.
- `ca6d8e6999496f6c4b03e4d27556039dc2ce7854` — rettifica LG-002 da grafo ad albero decisionale.
- `a9bede514fba3016caa33662d4e21eb0ac40c0e8` — LG-003, fattore di merito dei terminali e selezione per massima lunghezza tubo valida.
- `e420174d26b232c6ee6c7f170a7de2bd47ee0a32` — LG-004, struttura geometrica di contenimento con linee architettoniche, mandata e ritorno.
- `484a961e977505d703b7e3f67a99c553e919bd8f` — LG-005, definizione di tratto possibile.
- `9020b095e11b1c5dfda2ccbcb7d56ab838008b0c` — LG-006, passo `p` e distanze minime architettura/stesso colore/colore diverso.
- `75723ee7b6b08a5f278fd488d7ecbaf59ca89dd6` — LG-007, definizione di scelta di nodo possibile.
- `d4df535a993a5c2c03773f408b4f33c1f7e99de5` — LG-008, definizione di terminale accettabile.
- `3dd72b08db5fff5e9a9f3ca1bf29bc6a098c16a4` — precisazione LG-008: valutazione dei terminali accettabili solo a fine costruzione dell'albero.
- `58dc4cfbe7890a66170f5f03afba05b804c1f3ff` — LG-009, configurazione iniziale e direzione principe per ritorno a sinistra.
- `7a77cc8fae70d79fcccd1359fbd555fd439f5be7` — precisazione LG-009: destra/sinistra riferite al verso del tubo di collegamento `esterno -> stanza`.
- `0620f934f4b183f514e8e80ffd436a2008533df1` — LG-010, lato di ritorno indipendente per ogni tubo di collegamento di ingresso.
- `ae5cab7d3b4581ac652718cb44dc5416c75c7b7e` — LG-011, albero di collegamento idraulico: mandata input utente, ritorno generato dall'algoritmo.
- `d235a60b89d26dbdaf6198716822659ef1c613e5` — LG-012, radice del ritorno a 0,50 m e parallela alla parete architettonica più vicina.
- `34a82b9e885a230623509e17fa395d4bd8e2275a` — LG-013, primo tratto nella direzione del tubo di collegamento (rettifica LG-013); parallelismo obbligatorio dal secondo tratto.
- `ed9ae3ce976969623b3dae9ecd33540ff1589cb1` — LG-014, ritorno nel corridoio segue la mandata quando possibile e salta le evoluzioni impossibili.
- `e5a25a64eb7b5c1e637c6921ad4362da1834efc3` — LG-015, configurazione terminale mandata/ritorno e derivazione della scelta iniziale della spirale.
- `1b28cef915a91a19f5a35aeab08c6a86e049211e` — LG-016, scelta di prosecuzione rettilinea nella direzione di provenienza fino al primo ostacolo frontale.
- `d4918352f17733af8cae7b6d2ff86dea55a7791a` — precisazione LG-016: `PROSEGUI_DRITTO` è deroga esplicita al parallelismo con altre linee.
- `613dddd87fe4c980378046eaa685276d07aef7c6` — LG-017, linea frontale obbligatoria e troncamento del nuovo tratto alla distanza di rispetto.
- `d56f19c963a0a2fd350f019df7f7189f4d06e64d` — LG-018, flusso generale StrategiaDiego dalla rete di ritorno alla generazione definitiva.
- `f998d9a814cbc018c2ea5bcf64d25cd840af9226` — LG-019, evoluzione test-driven delle linee guida StrategiaDiego.
- `6d799d813e48a7d3871f3e5c7e995caacc62fe8e` — LG-020, riferimento sussidiario a Spirali Vittorio e Spirali GPT per aspetti non ancora definiti.
- `9da82a4b2ebe7da71913dd8d862a86414744352b` — LG-021, enumerazione completa delle linee di riferimento a ogni nodo.
- `0b001e6d3ca2c8b4122523fffb5023fb059822bf` — LG-022, direzione di provenienza ed estremo libero del tubo di collegamento.
- `fa8fc74265bbebc95b4416578bcda2ffd530b8e2` — LG-023, riferimento di parallelismo vincolato alla linea che ha troncato il tratto precedente; LG-021 rettificata.
- `ac362fc3ac48e038d919e9d368382cef22085115` — LG-024, generazione di entrambi i versi della nuova parallela senza potatura predittiva.
- `1ddaa84f865d1c3db1a0096a1b66bc901f9a8a4b` — LG-025, condizione di terminale dell'albero di mandata.
- `a680230894848e9c4b1777a0d63b959b863fc7f0` — LG-026, origine della spirale di ritorno dal tubo di collegamento di ritorno già generato.
- `ff8a1912882d1fa76e4e93db5ad614b094ff3c0a` — LG-027, stessa strategia di nodo condivisa da mandata e ritorno.
- `837a3148ce97d34d1e97207383fa3da159ed1a74` — LG-028, sottoalbero di ritorno distinto per ogni terminale della mandata e metriche di sostenibilità computazionale.
- `487553ad051c94f975045c94ced5b14c9920b37d` — LG-029, valutazione preliminare della chiusura tramite segmento diretto e futura verifica avanzata.
- `52f42a221bda4f479285d2e6d0654c29c85d0533` — LG-030, classificazione di StrategiaDiego come strategia computazionalmente pesante e selezionabile.
- `6c209c4db9c44ac8db05cfafb9eb9992fe6b6e76` — LG-031, geometria vincolante per ciascun ramo di ritorno.
- `34f691165cfd6a0e9f6509162e51ad455cf78013` — LG-032, geometria vincolante isolata per ciascun ramo di mandata.
- `6d14e0f98141f97a08fabd1401bd5ea1302ece17` — rettifica LG-013/LG-022: primo tratto allineato al tubo di collegamento entrante, con punto finale libero, per mandata e ritorno.
- `b21f2810bcb2fe2cf941539dc7c7c9f9fec6dd21` — LG-033, principio di inseguimento progressivo dei tratti della precedente evoluzione nei percorsi convessi.
- `3d2f21e49fae63ba36c5f60625d79089dfea4ce3` — prima formulazione LG-034, troncatura `-d/+d` per concavo/convesso; successivamente precisata per geometrie non ortogonali.
- `f51c468fc58cd42a48a18f5dc6696322ebcf07b0` — precisazione LG-034 e nuova LG-035 dopo confronto Vittorio/GPT: costruzione esatta tramite parallele offset e classificazione code-ready concavo/convesso.


### INCARICO 2026-09-24 — Pianta pulita persistente come artifact di progetto
Stato: ESEGUITO

Commissionato:
- verificare e mantenere attivo il percorso storico `LeggiDxf -> GeneraPianta` che, in modalità 2 sui piani calpestabili, produce la pianta architettonica derivata dal modello;
- denominare funzionalmente questo elaborato **Pianta pulita**;
- conservare nel Core l'output SVG già equivalente alla pianta DXF storica, formato `TERMODEL-CLEAN-FLOOR-SVG-V1`;
- trasferire tutte le piante pulite prodotte da una elaborazione nel `ProjectCalculationData` e pubblicarle atomicamente nel workspace del relativo `projectId`;
- esporre ogni piano tramite `GET /api/projects/{projectId}/artifacts/pianta-pulita/{piano}`, senza rieseguire il calcolo;
- rendere gli SVG reperibili anche dal catalogo universale `generated-files`;
- mantenere compatibile il legacy `GET /api/model/clean-floor/{floorName}`;
- aggiungere regression HTTP automatica che verifichi generazione, persistenza, catalogo e lettura dell'SVG;
- non modificare frontend, Library Desktop o `definizionedati.json`.

Risultato:
- verificato il percorso reale `GeneraModello -> LeggiDxf.LeggiFileDxf(..., modo 2, ...) -> GeneraPianta` sui piani calpestabili;
- la copia headless di `GeneraPianta.SalvaDXF()` continua a produrre l'SVG canonico `TERMODEL-CLEAN-FLOOR-SVG-V1`, unità cm, senza modificare la Library Desktop;
- `Model3DGenerationResult.CleanFloorPlans` viene ora trasferito in `ProjectCalculationData`;
- `ProjectStore` salva atomicamente ogni SVG sotto `artifacts/pianta-pulita/`, con nome fisico deterministico derivato dal nome logico del piano;
- `POST /api/calculations` elenca le Piante pulite tra gli artifact della risposta, con `floorName` e href projectId-scoped;
- implementato `GET /api/projects/{projectId}/artifacts/pianta-pulita/{piano}`, che restituisce `image/svg+xml`, header stale coerente e non riesegue il calcolo;
- gli stessi SVG sono automaticamente visibili nel canale universale `GET /api/projects/{projectId}/generated-files`;
- il legacy `GET /api/model/clean-floor/{floorName}` è rimasto invariato e compatibile;
- `calculation.log` registra `cleanFloorPlanCount`;
- contratto condiviso aggiornato a **v1.23**;
- frontend, Library Desktop e `definizionedati.json` non modificati.

Verifica:
- progetto regression reale `RadiantPanelsReference`, piano `Unico`;
- GitHub Actions run **#343**, id `36012889814`, job `107677835677`: **SUCCESS**;
- build Release: SUCCESS;
- smoke HTTP/storage/lock, feedback, esecutivo SVG/DXF e snapshot: SUCCESS;
- marker `CLEAN_FLOOR_ARTIFACT_OK`: SUCCESS;
- marker `RADIANT_REFERENCE_PROJECT_OK`: SUCCESS;
- verificati persistenza del file, catalogo `generated-files`, endpoint HTTP 200, `Content-Type: image/svg+xml`, marker SVG canonici e identità del contenuto;
- verificato che i GET non cambino i timestamp di `calculation.log` o dell'SVG: nessun ricalcolo/riscrittura in lettura;
- stato finale `TERMODEL_JOB_STATUS=SUCCESS`;
- notifica telefono `PHONE_NOTIFICATION_SENT status=SUCCESS`;
- prova manuale Visual Studio/browser locale: non eseguita in questa sessione.

Commit principali:
- `16279e6239ab7d22b9c0c9d0b153d652115256ff` — registrazione incarico;
- `149ce02891900adfbe48373833ddcfc48abce629` — contratto v1.23;
- `ef4cd8073a184ef1d87c470a97c4150983d9a507` — persistenza artifact + endpoint + regression;
- `11c6091ec653571dbe10e2b3a849db2f6603582b` — correzione header HTTP;
- `8efdb3329eb30eb2ac962ed6e1dd8a3d2001e71f` — regression finale valida.


### INCARICO 2026-09-24 — registro strategie geometriche SpiraliGPT
Stato: ESEGUITO

Commissionato:
- creare un registro Git dedicato alle decisioni strategiche geometriche per pannelli/SpiraliGPT, distinto dal catalogo storico dei pattern difettosi;
- registrare come prima regola il caso osservato sul progetto regression pannelli: **imbottigliamento / collo di bottiglia selettivo**;
- conservare per ogni regola testo, immagine di riferimento, motivazione e criteri di verifica;
- formalizzare la strategia indicata dall'utente: il ritorno blu può superare il collo quando può entrare e uscire; la mandata rossa deve evitare di impegnare una regione oltre il collo quando, una volta entrata, non può proseguire e richiudersi correttamente;
- usare il registro come vincolo di regressione per future strategie geometriche;
- non modificare in questo incarico l'algoritmo SpiraliGPT, la Library Desktop o `definizionedati.json`.

Risultato:
- creato `Server/Termodelwebservice/docs/spirali-strategy-register/README.md` come indice autorevole;
- creata `STRATEGY-001-imbottigliamento-selettivo.md` con stato **ATTIVA**;
- conservato lo screenshot utente in `images/STRATEGY-001-imbottigliamento-selettivo.png`;
- creato `TEMPLATE.md` per le future decisioni strategiche;
- formalizzata la distinzione tra area geometricamente raggiungibile e area validamente copribile dalla mandata;
- formalizzato che il ritorno può attraversare il collo quando dispone di continuità di ingresso/uscita, mentre la mandata deve evitare la regione oltre il collo quando l'ingresso la renderebbe topologicamente intrappolata;
- specificato che la scheda non impone ancora una soglia numerica o un algoritmo particolare: impone il comportamento da preservare;
- collegato STRATEGY-001 al progetto regression `RadiantPanelsReference` e al runner `smoke-radiant-reference.ps1`;
- mantenuto separato il registro strategico dal catalogo consultivo `SorgentiTermodel/Library/Impianti/Pannelli/SpiraliGPT/PatternDifettosi/`.

Verifica:
- file Markdown riletti da `main`;
- immagine PNG riletta da GitHub come blob base64 valido;
- nessuna modifica a Core, WebService runtime, frontend, Library Desktop o `definizionedati.json`;
- non è stato modificato l'algoritmo: questo incarico consolida soltanto la strategia che i successivi interventi dovranno rispettare.

Commit:
- `99c270f5de712309888631fd07ef2e5544eb79ef` — registrazione incarico;
- `5911d0977c119b0540851efe8380e98271f0cc8f` — registro, STRATEGY-001, template e immagine.



### INCARICO 2026-09-24 — ritorno apertura/salvataggio progetti al frontend
Stato: ESEGUITO

Commissionato:
- rendere nuovamente `File → Apri`, `Salva` e `Salva con nome` completamente locali al frontend, usando il file unico `TERMODEL-PROJECT-TEXT-V1`;
- eliminare dal frontend corrente la dipendenza da elenco progetti, open/save server, lock, heartbeat e allocate-id;
- mantenere Render/Termodel.WebService come motore di calcolo e sorgente degli artifact, non come archivio autorevole dei progetti;
- rendere `POST /api/calculations` autosufficiente anche quando il `projectId` non esiste ancora nel filesystem del Service o è stato perso dopo redeploy;
- generare localmente un UUID nel frontend quando il manifest non contiene `projectId`;
- mantenere compatibili gli endpoint legacy di gestione progetto senza usarli nel flusso frontend corrente;
- non modificare `definizionedati.json` né la Library Desktop.

Risultato:
- frontend portato a **v1.12**: `Apri...` usa il file picker locale; `Salva` e `Salva con nome` scaricano localmente il file unico;
- rimossi dal frontend corrente lock token, heartbeat, close, open/save server e `allocate-id`;
- il `projectId` viene letto dal manifest oppure generato localmente come UUID tecnico;
- `Aggiorna Modello` invia direttamente il progetto completo senza header lock;
- `POST /api/calculations` non richiede più `ProjectLockManager` e `ProjectStore.UpdateCurrentAsync` crea/ricrea il workspace anche per un projectId mai allocato;
- gli endpoint server legacy di open/save/lock restano disponibili e i relativi smoke test continuano a passare;
- caricando/creando un progetto locale vengono invalidati soltanto manifest/overlay transienti degli artifact server;
- il comando CAD per caricare l'esecutivo server resta disabilitato finché la sessione corrente non ha completato un nuovo calcolo;
- contratto condiviso aggiornato a **v1.21** con file locale come copia autorevole e workspace Render ricreabile.

Verifica:
- GitHub Actions run `35980223478`, job `107570267161`: **SUCCESS**;
- `node --check docs/termodel-ui-demo/app.js`: SUCCESS;
- build Release `Termodel.WebService.sln`: SUCCESS;
- smoke `LOCAL_PROJECT_CALCULATION_SMOKE_OK`: un projectId locale non allocato, senza open/lock, crea il workspace e rende disponibile `model3d`;
- smoke legacy `PROJECT_LOCK_SMOKE_OK`: SUCCESS, quindi compatibilità endpoint storici conservata;
- smoke feedback, esecutivo pannelli SVG/DXF, progetto reale pannelli e snapshot GitHub: SUCCESS;
- stato finale workflow: `TERMODEL_JOB_STATUS=SUCCESS`; notifica telefono: `PHONE_NOTIFICATION_SENT status=SUCCESS`;
- prova manuale interattiva Apri/Salva nel browser non eseguita da questa sessione: la verifica raggiunta è sorgente + CI + smoke HTTP.

Commit principali dell'intervento:
- `c1a0cfcd982e6be4b8569cbee564807820f0766b` — Restore local project open and save;
- `c6bf70ceefbc8d3662af31230f20ec9859914050` — Make calculations independent of project locks;
- `c797a5ad3b8c560b60e05b2ee2a0dd8a66a28a3d` — Allow calculations to recreate missing workspaces;
- `bad21112326440570823f26d41112c1107ed2e5c` — frontend v1.12;
- `f521c0a04567747046af581e9ba80ce1a8c800c4` / `166189e558a17bd0a50b4b2c5b9970bdd46d5534` — regression CI lock-free e correzione lista legacy;
- `7a99c29438fd996f9c780b6dd80e7ba242fb9bbe` — contratto v1.21 coerente con autorità locale.


### INCARICO 2026-09-24 — progetto regression reale pannelli radianti
Stato: ESEGUITO

Commissionato:
- consolidare su GitHub il progetto reale `TERMODEL-PROJECT-TEXT-V1` fornito dall'utente come fixture permanente per il calcolo pannelli radianti;
- analizzare integralmente progetto, archivi Reti/TipologiePannelli, geometria edificio e rete Tubo Txxx;
- eseguire il progetto reale contro il Service tramite GitHub Actions, raccogliendo `pannelli.json`, esecutivo SVG/DXF e log;
- correggere eventuali difetti del progetto fixture quando i dati risultano incoerenti o corrotti;
- correggere il CAD/frontend se il progetto dimostra che il disegno generato dal CAD 2D è difettoso;
- introdurre un regression test permanente sul progetto reale, senza modificare `definizionedati.json` né la Library Desktop;
- seguire le notifiche obbligatorie GitHub Actions tramite `Termodel/job`.

Analisi del progetto reale:
- file ricevuto: 987.311 byte, 34.125 righe, 33 sezioni;
- SHA-256 byte-per-byte CRLF ricevuto: `a2b5ddce40059ecae852ca572491bca230a1a95ecce376f8d2e69a43c0196411`;
- SHA-256 dello stesso contenuto normalizzato LF: `4af2675d670ed039f00d36e9c3fc82061db27a3c19cb4e5451faa69f3ebfe87a`;
- le impronte di tutte le sezioni dichiarate nel manifest coincidono con il contenuto normalizzato LF: il contenitore non risulta corrotto;
- rete `RAD-DEFAULT`: PannelliRadianti, tipologia `GEN-DEFAULT`, passo 300 mm, acqua 35/30 °C, ambiente 20 °C, diametro interno 12 mm, limite 100 m / 25.000 Pa;
- geometria Tubo: 12 segmenti `T002..T013`, layer `Unico_tubipannelli`, tutti associati a `RAD-DEFAULT`;
- la mancanza di `T001` è compatibile con una cancellazione CAD ed è stata classificata come non errore: gli ID non devono essere contigui;
- lunghezza centerline complessiva misurata: **19,599780842518 m**.

Difetto reale individuato:
- sei sequenze Tubo distinte condividono il punto di collettore `(583.349, 474.316) cm`;
- il CAD precedente salvava rete/piano/layer, ma non l'identità della sequenza/circuito;
- il Core precedente raggruppava esclusivamente per connettività geometrica entro 1 mm, quindi i 12 segmenti diventavano **un solo componente ramificato** invece di sei circuiti;
- il difetto è di contratto CAD→Core, non delle coordinate disegnate: spostare artificialmente i punti del collettore sarebbe stata una correzione geometrica sbagliata.

Correzione progetto/fixture:
- fixture permanente conservata in quattro parti UTF-8 LF sotto `tests/fixtures/RadiantPanelsReference.original.part01..04.txt`, con entrambe le impronte CRLF/LF documentate;
- `RadiantPanelsReference.circuit-map.json` registra la correzione semantica autorevole del progetto reale:
  - C001 = T002;
  - C002 = T003,T004;
  - C003 = T005,T006;
  - C004 = T007;
  - C005 = T008,T009;
  - C006 = T010,T011,T012,T013;
- la correzione non modifica coordinate o lunghezze del progetto; aggiunge soltanto l'identità circuito mancante;
- `README-RadiantPanelsReference.md` documenta provenienza, hash, topologia, distinzione progetto locale/payload Service e criteri regression.

Correzione CAD/frontend:
- frontend portato a **v1.11**;
- ogni nuova sequenza `Tubo` riceve ora `data-termodel-circuito="Cnnn"`;
- tutti i segmenti della stessa sequenza mantengono lo stesso circuito, inclusa la chiusura;
- una nuova sequenza ottiene un nuovo circuito anche quando parte con Snap Vicino/Estremo da un tubo/punto collettore già esistente;
- il metadato viene conservato dal normale `buildTermodelServerPayload()`; non è stato introdotto un formato progetto parallelo.

Correzione Core:
- `SvgDxfLineMetadata` conserva ora anche `CircuitCode` letto da `data-termodel-circuito`;
- `RadiantPanelCalculator` dà precedenza al circuito dichiarato dal CAD;
- circuiti dichiarati distinti possono condividere geometricamente il punto collettore senza essere fusi;
- se uno stesso circuito dichiarato contiene componenti disconnesse, il Core le separa e produce diagnostica;
- per i progetti legacy senza `data-termodel-circuito` resta il fallback storico per connettività geometrica;
- non è stato anticipato il grafo generalista Tubi: collettore topologico, percorso sfavorito, sizing, equilibratura e perdite concentrate restano nella futura fase Tubi universale.

Regression permanente:
- aggiunto `tools/smoke-radiant-reference.ps1` e collegato a `.github/workflows/termodel-service-build.yml`;
- il test ricompone la fixture, applica la mappa di correzione al progetto legacy, riproduce la canonicalizzazione frontend `TERMODEL-PROJECT-SVG-V1`, avvia realmente il Service e chiama `POST /api/calculations`;
- verifica 1 rete, **6 circuiti**, segment count per circuito, assenza di ramificazioni, lunghezze golden, valori idraulici positivi e lunghezza totale 19,599780842518 m;
- raccoglie come artifact CI progetto corretto, payload Service, `pannelli.json`, `pannelli-esecutivo.svg`, `pannelli-esecutivo.dxf`, `TermodelLog.md`, diagnostics e calculation.log;
- artifact reale del run verde: esecutivo SVG 25.991 byte, DXF 28.843 byte, **58 primitive**; calculation.log registra `radiantPanelCircuitCount=6`, `radiantExecutivePrimitiveCount=58`, `radiantExecutiveFloorCount=1`.

Verifica reale:
- primo run con nuovo regression, GitHub Actions **#318**, id `35978711969`: build e smoke preesistenti riusciti; regression nuovo fermato da un errore sintattico PowerShell nel solo script di test (`$wantedId:`), corretto senza modificare l'algoritmo; stato/notifica terminale FAILED eseguiti;
- GitHub Actions **#320**, id `35979205131`, commit `90baf12...`: **SUCCESS**;
- Build Release: **SUCCESS, 0 errori**;
- smoke HTTP/storage/lock preesistenti: SUCCESS;
- smoke esecutivo pannelli sintetico: SUCCESS;
- regression progetto reale: `RADIANT_REFERENCE_PROJECT_OK`;
- risultato reale: `networkCount=1`, `circuitCount=6`, `totalLengthM=19.599780842518`;
- artifact diagnostico `radiant-reference-regression` pubblicato con 10 file e ispezionato;
- Commit Status `Termodel/job=SUCCESS` e `PHONE_NOTIFICATION_SENT status=SUCCESS` verificati nello stesso run;
- compilazione/esecuzione Visual Studio locale dell'utente: NON ancora eseguita in questa chat;
- confronto con riferimento: SI per la topologia ricostruita dal progetto reale e le lunghezze centerline; NON è dichiarata equivalenza completa col futuro solver Tubi universale.

Contratto/documentazione:
- `docs/TERMODEL-FRONT-SERVICE-CONTRACT.md` aggiornato a **v1.20** con `data-termodel-circuito`, precedenza circuito esplicito e fallback legacy;
- `docs/TUBAZIONI-DEVELOPMENT-REGISTER.md` registra la milestone e mantiene separato il futuro grafo generalista.

Vincoli rispettati:
- `definizionedati.json` non modificato;
- Library Desktop non modificata;
- nessun nuovo formato concorrente a `TERMODEL-PROJECT-TEXT-V1`;
- geometria T002..T013 non alterata per mascherare il difetto topologico.

Commit principali:
- `c6de98a1...` — registrazione incarico;
- `bc7d2445...`, `0e09f92f...`, `2274cd5d...`, `ccc21870...` — fixture reale consolidata;
- `1eb7d026...` — CircuitCode nel Virtual CAD;
- `ac095f3b...` — solver per circuito dichiarato + fallback legacy;
- `4494a142...`, `20c0681c...` — CAD v1.11 con identità circuito;
- `b9f8df62...` — contratto v1.20;
- `3d177282...`, `db075dc1...` — mappa/README fixture;
- `c964e36d...`, `cc1b6a3f...` — regression reale e workflow;
- `90baf12b...` — fix sintassi regression, run #320 verde;
- `c36b7505...` — registro Tubazioni;
- `6f890661...`, `6a5836db...` — robustezza hash fixture e documentazione hash CRLF/LF.

### INCARICO 2026-09-24 — selezione e cancellazione Tubo CAD 2D
Stato: ESEGUITO

Commissionato:
- in modalità `Rete` rendere selezionabili con click le entità `Tubo` Txxx già disegnate sul piano corrente;
- abilitare il pulsante `Elimina` quando è selezionato un tubo e cancellare soltanto quel segmento dal `geometry/project.svg`;
- mantenere invariata la selezione/cancellazione delle pareti E/W in modalità `Edificio`;
- non estendere implicitamente ai tubi il drag/modifica geometrica delle pareti: l'obiettivo corrente è selezione + cancellazione;
- preservare undo/redo e il normale flusso `Consolida rete`;
- modifica limitata al frontend `docs/termodel-ui-demo`, senza toccare Service/Core, contratto API, `definizionedati.json` o Library Desktop;
- incrementare versione/cache busting frontend e verificare staticamente il percorso.

Risultato:
- individuata la causa: il renderer marcava come editabili/selezionabili soltanto le linee E/W; inoltre `cadSelectLine`, `cadUpdateControls`, `cadSyncOverlay` e `cadDeleteSelected` usavano `cadFindSourceLine()`, che rifiuta correttamente le entità Txxx;
- aggiunta `cadFindSelectableLine()`: in modalità `Rete` accetta soltanto i tubi del piano corrente, in modalità `Edificio` continua ad accettare soltanto le pareti E/W;
- il renderer rende cliccabili i Txxx soltanto quando `Modalità=Rete`; le pareti restano non selezionabili in tale modalità;
- il click su un tubo imposta `cadSelectedLineId`, applica l'evidenziazione `selected` e abilita `× Elimina`;
- la cancellazione rimuove soltanto il segmento selezionato dal documento SVG, mantiene undo/redo e mostra `Tubo Txxx eliminato · premi Consolida rete`;
- il drag geometrico delle pareti non è stato esteso ai tubi: dopo la selezione Txxx il percorso drag continua intenzionalmente a richiedere `cadFindSourceLine()`;
- tooltip del comando Elimina reso contestuale: tubo in modalità Rete, parete in modalità Edificio;
- frontend portato a **v1.10** con titolo e `app.js?v=1.10` per cache busting;
- Service/Core, contratto API, `definizionedati.json` e Library Desktop non modificati.

Verifica:
- sorgente GitHub ricontrollato dopo le modifiche;
- verificato staticamente che `cadFindSelectableLine()` accetti Txxx soltanto in modalità Rete;
- verificato che il renderer usi `cadIsPipeLine(line)` per rendere i tubi selezionabili in Rete e E/W in Edificio;
- verificato che `cadUpdateControls()` abiliti Elimina usando la selezione contestuale;
- verificato che `cadDeleteSelected()` rimuova la linea contestuale selezionata e produca feedback specifico Tubo/Parete;
- verificato che il drag dei tubi resti disattivato perché la routine di trascinamento continua a richiedere una parete E/W;
- verificati `APP_VERSION='1.10'`, titolo v1.10 e cache busting v1.10;
- compilazione: non applicabile al frontend statico JavaScript;
- esecuzione/test browser reale: NON ancora eseguito in questa chat.

Commit:
- `96996394...` — registrazione incarico;
- `0001127c...` — selezione/cancellazione tubo + versione app 1.10;
- `06384767...` — titolo/cache busting frontend 1.10;
- `b8d40583...` — tooltip Elimina contestuale.

### INCARICO 2026-09-24 — snap Vicino/Estremo sui tubi CAD 2D
Stato: ESEGUITO

Commissionato:
- correggere il CAD 2D in modalità `Rete`: durante il disegno `Tubo`, gli snap `Vicino` e `Estremo` devono agganciarsi ai tubi già disegnati sul piano corrente;
- mantenere invariata la modalità `Edificio`, dove gli snap continuano a usare le pareti E/W;
- mantenere invariato lo snap allo sfondo vettoriale;
- applicare la modifica minima al frontend `docs/termodel-ui-demo`, senza toccare Service/Core, contratto API, `definizionedati.json` o Library Desktop;
- incrementare la versione/cache busting frontend e verificare staticamente il percorso di snap.

Risultato:
- individuata la causa: `cadSnapPoint()` iterava esclusivamente su `cadEditableSourceLines()`, che contiene solo pareti E/W; le entità `Tubo` Txxx erano quindi escluse dallo snap;
- aggiunta `cadSnapSourceLines()`: in modalità `Edificio` restituisce le pareti E/W del piano corrente, in modalità `Rete` restituisce i tubi Txxx del piano corrente;
- `cadSnapPoint()` usa ora la sorgente contestuale e distingue internamente `wall` / `pipe`, mantenendo lo snap allo sfondo vettoriale invariato;
- `Snap Estremo` può agganciare gli endpoint dei tubi già disegnati;
- `Snap Vicino` può agganciare la proiezione sul segmento tubo già disegnato;
- il normale vincolo `Orto` resta invariato: quando attivo, uno snap incompatibile con l'asse ortogonale continua correttamente a non prevalere;
- frontend portato a **v1.09**; titolo e query `app.js?v=1.09` aggiornati per cache busting;
- Service/Core, contratto API, `definizionedati.json` e Library Desktop non modificati.

Verifica:
- sorgente GitHub ricontrollato dopo la modifica;
- verificato staticamente che in modalità Rete la sorgente snap sia `cadAllPipeLines().filter(cadEntityBelongsToCurrentPlane)`;
- verificato staticamente che in modalità Edificio resti `cadEditableSourceLines()`;
- verificato che `targetLineId` accetti sia sorgenti `wall` sia `pipe`;
- verificati `APP_VERSION='1.09'`, titolo v1.09 e cache busting v1.09;
- compilazione: non applicabile al frontend statico JavaScript;
- esecuzione/test browser reale: NON ancora eseguito in questa chat;
- deploy GitHub Pages associato al commit: non ancora osservato al momento della chiusura dell'incarico.

Commit:
- `646321df...` — registrazione incarico;
- `810fbac1...` — correzione snap contestuale pareti/tubi + versione app 1.09;
- `73a58e1f...` — titolo/cache busting frontend 1.09.

### INCARICO 2026-09-24 — pulsante versione desktop completa dalla main mobile
Stato: ESEGUITO

Commissionato:
- nella main Android/mobile aggiungere accanto al pulsante `Esplora` un piccolo pulsante con icona monitor per passare volontariamente alla versione completa desktop;
- il comando deve disattivare la modalità immersiva Android esistente, mostrare barre/menu/pannelli desktop reali e usare una viewport logica desktop, senza duplicare l'interfaccia;
- la modifica riguarda soltanto `docs/termodel-ui-demo`; non modificare Service, Core, contratto API, `definizionedati.json` o Library Desktop;
- preservare il comportamento mobile attuale finché l'utente non preme il nuovo pulsante.

Risultato:
- `docs/termodel-ui-demo/app.js`: aggiunto accanto a `Esplora` il pulsante compatto `androidFullDesktop` con icona SVG monitor e descrizione accessibile “Versione completa desktop”;
- il click chiude l'eventuale menu Esplora e chiama `enableTermodelFullDesktopLayout()`;
- il passaggio rimuove la classe `termodel-android`, mantiene un flag che impedisce ai successivi eventi resize/orientation di riapplicare gli override immersivi e pulisce le altezze/grid inline impostate dalla modalità Android;
- la meta viewport viene portata a **1100 px logici**, oltre tutte le breakpoint responsive correnti (massimo 900/820 px), così il tablet usa la UI desktop completa invece delle regole mobile;
- nessuna UI desktop è stata duplicata: vengono semplicemente rese nuovamente visibili titlebar, menubar, tabs, bottom bar e pannelli già esistenti;
- frontend portato a **v1.08**, titolo statico e `app.js?v=1.08` aggiornati.

Verifica:
- sorgente GitHub ricontrollato dopo i commit: pulsante presente subito dopo `Esplora`, listener presente e collegato alla funzione di passaggio desktop;
- controllo statico delle breakpoint: viewport 1100 px supera le soglie responsive presenti in `index.html`;
- compilazione: non applicabile al frontend statico JavaScript;
- esecuzione browser/tablet reale: NON ancora verificata in questa chat;
- test visuale su dispositivo Android/tablet: NON ancora eseguito;
- Service/Core/contratto API/`definizionedati.json`/Library Desktop: non modificati.

Commit:
- `91f456d6...` — registrazione incarico;
- `d2e6db82...` — pulsante e logica passaggio alla UI desktop completa;
- `a10a56af...` — versione/cache busting frontend 1.08.

### INCARICO 2026-09-24 — feedback DXF non deve deformare la toolbar CAD 2D
Stato: ESEGUITO

Segnalazione reale:
- screenshot utente con Termodel CAD 2D v1.06 dopo importazione DXF;
- il messaggio arancione completo `DXF convertito dal Service ...` occupava
  larghezza propria nella toolbar e invadeva visivamente i comandi successivi
  (`Esporta pianta CAD` / `Torna al modello 3d`).

Causa:
- `.cad-toolbar .cad-status` aveva `white-space: nowrap` e una
  `min-width`, ma nessun limite desktop di larghezza/overflow;
- un feedback diagnostico lungo poteva quindi diventare il principale elemento
  flessibile della barra.

Correzione:
- `docs/termodel-ui-demo/index.html`:
  - status CAD: `flex: 0 1 340px`;
  - `min-width: 120px`, `max-width: 340px`;
  - `overflow: hidden` e `text-overflow: ellipsis`;
  - resta `white-space: nowrap`, quindi la toolbar mantiene una sola riga;
- `docs/termodel-ui-demo/app.js`:
  - `cadSetStatus()` normalizza il testo e copia sempre il messaggio completo
    in `title`, quindi l'ellissi non perde l'informazione;
- versione frontend portata da **1.06 a 1.07** e query
  `app.js?v=1.07` per cache busting;
- nessuna modifica all'algoritmo DXF→SVG, al contratto API, ai dati progetto o
  a `definizionedati.json`.

Commit:
- `2d7a9a99...` — limite/ellissi dello status + cache busting;
- `bc40549a...` — tooltip completo e versione frontend 1.07.

Verifica:
- diagnosi effettuata sullo screenshot reale dell'utente;
- sorgente GitHub ricontrollato dopo la modifica: il feedback lungo non può più
  superare 340 px su desktop ed è troncato con ellissi;
- messaggio integrale resta disponibile nel tooltip;
- GitHub Actions Service dell'incarico preliminare: run `35968135152`,
  `Termodel/job = SUCCESS`;
- verifica visuale finale sul browser dell'utente dopo aggiornamento GitHub
  Pages/cache: NON ancora eseguita in questa chat.


### INCARICO 2026-09-24 — Farmacia.dxf come regression fixture e ottimizzazione pianta architettonica
Stato: ESEGUITO

Commissionato:
- consolidare nel repository GitHub il DXF reale fornito dall'utente, `Farmacia.dxf`, come fixture permanente per i test DXF→SVG;
- usare il file reale per misurare layer, entità, unità, bounding box e qualità dello SVG prodotto;
- ottimizzare `Termodel.Core.Cad.DxfSvgConverter` affinché produca un profilo automatico di pianta architettonica intellegibile, preservando la modalità manuale;
- aggiungere regression test GitHub Actions basati sul DXF reale;
- non modificare `definizionedati.json` né la Library Desktop.

Fixture consolidata:
- originale ricevuto: `Farmacia.dxf`, **3.225.548 byte**, SHA-256
  `81b7e14c361b0b5de94a877c715091b77a42f599c6a757ca1fc2906251496adc`;
- per limitare il peso Git senza perdere un solo byte, la fixture è conservata
  lossless come
  `Server/Termodelwebservice/tests/fixtures/Farmacia.dxf.gz.b64`;
- il workflow esegue Base64 decode + gzip decompress e verifica lo SHA-256
  dell'originale prima di ogni test;
- documentazione fixture:
  `Server/Termodelwebservice/tests/fixtures/README-Farmacia.md`;
- il file originale dichiara `$INSUNITS=6` (metri), contiene 382 entità
  principali e i layer operativi `0`, `01-SEZIONI`,
  `02-PROIEZIONI`, `03-QUOTE`, `04-RETINI`.

Ottimizzazione implementata:
- `DxfSvgConversionOptions` supporta ora `Profile` con valori
  `manual` e `architectural`; default API storico: `manual`;
- nel profilo `architectural` il Core seleziona automaticamente i layer
  geometrici utili e filtra nomi tipicamente annotativi/non architettonici
  (quote/dimensioni, retini/hatch, testi/scritte, arredi/furniture,
  figure, Defpoints);
- viene filtrato anche un layer in cui quote/testi/retini prevalgono
  numericamente sulla geometria utile;
- il profilo architettonico abilita automaticamente curve e bulge anche se
  `curves=false`, così porte, archi e aperture restano leggibili;
- i gruppi SVG dichiarano `data-dxf-role=section|projection|base` e usano una
  lieve gerarchia di spessore: sezioni/muri/strutture più marcati,
  proiezioni/infissi più leggeri;
- la radice SVG dichiara `data-termodel-dxf-profile`;
- la risposta API aggiunge `profile` e `appliedLayers`;
- `DxfToSvgRequest` espone il nuovo campo `profile`;
- modalità manuale invariata: se il frontend passa `manual`, il Core
  rispetta la selezione esplicita.

Frontend:
- import DXF apre ora di default in profilo **pianta architettonica automatica**;
- curve abilitate di default;
- layer con nomi evidentemente annotativi/arredo vengono deselezionati nel
  dialog;
- se l'utente cambia layer o opzioni grafiche il frontend passa a
  `profile=manual`, preservando il controllo esplicito;
- nessuna conversione SVG è stata reintrodotta nel browser.

Regression reale `Farmacia.dxf`:
- GitHub Actions run `35966250710`, commit `c74604da...`:
  **SUCCESS**, build **0 errori** e
  `FARMACIA_DXF_ARCHITECTURAL_SMOKE_OK`;
- risultato reale Service/Core:
  `appliedLayers = 0, 01-SEZIONI, 02-PROIEZIONI`;
- `03-QUOTE` e `04-RETINI` assenti dall'SVG architettonico;
- **227 entità convertite**;
- unità riconosciuta: metri, `unitScaleToCm=100`;
- ingombro architettonico: **19,050 × 17,153 m**;
- SVG verificato con metadata di profilo e ruoli grafici;
- GitHub Actions run `35966314257`, commit `0e916722...`:
  **SUCCESS**, build **0 errori**, regression Farmacia positiva e artifact
  `dxf-svg-regression` pubblicato;
- artifact reale scaricato e ispezionato dalla chat:
  `Farmacia.architectural.svg`, 23.284 byte, con planimetria chiaramente
  leggibile su fondo bianco: muri, partizioni, porte e archi conservati,
  senza l'espansione del viewBox causata dalle quote/retini;
- metadata artifact:
  `converted=227`, `ignored=155`, `unsupported=0`,
  `widthMeters=19.04993883792071`,
  `heightMeters=17.153186825263063`.

Documentazione:
- contratto Frontend↔Service aggiornato a **v1.19**;
- README Service documenta profilo architettonico e fixture reale;
- `definizionedati.json`, Library Desktop e algoritmo Desktop non modificati.

Stato di verifica:
- **progettato:** SI;
- **implementato:** SI;
- **fixture reale consolidata:** SI, con hash dell'originale verificato;
- **compilato GitHub Actions:** SI, 0 errori;
- **eseguito/testato via HTTP:** SI;
- **regression sul DXF Farmacia reale:** SI;
- **output SVG reale ispezionato visivamente:** SI;
- **compilato/eseguito in Visual Studio locale dell'utente:** NON ancora
  verificato in questa chat.

Commit principali:
- `06c4a4b0...` — registrazione incarico;
- `10f7104e...` — fixture Farmacia lossless;
- `564d80e0...` — documentazione fixture;
- `6cc63b01...` — profilo architettonico nel Core;
- `2f4e47ef...` — esposizione profilo nell'API;
- `7d155abf...` — default frontend architettonico;
- `c74604da...` — regression Farmacia;
- `0e916722...` — artifact SVG di regression;
- `6abcc42d...` — contratto v1.19;
- `ff2c3e27...` — README Service.


### INCARICO 2026-09-24 — spostamento conversione DXF→SVG dal frontend al Service
Stato: ESEGUITO

Commissionato:
- spostare la conversione DXF→SVG attualmente implementata in `docs/termodel-ui-demo/dxf-plotter.js` dal browser al backend;
- collocare la logica di conversione headless e riutilizzabile in `Termodel.Core`, lasciando in `Termodel.WebService` soltanto il contratto HTTP/adattatore;
- mantenere nel frontend soltanto l'interfaccia utente e la chiamata al Service, preservando layer selezionati, unità, curve, testi e blocchi;
- non introdurre WPF/Helix nel Core e non modificare `definizionedati.json`.

Implementato:
- nuovo motore headless `Termodel.Core.Cad.DxfSvgConverter` in
  `src/Termodel.Core/Cad/DxfSvgConverter.cs`;
- parser/converter server-side per DXF ASCII 2D con LINE,
  LWPOLYLINE/POLYLINE e, su opzione, ARC/CIRCLE/ELLIPSE/SPLINE,
  TEXT/MTEXT e INSERT/blocchi;
- conservate le convenzioni del precedente converter Web: scelta layer,
  `$INSUNITS`, unità `mm/cm/m`, scala in centimetri Termodel, origine
  normalizzata, `data-dxf-layer`, statistiche, bounds e viewBox;
- nuovo endpoint `POST /api/dxf/to-svg`; payload JSON con DXF originale,
  layer e opzioni; input non convertibile restituisce HTTP 422;
- CORS già globale del Service rende l'endpoint disponibile al frontend
  pubblico autorizzato;
- `docs/termodel-ui-demo/dxf-plotter.js` non esporta più
  `convertDxfToSvg`: resta soltanto l'analizzatore leggero necessario al
  dialog e alla stima preventiva;
- `docs/termodel-ui-demo/app.js` dopo la conferma del dialog chiama il
  Service e usa lo `svgText` restituito per lo sfondo CAD;
- contratto condiviso aggiornato a v1.18 e README Service aggiornato;
- `definizionedati.json` non modificato; nessuna dipendenza WPF/Helix
  introdotta nel Core.

Verifiche reali:
- prima build del porting, commit `5d0f7618...`: FALLITA correttamente in
  GitHub Actions per tre usi di `Math.Hypot` non disponibili nel target;
- correzione distanza con `Math.Sqrt(x*x+y*y)`, commit `1c6cc5e7...`:
  GitHub Actions SUCCESS;
- endpoint WebService, commit `de79f22a...`: build e smoke esistenti
  SUCCESS;
- workflow specifico DXF→SVG corretto nel commit `ba03a748...`;
- GitHub Actions run `35964233556`: **SUCCESS**, build Release
  **0 errori** e smoke HTTP specifico `DXF_TO_SVG_SMOKE_OK`;
- lo smoke invia un DXF ASCII con una LINE sul layer `WALL`, lunga
  `1000 mm`, e verifica risposta server con una entità convertita,
  `drawingUnit=mm`, `unitScaleToCm=0.1`, metadata layer/unità nello SVG
  e `realWidthMeters=1.0`;
- notifica/stato permanente `Termodel/job`: SUCCESS sul run
  `35964233556`.

Stato di verifica:
- **progettato:** SI;
- **implementato:** SI;
- **compilato in GitHub Actions:** SI, 0 errori;
- **eseguito nel runner Windows:** SI;
- **testato via HTTP:** SI, DXF→SVG smoke positivo;
- **frontend privo della conversione SVG locale:** SI;
- **compilato/eseguito nel Visual Studio locale dell'utente:** NON ancora
  verificato in questa chat;
- **confronto golden su DXF reale complesso:** NON ancora eseguito.

Commit principali:
- `67a34f1c...` — registrazione commissione;
- `5d0f7618...` / `1c6cc5e7...` — porting Core e fix .NET;
- `de79f22a...` — endpoint HTTP;
- `c6b2eae9...` / `245a1a66...` — rimozione conversione JS e chiamata Service;
- `0acec410...` — contratto Frontend↔Service v1.18;
- `163ecc67...` / `ba03a748...` — smoke DXF→SVG e correzione workflow;
- `649a510f...` — README Service.

### INCARICO 2026-09-24 — FIN visibili solo dal lato interno
Stato: ESEGUITO

Commissionato:
- riprodurre e correggere il difetto residuo dell'esempio pubblico `Appartamento`: dopo la precedente correzione di orientamento e profondità, le finestre risultano visibili dal lato interno ma ancora coperte/non visibili dal lato esterno;
- verificare congiuntamente offset lungo la normale della parete, verso dell'estrusione, profondità effettiva della FIN e orientamento/facce della mesh headless rispetto al riferimento Desktop;
- intervenire con modifica minima in Core/renderer, senza modificare frontend, `definizionedati.json` o Library Desktop salvo necessità dimostrata;
- verificare con GitHub Actions sull'Appartamento reale e distinguere build, esecuzione HTTP, regressione geometrica e verifica visiva.

Risultato:
- confrontati gli artifact reali GitHub Actions prima e dopo la correzione dello spessore, non soltanto il codice;
- artifact precedente alla correzione (run #259 / id `35955220418`): per F001 la parete E001 occupa lungo la normale circa `-0,34117..-0,21117 m`, mentre la FIN occupa solo `-0,26117..-0,16117 m`; la finestra sporge quindi sul lato interno ma resta circa 8 cm corta rispetto alla faccia esterna. Questo riproduce esattamente il sintomo riferito dall'utente;
- artifact successivo alla correzione (run #270 / id `35956863374`): la stessa FIN occupa `-0,35117..-0,20117 m`; attraversa l'intero spessore della parete e sporge circa 1 cm da entrambe le facce;
- verificato anche il renderer frontend corrente: `docs/termodel-ui-demo/app.js` usa `THREE.DoubleSide`, quindi il difetto non deriva dal back-face culling;
- nessuna ulteriore modifica geometrica è stata applicata: il codice corrente di `main` contiene già la correzione corretta in `Modello.AggiungiFinestra(...)`; aumentare arbitrariamente la profondità avrebbe mascherato un problema di deploy/artifact senza correggerne la causa;
- commit di registrazione incarico: `a6611fc252543ea2a84d72f79b26f14c1b185643`; GitHub Actions su tale stato, run `35961835080`, job `build`: **SUCCESS**;
- diagnosi residua: se nel browser pubblico la FIN è ancora visibile soltanto dall'interno, il modello visualizzato è compatibile con un artifact generato prima del commit `eb2f5479ed986259c0caf6ec312306954c3024ee` oppure con un Service Render non ancora allineato a quel commit; serve rigenerare l'artifact con `Aggiorna Modello` dopo il redeploy corrente;
- verifica diretta del runtime Render pubblico non ottenuta dagli strumenti di questa sessione; pertanto il deploy Render resta distinto dalla build GitHub verificata.

### INCARICO 2026-09-24 — visibilità FIN attraverso lo spessore parete
Stato: ESEGUITO

Commissionato:
- correggere l'esempio pubblico `Appartamento` perché le finestre, pur correttamente dimensionate e orientate nel piano, risultano coperte dalla parete ospite nel rendering 3D;
- verificare spessore e centratura della geometria FIN lungo la normale alla parete, confrontando il comportamento headless con il Desktop autorevole;
- correggere direttamente la causa nel Core/renderer senza modificare frontend, `definizionedati.json` o Library Desktop;
- verificare la correzione con build ed esecuzione reale GitHub Actions sull'Appartamento e controllare numericamente che ogni FIN attraversi lo spessore della parete associata.

Risultato:
- causa isolata in `Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/Model/Modello.cs`, metodo `AggiungiFinestra(..., spessoreParete)`: il parametro con lo spessore reale della parete arrivava correttamente da `LeggiDxf` ma veniva ignorato; la FIN veniva sempre costruita con profondità fissa `SpesPonte = 0,10 m` e centrata sulla linea CAD della parete;
- il renderer headless costruisce invece la parete a partire dalla linea CAD ed estrude lo spessore tutto lungo una normale. Nell'Appartamento reale la parete finestrata misura `0,13 m`: prima della correzione l'intervallo normale della parete era circa `-0,13..0,00 m`, mentre quello della FIN era `-0,05..+0,05 m`; il serramento non raggiungeva quindi la faccia opposta della parete e poteva risultare completamente coperto dalla mesh opaca osservando quel lato;
- correzione headless: `AggiungiFinestra` usa ora `abs(spessoreParete)`, calcola la stessa normale usata dall'estrusione parete, sposta il centro FIN di metà spessore nella parete e assegna profondità `max(0,10 m, spessoreParete + 0,02 m)`; il centimetro aggiuntivo per faccia evita z-fighting/copertura esatta;
- sull'Appartamento la FIN risultante è profonda `0,15 m` e occupa circa `-0,14..+0,01 m` rispetto alla linea della parete: è centrata sui `0,13 m` della parete e sporge di `0,01 m` su entrambe le facce;
- commit codice su `main`: `eb2f5479ed986259c0caf6ec312306954c3024ee` — `Expose FIN meshes through host wall thickness`;
- tracciatura della divergenza temporanea aggiornata in `CopiedFromTermodel/TERMODEL-SYNC.md`, commit `77acd802511425d2772892b433b9eeb4a32930df` — `Track headless FIN wall-thickness adaptation`; la Library Desktop non è stata modificata;
- GitHub Actions standard su `main`, run **#266**, id `35956352931`: **SUCCESS**;
- verifica dedicata definitiva su branch `ai-debug-fin-thickness-20260924`, run **#270**, id `35956863374`: **SUCCESS** sia per il job diagnostico sia per il job standard; build reale, avvio reale del Service, `POST /api/model/3d = 200`, `POST /api/calculations = 200`, artifact `model3d` con **438 primitive**;
- regression geometrica: **9 FIN controllate, 0 errori**. F001..F009 restano parallele alla parete associata con allineamento `1.000000`; per tutte il volume FIN contiene l'intero intervallo di spessore della parete e lascia circa `0,01 m` di sormonto su ciascuna faccia;
- confronto con artifact precedente alla correzione (run #259) conferma numericamente il difetto: parete `0,13 m` contro FIN `0,10 m`, centrata sulla linea e non sullo spessore della parete;
- strumentazione diagnostica temporanea rimossa dal branch al termine della prova; frontend, `definizionedati.json`, contratto Frontend↔Service e Library Desktop invariati;
- livello distinto non dichiarato: verifica visiva nel browser pubblico dopo il successivo redeploy Render.

### INCARICO 2026-09-24 — allineamento FIN alla parete nell'Appartamento
Stato: ESEGUITO

Commissionato:
- correggere il secondo difetto osservato nell'esempio pubblico `Appartamento`: finestre di dimensioni corrette ma ruotate/disallineate rispetto alla parete;
- confrontare il renderer headless Web con il `DrawBim` Desktop autorevole;
- intervenire soltanto sul punto responsabile dell'orientamento, senza modificare frontend, `definizionedati.json`, Library Desktop o algoritmi di associazione FIN-parete;
- verificare con GitHub Actions lo stesso Appartamento reale e controllare numericamente l'asse di ciascun FIN rispetto alla parete associata.

Risultato:
- causa isolata in `Server/Termodelwebservice/src/Termodel.Core/Compatibility/HeadlessDesktopUi.cs`, metodo `DrawBim.BuildBaseRing()`;
- `Modello.AggiungiFinestra()` calcolava già correttamente la direzione della parete e la passava come `rotationAngle`; il renderer headless applicava però tale rotazione soltanto ai profili con `verticale=true`;
- le finestre sono costruite con `verticale=false`, quindi il loro rettangolo base rimaneva parallelo agli assi globali. Il riferimento Desktop `SorgentiTermodel/Library/utilities/DrawBim.xaml.cs` applica invece la rotazione Z anche ai profili non verticali;
- correzione: nel ramo non verticale di `BuildBaseRing()` le coordinate locali X/Y vengono ruotate con la stessa matrice `cos/sin` prima della traslazione; non sono stati modificati `Modello.AggiungiFinestra`, `LeggiDxf`, frontend o Desktop;
- branch diagnostico: `ai-debug-fin-orientation-20260924`; strumentazione temporanea rimossa al termine;
- GitHub Actions run **#259**, id `35955220418`: build e Service reali riusciti; `POST /api/calculations = 200`, artifact `model3d` con **438 primitive**;
- regression check specifico: **9 FIN controllati, 0 errori**. Per F001..F009 il prodotto scalare assoluto tra asse larghezza della finestra e direzione della parete associata è `1.000000`; distanza centro finestra/punto FIN `0.000000` m;
- pareti associate verificate: F001/F002 -> E001, F003/F004 -> E002, F005/F006/F007 -> E003, F008/F009 -> E004;
- bounding box dopo la correzione: X `-1.77823..11.68775` m, Y `-0.34117..9.09104` m, Z `-0.1..3.89` m;
- commit su `main`: `d91e13acaf0c4a2447085bb4559bad51710383c9` — `Align Web FIN profiles with wall rotation`;
- GitHub Actions standard su `main`, run **#260**, id `35955388392`: **SUCCESS**; restore/build, storage+lock HTTP, feedback GitHub, pannelli SVG/DXF e snapshot publisher tutti riusciti;
- contratto Frontend↔Service invariato: il formato `TermodelWebModel v3` non cambia, si tratta di correzione del renderer headless per parità con Desktop;
- livello ancora distinto: prova visiva del nuovo commit sul Render pubblico/browser dopo redeploy.

### INCARICO 2026-09-24 — debug avanzato esempio Appartamento con GitHub Actions
Stato: ESEGUITO

Commissionato:
- riprodurre con GitHub Actions il difetto corrente per cui l'esempio pubblico `Appartamento` arriva a una vista 3D vuota;
- usare come input i file correnti di `main`, in particolare `docs/termodel-ui-demo/examples/catalog.json`, `appartamento.svg` e il template `ProgettoVuoto`;
- ricostruire il payload tecnico equivalente a `buildTermodelServerPayload()`, avviare realmente `Termodel.WebService`, chiamare `POST /api/calculations` e leggere l'artifact `model3d` senza rieseguire il calcolo;
- raccogliere response HTTP, `generated-files`, `model3d.json`, `TermodelLog.md`, diagnostica, workspace e stdout/stderr del Service;
- usare un branch diagnostico separato e strumentazione temporanea; non modificare `definizionedati.json` né la Library Desktop;
- distinguere se il vuoto nasce nell'input/canonicalizzazione frontend, nel Core/WebService, nell'artifact o nel redraw frontend;
- correggere soltanto la causa dimostrata dal test e ripetere l'Action prima di dichiarare il problema risolto.

Risultato:
- branch diagnostico usato: `ai-debug-appartamento-20260924`; la strumentazione temporanea è stata rimossa al termine;
- input reale: `docs/termodel-ui-demo/examples/appartamento.svg`, con 17 linee parete, 9 blocchi LOC e 9 blocchi FIN; i FIN Web memorizzano le dimensioni in centimetri, per esempio `LARGHEZZA=207.55`, `ALTEZZA=140`, `SOTTOFINESTRA=100`;
- **riproduzione prima della correzione:** GitHub Actions run **#251**, id `35947608742`, build + Service + POST `/api/calculations` riusciti; l'artifact non era vuoto ma conteneva **438 primitive**. Bounding box complessivo: X `-128.20225..151.31775` m, Y `-0.34117..9.09104` m, Z `-0.1..240` m;
- analisi per tipo: pareti/pavimenti/soffitti/ponti restavano entro circa 13,5 x 9,4 x 4 m; soltanto le 18 primitive `Finestra` arrivavano a X `-128.20225..151.31775` m e Z `100..240` m. Il frontend `fitView()` inquadra il bounding box completo, quindi l'edificio normale diventava visivamente quasi nullo: questa era la causa della vista 3D apparentemente vuota;
- **causa dimostrata:** `SvgDxfReader` convertiva correttamente coordinate e inserimenti SVG da cm a m, ma trasferiva senza conversione gli attributi testuali FIN `LARGHEZZA`, `ALTEZZA`, `SOTTOFINESTRA`, `SOPRALUCE`. Il Desktop autorevole dichiara esplicitamente questi quattro campi in metri in `MainWindow.xaml`; il CAD Web li serializza invece in cm, come confermato da `cadMetersToSvgCm(...)` e da `Finestra 2 punti`;
- **correzione:** `Server/Termodelwebservice/src/Termodel.Core/NetDxfCompat/SvgDxfReader.cs` normalizza ora esclusivamente quei quattro attributi del blocco `FIN` da cm a m al confine Virtual CAD; `NUMEROANTE` e gli altri attributi restano invariati. Il motore Desktop copiato `LeggiDxf/Modello` non è stato modificato;
- **verifica dopo la correzione:** GitHub Actions run **#252**, id `35947969346`, riuscito. Stesso esempio, stesso flusso HTTP, ancora **438 primitive**, ma bounding box complessivo corretto: X `-2.45163..12.95535` m, Y `-0.34117..9.09104` m, Z `-0.1..3.89` m; le finestre risultano Z `1.0..2.4` m e la prima finestra larga `2.0755` m;
- contratto Frontend↔Service aggiornato a **v1.16**: nel `TERMODEL-PROJECT-SVG-V1` Web gli attributi dimensionali FIN sono cm e `SvgDxfReader` li converte nei metri attesi dal Desktop;
- **main:** correzione codice commit `4663054cb7b337e242f6a12ed8864c3ba168a93e` — `Fix Web FIN dimensions at SVG-DXF boundary`; contratto commit `152b4d70a8bd51f898ad421d9341b0f9e2e518d7` — `Document FIN units across Web-Service boundary`;
- **build/smoke main:** GitHub Actions run **#253**, id `35948090552`, completato con successo: restore/build, storage+lock HTTP, feedback GitHub, pannelli SVG/DXF e snapshot publisher tutti verdi;
- `definizionedati.json`, Library Desktop e frontend operativo non sono stati modificati;
- **livello non ancora verificato:** il redeploy Render e la prova visiva sul browser pubblico dopo il nuovo commit; non vengono dichiarati verificati dal solo Action.

### INCARICO 2026-09-23 — debug Action sul progetto copiato dagli appunti
Stato: ESEGUITO

Commissionato:
- usare il `TERMODEL-PROJECT-TEXT-V1` reale copiato dal frontend e fornito dall'utente;
- eseguire il Service realmente in GitHub Actions, senza Render;
- raccogliere risposta HTTP, `generated-files`, artifact, workspace e log;
- esaminare i file di ritorno e isolare le anomalie;
- usare un branch diagnostico separato e non modificare `definizionedati.json`, Library Desktop o frontend operativo durante la diagnosi.

Risultato:
- branch diagnostico: `ai-debug-action-20260923`;
- input utente verificato tramite SHA-256: `geometry/project.svg = bda76910a15d4206f018d733d621f427ffb269c3fa4526f89bc0e3a23f17dd06`;
- tutte le sezioni tecniche diverse da `geometry/project.svg` coincidono con il fixture versionato `SorgentiTermodel/Library/projects/ProgettoVuoto/ProgettoVuoto.termodel.txt`;
- run diagnostico #236 / id `35905600774`: build ed esecuzione riuscite; inviando direttamente il progetto copiato, `POST /api/model/3d` e `POST /api/calculations` restituiscono HTTP 422 perché lo SVG locale non dichiara `data-termodel-units="cm"`;
- chiarito che il comando Help copia correttamente il progetto locale completo, mentre il percorso normale `Aggiorna Modello` applica prima `buildTermodelServerPayload()`; pertanto un futuro bridge clipboard -> Action deve eseguire la stessa canonicalizzazione prima di chiamare il Service;
- run diagnostico #241 / id `35906187985`: payload canonico equivalente al frontend, `/api/model/3d = 200`, `/api/calculations = 200`, `generated-files = 200`;
- artifact reali raccolti: `artifacts/model3d.json` (31.939 byte), `artifacts/pannelli.json` (932 byte), `logs/TermodelLog.md`, `logs/diagnostics.txt`, `logs/calculation.log`, progetto materializzato e stdout/stderr Service;
- `model3d.json`: 36 primitive = 2 Soffitto + 2 Pavimento + 8 Parete + 24 Ponte; i 24 mesh Ponte corrispondono a 12 ponti termici automatici, ciascuno esportato come lati+tappi;
- bounding box complessivo delle primitive: X 1,8276..6,65768 m, Y 1,59438..5,37853 m, Z -0,1..3,89 m; nessun vertice fuori scala o oggetto remoto è presente nell'artifact Service;
- il rettangolo edilizio derivato dalle quattro linee utente misura circa 4,57008 x 3,52415 m, coerente con le coordinate SVG; il file di ritorno non spiega quindi da solo una visualizzazione del modello molto piccola;
- i ponti automatici sono coerenti con gli archivi del progetto base: la parete `Parete esterna isolata` usa il gruppo `PontiAutomatici= Parete`;
- individuata una perdita del Nord nel trasporto frontend -> Service: il progetto locale contiene l'accessorio `NORD` con orientamento 71°, ma la canonicalizzazione corrente conserva solo linee e blocchi tecnici di piano; il contratto prescrive invece di non eliminare i simboli tecnici;
- il Core storico rileva il Nord come blocco CAD `NORD` e calcola `DirezNord = (Insert.Rotation + 90) % 360`;
- run diagnostico #243 / id `35906729046`: traduzione temporanea del Nord 71° nel blocco tecnico `NORD` con rotation 341°; build completa e job standard GitHub Actions entrambi SUCCESS; `/api/model/3d = 200`, `/api/calculations = 200`, `generated-files = 200`; l'errore `Il simbolo NORD non è stato trovato` scompare;
- il `model3d.json` del run #243 è identico al run #241 ignorando solo `generatedAtUtc`: il Nord mancante è quindi un difetto reale del contratto/adapter di trasporto, ma non genera le primitive aggiuntive e non altera la scala geometrica del modello;
- resta un messaggio stdout `Errore: Il valore 'Solaio piano' non è un numero intero valido per il colore della copertura.`; non interrompe il calcolo e il codice identico è presente sia nella Library Desktop sia nella copia Core: `Solaio piano` ricade nel valore storico `ColoreCopertura=0`. È una diagnostica fuorviante da correggere eventualmente nel sorgente condiviso, non una causa del fallimento corrente;
- `pannelli.json`: una rete standard, zero circuiti; diagnostica coerente con l'assenza di linee tubo CAD;
- nessuna correzione di prodotto applicata durante questo incarico: sono stati isolati i punti di intervento e verificati con Action reali;
- commit diagnostici principali sul branch:
  `cc03138bb75c13592b34e0a71edeb96aba1f7003`,
  `6b7b8682dd8918c5aff1d1af2e33e29bed02f519`,
  `fb719fbdf648984e22176beb73d88adf2d85f9b8`.

### INCARICO 2026-09-23 — collaudo generico protocollo "Debug avanzato"
Stato: ESEGUITO

Commissionato:
- verificare la fattibilità pratica del protocollo permanente di debug avanzato senza inseguire alcun bug applicativo specifico;
- eseguire il collaudo su branch diagnostico separato;
- far compilare e avviare realmente Termodel.WebService in GitHub Actions;
- eseguire soltanto sonde innocue (/health e /api/model/capabilities);
- produrre un artifact diagnostico di ritorno contenente risposta delle sonde e log stdout/stderr del Service;
- leggere e analizzare l'artifact dalla chat;
- rimuovere dal branch la strumentazione temporanea a collaudo concluso;
- non modificare Core, runtime WebService, frontend, definizionedati.json o Library Desktop.

Risultato:
- branch diagnostico usato: ai-debug-protocol-test-20260923;
- workflow temporaneo: .github/workflows/advanced-debug-protocol-test.yml;
- commit diagnostico: 4d2c4477400461185432221e1ab7f2f80460f998;
- GitHub Actions run #1, run id 35906599732: COMPLETATO CON SUCCESSO;
- restore: success;
- build Release: success;
- avvio reale di Termodel.WebService nel runner Windows: success;
- sonda GET /health: HTTP 200, risposta status=ok;
- sonda GET /api/model/capabilities: HTTP 200;
- capabilities osservate: Termodel Core 0.3.0-experimental, updateModelAvailable=true, newProjectAvailable=true, formato TERMODEL-PROJECT-TEXT-V1 disponibile;
- artifact advanced-debug-protocol-return creato e scaricato dalla chat;
- contenuto artifact verificato:
  - probe.json (537 byte);
  - service.stdout.log (2583 byte);
  - service.stderr.log (0 byte);
- stdout conferma ascolto su http://127.0.0.1:5082 e richieste HTTP 200;
- stderr vuoto;
- dimostrato end-to-end il canale:
  chat -> branch diagnostico -> GitHub Action -> build -> avvio Service -> richiesta HTTP -> artifact/log -> download -> analisi chat;
- nessun bug applicativo specifico è stato investigato durante questo collaudo;
- nessuna modifica a Core, runtime WebService, frontend, definizionedati.json o Library Desktop;
- la strumentazione temporanea viene rimossa dal branch al termine del collaudo.

### INCARICO 2026-09-23 — contratto permanente "Debug avanzato"
Stato: ESEGUITO

Commissionato:
- registrare una procedura permanente per la risoluzione dei problemi complessi del TermodelService tramite GitHub Actions;
- se la natura del problema non è già nota, chiedere prima all'utente quale anomalia deve essere riprodotta;
- chiedere il progetto reale necessario alla riproduzione quando non è già disponibile;
- avviare il ciclo di test sul Service in GitHub Actions, preferibilmente su branch diagnostico separato quando servono modifiche temporanee;
- quando necessario, inserire log/strumentazione diagnostica speciale esclusivamente per il problema corrente;
- raccogliere e analizzare output, log, artifact e file di ritorno dell'Action;
- ripetere autonomamente il ciclo modifica temporanea -> Action -> analisi fino alla risoluzione del problema o fino a quando emerga un impedimento concreto che renda impossibile proseguire;
- al termine rimuovere log e strumentazione temporanei non destinati al prodotto;
- lasciare nel codice solo le correzioni realmente necessarie e documentare separatamente progettato, implementato, compilato, eseguito e testato;
- non modificare `definizionedati.json`, Library Desktop o frontend salvo che il problema richieda esplicitamente tali componenti.

Risultato:
- creata la specifica permanente
  `Server/Termodelwebservice/docs/ADVANCED-GITHUB-ACTIONS-DEBUG.md`;
- aggiunta alle regole iniziali del Summary la regola permanente n. 13;
- formalizzato il ciclo:
  `problema -> progetto -> strumentazione -> GitHub Action -> file di ritorno -> analisi -> correzione -> nuova Action`;
- formalizzato l'uso di branch diagnostici separati per script/log/fixture temporanei;
- formalizzato che i log speciali possono essere aggiunti durante il debug ma devono essere rimossi alla chiusura, salvo promozione esplicita a diagnostica permanente;
- formalizzato che il ciclo continua fino a soluzione verificata oppure a impedimento concreto documentato;
- nessuna modifica a Core, WebService runtime, frontend, `definizionedati.json` o Library Desktop;
- **compilazione:** non richiesta, modifica esclusivamente documentale;
- **esecuzione/test:** non richiesti per la registrazione della procedura;
- commit:
  `7eecab0f95b3e26bd5def072a6ac8bfdc9f50c74` (commissione),
  `34df28d14a35374cdb041867fa301187d173d736` (specifica operativa).

### INCARICO 2026-09-23 — comando Help "Copia progetto negli appunti"
Stato: ESEGUITO

Commissionato:
- aggiungere nel menu `Help` del frontend operativo
  `docs/termodel-ui-demo/` il comando:
  `Copia progetto negli appunti`;
- il comando deve copiare negli appunti il progetto tecnico corrente nel
  formato canonico `TERMODEL-PROJECT-TEXT-V1`, riusando la funzione di
  serializzazione già esistente nel frontend e senza introdurre un formato
  parallelo;
- il comando deve servire al flusso di test rapido:
  `frontend -> clipboard -> chat AI -> GitHub Action/Service temporaneo`;
- non deve modificare il progetto, non deve chiamare Render e non deve
  pubblicare snapshot;
- deve mostrare un riscontro chiaro di successo/errore all'utente;
- non inserire secret o credenziali negli appunti;
- non modificare `definizionedati.json`, Core, WebService o Library Desktop.

Risultato:
- frontend portato a **v1.06**;
- aggiunta nel menu `Help` la voce
  `Copia progetto negli appunti`, disabilitata quando non esiste un progetto
  strutturato aperto;
- il comando richiama `buildCurrentProjectText()`, quindi usa la stessa
  serializzazione canonica già usata da salvataggio/calcolo e copia il
  `TERMODEL-PROJECT-TEXT-V1` completo corrente;
- nessuna chiamata a Render e nessuna pubblicazione snapshot vengono eseguite;
- introdotto un helper clipboard comune riusato anche dalla diagnostica
  Service, con fallback `document.execCommand('copy')`;
- feedback utente:
  `✓ Progetto TERMODEL-PROJECT-TEXT-V1 copiato negli appunti.`;
- aggiunto help contestuale del nuovo comando;
- **controllo sintattico JavaScript:** ESEGUITO con parser V8 sul contenuto
  corrente di `app.js` (rimosso soltanto il blocco import per il parse):
  ```text
  APP_JS_SYNTAX_OK
  HELP_COPY_PROJECT_STATIC_OK
  ```;
- **esecuzione browser reale:** NON ancora verificata manualmente;
- nessuna modifica a `definizionedati.json`, Core, WebService,
  `SorgentiTermodel/Library/` o `PROJECT-SUMMARY.md` Web JS;
- commit:
  `e73c6acce2ba1e538a44fed4ddf9593f68a68444` (commissione),
  `f32f078053d85d56595ed913ec092805c6a2b618` (menu/versione),
  `2c08c89a10e3a4a1940d288ab2af2caa0ef965bc` (logica clipboard).

### INCARICO 2026-09-23 — procedura permanente snapshot per diagnostica AI
Stato: ESEGUITO

Decisione:
- la procedura `Aggiorna Modello -> pubblica snapshot -> esamina l'ultimo snapshot`
  diventa una **procedura operativa fondamentale e permanente** del progetto;
- qualsiasi nuova chat Service deve conoscere il meccanismo prima di chiedere
  all'utente copie manuali di SVG, DXF, JSON, report o log già prodotti dal
  Service;
- quando serve analizzare una sessione reale Render, la chat deve cercare sul
  branch `service-snapshots` il file
  `service-snapshots/LATEST.json`, quindi leggere il relativo
  `manifest.json` e gli artifact/log dello snapshot;
- lo snapshot viene creato **solo su richiesta**, non ad ogni
  `Aggiorna Modello`;
- istruzione utente corrente:
  1. eseguire `Aggiorna Modello`;
  2. pubblicare la sessione con
     `POST /api/projects/{projectId}/publish-session-snapshot`;
  3. dire alla chat `esamina l'ultimo snapshot`;
- fino a quando non esisterà un comando locale/pulsante sicuro che automatizzi
  il punto 2, l'utente usa PowerShell con la propria
  `TERMODEL_SNAPSHOT_ADMIN_KEY`; la chiave e il token GitHub non devono
  essere incollati in chat;
- la chat deve distinguere chiaramente lo snapshot da GitHub dal workspace
  effimero Render: GitHub è la copia diagnostica persistente;
- gli snapshot non vengono puliti automaticamente allo stato attuale;
  `LATEST.json` indica soltanto l'ultimo. Una futura policy di retention
  dovrà essere deliberata prima di cancellare snapshot storici;
- registrare questa procedura nel Summary Service, nel contratto
  Front↔Service, nel README Service e nella nota frontend sul WebService;
- non modificare il `PROJECT-SUMMARY.md` Web JS alla radice.

Risultato:
- creata la specifica operativa autorevole:
  ```text
  Server/Termodelwebservice/docs/SERVICE-SNAPSHOT-DIAGNOSTIC.md
  ```
  con istruzioni separate per utente e nuova chat AI;
- aggiunta alle regole iniziali di questo Summary la regola permanente n. 12:
  una chat deve tentare prima la lettura dello snapshot GitHub e non chiedere
  copie manuali di file già disponibili;
- contratto Front↔Service aggiornato alla **v1.15** con la procedura normativa
  Render → GitHub → AI;
- README Service aggiornato con la sequenza pratica:
  ```text
  Aggiorna Modello
  -> Pubblica snapshot
  -> "esamina l'ultimo snapshot"
  ```
- aggiornata anche
  `docs/termodel-ui-demo/info_termodelwebservice.md`, così una chat/frontend
  developer conosce il meccanismo e sa che la chiave amministrativa non deve
  essere inserita nel JavaScript;
- documentato che:
  - la pubblicazione snapshot è manuale/on-demand;
  - Render Free è effimero;
  - GitHub è la copia diagnostica persistente;
  - `LATEST.json` individua automaticamente l'ultima sessione;
  - non esiste ancora retention/pulizia automatica;
  - token GitHub e admin key non devono essere incollati in chat;
- aggiornato anche lo stato storico della funzione snapshot: la pubblicazione
  reale Render → GitHub è stata **verificata** sul progetto
  `b38f622b-6411-48ea-ba57-0b07862f4046`, snapshot
  `20260923T162958425Z_b38f622b`;
- nessuna modifica funzionale a Core, WebService o frontend;
- nessuna modifica a `PROJECT-SUMMARY.md` della linea Web JS;
- commit:
  `8ebc751d900ffea2a650df05e52b170c69ef3471`,
  `ca726b10b8809eaad0cd09ebfea8b6e488908e62`,
  `3312435bb12ff6eb25f5f67282ce63f965213cc8`,
  `6f2af534a9820ced47fd5f71a894686616e4c14b`,
  `f4615154b2e15f9aea5159a5df3d8d61a481810e`.

### INCARICO 2026-09-23 — pubblicazione snapshot diagnostico Service → GitHub
Stato: ESEGUITO

Commissionato:
- aggiungere un servizio amministrativo che, **solo su richiesta esplicita**,
  pubblichi su GitHub uno snapshot diagnostico dell'ultima elaborazione valida
  del progetto;
- riusare il catalogo universale `generated-files` come sorgente dei file
  pubblicabili, senza accesso arbitrario al filesystem;
- pubblicare per default soltanto `artifacts/**` e `logs/**`;
- non pubblicare `project.tmdl`, credenziali, configurazioni server o altri
  file interni;
- usare un token GitHub distinto dal token feedback:
  `TERMODEL_SNAPSHOT_GITHUB_TOKEN`;
- proteggere l'endpoint con una chiave amministrativa separata:
  `TERMODEL_SNAPSHOT_ADMIN_KEY`, inviata tramite header
  `X-Termodel-Snapshot-Key`;
- usare per default il repository `Fetonte1960/Termodel` e un branch
  dedicato `service-snapshots`, configurabili via environment;
- creare per ogni pubblicazione una cartella autonoma sotto
  `service-snapshots/<snapshotId>/`;
- includere un `manifest.json` con projectId, timestamp UTC, commit Service
  quando disponibile, elenco file, dimensioni, content type e SHA-256;
- creare **un solo commit GitHub atomico** per snapshot tramite Git Data API;
- aggiungere endpoint:
  `POST /api/projects/{projectId}/publish-session-snapshot`;
- aggiungere smoke test con stub GitHub API che verifichi autenticazione,
  branch/commit/tree/blob, esclusione di `project.tmdl` e manifest;
- documentare la configurazione Render necessaria;
- non modificare `definizionedati.json`, protocollo progetto o Library
  Desktop.

Risultato:
- aggiunto
  `src/Termodel.WebService/Snapshots/GitHubSnapshotPublisher.cs`;
- introdotte opzioni server separate:
  ```text
  TERMODEL_SNAPSHOT_GITHUB_TOKEN
  TERMODEL_SNAPSHOT_ADMIN_KEY
  TERMODEL_SNAPSHOT_REPOSITORY=Fetonte1960/Termodel
  TERMODEL_SNAPSHOT_BRANCH=service-snapshots
  TERMODEL_SNAPSHOT_BASE_BRANCH=main
  TERMODEL_SNAPSHOT_GITHUB_API_BASE_URL=https://api.github.com
  TERMODEL_SNAPSHOT_ROOT=service-snapshots
  ```
- il token snapshot è volutamente distinto da
  `TERMODEL_FEEDBACK_GITHUB_TOKEN`; il primo richiede
  `Contents: read/write`, mentre il feedback può restare limitato alle
  Issues;
- aggiunto endpoint amministrativo:
  ```http
  POST /api/projects/{projectId}/publish-session-snapshot
  X-Termodel-Snapshot-Key: <secret>
  ```
- endpoint non configurato -> HTTP 503;
- chiave amministrativa errata -> HTTP 403;
- progetto inesistente -> HTTP 404;
- workspace senza file generati -> HTTP 409;
- `ProjectStore.ReadGeneratedFilesSnapshotAsync` legge atomicamente,
  sotto lo stesso gate progetto, esclusivamente i file di
  `artifacts/**` e `logs/**`;
- limite corrente per sicurezza:
  - 20 MiB per singolo file;
  - 50 MiB complessivi per snapshot;
- pubblicazione GitHub realizzata con Git Data API:
  1. verifica/creazione branch `service-snapshots`;
  2. creazione blob;
  3. creazione tree con base tree del branch;
  4. creazione commit;
  5. aggiornamento non-forzato della ref;
  quindi ogni snapshot corrisponde a **un solo commit atomico**;
- ogni snapshot viene scritto sotto:
  ```text
  service-snapshots/LATEST.json
  service-snapshots/<timestamp>_<project-prefix>/
    manifest.json
    artifacts/...
    logs/...
  ```
- `LATEST.json` usa il formato
  `TERMODEL-SERVICE-SNAPSHOT-LATEST-V1` e punta sempre allo snapshot più
  recente; una chat successiva può quindi leggere direttamente
  `service-snapshots/LATEST.json` sul branch `service-snapshots` senza
  conoscere prima lo snapshotId;
- `manifest.json` usa il formato
  `TERMODEL-SERVICE-SNAPSHOT-V1` e registra:
  projectId, timestamp UTC, eventuale commit Service
  (`RENDER_GIT_COMMIT`/`GITHUB_SHA`/`SOURCE_VERSION`), stale,
  content type, dimensione, data file e SHA-256;
- `project.tmdl` non è incluso e il publisher rifiuta qualsiasi path non
  appartenente ad `artifacts/` o `logs/`;
- aggiunti:
  `tests/github_snapshot_stub.py` e
  `tools/smoke-github-snapshot.ps1`;
- lo smoke verifica:
  - 503 senza configurazione;
  - 403 con chiave errata;
  - 201 con configurazione valida;
  - header Bearer e User-Agent verso GitHub;
  - creazione branch, blob, tree, commit e update ref non forzato;
  - quattro file generati + manifest;
  - esclusione reale di un `project.tmdl` presente nel workspace;
  - manifest con SHA-256 validi;
- **compilato/eseguito/testato:** SI — GitHub Actions
  `TermodelService Build` run **#219**
  (run id `35884001322`) completato con **success**;
- marker verificato:
  ```text
  GITHUB_SESSION_SNAPSHOT_SMOKE_OK
  ```
  insieme agli smoke preesistenti project/lock, feedback ed esecutivo
  pannelli;
- README Service aggiornato con endpoint, formato snapshot e configurazione
  Render;
- **GitHub reale da Render:** SI — i due secret sono stati configurati su
  Render e il 23/09/2026 è stata eseguita una pubblicazione reale del progetto
  `b38f622b-6411-48ea-ba57-0b07862f4046`; lo snapshot
  `20260923T162958425Z_b38f622b` è stato letto successivamente dalla chat
  tramite `service-snapshots/LATEST.json` e `manifest.json`;
- non sono stati modificati `definizionedati.json`,
  `TERMODEL-PROJECT-TEXT-V1` o la Library Desktop;
- commit principali:
  `ea602424cecaf6af075c4a46ff7dc273c85e2a68`,
  `53c5b822aeabf16d9bbb7bb8770b325065d115b6`,
  `6ccb94de5553a53e301f597ba9bb8e7d0601ca44`,
  `c7c39917e8062a96ffa01d3b955681c53ed33b1d`,
  `4456c69817332d83fc211cbff9d0260e65e5fbfa`,
  `6809503da66566b53a8ddd4d0020fa0f22f17add`,
  `2b07cba1cae7ecad3992e8dbe38dd12b195df432`,
  `d3f8586af2aed9d8f391ea50ab1d11d3625dda3f`,
  `4f18e69fa6ee98c990d68d59eecf7b51bd0788c0`,
  `00cd332adb89c794a3cdea065388cb4c50e753aa`,
  `a4c75c5b9b83c790fbf869f7ef349bb1c3c046ca`,
  `2d4d1c53258997cd3f669938ff02f31077996517`.

### INCARICO 2026-09-23 — canale universale file generati + test SVG spirali al frontend
Stato: ESEGUITO

Commissionato:
- verificare end-to-end il disegno esecutivo spirali SVG già prodotto dal
  Service e renderlo realmente raggiungibile dal frontend;
- verificare se esiste già un servizio universale per trasmettere file
  generati (disegni, report, JSON, CSV, PDF, DXF, SVG, log); se manca,
  introdurre un canale generico **read-only** e sicuro;
- il canale universale deve pubblicare soltanto file generati autorizzati
  del workspace progetto, senza esporre `project.tmdl`, file arbitrari o
  path traversal;
- aggiungere un catalogo/manifest dei file generati con nome, percorso
  logico, categoria, content type, dimensione, stale e href;
- aggiungere un endpoint generico di lettura che rispetti content type e
  disposizione inline/attachment;
- mantenere gli endpoint specifici esistenti per retrocompatibilità;
- collegare il frontend operativo `docs/termodel-ui-demo` al catalogo
  generico e aggiungere un comando per caricare l'esecutivo pannelli SVG
  come **sfondo/overlay di riferimento del CAD2D**, senza alterare la
  geometria tecnica del progetto;
- lo sfondo esecutivo deve poter essere rimosso/ripristinato senza
  modificare `TERMODEL-PROJECT-TEXT-V1`;
- aggiungere smoke automatico del catalogo, del GET generico e del contenuto
  SVG spirali;
- aggiornare contratto Front↔Service, README e Summary;
- non modificare `definizionedati.json` né la Library Desktop.

Risultato:
- non esisteva un canale universale: erano presenti soltanto endpoint
  specifici per `model3d`, `pannelli`, esecutivo SVG/DXF e TermodelLog;
- implementato in `ProjectStore` il catalogo read-only ricorsivo dei soli
  alberi:
  ```text
  artifacts/**
  logs/**
  ```
  con normalizzazione del path e rifiuto di traversal/file esterni;
- introdotto il contratto:
  ```text
  TERMODEL-GENERATED-FILES-V1
  ```
- nuovi endpoint:
  ```http
  GET /api/projects/{projectId}/generated-files
  GET /api/projects/{projectId}/generated-files/{relativePath}
  ```
- ogni record del catalogo espone:
  `path`, `fileName`, `category`, `contentType`, `size`,
  `lastWriteTimeUtc`, `inline`, `stale`, `href`;
- il GET generico riconosce già JSON, SVG, DXF, PDF, CSV, TXT, Markdown,
  XML, immagini e ZIP; mantiene `X-Termodel-Artifact-Stale`, usa
  `X-Content-Type-Options: nosniff` e sandbox CSP per SVG/HTML;
- `project.tmdl` non è pubblicabile tramite questo canale;
- `POST /api/calculations` espone anche `generatedFilesHref`;
- gli endpoint specifici esistenti sono rimasti invariati per
  retrocompatibilità;
- l'SVG esecutivo pannelli dichiara ora metadata metrici:
  ```text
  data-coordinate-unit="m"
  data-termodel-max-y="..."
  data-termodel-min-y="..."
  ```
  per consentire al CAD2D di riallineare correttamente le coordinate;
- frontend portato a **v1.05**;
- nel menu CAD2D `Sfondo` sono stati aggiunti:
  ```text
  ↻ Esecutivo pannelli SVG
  Mostra esecutivo calcolato
  ```
- il frontend recupera il catalogo universale, individua
  `artifacts/pannelli-esecutivo.svg` e lo legge tramite il relativo
  `href`;
- l'esecutivo viene visualizzato in un layer runtime separato
  `cadGeneratedExecutiveLayer`, filtrato per `data-piano`, convertendo
  metri→centimetri e annullando la sola inversione Y del writer SVG;
- l'overlay non entra in `cadWorkingDoc`, non modifica
  `TERMODEL-PROJECT-TEXT-V1`, non entra in Undo/Redo e non viene reinviato
  al Service;
- lo stesso overlay può essere mostrato/nascosto indipendentemente dagli
  sfondi importati tradizionali;
- **test SVG spirali reale:** lo smoke crea un locale sintetico 4×4 m con
  ingresso Tubo e verifica nell'SVG:
  - formato `TERMODEL-PANNELLI-ESECUTIVO-SVG-V1`;
  - metadata metrici;
  - layer edificio/mandata/ritorno;
  - presenza effettiva di geometria mandata e ritorno;
  - bounding box dell'edificio 0..4 m × 0..4 m;
  - equivalenza del numero di primitive tecniche SVG/DXF;
- **test canale universale:** lo smoke verifica catalogo, content type di
  SVG/DXF/JSON/Markdown, GET dell'SVG tramite `href`, stale=false e
  rifiuto di `project.tmdl`;
- marker automatici verificati:
  ```text
  GENERATED_FILES_CHANNEL_SMOKE_OK
  RADIANT_EXECUTIVE_SVG_GEOMETRY_SMOKE_OK
  RADIANT_EXECUTIVE_SVG_DXF_SMOKE_OK
  ```
- **compilato/eseguito/testato:** SI — GitHub Actions
  `TermodelService Build` run **#206** (run id `35881202382`) completato
  con successo, inclusi build Release, smoke project/lock, feedback e smoke
  esecutivo;
- **frontend verificato staticamente:** `APP_JS_SYNTAX_OK` e
  `GENERATED_EXECUTIVE_FRONT_STATIC_OK`;
- **frontend pubblicato:** GitHub Pages run **#834**
  (run id `35881201564`) completato con **success**;
- contratto Front↔Service aggiornato alla **v1.14**;
- README Service aggiornato con il canale universale;
- non sono stati modificati `definizionedati.json`,
  `TERMODEL-PROJECT-TEXT-V1` o la Library Desktop;
- prova browser manuale del nuovo pulsante CAD non ancora eseguita
  dall'utente: build, deploy e percorso HTTP/geometry sono verificati, ma
  l'interazione visuale finale nel browser resta da confermare sul front
  pubblico;
- commit principali:
  `15ccc03845bcc27e86ad65a393defc3211114cad`,
  `39be9e54e17e4593fd3c970ce859e08007246ae7`,
  `8b84672234453a1fa1344472b7700393585fe6ac`,
  `5e91b257c26a8bf80931013e86f9e23d43ac4b46`,
  `6bbaa3a7081adef0335d3a3c7740d34a6c05392e`,
  `7bbea9dcc8b5cb0ea4abf380588202baf3572b16`,
  `bf5d65915c1659748485bd92a5881424aa0b5231`,
  `2337aaef7264eef941bd1cf817d27b2934d9276b`,
  `095ab077b6727323f86ead5da194372cf08d4e58`.

### INCARICO 2026-09-23 — attivazione esecutivo pannelli SVG/DXF
Stato: ESEGUITO

Commissionato:
- attivare il disegno esecutivo pannelli usando i **default attuali** già
  consolidati nel ramo Desktop/pannelli;
- produrre nel Service sia l'esecutivo DXF sia un esecutivo SVG
  **graficamente equivalente al DXF OUT**;
- DXF e SVG devono derivare dallo **stesso modello grafico esecutivo** nel
  Core: non creare due algoritmi di disegno indipendenti;
- consultare e riusare come riferimento funzionale
  `SorgentiTermodel/Library/Impianti/Pannelli/IoPannelli.cs` e
  `IoTubi.cs`, in particolare `EsecutivoPannelli`;
- mantenere fuori scope il grafo universale, il percorso sfavorito,
  l'equilibratura e le perdite concentrate, già rimandati alla fase
  **Tubi universale**;
- per questa milestone è ammesso il comportamento grafico con i default
  correnti; non rendere ancora parametrico il motore spirali se ciò
  richiederebbe duplicazione o modifica della Library Desktop;
- persistire gli artifact esecutivi nello stesso
  `SavedProjects/{projectId}/artifacts/` dell'ultima elaborazione valida e
  renderli leggibili senza nuovo calcolo;
- aggiornare il manifest artifact di `POST /api/calculations`, gli endpoint
  GET, il contratto Front↔Service e la documentazione;
- aggiungere smoke automatico che verifichi presenza e coerenza strutturale
  DXF/SVG;
- non modificare `definizionedati.json`, `TERMODEL-PROJECT-TEXT-V1` o
  la Library Desktop.

Risultato:
- implementato `RadiantExecutiveGenerator` nel Core;
- il motore grafico usa il `SpiraliGPT` Desktop corrente con default
  `PassoTubi=0,30 m`, coerente con `RAD-DEFAULT`;
- i cinque sorgenti `SpiraliGPT` necessari sono copie temporanee
  byte-identical della Library e sono tracciati in
  `Termodel.Core/CopiedFromTermodel/TERMODEL-SYNC.md`;
- DXF e SVG derivano dallo stesso modello neutro
  `RadiantExecutiveDrawing`;
- artifact persistiti:
  ```text
  artifacts/pannelli-esecutivo.svg
  artifacts/pannelli-esecutivo.dxf
  ```
- endpoint disponibili senza ricalcolo:
  ```http
  GET /api/projects/{projectId}/artifacts/pannelli-esecutivo-svg
  GET /api/projects/{projectId}/artifacts/pannelli-esecutivo-dxf
  ```
- contenuto equivalente verificato per i layer:
  `<Piano>_Edificio_Output`,
  `<Piano>_PannelliMandata_Output`,
  `<Piano>_PannelliRitorno_Output`,
  `<Piano>_NumeriCircuiti_Output` quando presente;
- il grafo/collettore resta intenzionalmente fuori scope e rimandato a
  **Tubi universale**;
- contratto Front↔Service aggiornato alla **v1.13**;
- README e registro Tubazioni aggiornati;
- **compilato:** SI — GitHub Actions `TermodelService Build` run **#195**
  (run id `35878924866`), Build completata con successo;
- **eseguito/testato:** SI — smoke dedicato
  `RADIANT_EXECUTIVE_SVG_DXF_SMOKE_OK`, locale sintetico 4×4 m con
  ingresso Tubo, persistenza di entrambi gli artifact, GET senza ricalcolo
  con `X-Termodel-Artifact-Stale=false` e uguaglianza del numero di
  primitive tecniche fra SVG e DXF;
- **confrontato con riferimento:** SI per il comportamento grafico
  `IoPannelli.EsecutivoPannelli` nel perimetro supportato dalla milestone;
  non viene dichiarata equivalenza per il futuro grafo universale;
- commit principali:
  `41998b8c63a7c06b10818320ab9e5323ca3c3746`,
  `2e2b711f733f925aa5c04f8b6b4516575259d68a`,
  `f346ded263dffef95e7c9588379573643c218efc`,
  `51c0ca3cc288d00284983b08990424a1d1dc64de`,
  `b9ac3c2ed83a2b8c35adc6c4e1b6bb40da1df38c`,
  `502da9f5cf63264c7ab39fe4373f771ea4fe5d25`,
  `a412bd5d5cdd79e28e9e8c18fd8eea2c024ea9fe`,
  `0b5472e538b962311d791c452bf9df964ec521e6`,
  `d30493eb28e76afb6357afe92dfe567003cdbbb5`,
  `c9a584d6254493552672b19e24b1fb400500639a`,
  `5680af2d093e604509e01820d1edffc80aadd57b`,
  `ca9f6c39a1b4bd755dc42e8d6eca79c32797349a`,
  `4cb2349ebaf0d102875c521b305af05aa55f9d48`,
  `10e87f688cc0a3f0d0b4009e44a3a6df24c780ea`,
  `bc6c2cc5b3966c5acaf820def1aa450a9bda3c23`,
  `8f929a1709677cff126c45f3c220185a2313e68c`.

### INCARICO 2026-09-23 — rinvio grafo alla fase Tubi universale
Stato: ESEGUITO

Decisione:
- il grafo generale della rete, il riconoscimento/scomposizione
  collettore→rami→terminali e il relativo percorso sfavorito vengono
  **rimandati alla futura fase Tubi universale**;
- questa fase PannelliRadianti non deve essere bloccata dall'assenza del
  grafo universale;
- per il ramo pannelli corrente è sufficiente il **calcolo delle perdite di
  carico per singolo circuito**, usando la geometria del circuito già
  identificato e i dati di `Reti`/`TipologiePannelli`;
- non introdurre adesso una seconda implementazione del grafo specifica dei
  pannelli che poi dovrebbe essere sostituita dal motore Tubi universale;
- mantenere il kernel Darcy già implementato come componente riusabile della
  futura fase Tubi universale;
- aggiornare Summary, registro Calcolo Tubazioni e contratto Front↔Service
  per evitare che il grafo venga indicato come requisito pendente della fase
  pannelli attuale.

Risultato:
- decisione registrata nel
  `Server/Termodelwebservice/docs/TUBAZIONI-DEVELOPMENT-REGISTER.md`;
- roadmap T2/T4 e le parti di T3/T5 relative a grafo, sizing, percorso
  sfavorito ed equilibratura sono state classificate come lavoro futuro della
  fase **Tubi universale**;
- il perimetro della fase pannelli corrente termina al calcolo della perdita
  distribuita del singolo circuito già identificato;
- convenzione operativa fino al grafo universale:
  ```text
  un circuito = una componente geometrica connessa indipendente
  ```
- circuiti diversi non devono quindi condividere un nodo geometrico comune
  nel disegno destinato al calcolo corrente; se condividono un punto vengono
  riconosciuti come un unico componente ramificato e diagnosticati, senza
  scomposizione automatica;
- il collettore topologico non viene introdotto in questa fase e sarà
  responsabilità del modulo Tubi universale;
- contratto Front↔Service aggiornato alla **v1.12** con questo confine
  funzionale;
- nessuna modifica al codice di calcolo, al frontend operativo, al protocollo
  `TERMODEL-PROJECT-TEXT-V1`, a `definizionedati.json` o alla Library
  Desktop;
- commit:
  `7d56df6d70df0b4daeb28bcb7fc77166891c7933`,
  `122977c9959e1d9aff389bec43db4ae636dbe798`,
  `74cc540fc71bb3cee400e8583ef94010a53ffa1f`.

### INCARICO 2026-09-23 — completamento ramo pannelli radianti Service
Stato: ESEGUITO

Commissionato:
- completare il passo successivo al trasporto CAD Tubo già verificato;
- riusare prima di tutto il comportamento Desktop documentato in
  `SorgentiTermodel/Library/Impianti/Pannelli/*`, evitando un motore
  pannelli parallelo nel WebService;
- collegare runtime gli archivi progetto `Reti` e
  `TipologiePannelli` al calcolo pannelli, eliminando per il ramo Web i
  default hard-coded quando gli archivi contengono i dati equivalenti;
- validare `PassoSelezionatoMm` rispetto a `PassiDisponibiliMm`;
- implementare nel Core un primo kernel idraulico puro Darcy-Weisbach per i
  circuiti radianti, con proprietà acqua derivate dalla temperatura media,
  fattore Darcy e diagnostica esplicita;
- usare la geometria Tubo già trasportata nel Virtual CAD e il grafo/DTO
  pannelli Desktop quando disponibili, senza inventare protocolli alternativi;
- produrre nel workspace projectId almeno un artifact dati pannelli JSON
  persistente e leggibile senza ricalcolo; aggiungere SVG spirali per piano
  soltanto se il percorso Desktop headless è realmente integrabile in questa
  milestone senza dipendenze UI;
- aggiungere endpoint GET degli artifact correnti mantenendo
  `POST /api/calculations` come unica elaborazione autorevole;
- aggiungere smoke automatici su progetto sintetico che verifichino:
  archivi -> solver -> artifact -> persistenza -> GET;
- non modificare `definizionedati.json`;
- non modificare la Library Desktop;
- aggiornare contratto Front↔Service, registro Tubazioni e questo Summary
  secondo lo stato reale;
- distinguere esplicitamente ciò che è progettato, implementato, compilato,
  eseguito e confrontato col riferimento Desktop.

Risultato:
- aggiunto in `Termodel.Core`
  `RadiantPanels/RadiantPanelCalculator.cs`;
- il solver legge **a runtime** gli archivi XML del file unico
  `Reti` e `TipologiePannelli`, seleziona le reti attive
  `TipoRete=PannelliRadianti`, risolve
  `CodiceTipologiaPannello` e usa passo, temperature, limiti,
  `KLayout`, diametro interno, rugosità e coefficiente resa;
- `PassoSelezionatoMm` viene realmente validato contro
  `PassiDisponibiliMm`; un passo 333 mm non ammesso produce HTTP 422 e
  non sostituisce l'ultimo artifact valido;
- `SvgDxfReader` conserva ora sulle linee del Virtual CAD un
  `SvgDxfLineMetadata` con id, piano, entità, rete e layer. Il normale
  layer/colore/linetype netDxf usato dal codice Desktop resta invariato;
- i segmenti `Tubo` della stessa rete/piano vengono raggruppati per
  connettività geometrica (tolleranza 1 mm) in circuiti; vengono rilevate e
  diagnosticate topologie aperte/chiuse/ramificate;
- implementato il primo kernel idraulico:
  densità e viscosità acqua dalla temperatura media, velocità, Reynolds,
  fattore Darcy `64/Re` in laminare, Colebrook in turbolento e transizione
  interpolata/diagnosticata 2300–4000;
- perdita distribuita:
  `DeltaP = f * (L/D) * rho*v²/2`, con output Pa/m, Pa e kPa;
- la resa preliminare mantiene la stessa relazione del Desktop
  `CalcoloPannelli.CalcolaPotenzaSpecifica`:
  `CoefficienteResaWm2K * (TmediaAcqua - Tambiente)`;
- finché il calcolo pannelli completo non fornisce una portata circuito
  autorevole, la prima versione ricava esplicitamente una **portata
  preliminare** da potenza, `cp=4180 J/(kg K)` e salto mandata/ritorno;
- per il CAD manuale la centerline Tubo è trattata come lunghezza idraulica
  effettiva. L'area servita è stimata inversamente dal fattore
  superficie/passo e `KLayout`; questa assunzione è dichiarata
  nell'artifact e non viene confusa con una spirale generata;
- i fattori passo implementati sono quelli registrati nella specifica:
  50→20; 100→10; 125→8; 150→6,7; 175→5,8; 200→5; 300→3,4 m/m²,
  con fallback `1000/passo_mm`;
- `POST /api/calculations` continua a essere l'unica elaborazione
  autorevole e pubblica anche:
  ```text
  SavedProjects/{projectId}/artifacts/pannelli.json
  ```
  formato `TermodelRadiantPanels v1`;
- aggiunto:
  ```http
  GET /api/projects/{projectId}/artifacts/pannelli
  ```
  che legge il JSON persistito senza rilanciare il calcolo e restituisce
  `X-Termodel-Artifact-Stale` coerente con lo stato progetto;
- la response di `POST /api/calculations` include ora gli artifact
  `model3d` e `pannelli`;
- le diagnostiche idrauliche restano dentro `pannelli.json`; il campo
  top-level `diagnostics` continua a rispettare esattamente
  `logEnabled/logCategories`, preservando il contratto TermodelLog;
- `logs/calculation.log` registra anche
  `radiantPanelCircuitCount`;
- test sintetico end-to-end: un `T001` di 1,000 m, rete
  `RAD-DEFAULT`, passo 300 mm, PE-Xa D interno 12 mm, acqua 35/30 °C
  produce, entro tolleranze definite:
  ```text
  portata derivata ~= 3,1826793 L/h
  Reynolds         ~= 123,4017
  perdita          ~= 1,313675 Pa
  ```
- lo smoke verifica anche rete/tipologia, passo, diametro, fattore 3,4,
  lunghezze 1 m, persistenza di `pannelli.json`, GET senza ricalcolo,
  validazione passo 333 -> 422 e conservazione dell'ultimo artifact valido;
- **compilato:** SI — GitHub Actions `TermodelService Build` run **#165**
  (run id `35871205144`), Build Release riuscita con **0 Error(s)**;
- **eseguito/testato:** SI — nello stesso run sono verdi
  `RADIANT_NETWORK_ARCHIVES_SMOKE_OK`,
  `RADIANT_INVALID_STEP_STATUS_422`,
  `RADIANT_PANEL_DARCY_SMOKE_OK`,
  `RADIANT_PIPE_FILE_UNIQUE_SMOKE_OK`,
  `TERMODEL_LOG_OPTIONS_SMOKE_OK`,
  `PROJECT_LOCK_SMOKE_OK` e `GITHUB_FEEDBACK_SMOKE_OK`;
- **confrontato con riferimento Desktop:** SI per convenzione layer Tubo,
  dati progetto precedentemente hard-coded e formula preliminare di resa;
  NO per equivalenza numerica completa del generatore spirali/collettori,
  che non è ancora nel Service;
- **stato storico di questa commissione:** il generatore grafico non era
  ancora integrato. Questa limitazione è stata successivamente superata dalla
  commissione “attivazione esecutivo pannelli SVG/DXF” per il solo default
  corrente `PassoTubi=0,30 m`; resta da rendere parametrico il motore
  condiviso per passi diversi da 300 mm;
- non sono ancora incluse perdita collettore, valvole, flussimetri, perdite
  concentrate, distribuzione primaria, sizing automatico o equilibratura;
  per decisione del 23/09/2026 questi aspetti, insieme al grafo generale e al
  percorso sfavorito, sono **fuori dal completamento pannelli corrente** e
  appartengono alla futura fase Tubi universale;
- contratto Front↔Service aggiornato allora alla **v1.11**; stato corrente del contratto dopo l'esecutivo: **v1.13**;
- registro
  `Server/Termodelwebservice/docs/TUBAZIONI-DEVELOPMENT-REGISTER.md`
  aggiornato alla milestone 15.3;
- `Server/Termodelwebservice/README.md` documenta il nuovo endpoint;
- `definizionedati.json`, `TERMODEL-PROJECT-TEXT-V1` e la Library
  Desktop non sono stati modificati;
- principali commit dell'incarico:
  `ea7be8d2a03e848d16e2c8ac5a26e8ebae05be04`,
  `1c1b4eae87fdb5a63669fd9ac8af2aa1e1a3d009`,
  `ccfeaf5d42d74f84cb07d3c1c63cfdf56b6b3e13`,
  `59bd736f7141430a8760e215fbe4769e748d76f2`,
  `f96091fe9cc3c62f38a6da184e542f788530276a`,
  `f6bf6ce3034f546064a5e22546049d38843a7b1a`,
  `cd90e16ede425dbc5945fd079e0d5852623cdb1c`,
  `e871fb4f742eb03c4ba51af654cace2115ba6c48`,
  `cf7f3efb636ed09601017c1cbc925651a413b92b`,
  `1c1486e817087aa849edd705263058868f212e6a`,
  `b7f1cab0c889a7673a8b0baa5072b15fef58f3fb`,
  `232c970088d88b64e9aa96c2c4ee44a076f79438`,
  `459e07f4a06a65c865a2b91c61595db5d8a39805`.

### INCARICO 2026-09-23 — entità Tubo in modalità Rete CAD 2D
Stato: ESEGUITO

Commissionato:
- in modalità `Rete` il CAD 2D deve esporre una sola entità disegnabile:
  `Tubo`;
- il comando `Tubo` deve usare una modalità di disegno sequenziale analoga
  alla parete: ogni segmento termina dove inizia il successivo e il comando
  resta attivo fino a interruzione;
- per `Tubo` resta disponibile la chiusura diretta `Chiudi` della
  sequenza multipla, mentre **non** deve essere disponibile
  `Chiudi ortogonale`; resta disponibile l'interruzione della sequenza e,
  se compatibile, la ripetizione dell'ultimo comando;
- la modalità `Edificio` deve conservare integralmente i comandi correnti;
- consultare il riferimento Desktop in
  `SorgentiTermodel/Library/leggidxf/LeggiDxf.cs` e
  `SorgentiTermodel/Library/Impianti/Pannelli/IoPannelli.cs`, oltre agli
  adattatori Virtual CAD del Core, per determinare la formattazione corretta
  delle linee tubo, il layer atteso e il percorso di ingresso al calcolo;
- le linee tubo devono essere incluse nello SVG tecnico
  `geometry/project.svg` del `TERMODEL-PROJECT-TEXT-V1` con metadati tali
  da permettere al Virtual CAD di ricostruire il layer DXF atteso dal codice
  Desktop, senza introdurre un formato parallelo;
- la rete selezionata nel combo `Reti` deve essere associata alle nuove
  entità tubo con metadato tecnico, mantenendo il piano corrente;
- preservare il supporto multipiano: una stessa rete può avere segmenti tubo
  su più piani;
- non modificare `definizionedati.json` né la Library Desktop;
- modificare Core/Virtual CAD soltanto se l'analisi dimostra che il formato
  frontend corretto non è già trasportabile dal lettore SVG corrente;
- aggiornare contratto Front↔Service se vengono formalizzati nuovi metadati
  tecnici nello SVG del file unico.

Risultato:
- frontend portato a **v1.04**;
- in `Modalità=Rete` il menu Disegna nasconde Parete E/W, Allinea,
  Finestra 1/2 punti, Ponte, Locale e Colmo: la sola entità nuova disponibile
  è **Tubo**;
- `Tubo` riusa il motore sequenziale della parete: il punto finale di un
  segmento diventa il punto iniziale del successivo; `Interrompi sequenza`
  resta disponibile;
- dopo almeno tre segmenti il menu contestuale permette `Chiudi` diretto;
  `Chiudi ortogonale` è nascosto e comunque rifiutato dalla routine quando
  la sequenza è di tipo pipe;
- il cambio di Rete o Modalità interrompe una sequenza in corso, evitando che
  una stessa multilinea venga accidentalmente divisa fra due reti;
- gli ID delle primitive sono `T001`, `T002`, ... e vengono calcolati
  sull'intero SVG per evitare collisioni;
- ogni Tubo conserva:
  ```text
  data-termodel-piano    = Piani.Nome
  data-termodel-layer    = <Piani.Nome>_tubipannelli
  data-termodel-entity   = Tubo
  data-termodel-rete     = Reti.Codice
  data-termodel-linetype = Continuous
  data-termodel-color    = 1
  stroke                 = #ff0000
  ```
- la convenzione è stata ricavata dal riferimento Desktop:
  `ScriptCad.TipoComandoEnum.Tubo` imposta layer `*_tubipannelli`,
  colore ACI 1 e `Continuous`; `IoPannelli.LeggiTubiDXF` cerca
  esattamente `<NomePiano>_tubipannelli`;
- il piano resta indipendente dalla rete: la stessa `Reti.Codice` può
  quindi avere Tubi su più `Piani.Nome`;
- `GeneraPianta.js` considera ora esclusivamente le linee E/W nella
  polygonizzazione architettonica, quindi le linee T non alterano locali,
  pareti o anteprima edificio;
- il comando `Rigenera pianta` diventa `Consolida rete` in modalità Rete:
  consolida lo SVG tecnico senza passarlo a GeneraPianta locale;
- il normale `buildTermodelProjectText/buildTermodelServerPayload` conserva
  le linee Tubo nel `geometry/project.svg` del file unico; non è stato
  introdotto alcun nuovo formato progetto;
- `SvgDxfReader` era già in grado di conservare il layer ausiliario e
  tradurre `data-termodel-linetype/data-termodel-color` nel
  `DxfDocument` virtuale: non è stato necessario modificarlo;
- corretto il solo adattatore headless
  `Compatibility/HeadlessLegacyServices.cs`: in precedenza rifiutava
  qualsiasi layer tubi; ora acquisisce e conta le linee del layer
  `<NomePiano>_tubipannelli` al confine
  `LeggiDxf -> IoPannelli.LeggiTubiDXF`;
- questa modifica **non implementa ancora il solver pannelli**, non genera
  `retePannelli.xml`, spirali o perdite di carico e non sostituisce
  l'adapter Pannelli futuro;
- contratto Front↔Service aggiornato alla **v1.10** con la convenzione
  normativa dell'entità Tubo;
- registro `docs/TUBAZIONI-DEVELOPMENT-REGISTER.md` aggiornato con la
  milestone CAD Rete/Tubo;
- verifica sintattica frontend:
  `APP_JS_SYNTAX_OK`, `PIPE_FRONT_STATIC_OK`,
  `GENERA_PIANTA_SYNTAX_OK`,
  `GENERA_PIANTA_NETWORK_FILTER_OK`;
- durante la verifica è stata individuata e corretta una duplicazione
  accidentale del tail di `app.js`; la versione finale contiene una sola
  definizione delle routine CAD interessate;
- **compilato:** SI — GitHub Actions `TermodelService Build` run **#153**
  (run id `35867097104`), Build Release riuscita con **0 Error(s)**;
- **eseguito/testato:** SI — nello stesso run #153 uno smoke end-to-end ha
  inserito `T001` nel file unico, lo ha inviato a
  `POST /api/calculations`, verificato nel log
  `Letti 1 tubi dal layer <Piano>_tubipannelli` e verificato che
  `project.tmdl` persistesse layer, `entity=Tubo` e
  `rete=RAD-DEFAULT`; marker
  `RADIANT_PIPE_FILE_UNIQUE_SMOKE_OK`;
- nello stesso run sono rimasti verdi
  `RADIANT_NETWORK_ARCHIVES_SMOKE_OK`,
  `TERMODEL_LOG_OPTIONS_SMOKE_OK`, `PROJECT_LOCK_SMOKE_OK` e
  `GITHUB_FEEDBACK_SMOKE_OK`;
- il primo smoke dedicato, run #151, era fallito soltanto perché il test
  presumeva un gruppo SVG `<g>...</g>`; il ProgettoVuoto usa correttamente
  `<g ... />`. Il test è stato corretto per entrambe le forme e il run #153
  ha superato l'intero percorso;
- **frontend pubblicato:** GitHub Pages run **#776**
  (run id `35867394600`) completato con **success** dopo build, deploy e
  report build status;
- **confrontato con riferimento:** SI per formato CAD/layer/colore/linetype e
  punto di ingresso `LeggiDxf/IoPannelli`; NO per equivalenza del solver
  pannelli, che non è ancora implementato nel Service;
- `definizionedati.json`, `TERMODEL-PROJECT-TEXT-V1` e Library Desktop
  non sono stati modificati;
- commit principali:
  `e30ce3a5d2fe5922e73d03b358d992715a54ed7d`,
  `fffc48e3df745479dcc7aea4a85a9cfb5a82437b`,
  `22aa7f9156812db8754f8dc64deb381bcbca6ef5`,
  `dc31494825f6e284b37dd966a8d30d8a100e8d45`,
  `5534d9112b4ad598d7f55ca46bd24279373fff7e`,
  `e02fdc678b51a02c076407a9240c14a78da9e5a9`,
  `8991dc475f960e4b077f63c7ae633b6def27331c`,
  `6a11a381a73c42db5919d5029803f4a01d2b81b6`,
  `237bfa37cdc9aba24d76b095a3cdee6953c44848`,
  `abed0c44ccdecc6d931d63d1579be984b0a31ce2`,
  `31db33473429660afdb7489b9fe17601043ead4f`.

### INCARICO 2026-09-23 — modalità Edificio/Rete nel pannello CAD 2D
Stato: ESEGUITO

Commissionato:
- modificare esplicitamente il frontend `docs/termodel-ui-demo` nel pannello
  principale del CAD 2D;
- aggiungere un combo `Modalità` con almeno `Edificio` e `Rete`, con
  `Edificio` come modalità iniziale compatibile col comportamento corrente;
- quando `Modalità=Rete`, mostrare un secondo combo `Rete` alimentato
  dall'archivio progetto `Reti`, usando il codice della riga come
  identificatore e una descrizione leggibile per l'utente;
- mantenere il combo `Piano` sempre attivo sia in modalità `Edificio` sia
  in modalità `Rete`, perché una stessa rete può svilupparsi su più piani;
- quando si torna a `Edificio`, nascondere/disattivare il selettore della
  rete senza alterare il piano corrente;
- aggiornare il combo Rete quando cambia/carica il progetto e quando viene
  aggiornato lo stato degli archivi, gestendo in modo leggibile anche
  l'assenza di righe `Reti`;
- in questo incarico la selezione `Rete` è stato operativo del CAD/frontend:
  non implementare ancora la semantica di disegno delle reti, il tagging delle
  entità CAD o il calcolo pannelli;
- non modificare Service API, `TERMODEL-PROJECT-TEXT-V1`,
  `definizionedati.json`, Termodel.Core o Library Desktop.

Risultato:
- frontend portato a **v1.03**;
- aggiunto nella toolbar principale del CAD 2D il combo
  `Modalità = Edificio | Rete`, con `Edificio` come default;
- in modalità `Rete` compare il combo `Rete`, alimentato direttamente da
  `getArchivioWebRecords('Reti')`;
- il valore selezionato è `Reti.Codice`; la voce mostrata è
  `Codice — Descrizione` e le righe con `Attivo=NO` sono marcate
  `non attiva`;
- la scelta iniziale privilegia la prima rete attiva; se la rete precedentemente
  selezionata viene rimossa dall'archivio, la selezione viene riallineata alla
  prima rete attiva disponibile oppure alla prima riga;
- archivio `Reti` vuoto: il combo mostra `Nessuna rete in archivio` ed è
  disabilitato senza generare errori;
- tornando a `Edificio`, etichetta e combo Rete vengono nascosti e
  disabilitati;
- il combo `Piano` resta sempre visibile e attivo: il cambio piano modifica
  soltanto `cadToolbarState.piano` e conserva `modalita` e
  `rete`, quindi la stessa rete resta selezionata passando da un piano
  all'altro;
- l'evento esistente `termodel:archives-updated` richiama
  `cadRefreshToolbarControls()`, quindi il combo Rete viene riallineato dopo
  le modifiche tramite ArchivioWeb;
- la selezione Modalità/Rete è per ora **solo stato operativo del frontend**:
  non viene ancora scritta sulle entità SVG e non modifica il formato progetto;
- nessuna modifica a Service API, contratto Front↔Service,
  `TERMODEL-PROJECT-TEXT-V1`, `definizionedati.json`, Core o Library;
- verifica sintattica completa di `app.js` con parser V8:
  `APP_JS_SYNTAX_OK`; verifica statica dei nuovi elementi:
  `CAD_NETWORK_SELECTOR_STATIC_OK`;
- GitHub Pages run **#762**, run id `35863001579`, head
  `39760155b14ff4b3e0857faa453efedcef74a6cf`:
  **completed / success**;
- prova manuale dei combo nel browser dell'utente: non ancora eseguita;
- commit principali:
  `c00069fc6597225a4f7dcb7bb7935b6db2645158`,
  `a50e5a98c0b1403a0695d41275983dc05e26bb38`,
  `39760155b14ff4b3e0857faa453efedcef74a6cf`.

### INCARICO 2026-09-23 — revisione archivi pannelli radianti: Reti + TipologiePannelli
Stato: ESEGUITO

Commissionato:
- correggere la struttura dati introdotta negli incarichi precedenti:
  per il completamento pannelli radianti gli archivi autorevoli diventano due,
  `Reti` e `TipologiePannelli`;
- `Reti` descrive la tipologia di rete e i parametri di esercizio indipendenti
  dal costruttore; deve essere pensato anche per future reti
  `PannelliRadianti`, `Tubazioni`, `Canali`, pur precompilando ora solo
  il caso pannelli radianti;
- `Reti` contiene, per il caso pannelli, le temperature acqua e gli altri
  parametri di progetto/esercizio che non dipendono dalla casa produttrice;
- `TipologiePannelli` è codificato per casa produttrice/modello e contiene le
  caratteristiche costruttive dipendenti dal prodotto, comprese tubazione,
  diametri/materiale/rugosità e l'elenco dei passi/interassi disponibili
  (necessario in particolare per sistemi a funghetti);
- eliminare dal nuovo template/progetto vuoto la necessità di archivi separati
  `Tubazioni` e `Fluidi` per questa prima fase;
- aggiornare metadata estesi, template Service, ProgettoVuoto frontend,
  ArchivioWeb/menu e contratto Front↔Service coerentemente;
- mantenere `TERMODEL-PROJECT-TEXT-V1` invariato e non modificare
  `definizionedati.json`;
- registrare che in futuro il CAD 2D avrà una combo che seleziona una riga
  dell'archivio `Reti` e determina il tipo di rete che si sta disegnando;
  la combo CAD non viene implementata in questo incarico;
- non modificare ancora gli algoritmi del calcolo pannelli o Darcy.

Risultato:
- la precedente struttura
  `TipologiePannelli / Tubazioni / Fluidi` è dichiarata **SUPERATA**;
- nuovo modello autorevole:
  ```text
  Reti
  TipologiePannelli
  ```
- creato metadata:
  `Server/Termodelwebservice/src/Termodel.WebService/Definitions/reti-pannelli-definizionedati.json`;
- eliminato dal Service il precedente
  `pannelli-tubazioni-definizionedati.json`;
- `Reti` è predisposto per futuri tipi rete, ma oggi ammette soltanto
  `PannelliRadianti`;
- prima riga `Reti`:
  `RAD-DEFAULT`, tipologia `GEN-DEFAULT`, passo 300 mm, acqua,
  35/30 °C, ambiente 20 °C, esterna progetto 5 °C, limite circuito 100 m,
  perdita massima 25.000 Pa, `KLayout=1`,
  `FormulaPerdita=Darcy-Weisbach`;
- `Fluido` e `FormulaPerdita` sono vincolati nel metadata corrente alle
  sole scelte implementate `Acqua` e `Darcy-Weisbach`;
- le proprietà fisiche dell'acqua non sono più archiviate in un archivio
  `Fluidi`: il futuro kernel dovrà ricavarle dalla temperatura media;
- `TipologiePannelli` contiene esclusivamente dati del prodotto/sistema:
  casa produttrice, modello, descrizione, PE-Xa 16x2, D interno 12 mm,
  rugosità 0.0007 mm, barriera ossigeno, matassa 600 m,
  coefficiente resa 5 W/m²K e passi ammessi
  `50;100;150;200;250;300` mm;
- il passo **scelto** appartiene a `Reti`; l'elenco dei passi **ammessi**
  appartiene alla tipologia pannello. La validazione dinamica fra i due è
  registrata ma non ancora implementata;
- i nuovi progetti Service generano soltanto:
  `archives/json|xml/Reti` e
  `archives/json|xml/TipologiePannelli`;
- i template estesi `Tubazioni.json` e `Fluidi.json` sono stati rimossi;
- `ProgFileUnico` usa il nuovo metadata e i due archivi estesi;
- `Termodel.WebService.csproj` distribuisce il nuovo metadata;
- `ProgettoVuoto.termodel.txt` è stato rigenerato:
  contiene `Reti` e `TipologiePannelli`, non contiene
  `Tubazioni` o `Fluidi`, e il manifest contiene hash aggiornati;
- `docs/termodel-ui-demo/progetto-vuoto.js` è stato rigenerato dalla
  stessa risorsa; verifica diretta:
  metadata embedded = metadata Service, `Reti=true`,
  `TipologiePannelli=true`, `Tubazioni=false`, `Fluidi=false`;
- frontend portato a **v1.02**:
  menu `Modifica -> Archivio Reti / Archivio Tipologie pannelli`;
- `ArchivioWeb` mostra i due archivi nelle tab e legge prioritariamente
  `definition/reti-pannelli-definizionedati.json`;
- compatibilità transitoria: se un vecchio progetto contiene
  `definition/pannelli-tubazioni-definizionedati.json`, ArchivioWeb può
  ancora leggerlo; eventuali sezioni legacy `Tubazioni`/`Fluidi` non
  vengono cancellate automaticamente al semplice caricamento/salvataggio;
- contratto Front↔Service aggiornato alla **v1.9**;
- registro
  `Server/Termodelwebservice/docs/TUBAZIONI-DEVELOPMENT-REGISTER.md`
  revisionato: niente database `Tubazioni/Fluidi` separato per il ramo
  pannelli; il vecchio `base.dat` resta fonte di studio per il futuro
  programma generalista;
- decisione CAD registrata:
  futura combo `Rete` -> `Reti.Codice` -> `TipoRete` determina il
  tipo di rete disegnata; **NON IMPLEMENTATA** in questa fase;
- algoritmi pannelli, Darcy, geometria spirali, `definizionedati.json` e
  `TERMODEL-PROJECT-TEXT-V1` non modificati;
- **compilato:** SI, GitHub Actions Service run **#144**
  (run id `35854123945`), Build Release con **0 Error(s)**;
- **eseguito/testato:** SI per generazione progetto nuovo e smoke HTTP;
  marker `RADIANT_NETWORK_ARCHIVES_SMOKE_OK`,
  `TERMODEL_LOG_OPTIONS_SMOKE_OK`,
  `PROJECT_LOCK_SMOKE_OK`, `GITHUB_FEEDBACK_SMOKE_OK`;
- **frontend pubblicato:** GitHub Pages run **#758**
  (run id `35854209496`) completato con successo;
- **confrontato con riferimento:** i valori iniziali sono stati ricollocati
  rispetto agli hard-coded correnti di `DatiProgettoPannelli` senza
  modificare gli algoritmi; la lettura runtime da parte del solver resta il
  prossimo passo;
- commit chiave:
  `bedc754e51f02f4468283e77a4671e24db26617e`,
  `f1a522aeb275e775631ac91c68863bbffc13005d`,
  `2835851dacb46e02a30da9827af5c8eecf005afd`,
  `fc5f4b3ae09b1a29a140e4fe3e2d33ed0980723e`,
  `90cc9cd8cd3b074ef5e5fa574ae19fced62287dd`,
  `06910829a433bf5d935af8c3ba6bd42d95fc6bd2`,
  `66aac096b985048b8f0e7c302cff7c69701e98f3`,
  `a57f8805e4dff0c91c0b8fdc4fb7dcf825fc3445`,
  `9491b89a10dcad8a00a4fc7f3d63e698ace03366`.

### INCARICO 2026-09-23 — voci archivi pannelli nel menu frontend
Stato: ESEGUITO — **SUPERATO dalla successiva revisione Reti + TipologiePannelli**

Commissionato:
- aggiungere al menu frontend le voci per gli archivi progetto
  `TipologiePannelli`, `Tubazioni` e `Fluidi`;
- collegare le voci al motore unico `ArchivioWeb` esistente tramite
  `data-archive`;
- rendere effettivamente apribili i tre archivi usando i metadata estesi già
  trasportati nel `TERMODEL-PROJECT-TEXT-V1`, senza modificare o duplicare
  `definizionedati.json`;
- aggiungere i tre archivi alle tab interne della finestra Archivi;
- non modificare algoritmi pannelli, Service API o formato progetto.

Criteri di completamento:
- tre voci visibili nel menu frontend;
- apertura corretta di griglia/form per i tre archivi nel progetto vuoto;
- metadata caricati dalla sezione progetto
  `definition/pannelli-tubazioni-definizionedati.json`;
- progetti precedenti senza i nuovi archivi restano caricabili;
- verifica frontend e pubblicazione GitHub Pages;
- Summary aggiornato allo stato reale.

Risultato:
- aggiunte in `docs/termodel-ui-demo/index.html`, menu `Modifica`, le voci:
  `Archivio Tipologie pannelli`, `Archivio Tubazioni`,
  `Archivio Fluidi`, tutte collegate tramite `data-archive`;
- `ARCHIVE_ORDER` di `archivio-web.js` esteso con
  `TipologiePannelli`, `Tubazioni`, `Fluidi`, quindi i tre archivi
  compaiono anche nelle tab interne della finestra Archivi;
- `ArchivioWeb` mantiene una copia dello schema storico base e, ad ogni
  progetto caricato, integra i metadata presenti nella sezione
  `definition/pannelli-tubazioni-definizionedati.json`;
- nessuna modifica e nessuna duplicazione del file storico
  `definizionedati.json`;
- i metadata estesi sono quindi realmente quelli trasportati dal progetto;
- sui progetti precedenti senza metadata/archivio esteso il caricamento del
  progetto resta compatibile; la richiesta esplicita di una nuova voce assente
  produce ora un errore chiaro invece di aprire silenziosamente un altro
  archivio;
- versione frontend portata a **1.01** e import `archivio-web.js` portato a
  cache key **0.81**;
- contratto Front↔Service aggiornato alla **v1.8**: le tre voci archivio sono
  ora parte della UI implementata; il futuro sottomenu generalista
  `Tubazioni` con funzioni di calcolo resta distinto e sospeso;
- registro `TUBAZIONI-DEVELOPMENT-REGISTER.md` aggiornato:
  `voci archivio frontend = IMPLEMENTATE`,
  `sottomenu generalista Tubazioni = SOSPESO`;
- GitHub Pages run **#725**, run id `35851842080`, commit frontend
  `4216a670ca78def2f0e7754a0c887bba96b803ad`:
  build Jekyll **success**, deploy Pages **success**, report build status
  **success**;
- il precedente Service build avviato dalla registrazione dell'incarico,
  run **#125**, è terminato con successo; nessuna modifica Service runtime è
  stata necessaria;
- verifica del percorso logico frontend eseguita sul codice:
  menu `data-archive` -> `openArchivioWeb(name)` -> schema esteso del
  progetto -> records `archives/json/<name>.json` -> form/griglia
  `ArchivioWeb`;
- **compilato:** non applicabile come binario per il frontend statico; build
  GitHub Pages riuscita;
- **eseguito:** pubblicazione GitHub Pages riuscita;
- **testato:** struttura/menu/schema e deploy automatico verificati; il click
  manuale nel browser dell'utente resta una verifica reale separata;
- **confrontato con riferimento:** coerente con il motore unico ArchivioWeb e
  con gli archivi progetto introdotti nell'incarico precedente;
- algoritmi pannelli, Service API, protocollo progetto e
  `definizionedati.json` non modificati;
- commit principali:
  `a065bde25e3ae1ec3084c6d36b0e69a49960bccc`,
  `e49d9a1774b69e2462e2c6c4e2479a0d1588926c`,
  `356cb28449f6926a3c46af452c65f5ab065a7451`,
  `be6ef9340ee1f64205f6ec4a4cf9cf6780ff9939`,
  `d33e2241652749c03a37bacedbdfc1f85d49dd46`,
  `a15ec69165a0d29a876475da9d5f22ef101d97f3`,
  `4216a670ca78def2f0e7754a0c887bba96b803ad`,
  `1e70bc65625a65638040f43716c20116a8aec13d`,
  `838926d57b5a48f3178ddc4be88c61cbebeafc95`.

### INCARICO 2026-09-23 — completamento calcolo pannelli radianti: archivi progetto
Stato: ESEGUITO — **SUPERATO dalla successiva revisione Reti + TipologiePannelli**

Commissionato:
- classificare l'intervento come **completamento calcolo pannelli radianti**;
- creare tre archivi progetto indipendenti e precompilati:
  `TipologiePannelli`, `Tubazioni`, `Fluidi`;
- `TipologiePannelli` deve essere identificato per casa produttrice/modello e
  contenere inizialmente tutti i parametri oggi hard-coded come default in
  `SorgentiTermodel/Library/Impianti/Pannelli/CalcoloPannelli.cs`;
- `Tubazioni` deve contenere almeno il tubo radiante default già specificato
  per il primo calcolo idraulico;
- `Fluidi` deve contenere almeno acqua con proprietà necessarie al calcolo
  Darcy in funzione della temperatura;
- i tre archivi devono essere dati di progetto reali e devono comparire nel
  `TERMODEL-PROJECT-TEXT-V1` consolidato;
- il `ProgettoVuoto` usato dal frontend deve contenerli già precompilati;
- il Service e il frontend devono leggere/conservare gli archivi senza creare
  formati concorrenti;
- mantenere separato `definizionedati.json` Termodel esistente: introdurre
  metadata Tubazioni/Pannelli separati se necessario;
- preparare la struttura perché il successivo calcolo pannelli legga i default
  dall'archivio `TipologiePannelli` invece che da costanti C#;
- non implementare in questo incarico il futuro sottomenu generale
  `Tubazioni`, che resta sospeso salvo quanto strettamente necessario a
  conservare/mostrare i dati progetto;
- non alterare algoritmi geometrici delle spirali.

Criteri di completamento:
- tre archivi presenti nel template autorevole e nel progetto vuoto consolidato;
- frontend conserva i tre archivi in apertura/modifica/ricostruzione del file
  unico;
- schema di `TipologiePannelli` copre tutti gli attuali default
  `DatiProgettoPannelli`;
- almeno una riga default coerente con gli attuali valori C#;
- `Tubazioni` precaricato con PE-Xa 16x2 per pannelli;
- `Fluidi` precaricato con acqua e proprietà sufficienti al futuro Darcy;
- contratto Front↔Service aggiornato se il contenuto obbligatorio del progetto
  cambia;
- build Release e smoke del progetto nuovo;
- verifica che il progetto vuoto frontend contenga realmente le tre sezioni;
- registro `TUBAZIONI-DEVELOPMENT-REGISTER.md` e Summary aggiornati allo
  stato reale.

Risultato:
- creato metadata separato
  `Server/Termodelwebservice/src/Termodel.WebService/Definitions/pannelli-tubazioni-definizionedati.json`;
  `definizionedati.json` storico non modificato;
- creati nel template Service gli archivi precompilati
  `extended-archives/TipologiePannelli.json`,
  `Tubazioni.json`, `Fluidi.json`;
- `TipologiePannelli` contiene la riga `GEN-DEFAULT`,
  `CasaProduttrice=Generico`, `Modello=Default Termodel`, con tutti gli
  11 valori precedentemente hard-coded in `DatiProgettoPannelli`:
  passo 0,30 m, tubo 16x2, temperature 35/30/20/5 °C, matassa 600 m,
  lunghezza massima circuito 100 m, perdita massima 25.000 Pa e coefficiente
  resa 5 W/m²K;
- la tipologia default referenzia inoltre
  `CodiceTubazione=PEXA-O2-16X2` e `CodiceFluido=H2O`;
- `Tubazioni` contiene PE-Xa 16x2 mm, D interno 12 mm, rugosità
  0,0007 mm, barriera ossigeno e Darcy-Weisbach;
- `Fluidi` contiene acqua H2O con punti proprietà 30/35/40 °C;
- `ProgFileUnico` carica automaticamente gli archivi estesi dal template e
  li inserisce nel progetto nuovo sia come `archives/json/*.json` sia come
  `archives/xml/*.xml`; aggiunge anche
  `definition/pannelli-tubazioni-definizionedati.json`;
- corretta la normalizzazione dei valori JSON estesi in tipi CLR primitivi
  prima della serializzazione XML, evitando `JsonElement` nel
  `DataContractSerializer`;
- il nuovo metadata viene copiato in output/publish dal
  `Termodel.WebService.csproj`;
- aggiornato il progetto vuoto consolidato
  `SorgentiTermodel/Library/projects/ProgettoVuoto/ProgettoVuoto.termodel.txt`
  con metadata e sezioni XML/JSON dei tre archivi;
- rigenerato
  `docs/termodel-ui-demo/progetto-vuoto.js` dalla risorsa consolidata;
- verificato il percorso frontend esistente: `archivio-web.js` acquisisce
  tutte le sezioni `archives/json/*`, `getArchivioWebState()` espone tutte
  le chiavi archivio e `app.js` ricostruisce il file unico passando tutte le
  collection a `buildTermodelProjectText`; pertanto i tre archivi vengono
  conservati anche se non sono ancora esposti in `ARCHIVE_ORDER`;
- il futuro menu/sottomenu `Tubazioni` resta **SOSPESO** e non è stato
  implementato;
- contratto Front↔Service aggiornato alla **v1.7**, sezione
  `2.0.1 Archivi di progetto per completamento pannelli radianti`;
- registro autonomo Tubazioni aggiornato con la milestone
  `completamento dati di base pannelli radianti`;
- README template Service e ProgettoVuoto aggiornati;
- GitHub Pages relativo al commit frontend
  `dd2ed57029bbfbe672840e2dfa78c8c972532582`: run
  **#711**, completato con successo;
- GitHub Actions Service run **#121** ha dato:
  Build Release **153 warning, 0 errori** e smoke progetto/log riuscito,
  incluso `RADIANT_PROJECT_ARCHIVES_SMOKE_OK`; lo smoke feedback separato è
  fallito per una race preesistente all'avvio dello stub locale (porta 5099
  non ancora in ascolto);
- stabilizzato lo smoke feedback sostituendo il ritardo fisso con retry
  esplicito fino a disponibilità dello stub;
- GitHub Actions Service run **#123**, commit
  `2c6f477287744131dec381b9ee26666716222299`: **successo completo**;
  Build Release 0 errori, smoke progetto/lock/log success, nuovo marker
  `RADIANT_PROJECT_ARCHIVES_SMOKE_OK`, e smoke feedback
  `GITHUB_FEEDBACK_SMOKE_OK`;
- **compilato:** SI, GitHub Actions Release;
- **eseguito:** SI, generazione reale via `POST /api/projects/new` nello
  smoke HTTP;
- **testato:** SI per presenza/sezioni/contenuto iniziale dei tre archivi nel
  progetto Service, presenza nel ProgettoVuoto statico, regressioni project
  lock/log e feedback;
- **confrontato con riferimento:** valori della tipologia default confrontati
  con gli hard-coded correnti di `CalcoloPannelli.cs`; la lettura runtime di
  tali archivi da parte del solver pannelli è predisposta ma resta il prossimo
  intervento;
- non modificati algoritmi geometrici delle spirali;
- commit principali:
  `bf12ba9d3c58ac7c198e4787867074d0e4e31b54`,
  `615cfbea94159bf9faa6a17f30af43d0792ee165`,
  `94c23c28bde49167bf04dd9efef78340789f49ff`,
  `30ef99605037b81f732c0d808b458f046fab0a52`,
  `beeaf415422ad909d97d1c6d6682ed74af596d84`,
  `f87f1cd160cd9329fb1ba1471666a0e7e2eeced6`,
  `09ea1f8794ef2baa8c520a2d7a993c7f7ac14601`,
  `47bc4d314ef9ab8314048a45833e248b871a5f21`,
  `dd2ed57029bbfbe672840e2dfa78c8c972532582`,
  `439cb7215323812b4295245c15ca787e6a12dcbb`,
  `2e155845fca706a2373894ff6db46c43fcae8297`,
  `6ce39bba2db38a89d8b6771d627e56e63566519c`,
  `2c6f477287744131dec381b9ee26666716222299`.

### INCARICO 2026-09-23 — specifica perdite di carico pannelli radianti
Stato: ESEGUITO

Commissionato:
- definire e registrare le specifiche della prima funzione operativa della nuova
  linea Calcolo Tubazioni: calcolo delle perdite di carico dei circuiti dei
  pannelli radianti;
- NON usare come sorgente autorevole la lunghezza delle spirali già generata,
  perché può risultare corrotta;
- ricavare una lunghezza idraulica della spirale da superficie servita e passo
  tubo mediante una relazione empirica/documentata, da verificare su fonti
  tecniche esterne;
- sommare alla lunghezza stimata della spirale la lunghezza reale dei tubi di
  collegamento fra collettore e circuito;
- usare portata, lunghezza totale, diametro/proprietà della tubazione e fluido
  per il calcolo delle perdite di carico tramite la nuova libreria Tubazioni;
- usare come formula predefinita Darcy-Weisbach, con fattore d'attrito
  determinato in modo coerente col regime di moto e con la rugosità;
- progettare contestualmente gli archivi indipendenti Tubazioni e Fluidi,
  predisposti per il futuro programma generalista;
- caricare almeno una famiglia di tubazione idonea ai pannelli radianti e il
  fluido acqua, dopo verifica tecnica del materiale/nomenclatura corretta;
- prevedere una futura gestione UI tramite sottomenu "Tubazioni", ma lasciarla
  esplicitamente IN SOSPESO in questa fase;
- mantenere l'obiettivo di questa fase limitato alla produzione del dato
  "perdita di carico del circuito"; il completamento del programma generalista
  verrà affrontato successivamente.

Vincoli:
- aggiornare il registro autonomo
  `Server/Termodelwebservice/docs/TUBAZIONI-DEVELOPMENT-REGISTER.md`;
- non implementare ancora solver, archivi runtime, menu, frontend o integrazione
  in `Aggiorna Modello`;
- non modificare `definizionedati.json`, Library Pascal o protocollo progetto;
- distinguere chiaramente dati derivati empiricamente, dati geometrici reali e
  parametri idraulici di archivio.

Criteri di completamento:
- relazione superficie/passo -> lunghezza registrata con ipotesi e coefficiente
  di correzione separato/configurabile;
- definito il contributo dei tubi di collegamento;
- definito il set minimo di input/output del calcolo Darcy;
- definiti gli archivi minimi Tubazioni e Fluidi e i dati iniziali da
  precaricare;
- annotato il materiale corretto per tubi radianti sulla base delle fonti;
- sottomenu Tubazioni registrato come sospeso;
- Summary aggiornato con lo stato reale.

Risultato:
- aggiornato
  `docs/TUBAZIONI-DEVELOPMENT-REGISTER.md` con la specifica completa della
  prima funzione operativa;
- la lunghezza grafica della spirale è stata esplicitamente esclusa dagli input
  autorevoli del calcolo idraulico;
- adottata la relazione
  `L_spirale = AreaServita * F_passo * K_layout`, con fattori Uponor
  verificati: 100 mm -> 10.0 m/m², 150 mm -> 6.7 m/m²,
  200 mm -> 5.0 m/m², oltre alla tabella 50/125/175/300 mm;
- `K_layout` registrato a 1.000 di default e modificabile soltanto dopo
  regression test; esclusa qualunque maggiorazione commerciale 5-10% dalla
  lunghezza idraulica;
- i collegamenti mandata+ritorno fra collettore e spirale sono sommati usando
  la loro lunghezza geometrica reale;
- confine prima versione definito da uscita collettore a ingresso collettore;
  collettore, flussimetri, valvole e altre perdite concentrate sono rinviati al
  programma generalista;
- definito il set minimo input:
  superficie, passo, lunghezza collegamenti, portata, codice tubo, codice
  fluido e temperatura media;
- formula default registrata: Darcy-Weisbach; velocità e Reynolds in SI,
  `f=64/Re` in laminare, Colebrook-White in turbolento; transizione da
  trattare con diagnostica e regola numerica da fissare nel kernel;
- definito output minimo comprendente lunghezze stimate/reali, velocità,
  Reynolds, fattore Darcy, perdita lineare e perdita circuito Pa/kPa;
- progettati gli archivi minimi `Tubazioni`/`DiametriTubazioni` e
  `Fluidi`/`ProprietaFluidi`;
- la richiesta iniziale "PVC" è stata verificata contro documentazione
  produttori: per pannelli radianti il default corretto è PE-X/PEX o PE-RT;
  registrato come prima famiglia `PEXA-O2`, PE-Xa con barriera ossigeno,
  16x2 mm, diametro interno 12 mm;
- il PPI 2024 indica per PEX rugosità assoluta 0.0005-0.0007 mm:
  registrato 0.0007 mm come valore iniziale conservativo/modificabile;
- primo fluido registrato: `H2O / Acqua`, liquido Newtoniano con proprietà
  tabellate/interpolate in funzione della temperatura; riportati riferimenti
  30/35/40 °C per densità e viscosità;
- futura UI registrata:
  `Tubazioni -> Archivio tubazioni / Archivio fluidi`;
  **stato UI: IN SOSPESO**;
- T1 resta IN CORSO: è definito il nucleo minimo per pannelli, mentre il
  mapping generalista completo di `base.dat` resta successivo;
- nessun solver, archivio runtime, menu, frontend o integrazione
  `Aggiorna Modello` implementati;
- `definizionedati.json`, Library Pascal e protocollo progetto non modificati;
- **compilazione:** non eseguita/non applicabile, modifica documentale;
- **esecuzione:** non eseguita;
- **test numerici:** non eseguiti; specifiche da validare nella futura
  implementazione con casi sintetici e regression test;
- commit specifica:
  `fe12046b4d1f193399b1d73bba640d48187594df`.

### INCARICO 2026-09-23 — registro sviluppo autonomo Calcolo Tubazioni
Stato: ESEGUITO

Commissionato:
- studiare i sorgenti Pascal storici presenti in
  `SorgentiTermodel/Library/SorgentiPascal/` relativi al calcolo reti/tubazioni,
  ai pannelli radianti, alla gestione DXF, alle definizioni `base.dat` e al
  generatore database/form;
- usare tali sorgenti come **fonte di ispirazione funzionale e algoritmica**,
  non come codice da portare ciecamente;
- definire una nuova linea di sviluppo autonoma **Calcolo Tubazioni**, concepita
  come libreria di supporto ai pannelli radianti e futura fase richiamata da
  `Aggiorna Modello`;
- progettare un database JSON indipendente per Tubazioni, ma con la stessa
  impostazione strutturale/di metadati degli archivi JSON Termodel, evitando di
  modificare `definizionedati.json`;
- prevedere generazione/automazione dei form basata sui metadati, secondo il
  principio già usato da Termodel per gli archivi, evitando form codificati a
  mano per ogni tabella;
- studiare la vecchia libreria DXF Pascal per identificare soltanto le
  responsabilità geometriche/di rete riutilizzabili; il nuovo motore non deve
  dipendere obbligatoriamente da AutoCAD o dal filesystem storico;
- creare un registro di sviluppo dedicato in
  `Server/Termodelwebservice/docs/TUBAZIONI-DEVELOPMENT-REGISTER.md` con
  fonti studiate, architettura target, dati, fasi, decisioni, rischi, test e
  stato di avanzamento;
- in questo incarico non implementare ancora il motore Tubazioni e non
  modificare frontend, Library Pascal, `TERMODEL-PROJECT-TEXT-V1` o
  `definizionedati.json`.

Criteri di completamento:
- individuare e classificare i sorgenti Pascal realmente rilevanti;
- descrivere il flusso storico dati → grafo/rete → calcolo → risultati/DXF;
- definire il confine fra nuovo Core Tubazioni, database JSON, generatore form
  e adattatore futuro per `Aggiorna Modello`;
- registrare una roadmap autonoma con fasi verificabili e strategia di
  regression test contro i programmi Pascal storici;
- aggiornare il Summary con il percorso del nuovo registro e lo stato reale
  dell'analisi.

Risultato:
- creato il registro autonomo
  `docs/TUBAZIONI-DEVELOPMENT-REGISTER.md`;
- studiato il nucleo storico
  `SorgentiPascal/Pascal/02_Sottosistemi_Completi/.../versione_10/Tubi/`,
  con particolare attenzione a `Calcolo_Tubi.pas`, `PERDCONC.PAS`,
  `EQUIL.PAS`, `UGrafoDXF.pas`, `RITORNO.PAS`, `collettori.pas`,
  `iotubi.pas`, `DATITUBI.PAS`, `OutDXFBM.pas`,
  `UMain_CalcTubi.pas` e `CalcTubiDll.dpr`;
- ricostruito il flusso storico: entità CAD → grafo → controllo topologico →
  propagazione portate → dimensionamento → perdite distribuite/concentrate →
  percorso sfavorito → eventuale equilibratura/valvole/portate effettive →
  risultati e output grafico;
- identificato nel Pascal il nucleo fisico da reimplementare come funzioni
  pure: propagazione portate, Darcy/Colebrook, perdite concentrate,
  dimensionamento per limiti di velocità/perdita, percorso critico ed
  equilibratura;
- studiato il `base.dat` Tubazioni storico: tre copie della versione 10
  risultano sullo stesso Git blob
  `a643c307657969b756d53cbeca484a20463596dc`; mappati i principali
  archivi `Reti`, `Tubazioni`, `Diametri`, `MatTubi`, `Perdite`,
  `TipiRete`, terminali e perdite concentrate;
- studiato il generatore storico `GENERA`: i token `INI`, `CMB`,
  `LKK`, `GRD`, `DEC` e le relazioni master/slave pilotavano
  generazione di record, DB, form, combo, lookup e griglie;
- confrontato il precedente con l'attuale automazione Termodel
  `AutoForm.cs` / `FormArchivio.xaml.cs` e
  `definizionedati.json`: registrata la decisione di creare un
  `tubazioni-definizionedati.json` indipendente ma compatibile nelle
  convenzioni metadata e un database operativo JSON autonomo;
- chiarito che il Desktop Termodel corrente usa il JSON soprattutto come
  metadata mentre molti dati archivio sono persistiti in XML; il nuovo
  database Tubazioni sarà invece esplicitamente JSON senza modificare il
  formato degli archivi Termodel esistenti;
- studiata la vecchia gestione DXF/AutoCAD: le convenzioni geometriche,
  terminali, valvole, collettori, curve e diramazioni restano riferimenti,
  mentre script AutoCAD, `WinExec` e file temporanei non entreranno nel
  nuovo Core;
- verificato il collegamento moderno con i pannelli:
  `CalcoloPannelli.cs` possiede già DTO di circuiti/lunghezze/potenze,
  `IoPannelli` genera `retePannelli.xml` con nodi/tratti e `IoTubi`
  usa il grafo per collettore e collegamenti; il nuovo solver riceverà quindi
  un `TubazioniNetwork` neutro tramite adapter Pannelli, senza dipendere
  direttamente dal DXF;
- definita roadmap T0–T9: dati/schema, dominio grafo, kernel idraulico,
  equilibratura, adapter Pannelli, regression Pascal/golden, drawing result,
  integrazione `Aggiorna Modello`, UI metadata-driven;
- **compilazione:** non eseguita e non richiesta, perché questo incarico ha
  modificato soltanto documentazione/registro;
- **esecuzione/test:** non applicabili in questa fase; nessun motore Tubazioni
  è stato dichiarato implementato;
- **confronto riferimento:** studio statico Pascal/C# completato a livello
  architetturale; regression test numerici Pascal ancora da creare;
- frontend, Library Pascal, `TERMODEL-PROJECT-TEXT-V1` e
  `definizionedati.json` non modificati;
- commit registro:
  `c40b6b5f264a49c94df3dff6b97185b83764c178`.

### INCARICO 2026-09-23 — configurazione log per Aggiorna Modello
Stato: ESEGUITO

Commissionato:
- estendere `POST /api/calculations` (Aggiorna Modello) con parametri opzionali
  per configurare il logging della singola elaborazione;
- usare come categorie autorevoli quelle del Desktop appena acquisite:
  `Sempre`, `colmi`, `spezza`, `Error`, `Svg`, `RedrawHelix`,
  `GeneraModello`, `Performance`, `PontiAutomatici`;
- mantenere piena retrocompatibilità: se non vengono passati parametri di log,
  il Service deve conservare il comportamento headless corrente già verificato;
- introdurre i parametri query opzionali `logEnabled` e `logCategories`;
  `logCategories` accetta elenco separato da virgole, case-insensitive, oltre
  agli alias `all` e `none`;
- quando `logCategories` è specificato, `IsEnabled(...)` deve riflettere
  esattamente le categorie selezionate e le scritture dirette devono essere
  filtrate per categoria; `LogOperation` usa la categoria Desktop `Sempre`
  e `LogError` la categoria `Error`;
- `logEnabled=false` disabilita completamente la raccolta log per quella sola
  elaborazione;
- le opzioni devono essere isolate per richiesta tramite lo stesso meccanismo
  `AsyncLocal`, senza stato globale condiviso fra progetti;
- non modificare `TERMODEL-PROJECT-TEXT-V1`: le opzioni di log sono parametri
  di esecuzione e non dati persistenti del progetto;
- aggiungere alla risposta di `POST /api/calculations` il riepilogo della
  configurazione log effettivamente applicata e registrarla anche in
  `logs/calculation.log`;
- preservare `TermodelLog.md`, `diagnostics.txt`, endpoint
  `GET /api/projects/{projectId}/logs/termodel`, publish transazionale e
  protezione dell'ultimo risultato valido;
- non modificare frontend, Library Desktop o `definizionedati.json`.

Criteri di completamento:
- build Release con 0 errori;
- smoke HTTP del comportamento predefinito invariato;
- smoke con `logEnabled=false`;
- smoke con filtro di categoria e con `logCategories=all`;
- verifica rifiuto di categoria sconosciuta con errore client strutturato;
- verifica isolamento fra elaborazioni successive con configurazioni diverse;
- aggiornare README, contratto condiviso e questa voce a `Stato: ESEGUITO`
  soltanto dopo build e smoke riusciti.

Risultato:
- **API implementata:** `POST /api/calculations` accetta
  `logEnabled=true|false` e `logCategories=<elenco>` come query parameter;
  il body resta il normale `TERMODEL-PROJECT-TEXT-V1`;
- **categorie:** l'adattatore headless usa ora gli stessi nomi del riferimento
  Desktop: `Sempre`, `colmi`, `spezza`, `Error`, `Svg`,
  `RedrawHelix`, `GeneraModello`, `Performance`,
  `PontiAutomatici`;
- **retrocompatibilità:** senza parametri resta la modalità
  `service-default`: tutte le scritture dirette già raccolte dal Service
  continuano a essere raccolte, mentre i blocchi protetti da
  `IsEnabled(...)` restano disattivati;
- **modalità filtrata:** se `logCategories` è presente,
  `IsEnabled(category)` e le scritture dirette rispettano esclusivamente le
  categorie selezionate; `LogOperation` è associato a `Sempre` e
  `LogError` a `Error`;
- supportati alias `all` e `none`; i nomi categoria sono
  case-insensitive; categoria sconosciuta o lista vuota → HTTP 400 con
  validation problem e calcolo non avviato;
- `logEnabled=false` produce modalità `disabled` e nessuna diagnostica
  raccolta per quella elaborazione;
- configurazione e messaggi sono isolati per elaborazione con `AsyncLocal`;
  `GeneraModello.GeneraAsync` riceve la configurazione senza introdurre
  stato persistente nel progetto;
- la risposta di `POST /api/calculations` include il nuovo oggetto additivo
  `logging { enabled, mode, categories }`;
- `logs/calculation.log` registra ora anche `logEnabled`, `logMode` e
  `logCategories`; `TermodelLog.md` e `diagnostics.txt` continuano a
  contenere i messaggi effettivamente raccolti;
- preservati publish transazionale, ultimo log valido su errore, endpoint
  `GET /api/projects/{projectId}/logs/termodel` e header stale;
- README, contratto condiviso **v1.6**, `TERMODEL-SYNC.md` e
  `docs/copied-from-termodel.md` aggiornati;
- **compilazione:** GitHub Actions `TermodelService Build` run **#101**,
  commit `d3ee3afa7d40dd30c2235c5729f882090d20ced4`: Build Release riuscita
  con **153 warning, 0 errori**;
- **smoke HTTP:** nello stesso run #101 lo step
  `Smoke test HTTP project storage and exclusive locks` è riuscito e i log
  del job riportano esplicitamente `TERMODEL_LOG_OPTIONS_SMOKE_OK`,
  `TERMODEL_LOG_SMOKE_OK` e `PROJECT_LOCK_SMOKE_OK`;
- lo smoke verifica realmente: comportamento predefinito non vuoto,
  `logEnabled=false` con zero diagnostiche e file log vuoto, filtro
  `Error` senza messaggi `info/operation`, `logCategories=all` con tutte
  le 9 categorie, categoria sconosciuta → HTTP 400 senza sostituire il log
  precedente e assenza di contaminazione del log del progetto A durante le
  elaborazioni configurate del progetto B;
- **verifica tree documentato:** GitHub Actions run **#104**, commit
  `e5438f8155b16ae3ce6f780f3e7b48f3c94c50c7`, completato con successo
  per Build, smoke project/log e smoke feedback;
- **frontend:** non modificato;
- **Library Desktop:** non modificata;
- **definizionedati.json:** non modificato;
- commit principali:
  `dc71fd329ea1eb00a09d20e7d185b8f814b02585`,
  `a367321570ef2abdc7871463977ffce2ac679955`,
  `b8fc9a4ec3477fce068963c365ce02894b8380ff`,
  `0d5fe4f33ee92d885c4363160a9d6a89745cfcb7`,
  `d3ee3afa7d40dd30c2235c5729f882090d20ced4`,
  `8023cbf6e0af0b562cf0c553afa034eb91f68a06`,
  `8fa3d1c935e5baa419b0b51144f6b1e1d774fc33`,
  `e5438f8155b16ae3ce6f780f3e7b48f3c94c50c7`,
  `dcdbdd4b37d021d3b131375444a75d9dfe6cba87`.

### INCARICO 2026-09-23 — acquisizione sorgente Desktop autorevole TermodelLog
Stato: ESEGUITO

Commissionato:
- individuare nel sorgente Desktop locale reale l'implementazione autorevole
  di `TermodelLog` e verificarne provenienza e SHA-256;
- integrare in `SorgentiTermodel/Library/utilities/TermodelLog.cs` una copia
  non adattata e byte-per-byte identica all'originale Desktop;
- confrontare il comportamento Desktop con l'adattatore headless già presente
  in `Compatibility/LegacyCoreAdapters.cs`, preservando lifecycle per-request,
  isolamento `AsyncLocal`, persistenza per progetto ed endpoint già verificati;
- aggiornare `TERMODEL-SYNC.md`, `docs/copied-from-termodel.md` e questo
  Summary eliminando il precedente limite documentale dovuto all'assenza del
  sorgente Desktop nella Library;
- non modificare l'adattatore headless salvo una necessità dimostrata dal
  confronto; non copiare nel runtime server dipendenze WPF, filesystem Desktop,
  finestre di errore o diagnostica grafica IFC/NTS;
- non modificare frontend, `PROJECT-SUMMARY.md` alla radice o
  `definizionedati.json`.

Criteri di completamento:
- copia Library con SHA-256 identico all'originale locale;
- confronto funzionale Desktop/headless documentato per API, categorie,
  lifecycle, persistenza, concorrenza e dipendenze non portabili;
- verifica statica che il sistema headless e il suo contratto pubblico siano
  rimasti invariati;
- stato aggiornato a `ESEGUITO` soltanto dopo le verifiche finali, riportando
  distintamente build, esecuzione e test realmente effettuati.

Risultato:
- **sorgente recuperato:** individuato l'originale Desktop locale
  `utilities/TermodelLog.cs`, 378 righe, SHA-256
  `79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218`;
- **Library integrata:** aggiunto
  `SorgentiTermodel/Library/utilities/TermodelLog.cs` come copia non adattata;
  SHA-256 e confronto byte-per-byte coincidono con l'originale locale; la
  regola `.gitattributes` specifica `-text` impedisce a Git di normalizzare i
  fine riga del solo file copiato e conserva identico anche il blob versionato;
- **confronto Desktop:** il logger Desktop usa file globali
  `TermodelLog.md`/`LogError.md` sotto `GestProg.ProgramPath`, categorie a
  costanti (solo `PontiAutomatici=true`), presentazione errori WPF e funzioni
  diagnostiche dipendenti da SVGHelper, xBIM e NetTopologySuite; conserva
  inoltre rami legacy resi inattivi da ritorni anticipati;
- **confronto headless:** `InitializeLog()`/`Reset()`, buffer `AsyncLocal`,
  raccolta `WriteLog`/`LogOperation`/`LogError`, publish transazionale per
  `projectId` ed endpoint persistente sono requisiti server corretti e restano
  invariati. `IsEnabled(...)` continua a disabilitare i blocchi condizionati di
  debug, mentre le chiamate dirette restano raccolte nel buffer diagnostico;
- **decisione:** il file Desktop acquisito chiude la lacuna della Library ma
  non deve sostituire l'adattatore headless, perché reintrodurrebbe filesystem
  globale, UI e dipendenze non portabili e perderebbe l'isolamento per richiesta;
- aggiornati `TERMODEL-SYNC.md` e `docs/copied-from-termodel.md` con
  provenienza, hash, categorie, differenze e responsabilità delle due versioni;
- **verifica statica:** `LegacyCoreAdapters.cs` è invariato rispetto a
  `origin/main`; frontend, `PROJECT-SUMMARY.md` radice e
  `definizionedati.json` non sono stati modificati;
- **compilazione:** GitHub Actions `TermodelService Build` run **#94**, commit
  `62797e05ad109b957200f8097310daf0ba04a453`: restore e Build completati con
  successo; nessuna build locale eseguita;
- **esecuzione/test HTTP:** nello stesso run #94 sono completati con successo
  `Smoke test HTTP project storage and exclusive locks` e
  `Smoke test GitHub feedback bridge`; il runtime headless e il contratto log
  già verificato dal run #91 restano quindi operativi dopo l'integrazione
  consultiva;
- **commit di integrazione:**
  `d080b8c96657f5fa564f008d967a337c46dae1a1` —
  `Add authoritative desktop TermodelLog reference`.

### INCARICO 2026-09-23 — correzione validazione attributi numerici FIN
Stato: ESEGUITO

Commissionato:
- correggere in `Termodel.Core` la routine `CaricaDatiFinestra(...)` che valida
  gli attributi numerici dei blocchi FIN usando erroneamente
  `DatiFinestra.Tipo` invece del valore corrente dell'attributo;
- applicare la correzione a `ALTEZZA`, `LARGHEZZA`, `NUMEROANTE`,
  `SOTTOFINESTRA` e `SOPRALUCE`;
- per `NUMEROANTE` validare il testo prima della conversione intera, evitando
  eccezioni generiche su input non numerico;
- inserire nel sorgente Core un commento esplicito **DA RIPORTARE NEL DESKTOP**,
  indicando l'originale
  `SorgentiTermodel/Library/leggidxf/LeggiDxf.cs`, dove è presente lo stesso
  difetto storico;
- non modificare la Library Desktop in questo incarico: resta sorgente di
  riferimento in sola lettura;
- non modificare frontend, contratto Frontend↔Service o
  `definizionedati.json`.

Risultato:
- corretto
  `src/Termodel.Core/CopiedFromTermodel/Leggidxf/LeggiDxf.cs`: i cinque
  attributi numerici FIN `ALTEZZA`, `LARGHEZZA`, `NUMEROANTE`,
  `SOTTOFINESTRA` e `SOPRALUCE` passano ora il vero `valore` a
  `Utigen.VerificaAttributoNumero(...)`;
- `NUMEROANTE` viene validato prima della conversione con
  `int.TryParse(..., CultureInfo.InvariantCulture)` e produce
  `InvalidDataException` leggibile se non è un intero;
- inserito nel punto della correzione il commento
  `TERMODEL-WEB FIX — DA RIPORTARE NEL DESKTOP`, con riferimento esplicito a
  `SorgentiTermodel/Library/leggidxf/LeggiDxf.cs`;
- la Library Desktop **non è stata modificata**: conserva intenzionalmente il
  difetto come riferimento storico finché la correzione non verrà riportata
  nella versione Desktop;
- verifica statica: 0 chiamate FIN residue che passano
  `DatiFinestra.Tipo`; 5 chiamate corrette che passano `valore`;
- **compilazione:** GitHub Actions `TermodelService Build` run **#69** sul
  commit `fa71bd4cee4968a7f57ad3458ba883f0d6c4e262`: Build Release
  completata con successo;
- **smoke HTTP:** nello stesso run #69 lo step
  `Smoke test HTTP project storage and exclusive locks` è completato con
  successo;
- l'SVG consolidato dell'esempio `Appartamento` è stato verificato: i FIN
  contengono valori numerici reali (ad es. `LARGHEZZA,207.55`,
  `LARGHEZZA,209.22`, ecc.); il precedente HTTP 422 dipendeva quindi dal
  bug Core e non dal dato dell'esempio;
- **test pubblico Appartamento:** non ancora dichiarato verificato dopo il fix;
  va rifatto dal frontend dopo il deploy Render;
- frontend, contratto Frontend↔Service e `definizionedati.json` non sono stati
  modificati in questo incarico;
- commit di codice:
  `fa71bd4cee4968a7f57ad3458ba883f0d6c4e262` —
  `Fix FIN numeric validation in Termodel Core`.

### INCARICO 2026-09-23 — esposizione TermodelLog per progetto
Stato: ESEGUITO

Commissionato:
- verificare il comportamento del logging del Desktop attraverso i sorgenti disponibili in `SorgentiTermodel/Library` e confrontarlo con l'adattatore headless corrente;
- non introdurre un secondo motore di log: riusare `TermodelLog` già chiamato dal codice Desktop/Core e la diagnostica prodotta da `GeneraModello`;
- persistere, a ogni `Aggiorna Modello` riuscito, il log applicativo corrente come `SavedProjects/{projectId}/logs/TermodelLog.md`, mantenendo `diagnostics.txt` e `calculation.log` per retrocompatibilità e metadati tecnici;
- aggiungere `GET /api/projects/{projectId}/logs/termodel` che restituisce il file di log corrente senza rieseguire il calcolo;
- il log deve essere isolato per projectId, sostituito atomicamente insieme al workspace corrente e sopravvivere al riavvio del Service finché persiste lo storage;
- verificare che `TermodelLog.Reset()` avvenga a inizio elaborazione e che `WriteLog`, `LogOperation` e `LogError` siano catturati;
- verificare le differenze residue rispetto al Desktop, in particolare la gestione delle categorie tramite `IsEnabled(...)`; non inventare configurazioni Desktop non presenti nella Library;
- non modificare frontend, `definizionedati.json` o Library Desktop in questo incarico.

Criteri di completamento:
- documentare cosa fa realmente il Desktop sulla base dei sorgenti disponibili e quali parti del logger Desktop non sono ancora presenti nella Library;
- build Release con 0 errori;
- smoke HTTP reale: calcolo di progetto, presenza fisica di `logs/TermodelLog.md`, GET del log con contenuto identico al file, 404 per progetto/log assente e lettura ancora riuscita dopo riavvio Service;
- verificare che una elaborazione fallita non sostituisca il log dell'ultimo calcolo riuscito;
- aggiornare contratto condiviso, README e questa voce a `Stato: ESEGUITO` soltanto dopo build e smoke riusciti.

Risultato:
- **verifica Desktop:** `SorgentiTermodel/Library/MainWindow.xaml.cs` chiama
  `TermodelLog.InitializeLog()` all'avvio e nuovamente prima di
  `Genera_modello()`; i sorgenti del motore usano diffusamente
  `WriteLog`, `LogOperation`, `LogError`, `LogContesto` e categorie
  specifiche. La documentazione Desktop identifica inoltre il file
  `Documenti\\Termodel\\TermodelLog.md` come log da analizzare;
- **limite di confronto:** l'implementazione sorgente Desktop della classe
  `TermodelLog` non è presente in `SorgentiTermodel/Library`: sono presenti
  i chiamanti, ma non il file che definisce persistenza e configurazione delle
  categorie. Non è quindi corretto dichiarare ancora equivalenza completa
  delle categorie verbose;
- **Core headless:** aggiunto `TermodelLog.InitializeLog()` come equivalente
  per-request di `Reset()`; `GeneraModello` lo chiama all'inizio di ogni
  elaborazione. `WriteLog`, `LogOperation` e `LogError` confluiscono
  nello stesso buffer `AsyncLocal`, isolato dalla richiesta corrente;
- `IsEnabled(...)` resta intenzionalmente `false` per i blocchi di debug
  condizionati (`colmi`, `spezza`, ecc.) finché non viene acquisita la
  configurazione Desktop autorevole; le normali chiamate di log restano attive;
- **persistenza:** `ProjectStore` scrive ora
  `SavedProjects/{projectId}/logs/TermodelLog.md` durante il publish
  transazionale dello stesso workspace; `diagnostics.txt` conserva lo stesso
  contenuto per retrocompatibilità, mentre `calculation.log` resta il log
  sintetico con projectId, data, stato e conteggi;
- **endpoint implementato:**
  `GET /api/projects/{projectId}/logs/termodel`; restituisce
  `text/markdown; charset=utf-8`, nome logico `TermodelLog.md` e header
  `X-Termodel-Artifact-Stale`; 404 se il progetto non dispone ancora del log;
- il GET legge esclusivamente il file persistito e non rilancia
  `GeneraModello`;
- un Salva/Salva con nome successivo mantiene il log dell'ultimo calcolo valido
  ma lo espone come stale; un nuovo calcolo riuscito lo sostituisce insieme al
  workspace corrente;
- una elaborazione fallita non pubblica lo staging e quindi conserva il
  `TermodelLog.md` dell'ultimo calcolo riuscito;
- README, contratto condiviso **v1.5** e `TERMODEL-SYNC.md` aggiornati;
- **compilato:** GitHub Actions `TermodelService Build` run **#91**, commit
  `72910f25ed86e6aeacb09b69bc88aa2f25768302`: step Build completato con
  successo;
- **eseguito/testato:** nello stesso run #91 lo smoke HTTP
  `Smoke test HTTP project storage and exclusive locks` è completato con
  successo e verifica: file fisico `TermodelLog.md` presente e non vuoto,
  uguaglianza con `diagnostics.txt`, GET 200 con contenuto identico,
  Content-Type markdown, stale=false subito dopo calcolo, 404 su log
  inesistente, calcolo volutamente invalido HTTP 422 senza modifica SHA-256 del
  log, stale=true dopo Salva con nome e lettura identica dopo riavvio del
  Service; anche lo smoke feedback GitHub è rimasto verde;
- **frontend:** non modificato;
- **Library Desktop:** non modificata;
- **definizionedati.json:** non modificato;
- commit principali:
  `3804348899c9af20448570532fd88ee8fb25f6d8`,
  `437e0d5e70c2292e7fdabe1b50994a3f58266e1f`,
  `deca7c459d3c4b0b6c1a9f724f58cf0477f14194`,
  `3f5f9a45bf69158895cb10bd817930bc03f7938a`,
  `c486e6d25db71e87b75fa6ca9eac09aad5371fa7`,
  `72910f25ed86e6aeacb09b69bc88aa2f25768302`,
  `9f1db6bf227549d699fc89e4234e735955b0ddd6`,
  `3e45258f546d48bfa00aacabddd060f3d2d51ec9`.

### INCARICO 2026-09-23 — inoltro suggerimenti utenti a GitHub
Stato: ESEGUITO

Commissionato:
- progettare e implementare in `Termodel.WebService` un servizio pubblico
  minimale che riceva suggerimenti/bug degli utenti e li inoltri a GitHub;
- usare **GitHub Issues** del repository `Fetonte1960/Termodel` come
  destinazione, evitando commit automatici nel branch `main` e senza
  richiedere un clone Git nel container Render;
- aggiungere `POST /api/feedback` con payload JSON limitato a testo, categoria,
  titolo opzionale e metadati client non sensibili;
- mantenere il token GitHub esclusivamente lato server tramite variabile
  d'ambiente/secret; il browser non deve mai ricevere credenziali GitHub;
- usare un token fine-grained con permesso minimo `Issues: Read and write`
  sul solo repository Termodel;
- accettare feedback soltanto dall'origine Web Termodel configurata, con
  validazione lunghezze/categorie e nessun invio automatico del file progetto,
  projectId, email, IP o altri dati personali nel corpo dell'Issue;
- prevedere protezione antispam/rate-limit in memoria adatta al pretest;
- rendere repository, API base GitHub e origine consentita configurabili per
  test/deploy, mantenendo default `Fetonte1960/Termodel` e
  `https://www.termodel.it`;
- il Service deve restare Linux/container compatible e non dipendere dal
  filesystem persistente Render;
- non modificare frontend in questo incarico: l'endpoint sarà pronto per una
  successiva UI `Invia suggerimento`.

Criteri di completamento:
- build Release con 0 errori;
- test HTTP reale dell'endpoint con GitHub API stub, verificando request issue
  e response `201 Created` senza usare credenziali reali;
- verifica rifiuto origine non autorizzata e payload non valido;
- verifica configurazione mancante → errore strutturato senza crash;
- documentare variabili ambiente e configurazione Render;
- aggiornare contratto condiviso e questa voce a `Stato: ESEGUITO` solo dopo
  build e smoke riusciti.

Risultato:
- **progettato/implementato:** aggiunto
  `src/Termodel.WebService/Feedback/GitHubFeedbackService.cs` e
  `POST /api/feedback`; il Service crea una GitHub Issue nel repository
  configurato, senza eseguire commit, `git push` o richiedere un clone Git;
- il payload accetta `message/category/title/page/appVersion`; categorie:
  `suggestion`, `bug`, `question`, `other`; sono applicati limiti di
  lunghezza e titolo automatico quando manca;
- il campo `page` perde query string e fragment prima dell'invio; il testo
  disarma le mention `@`; non vengono aggiunti automaticamente file progetto,
  `projectId`, email, cookie o IP al corpo dell'Issue;
- il token GitHub resta esclusivamente lato server tramite
  `TERMODEL_FEEDBACK_GITHUB_TOKEN`; repository, origine autorizzata e API base
  sono configurabili con `TERMODEL_FEEDBACK_REPOSITORY`,
  `TERMODEL_FEEDBACK_ALLOWED_ORIGIN` e
  `TERMODEL_FEEDBACK_GITHUB_API_BASE_URL`;
- default: repository `Fetonte1960/Termodel`, origine
  `https://www.termodel.it`, API `https://api.github.com`;
- previsto fine-grained PAT limitato al solo repository con permesso minimo
  **Issues: Read and write**; nessuna credenziale è presente nel repository;
- origine diversa da quella configurata → 403; payload non valido → 400;
  configurazione/token assenti → 503; errore/rete GitHub → 502;
- rate-limit in memoria: massimo 5 feedback per client/10 minuti e 100 globali/
  ora; superamento → 429 con `Retry-After`;
- README e contratto condiviso **v1.4** documentano endpoint, errori,
  configurazione Render e regole di privacy/sicurezza;
- aggiunto `tests/github_feedback_stub.py` e nuovo smoke end-to-end nel
  workflow GitHub Actions; lo stub simula la REST API Issues senza usare
  credenziali reali;
- **compilato:** GitHub Actions run **#82**, commit
  `0989c0e967bcc86edb909a3cbb73498be4b2c658`: build Release riuscita,
  **153 warning, 0 errori**;
- **eseguito/testato:** nello stesso run il WebService ASP.NET è stato avviato
  realmente e lo smoke ha concluso con `GITHUB_FEEDBACK_SMOKE_OK`,
  `issueNumber=4242`; verificati anche il precedente
  `PROJECT_LOCK_SMOKE_OK`, origine non autorizzata 403, payload invalido 400,
  creazione Issue simulata 201, path/API/header GitHub, rimozione query dalla
  pagina, rate-limit 429 e configurazione senza token 503;
- **GitHub reale/Render:** non è stata ancora creata una Issue reale tramite
  Render, perché il secret `TERMODEL_FEEDBACK_GITHUB_TOKEN` deve essere
  configurato esplicitamente nell'hosting; non dichiarare questo livello come
  verificato finché non viene eseguita una prova reale;
- **frontend:** non modificato in questo incarico; la futura UI
  `Invia suggerimento` dovrà limitarsi a chiamare `POST /api/feedback`;
- **confronto con riferimento Desktop:** non applicabile, perché questa è una
  funzione di trasporto/WebService senza algoritmo Desktop;
- commit principali:
  `3351bd74540dfe43c79a881ad5fe6288af77d84a`,
  `9d68b0f05499973cc3e9ea3b363d2b5d613c9d43`,
  `01f9899cffa590bc9a9647e675b057589c3a9ca9`,
  `aaf0444d77ecce930307d35419e9203798507ae9`,
  `52b6460a3e745940a019aae37ddb7d289bb120b0`,
  `0989c0e967bcc86edb909a3cbb73498be4b2c658`.
### INCARICO 2026-09-22 — gestione progetti server e apertura esclusiva
Stato: ESEGUITO

Commissionato:
- implementare lato Termodel.WebService le operazioni server per elenco/apertura,
  Salva, Salva con nome, heartbeat, chiusura e sblocco controllato dei progetti;
- i file persistenti del progetto devono restare sotto
  `SavedProjects/{projectId}/`; il frontend non deve conoscere il path fisico;
- impedire la doppia apertura in modifica dello stesso projectId con lock
  esclusivo e risposta HTTP 423 `Il progetto è già in uso.`;
- consentire contemporaneamente l'apertura di projectId differenti;
- usare un token di lock temporaneo, non persistente nel manifest e non
  assimilabile a calculationId;
- implementare lease/heartbeat e recovery dei lock impropri dovuti a chiusura
  browser, crash, rete o riavvio Service;
- prevedere sblocco controllato: automatico per lock stale, esplicito/forzato
  solo su richiesta confermata per lock ancora vivo;
- proteggere Salva, Salva con nome e Aggiorna Modello con il lock del progetto;
- `Salva con nome` conserva projectId e modifica soltanto il nome leggibile;
- mantenere separati Salva e Aggiorna Modello, marcando gli artifact come
  stale dopo un salvataggio non seguito da ricalcolo;
- non modificare frontend, Termodel.Core, Library o `definizionedati.json`
  durante questo incarico server.

Criteri di completamento:
- build Release della soluzione con 0 errori;
- test HTTP reale di due aperture concorrenti dello stesso progetto con una
  sola riuscita e seconda risposta 423;
- test di apertura simultanea di due projectId differenti;
- test Salva e Salva con nome con verifica del file `project.tmdl` su disco;
- test che Salva con nome conservi il projectId;
- test heartbeat e chiusura/rilascio lock;
- test recovery di lock stale/improprio e riapertura successiva;
- test sblocco controllato e protezione dei file validi;
- test che `POST /api/calculations` rifiuti un token non valido e accetti il
  possessore del lock;
- aggiornare contratto condiviso con endpoint definitivi e questa stessa voce
  a `Stato: ESEGUITO` soltanto dopo i test reali.

Risultato:
- **implementato** lato `Termodel.WebService` con `ProjectStore`,
  `ProjectLockManager` e API server-owned per elenco/apertura, Salva, Salva con
  nome, heartbeat, close, unlock e `POST /api/calculations` protetto dal lock;
- aggiunti endpoint:
  `GET /api/projects`,
  `POST /api/projects/{projectId}/open`,
  `PUT /api/projects/{projectId}/save`,
  `PUT /api/projects/{projectId}/save-as`,
  `POST /api/projects/{projectId}/heartbeat`,
  `POST /api/projects/{projectId}/close`,
  `POST /api/projects/{projectId}/unlock`;
- `POST /api/projects/allocate-id` restituisce anche il lock iniziale;
- token lock trasmesso tramite header `X-Termodel-Project-Lock`; non entra nel
  manifest e non sostituisce `projectId`;
- doppia apertura dello stesso progetto → HTTP 423; progetti differenti possono
  essere aperti contemporaneamente;
- lease lock configurabile con `TERMODEL_PROJECT_LOCK_LEASE_SECONDS`, heartbeat,
  scadenza automatica e recupero dei lock residui dopo crash/riavvio;
- `Salva` e `Salva con nome` persistono `project.tmdl` nella cartella progetto;
  `Salva con nome` conserva il projectId e modifica il nome leggibile;
- salvataggi senza ricalcolo marcano gli artifact come stale tramite
  `project-state.json`; il GET model3d espone `X-Termodel-Artifact-Stale`;
- `POST /api/calculations` richiede un lock valido e pubblica di nuovo artifact
  coerenti/non stale;
- **compilato/eseguito/testato:** GitHub Actions run #62 sul commit
  `cee1343106d2c09864d3c45161701c737d809447` completato con successo;
- verifica nuovamente superata nel run #63 del commit
  `a6aada8df28347cc3d753be86c3a26bf8146638c` con
  `PROJECT_LOCK_SMOKE_OK`; build e smoke HTTP completi riusciti;
- lo smoke verifica realmente doppia apertura 423, apertura simultanea A/B,
  lock errato su calcolo, Salva, Salva con nome, stale artifact, heartbeat,
  sblocco con conferma/force, scadenza lease e recovery dopo restart;
- frontend, Core, Library e `definizionedati.json` non sono stati modificati
  durante l'incarico server;
- confronto Desktop non applicabile alla gestione lock/filesystem; il motore
  algoritmico Core non è stato modificato.

### INCARICO 2026-09-23 — pretest remoto Render e collegamento frontend
Stato: ESEGUITO

Commissionato:
- registrare il nuovo Termodel.WebService pubblico di pretest su
  `https://termodel.onrender.com`, repository `Fetonte1960/Termodel`, branch
  `main`, deploy Docker/Linux/.NET 8;
- considerare Render Free esclusivamente ambiente di collaudo: filesystem
  effimero, `SavedProjects` non definitivo e cold-start dopo inattività;
- mantenere `projectId` come unico identificatore persistente dominante e non
  reintrodurre `calculationId`;
- adeguare il frontend pubblico `https://www.termodel.it` a usare come base URL
  primaria il Service HTTPS Render, mantenendo la possibilità di override per
  sviluppo locale;
- adeguare `Aggiorna Modello` al contratto corrente projectId +
  `X-Termodel-Project-Lock`, rimuovendo le aspettative frontend sul vecchio
  `calculationId`;
- collegare almeno creazione/allocazione projectId, elenco/apertura progetto,
  Salva, Salva con nome, heartbeat/close lock e recupero model3d alle API
  server già implementate;
- PC e Web mobile devono usare lo stesso endpoint pubblico; non introdurre
  dipendenze da un PC locale per il pretest remoto;
- preservare CORS per `https://www.termodel.it`, compatibilità Linux/container
  e porta dinamica `PORT`; non introdurre percorsi Windows;
- non trasformare la persistenza effimera Render Free in una nuova architettura
  di storage.

Criteri di completamento:
- frontend su main usa `https://termodel.onrender.com` come default Service;
- codice frontend non usa più `calculationId` nel workflow corrente;
- chiamate mutanti inviano il lock token corretto;
- apertura e salvataggio progetto passano dalle API Service;
- heartbeat e rilascio lock sono gestiti dal frontend;
- build/smoke Service continuano a riuscire;
- aggiornare contratto e Summary con distinzione fra implementato e verificato
  realmente sul frontend pubblico/mobile.

Risultato:
- **deploy Service:** aggiunto `Server/Termodelwebservice/Dockerfile` nel commit
  `a6aada8df28347cc3d753be86c3a26bf8146638c`; usa immagini .NET 8 Linux,
  publish Release e `ASPNETCORE_URLS=http://0.0.0.0:${PORT:-10000}`, quindi
  non fissa una porta incompatibile con Render;
- **pretest remoto:** l'utente ha verificato il deploy Render pubblico
  `https://termodel.onrender.com`, con `/` e `/health` rispondenti; region
  Frankfurt, piano Free. Questa istanza resta esplicitamente non produttiva;
- filesystem Render Free registrato come effimero: `SavedProjects` serve solo
  al collaudo e non è archivio definitivo dei progetti clienti;
- contratto condiviso aggiornato a **v1.3** con base URL remota, endpoint di
  progetto/lock, vincoli Linux/container, `PORT`, CORS e cold-start Render;
- **frontend implementato:** Termodel Web **v0.95** usa
  `https://termodel.onrender.com` come base URL predefinita mantenendo
  `globalThis.TERMODEL_SERVICE_BASE_URL` come override;
- rimosso `calculationId` dal workflow frontend corrente; il redraw Service
  usa `projectId` e l'href `model3d` restituito da `POST /api/calculations`;
- Nuovo progetto alloca `projectId`/lock e salva il progetto sul Service;
- `File → Apri` usa `GET /api/projects` + `POST /api/projects/{projectId}/open`;
- `Salva` e `Salva con nome` usano le API server e non il download browser come
  storage operativo; Save As conserva lo stesso projectId;
- il frontend mantiene `projectLockToken` solo in memoria, invia
  `X-Termodel-Project-Lock`, esegue heartbeat ogni 45 s e tenta close con
  `keepalive` su `pagehide`;
- `Aggiorna Modello` richiede/riusa il lock, invia il payload tecnico filtrato
  e recupera l'artifact `model3d` corrente;
- il badge 3D mostra `projectId` invece del vecchio calculationId;
- **GitHub Actions Service run #64:** build + smoke completi riusciti, con
  `PROJECT_LOCK_SMOKE_OK`; conferma che le modifiche documentali/frontend non
  hanno rotto il Service;
- **GitHub Pages run #629:** deploy del frontend v0.95 riuscito;
- **non ancora verificato manualmente:** intero round-trip sul sito pubblico,
  Android/mobile reale, doppia apertura da due pagine reali e comportamento
  sleep/wakeup Render. Questi restano test di collaudo utente, non condizioni
  già dichiarate superate;
- nessuna dipendenza da percorsi Windows introdotta; Core, Library e
  `definizionedati.json` non sono stati modificati;
- commit frontend principali:
  `4c9f9e2e591d78f6fd8073096bf734b224409e85` e
  `92664a593846456bcf89065b0001de2807392227`.
- **completamento frontend v0.96:** aggiunto preflight
  `GET /health → GET /api/model/capabilities` prima delle operazioni server,
  con progress di wake-up Render, timeout 90 s e cache readiness 60 s;
- il messaggio di cold start è comune a PC/mobile e scompare al completamento;
- un projectId presente nel file ma non più disponibile sul filesystem
  effimero Render genera un errore esplicito e non viene sostituito
  automaticamente;
- verifica statica JavaScript superata; il round-trip pubblico/mobile e il
  vero sleep/wakeup restano prove runtime da eseguire e non sono dichiarati
  verificati.
### INCARICO 2026-09-22 — projectId unico, persistenza corrente e rimozione calculationId
Stato: ESEGUITO

Questa commissione **sostituisce integralmente** le due precedenti proposte
2026-09-22 sulla persistenza per elaborazione e sulla coesistenza
`projectId`/`calculationId`.

Decisione definitiva:
- `projectId` è l'unico identificatore operativo e persistente del progetto;
- il concetto `calculationId` deve essere eliminato dal nuovo contratto, dalla
  response di `AggiornaCalcolo`, dalle route artifact e dalla persistenza;
- ogni nuova elaborazione riuscita dello stesso `projectId` ricopre i dati
  prodotti dall'elaborazione precedente;
- non viene mantenuto automaticamente uno storico delle elaborazioni.

Commissionato:
- implementare `POST /api/projects/allocate-id` per generare e riservare un
  nuovo `projectId` univoco rispetto ai progetti già presenti, con sicurezza
  anche in caso di richieste concorrenti;
- il Service restituisce il nuovo ID ma non modifica implicitamente il file
  progetto; il frontend lo consoliderà come `manifest.projectId` top-level del
  `TERMODEL-PROJECT-TEXT-V1`;
- `POST /api/calculations` deve leggere e validare `manifest.projectId`; nel
  nuovo flusso un progetto senza ID deve essere prima consolidato dal
  frontend tramite `allocate-id`; non assegnare ID silenziosamente durante il
  calcolo;
- eliminare dalla response di `POST /api/calculations` il riferimento
  `calculationId`; restituire `projectId`, stato, artifact disponibili e
  diagnostica;
- eliminare il modello pubblico di artifact basato su
  `/api/calculations/{calculationId}/artifacts/...` e introdurre le route
  correnti basate sul progetto, a partire da
  `GET /api/projects/{projectId}/artifacts/model3d`;
- il GET artifact deve leggere il file/risultato già prodotto e non deve
  rieseguire `GeneraModello`;
- sostituire o rimuovere `CalculationSnapshotStore` e gli altri componenti
  introdotti esclusivamente per la gestione del `calculationId`, salvo
  eventuali dettagli interni temporanei che non espongano né mantengano il
  concetto nel contratto e che risultino realmente necessari durante la
  migrazione; l'obiettivo finale è non avere un secondo identificatore;
- usare una sola directory persistente per progetto:
  ```text
  SavedProjects/
  └── {projectId}/
      ├── project.tmdl
      ├── artifacts/
      │   ├── model3d.json
      │   └── ... artifact correnti
      └── logs/
          └── ... diagnostica/log correnti
  ```
- ogni `AggiornaCalcolo` riuscito dello stesso projectId deve aggiornare
  atomicamente quella stessa cartella, sostituendo progetto, artifact e log
  precedenti con i nuovi valori;
- l'elaborazione fallita non deve distruggere l'ultimo stato valido. Può
  aggiornare un log di ultimo errore separato, ma non deve pubblicare output
  parziali come stato corrente;
- materializzare almeno `artifacts/model3d.json` e predisporre la stessa
  struttura per piante pulite, XML nazionale, dispersioni, pannelli, spirali,
  DXF e altri artifact futuri;
- `project.tmdl` deve restare la copia UTF-8 del projectText tecnico realmente
  ricevuto ed elaborato con successo, senza sfondi esclusivamente frontend;
- mantenere la root configurabile tramite `TERMODEL_SAVED_PROJECTS_DIR`;
- non modificare `definizionedati.json` e non spostare nel WebService logica
  appartenente al Core.

Criteri di completamento:
- build completa della soluzione riuscita;
- due richieste anche concorrenti a `POST /api/projects/allocate-id` producono
  due projectId differenti e già riservati;
- un progetto con `manifest.projectId=A` produce/aggiorna soltanto
  `SavedProjects/A/`;
- due `POST /api/calculations` successivi con lo stesso projectId non creano
  alcun secondo identificatore e non creano cartelle storiche: la seconda
  elaborazione ricopre i valori persistiti dalla prima;
- la response di `POST /api/calculations` non contiene `calculationId`;
- `GET /api/projects/A/artifacts/model3d` restituisce il `model3d.json`
  corrente senza ricalcolo;
- un secondo progetto con `projectId=B` resta isolato in `SavedProjects/B/`;
- riavviando il WebService gli artifact persistiti restano leggibili tramite
  projectId;
- una elaborazione fallita non sostituisce `project.tmdl` e artifact
  dell'ultima elaborazione riuscita;
- verificare che non restino dipendenze funzionali necessarie dal precedente
  `calculationId` nei nuovi endpoint/DTO/manifest di risposta;
- aggiornare/adeguare i test HTTP e automatici al contratto projectId;
- documentare separatamente compilazione, test, endpoint realmente eseguiti,
  filesystem verificato, artifact e log;
- a lavoro concluso aggiornare questa stessa voce a `Stato: ESEGUITO` con
  risultato reale e commit.

Risultato:
- **implementato:** aggiunti
  `src/Termodel.WebService/Projects/ProjectStore.cs` e
  `ProjectRequestIdentity.cs`; il WebService legge
  `manifest.projectId` dal file unico tramite `ProjectTextDocument` senza
  modificare Termodel.Core;
- implementato `POST /api/projects/allocate-id`: genera GUID, ne riserva
  l'unicità su filesystem e usa `FileMode.CreateNew` per rendere la
  prenotazione sicura anche fra richieste concorrenti; gli ID già persistiti o
  già riservati vengono esclusi;
- `POST /api/calculations` rifiuta con HTTP 422 un progetto senza
  `manifest.projectId` o con ID non allocato dal Service; non assegna ID
  implicitamente;
- la response di `POST /api/calculations` contiene `projectId`,
  `status`, `savedProject.fileName = project.tmdl`, artifact e diagnostica;
  **non contiene più `calculationId`**;
- il workspace corrente è
  `SavedProjects/{projectId}/` con
  `project.tmdl`, `artifacts/model3d.json`,
  `logs/calculation.log` e `logs/diagnostics.txt`;
- ogni aggiornamento riuscito prepara una directory staging e poi sostituisce
  la directory corrente con swap staging/backup; il backup non è storico e
  viene eliminato dopo il commit;
- due elaborazioni dello stesso projectId sono serializzate nel processo
  Service tramite lock per-project, evitando scritture concorrenti sullo
  stesso workspace;
- se `GeneraModello` fallisce, il publish non parte e l'ultimo workspace
  valido resta intatto; lo smoke ha verificato hash invariati di progetto,
  model3d e log dopo un calcolo volutamente fallito;
- implementato
  `GET /api/projects/{projectId}/artifacts/model3d`: legge esclusivamente
  `artifacts/model3d.json` dal disco e non richiama `GeneraModello`;
- rimossi `CalculationSnapshotStore.cs` e il precedente
  `SavedProjectStore.cs`; rimossa la route
  `/api/calculations/{id}/artifacts/model3d`;
- gli endpoint legacy indipendenti dal nuovo modello
  `POST /api/model/3d` e `GET /api/model/clean-floor/{floorName}`
  restano disponibili;
- nessuna modifica a frontend, Termodel.Core, Library o
  `definizionedati.json`;
- **compilato:** GitHub Actions TermodelService Build run **#50**, commit
  `8e29e9a2f988a7d0ff24f111727f89f2aee75c07`: build Release riuscita,
  **154 warning, 0 errori**;
- **eseguito/testato:** nello stesso run il WebService è stato avviato
  realmente e lo smoke `PROJECTID_SMOKE_OK` ha verificato:
  12 `allocate-id` concorrenti tutti distinti, rifiuto di ID non riservato,
  progetto A V1 → A V2 nella stessa singola cartella, sostituzione effettiva
  di `project.tmdl`, `model3d.json` e `calculation.log`, assenza di
  directory staging/backup residue, protezione dell'ultimo stato valido su
  elaborazione fallita, isolamento del progetto B, rimozione della vecchia
  route per-elaborazione e lettura identica degli artifact A/B dopo riavvio
  del Service;
- projectId reali esercitati nello smoke run #50:
  `ceb9463f-3635-4f22-8fb1-aa7902eac931` e
  `4b2a336c-a00f-4dd2-ab3e-115168a4a36c`;
- **confronto con riferimento Desktop:** non applicabile alla persistenza;
  il motore `GeneraModello` non è stato modificato e il confronto golden
  geometrico resta un'attività separata;
- contratto projectId-only aggiornato a versione documento **1.0** nel commit
  `9c70c2b8b454b0d6ebe9a8276eff7cc6dacd6400`; le successive regole
  Apri/Salva server-owned e mobile open-only sono registrate nel contratto **1.1**; la successiva apertura esclusiva e il recovery dei lock impropri sono registrati nel contratto **1.2**;
- commit tecnici principali:
  `f26de11c61ba2815a6ae9e7609e942ff6fb771b2`,
  `039f228039e85f79315b6126f84fe770f5c1f501`,
  `20a86414b690b0f76014a3d14f5c5f8483f8ac9b`,
  `c3c448505ce662a54ff36f3128e9105ad0ffad74`,
  `5700a7c9f1bd02bb74cbc0c67ca94e5bf1aaff68`,
  `211c47b4e00a8dacc1ea851d0425f51f564cafcf`,
  `fe1dc32909d7124b31bec7247084724b8cb49d5f`,
  `8e29e9a2f988a7d0ff24f111727f89f2aee75c07`.

### DECISIONE 2026-09-22 — Apri/Salva progetto gestiti dal Service; mobile open-only

Registrato nel contratto condiviso v1.1:
- nel profilo Web/PC con Termodel.WebService, `Apri progetto`,
  `Salva progetto` e `Salva progetto con nome` sono operazioni di
  persistenza del **Service**, non accessi diretti al filesystem dal frontend;
- il frontend presenta selezione/nome e scambia il
  `TERMODEL-PROJECT-TEXT-V1`, mentre il Service enumera, legge e scrive i
  progetti sul proprio storage;
- `Salva progetto` conserva il `projectId`;
- `Salva progetto con nome` conserva anch'esso il `projectId` e modifica il
  nome/collocazione logica; non equivale a duplicare un progetto;
- una futura `Duplica come nuovo progetto` dovrà ottenere un nuovo
  `projectId`;
- salvataggio del progetto e `Aggiorna Modello` restano operazioni distinte:
  dopo un salvataggio successivo all'ultimo calcolo gli artifact precedenti
  devono essere considerati **stale** finché non vengono rigenerati;
- nella versione mobile/serverless, per questa fase, resta soltanto
  `Apri progetto` tramite host/app e file picker locale; `Salva progetto`,
  `Salva con nome` e catalogo/cartelle server non sono esposti;
- i nomi definitivi delle nuove route HTTP Apri/Salva/Salva con nome non sono
  ancora fissati: questa voce registra il contratto di responsabilità, non
  dichiara tali API implementate;
- nessuna modifica a frontend, Core, Library o `definizionedati.json` in
  questa registrazione.

### DECISIONE 2026-09-22 — cartella progetto, apertura esclusiva e recovery lock

Registrato nel contratto condiviso v1.2:
- tutti i file persistenti del progetto restano reperibili sotto
  `SavedProjects/{projectId}/`; eventuali workspace/staging sono tecnici,
  temporanei e non costituiscono una seconda copia autorevole;
- nel profilo Web/PC con Service, lo stesso `projectId` può essere aperto in
  modifica da una sola pagina/sessione alla volta;
- una seconda apertura concorrente dello stesso progetto deve essere rifiutata
  con HTTP `423 Locked` e messaggio utente `Il progetto è già in uso.`;
- progetti diversi possono restare aperti contemporaneamente;
- l'apertura può restituire un `projectLockToken` opaco e temporaneo, che non
  entra nel manifest e non costituisce un secondo identificatore persistente;
- Salva, Salva con nome, Aggiorna Modello e Chiudi progetto dovranno essere
  autorizzati soltanto dalla sessione che possiede il lock valido;
- il lock deve essere una lease rinnovabile con heartbeat/ultima attività,
  non un flag permanente senza scadenza;
- lock scaduti o abbandonati devono essere recuperabili automaticamente dal
  Service; un riavvio del Service deve poter riconoscere lock non più validi
  senza alterare i file del progetto;
- nei casi dubbi è prevista una futura funzione controllata `Sblocca progetto`;
  se il lock appare ancora vivo/recente, lo sblocco forzato richiede conferma
  esplicita;
- lo sblocco può rimuovere soltanto lock e workspace temporanei abbandonati,
  mai `project.tmdl`, artifact validi o log correnti;
- questa è una decisione di contratto; le API di apertura/heartbeat/chiusura
  e sblocco non sono ancora dichiarate implementate.
### INCARICO 2026-09-21 — Invarianza Polig3D e TermodelWebModel v3 completo
Stato: ESEGUITO

Commissionato:
- riportare `Polig3D` del Core verso il comportamento e la struttura del
  Desktop, evitando la versione semplificata che perde
  `ElementoAssociato/ElementiAssociati`;
- conservare nel Core i metadati semantici necessari a filtri, XML e calcoli:
  piano, confine, separatore, stessaZona, fittizia e falda;
- usare la stessa strategia già adottata per `LeggiDxf`: mantenere il più
  possibile invariata la classe strategica e sostituire solo le dipendenze
  UI/rendering con facciate headless;
- usare xBIM reale come supporto dati IFC in memoria se necessario, senza
  introdurre un secondo motore geometrico o un falso xBIM esteso;
- fare produrre al Core un unico `TermodelWebModel v3` semanticamente
  compatibile con `SorgentiTermodel/Work/Web/DrawBimJson.cs`, senza creare
  formati JSON alternativi;
- mantenere compatibili gli endpoint legacy durante l'intervento;
- non modificare frontend né contratto condiviso salvo necessità esplicita.

Criteri di completamento:
- soluzione Service compilata da GitHub Actions con 0 errori;
- DTO/artifact `TermodelWebModel v3` con i metadati avanzati espliciti;
- semantica di `numero/source/parte` riallineata al riferimento Desktop per
  quanto esercitato dal motore Core;
- stato e limiti reali documentati, distinguendo build, esecuzione HTTP e
  confronto golden;
- aggiornamento della stessa voce a `ESEGUITO` solo a lavoro concluso.

Risultato:
- `CopiedFromTermodel/Model/Polig3D.cs` è ora una copia **byte-per-byte
  identica** a `SorgentiTermodel/Library/leggidxf/Polig3D.cs`; entrambi hanno
  Git blob SHA `d7d835a8a39febb3c3b26bcb88a8cc5cebb19411`;
- il Core usa `Xbim.Essentials 6.1.605` come struttura IFC in memoria richiesta
  dal codice Desktop; non viene prodotto né richiesto un file IFC come artifact;
- WPF/MainWindow/filtri/DrawBim sono sostituiti da facciate headless limitate
  alla superficie richiesta da `Polig3D`;
- `Polig3D.ElementiAssociati`, `Separatore`, `StessaZona`, `Falda`,
  `NomePiano` e le relazioni semantiche Desktop sono conservati e alimentano
  il renderer headless;
- `TermodelWebModel v3` espone campi espliciti
  `filterMetadata/piano/confine/separatore/stessaZona/fittizia/falda`;
- il renderer headless conserva per le primitive generate da
  `DrawPolyEstruso` la semantica Desktop `source=ExtrudedVisual3D,
  parte=lati` e `source=MeshGeometry3D, parte=tappi`, mantenendo
  `numero` uguale all'indice 1-based dell'ElementoAssociato usato dal redraw
  Desktop;
- `Modello.Close_modello` esegue `Polig3D.TrovaConfini` e poi
  `Polig3D.GrafRedraw(... forzaModello3D:true)`, quindi il JSON deriva dal
  catalogo semantico dopo l'analisi confini;
- build GitHub Actions sul commit
  `9eb3ddfccb09d0d610e531c21495456924b2107b`: **0 errori, 154 warning**;
- workflow esteso con smoke HTTP nel commit
  `297d593be6b7e205e3dcb9052d8f6a13cf2878e6`: build riuscita e percorso
  `POST /api/projects/new -> POST /api/model/3d` eseguito con successo sul
  progetto vuoto, verificando `TermodelWebModel v3`, `Z-up` e 0 primitive;
- confronto golden avanzato con le 546 primitive del progetto mansardato:
  **non ancora eseguito**, perché manca ancora il corrispondente file unico SVG
  multipiano utilizzabile dal Service.



### INCARICO 2026-09-21 — Prova AggiornaCalcolo e artifact model3d v3
Stato: ESEGUITO

Commissionato:
- esporre il primo ciclo reale del contratto `AggiornaCalcolo` senza ancora
  integrare XML nazionale, dispersioni o pannelli;
- implementare `POST /api/calculations` con body
  `TERMODEL-PROJECT-TEXT-V1` in `text/plain; charset=utf-8`;
- eseguire una sola volta il motore corrente `GeneraModello`, creare un
  `calculationId` e catturare nello snapshot il `TermodelWebModel v3`
  avanzato già prodotto dal Core;
- esporre
  `GET /api/calculations/{calculationId}/artifacts/model3d` in modo che
  restituisca il JSON già catturato senza rieseguire il calcolo;
- restituire da `POST /api/calculations` almeno
  `contractVersion/calculationId/status/artifacts/diagnostics`;
- mantenere invariati e funzionanti gli endpoint legacy
  `POST /api/model/3d` e `GET /api/model/clean-floor/{floorName}`;
- usare storage temporaneo in memoria per questa prima prova, isolato per
  `calculationId`, senza introdurre persistenza prematura;
- aggiungere uno smoke test HTTP automatico che verifichi creazione progetto,
  aggiornamento, manifest e doppia lettura dell'artifact model3d dallo stesso
  snapshot.

Criteri di completamento:
- build GitHub Actions con 0 errori;
- `POST /api/calculations` eseguito realmente nello smoke test;
- risposta contenente un `calculationId` e href `model3d`;
- `GET .../artifacts/model3d` eseguito almeno due volte sullo stesso id con
  JSON v3 valido e senza nuova elaborazione;
- stato, limiti e commit registrati qui prima di passare a `ESEGUITO`.

Risultato:
- implementato `CalculationSnapshotStore` nel WebService come storage
  temporaneo in memoria, indicizzato per `Guid calculationId`;
- `POST /api/calculations` esegue `GeneraModello.GeneraAsync` una sola volta,
  serializza immediatamente il `TermodelWebModel v3` in byte JSON e registra
  quei byte nello snapshot;
- la risposta di `POST /api/calculations` contiene
  `contractVersion = TERMODEL-FRONT-SERVICE-V1`, `calculationId`,
  `status = completed`, manifest dell'artifact `model3d` e diagnostica;
- implementato
  `GET /api/calculations/{calculationId}/artifacts/model3d`: legge soltanto
  i byte JSON già catturati e non richiama `GeneraModello`;
- snapshot inesistente restituisce Problem Details HTTP 404;
- gli endpoint legacy `POST /api/model/3d` e
  `GET /api/model/clean-floor/{floorName}` sono rimasti disponibili;
- il workflow GitHub Actions è stato esteso per esercitare sia il percorso
  legacy sia il nuovo ciclo
  `/api/projects/new -> /api/calculations -> GET model3d -> GET model3d`;
- GitHub Actions run #23 sul commit
  `2cb8b15860f39e475ada2fda3d61c9dbd6dfa600`: **build riuscita,
  0 errori, 154 warning; smoke HTTP riuscito**;
- lo smoke verifica un `calculationId` reale, un manifest con href
  `model3d`, `TermodelWebModel v3`, coordinate `Z-up`, 0 primitive sul
  `ProgettoVuoto` e identità byte-per-byte delle due letture successive
  dello stesso artifact;
- il primo tentativo sul commit
  `ee02243a2e8b4c7b38d6ad4cc41b20f356b0eecc` aveva un solo errore di
  overload `Results.Bytes`; corretto nel commit `2cb8b158...`;
- contratto condiviso aggiornato alla versione documento 0.3 nel commit
  `70647ecd502e843bff7944ae125c29c0d67a51a2` per indicare che il ciclo
  `model3d` è ora operativo;
- **non ancora eseguito** il test con un progetto geometrico non vuoto né il
  confronto golden da 546 primitive; il JSON avanzato è compilato ed esposto,
  ma i metadati per primitive reali devono ancora essere esercitati con un
  file unico di prova rappresentativo;
- esecuzione locale Visual Studio/browser: **effettuata il 21 settembre 2026**.
  `GET /api/model/capabilities` ha risposto su `http://localhost:5080`;
  il frontend pubblico ha poi completato
  `POST /api/calculations -> calculationId -> GET artifact model3d`.
  Il primo progetto reale provato ha restituito **0 primitive e 19
  diagnostiche**: comunicazione e snapshot sono quindi raggiunti realmente,
  ma la correttezza geometrica non è ancora verificata e le diagnostiche
  devono essere analizzate.


### INCARICO 2026-09-21 — SVG tecnico canonico frontend per AggiornaCalcolo
Stato: ESEGUITO

Commissionato:
- correggere la prima anomalia runtime reale di `POST /api/calculations`,
  dove `SvgDxfReader` rifiutava `geometry/project.svg` perché il frontend
  aveva sostituito lo SVG tecnico del progetto con lo SVG operativo CAD/AI;
- mantenere invariato lo SVG locale del CAD;
- generare per il solo payload server uno SVG `TERMODEL-PROJECT-SVG-V1`
  canonico in centimetri, con gruppi piano e metadati richiesti dal Core;
- non rilassare la validazione del server.

Risultato:
- prima prova locale reale: `GET /api/model/capabilities` raggiunto con
  successo e `POST /api/calculations` arrivato fino a `SvgDxfReader`;
- l'errore runtime osservato era
  `Lo SVG deve dichiarare data-termodel-units='cm'.`;
- Termodel Web v0.73 costruisce ora il solo payload server in forma canonica,
  lasciando invariato lo SVG operativo del CAD;
- radice SVG: `TERMODEL-PROJECT-SVG-V1`, namespace SVG, unità `cm`;
- gruppi piano: `floor-id/name/role/file/layer/order` derivati da
  manifest/archivio Piani;
- entità trasferite: `line` e blocchi `text` tecnici; sfondi/accessori
  frontend esclusi;
- adattati anche, se presenti, tipo linea e colore locali ai nomi letti da
  `SvgDxfReader`;
- manifest/hash rigenerati sul payload finale;
- sintassi JavaScript verificata;
- commit principali frontend:
  `753d12050f73e91a3134000400927bfadfe5e960`,
  `07f460deeb6a96b69ec5df08a055665fd4fcebe2`,
  `ce3ed27f08a6a466a12e4a9721ceecf91b574cb5`,
  `cf90174307eda011fc78aa568917b369d810f63c`;
- nuova prova runtime v0.73 sul PC: **non ancora eseguita**; non dichiarare
  ancora superata la validazione HTTP finché l'utente non ripete il test.



### INCARICO 2026-09-22 — Salvataggio automatico progetto ricevuto da Aggiorna Modello
Stato: ESEGUITO

Commissionato:
- a ogni `POST /api/calculations` elaborato con successo salvare su disco una
  copia UTF-8 del `projectText` `TERMODEL-PROJECT-TEXT-V1` ricevuto,
  senza rigenerarlo e senza aggiungere sfondi frontend;
- associare senza ambiguità il file allo stesso `calculationId` dello
  snapshot, usando un nome con data/ora e GUID;
- usare una directory dedicata e determinabile `SavedProjects/` del
  WebService, mantenendo distinta questa persistenza operativa dallo
  `CalculationSnapshotStore` in memoria;
- preferire un piccolo servizio dedicato `SavedProjectStore` e non modificare
  frontend, Termodel.Core, Library o `definizionedati.json`;
- mantenere invariati gli endpoint legacy e il formato
  `TERMODEL-PROJECT-TEXT-V1`;
- aggiungere alla risposta di `POST /api/calculations`, se resta
  retrocompatibile e minimale, il solo nome logico del file salvato, senza
  esporre il path fisico; in tal caso aggiornare il contratto condiviso;
- estendere lo smoke HTTP per verificare file realmente creato, contenuto
  letto, corrispondenza del `calculationId`, due richieste → due file distinti
  e nessun file presentato come successo per una richiesta non valida.

Criteri di completamento:
- build Service con 0 errori;
- `POST /api/calculations` e artifact `model3d` ancora funzionanti;
- file fisico `.tmdl` creato in `SavedProjects/` dopo elaborazione riuscita;
- contenuto del file equivalente al `projectText` ricevuto;
- nome contenente data/ora e lo stesso `calculationId`;
- due richieste riuscite producono due file distinti;
- richiesta non valida non produce un progetto consolidabile;
- endpoint legacy invariati;
- diff finale limitato al WebService, test e documentazione pertinente;
- questa stessa voce aggiornata a `ESEGUITO` riportando separatamente
  implementazione, compilazione, esecuzione, test, confronto e commit.

Risultato:
- **implementato:** aggiunto
  `src/Termodel.WebService/Calculations/SavedProjectStore.cs`; salva
  direttamente il `projectText` ricevuto come UTF-8 senza BOM, con scrittura
  temporanea + rename finale, senza ricostruire il progetto;
- directory predefinita:
  `<ContentRootPath>/SavedProjects/`; per test/deployment può essere
  sovrascritta con `TERMODEL_SAVED_PROJECTS_DIR`;
- nome file:
  `TermodelProject-yyyyMMdd-HHmmssfff-<calculationId>.tmdl`, con timestamp UTC
  dello stesso snapshot;
- `POST /api/calculations` crea lo snapshot solo dopo `GeneraAsync`
  riuscito, salva il progetto con lo stesso `calculationId` e, se il
  salvataggio fallisce, rimuove lo snapshot appena creato prima di propagare
  l'errore;
- risposta pubblica estesa in modo additivo con
  `savedProject.fileName`; non viene esposto il path fisico e il progetto
  salvato non è inserito nel manifest degli artifact;
- contratto condiviso aggiornato a versione documento **0.9** nel commit
  `db6c81d53a57b439e0375e014b6cbc1bf800f919`;
- `.gitignore` esclude la cartella locale
  `Server/Termodelwebservice/src/Termodel.WebService/SavedProjects/`;
- **compilato:** GitHub Actions run **#35**, commit
  `a52c3a11c50d08d148e749f71f25def0a325ac58`: build Release riuscita,
  **154 warning, 0 errori**;
- **eseguito:** nello stesso run il WebService è stato avviato realmente su
  `127.0.0.1:5080` e lo smoke HTTP ha completato gli endpoint legacy e il
  ciclo `POST /api/calculations -> GET model3d`;
- **testato:** lo smoke ha verificato fisicamente un file `.tmdl` creato,
  nome contenente lo stesso `calculationId`, contenuto letto da disco e
  logicamente identico al `projectText`; due POST consecutivi hanno prodotto
  due GUID e due file distinti; un POST con progetto non valido ha restituito
  HTTP 422 senza aumentare il numero dei file `.tmdl`;
- **endpoint legacy:** `POST /api/model/3d` continua a essere esercitato con
  successo nello smoke; nessuna modifica a frontend, Termodel.Core, Library o
  `definizionedati.json`;
- **confronto con riferimento:** non applicabile a questa persistenza; non è
  stato introdotto alcun nuovo formato e il contenuto è confrontato con il
  testo ricevuto, non rigenerato;
- **test locale Visual Studio dopo questa modifica:** non ancora eseguito sul
  PC dell'utente; la verifica corrente è build + esecuzione HTTP + filesystem
  reali su runner Windows GitHub Actions;
- commit tecnici principali:
  `1af4a0bb9876de49b01fc2ab6c5e55640a5b33b3`,
  `a0a0f7325da81d030fbaa27facf86ea513dac520`,
  `0e5261f0cdacc3242ce06a146568484c80f8dc82`,
  `885942d2bb7538fdfc5d40c96332fe79e0422b9f`,
  `db6c81d53a57b439e0375e014b6cbc1bf800f919`,
  `a52c3a11c50d08d148e749f71f25def0a325ac58`.


### PROSSIMA PROVA — tetti e locali mansardati da Termodel Web v0.75

Il frontend dispone ora di uno strumento di test multipiano: `＋ Copertura`
crea un record `Piani` con `Tipo=Copertura`, stesso `NomeFile` del piano
sorgente e `LayerCad` distinto. Lo sfondo viene duplicato solo localmente,
mentre la geometria tecnica della copertura entra nel payload canonico
`TERMODEL-PROJECT-SVG-V1`.

Il frontend non genera un tetto 3D locale per i piani `Copertura`: la prossima
prova deve quindi verificare realmente la catena
`GeneraModello -> Tetti -> Polig3D -> TermodelWebModel v3` e il comportamento
dei locali mansardati. Nessun codice Service è stato modificato per questa
funzione frontend.

### FRONTEND TEST TOOLING — modalità Copertura v0.77

Il frontend Web dispone ora dei comandi minimi per esercitare realmente la
logica tetti del Service senza duplicarla nel browser. In un piano
`Tipo=Copertura` vengono disegnate linee perimetrali di falda e possono essere
inseriti blocchi `Colmo` con gli attributi già letti dal Core:
`QUOTACOLMO`, `QUOTAGRONDA`, `QUOTASHED`, `LATOPARTEBASSA`,
`PARETESHED`.

Il riferimento implementativo resta `LeggiDxf.AssociaBlocchiAParete("Colmo",...)`:
il prossimo test deve verificare sul runtime locale che il Colmo venga
associato alla linea corretta, che le quote Z vengano propagate e che il
`TermodelWebModel v3` contenga le falde/mansardati attesi. Nessun sorgente
Service/Core è stato modificato da questo intervento.

## 2. Posizioni e struttura

Sorgente locale compilato e avviato da Visual Studio:

```text
C:\DOCUMENTI\termomodel\codec\Termodelwebservice\
```

Copia di lavoro GitHub per AI:

```text
Server/Termodelwebservice/
```

Struttura reale, mantenuta senza riorganizzazioni:

```text
Termodelwebservice/
├── PROJECT-SUMMARY-SERVICE.md
├── Termodel.WebService.sln
├── Directory.Build.props
├── README.md
├── docs/
│   └── copied-from-termodel.md
└── src/
    ├── Termodel.Core/
    └── Termodel.WebService/
```

`Termodel.Core` è una libreria .NET 8 headless: contiene contratti, file unico,
archivi in memoria, geometria e motore 3D. `Termodel.WebService` è la Web API
ASP.NET Core che ospita il Core, CORS, template e endpoint HTTP.

## 3. Relazione con Termodel desktop e Library

Il desktop resta il riferimento funzionale e algoritmico. La Library GitHub
unica è:

```text
SorgentiTermodel/Library/
```

È consultiva e non va duplicata dentro `Server`. Durante il normale sviluppo
non viene adattata; può essere aggiornata o integrata, dopo autorizzazione
esplicita, con copie non modificate di sorgenti desktop selezionati. Provenienza
e SHA-256 devono essere verificati. Nuovi adattamenti si preparano nel Service
o in `SorgentiTermodel/Work`; l'obiettivo è duplicare il meno possibile e
convergere verso un Core realmente condiviso.

Il 21 settembre 2026 la Library è stata completata, come riferimento Desktop,
anche per la generazione XML APE nazionale e per pannelli radianti/spirali. Sono
stati aggiunti senza modifiche `GestXml`, `CalcoliXML`, `CalcoloAPE`, `Cened`,
`PannelliRadianti`, `IoPannelli`, `IoTubi`, `CalcoloPannelli` e i sorgenti dei
motori `SpiraliGPT` e `SpiralHeating` di Vittorio. Percorsi, dipendenze,
esclusioni e SHA-256 sono registrati in
`SorgentiTermodel/Library/RIFERIMENTI-DESKTOP-APE-PANNELLI.md`. Tutte le 21
copie sono risultate byte-per-byte uguali agli originali locali.

Il 23 settembre 2026 è stato inoltre acquisito il sorgente Desktop autorevole
`utilities/TermodelLog.cs`, fino ad allora assente dalla Library. La copia è
invariata e ha SHA-256
`79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218`.
Il confronto conferma che l'adattatore headless deve restare distinto per
isolamento `AsyncLocal`, diagnostica HTTP e persistenza per `projectId`.

Questa integrazione non implementa XML APE o pannelli nel WebService: rende
soltanto disponibile il riferimento autorevole per una futura estrazione
headless. Restano da isolare dipendenze WPF/MainWindow, Helix, IFC/Xbim,
netDxf, Windows Forms e altre librerie Desktop.

Le copie temporanee sono sotto:

```text
src/Termodel.Core/CopiedFromTermodel/
```

La mappa `TERMODEL-SYNC: PENDING` e le origini sono in
`CopiedFromTermodel/TERMODEL-SYNC.md`. Il 21 settembre 2026 sono stati integrati
nella Library unica `Modello.cs` e `utilities/ErrorManager.cs`, copiati senza
modifiche dagli originali desktop e verificati mediante SHA-256.

```text
Modello.cs
7B201DA17781CB2682EC9AF25D798B753EC590850031572A4A07E63975B125F0

utilities/ErrorManager.cs
6A7E93D009526D4DA5ED0F800B6155AB0B90C52237C13E76CEC52C4204863ECD

utilities/TermodelLog.cs
79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218
```

## 3.1 Strategia permanente di compatibilità Desktop

Decisione architetturale consolidata il 21 settembre 2026.

Per migrare il motore storico senza riscriverne inutilmente gli algoritmi, il
Service deve preferire **facciate di compatibilità** che presentino al codice
Desktop gli stessi concetti che esso si aspetta, pur ricavandoli dal file unico.

Architettura di riferimento:

```text
TERMODEL-PROJECT-TEXT-V1
        |
        +--> Virtual CAD
        |      SVG multipiano -> API netDxf compatibile
        |      file/layer/blocchi/linetype/colori/Z
        |
        +--> Virtual DB
        |      archives/xml/*.xml -> UtiDb / Database.DB compatibili
        |
        +--> Virtual Project
               workspace temporaneo per elaborazione
               percorsi/file attesi da GestProg e moduli file-based
        |
        v
codice Desktop/Core riusato
LeggiDxf / GestXml / CalcoloAPE / pannelli / ecc.
```

Principio permanente:

> quando il codice Desktop richiede una risorsa, preferire che il Core gliela
> presenti nel formato/comportamento già atteso invece di modificare
> l'algoritmo storico per adattarlo al Web.

### Virtual CAD

Il Desktop può usare lo stesso DXF per più piani, distinguendoli tramite
`Piani.NomeFile` + `Piani.LayerCad`. Il file unico usa invece SVG multipiano,
ma deve conservare la stessa semantica logica.

Lo strato compatibile deve quindi poter ricostruire un documento CAD virtuale
per nome file contenente più layer, inclusi progressivamente layer ausiliari
(es. tubi pannelli), in modo che il codice storico continui a filtrare
`dxf.Lines`, blocchi e layer senza conoscere la sorgente SVG.

Stato implementato al 21 settembre 2026: `SvgDxfReader` costruisce un solo
`DxfDocument` logico per `NomeFile`; i gruppi/piani che condividono il file
condividono quindi anche il documento e restano distinti tramite `LayerCad`.
Gli elementi SVG possono inoltre dichiarare un `data-termodel-layer` specifico,
permettendo di rappresentare layer ausiliari nello stesso documento.

`DxfDocument.Load(path)` consulta un registro CAD scoped alla richiesta.
`GeneraModello` materializza nel Virtual Project un percorso DXF reale,
registra sotto quel percorso il documento virtuale e richiama nuovamente il
metodo storico `LeggiFileDxf(...)`. Di conseguenza `LeggiDxf` continua a
passare da `File.Exists` e `DxfDocument.Load` come nel Desktop senza sapere
che geometria e layer provengono dallo SVG.

Il supporto geometrico dei layer ausiliari è operativo anche per l'input
`Tubo` dei pannelli: il Virtual CAD ricostruisce
`<NomePiano>_tubipannelli`, conserva `data-termodel-rete` nei metadata
della linea e l'adattatore headless `IoPannelli.LeggiTubiDXF` continua a
vedere la convenzione Desktop. Il primo solver idraulico pannelli è integrato
in `POST /api/calculations` e produce `artifacts/pannelli.json`.
Dal 23 settembre 2026 è inoltre attivo l'esecutivo grafico con il default
corrente `PassoTubi=0,30 m`, che produce
`pannelli-esecutivo.svg` e `pannelli-esecutivo.dxf` dallo stesso modello
grafico neutro. Resta futura soltanto la parametrizzazione del motore spirali
per passi diversi da 300 mm; grafo e collettore restano alla fase Tubi
universale.

### Virtual DB

Gli archivi autorevoli per il motore nel file unico sono
`archives/xml/*.xml`. `ProjectArchiveDatabase` li carica in memoria e
l'adattatore `UtiDb` / `Database.DB` deve replicare la semantica Desktop,
non solo le firme necessarie alla compilazione.

Allineamento implementato al 21 settembre 2026:

- `GetDataDB` replica il comportamento Desktop rilevante: confronto trimmed
  case-sensitive e `null` a runtime quando il dato non viene trovato o è
  vuoto;
- `TipoZona` usa i valori Desktop, incluso `Edificio adiacente`, e conserva
  il comportamento per campo `Tipo` mancante;
- `AggiungiZoneStandard` è disponibile attraverso `UtiDb` e
  `Database.DB`;
- la validazione server mantiene intenzionalmente errore strutturato quando un
  archivio richiesto è assente dal file unico, invece di reintrodurre UI o
  MessageBox.

Ulteriori metodi verranno aggiunti alla facciata quando richiesti da
`GestXml`, `CalcoloAPE`, pannelli o altri moduli, evitando modifiche ai
chiamanti storici.

Il JSON parallelo degli archivi è una rappresentazione utile al Web/AI; il
motore Core continua a usare come riferimento runtime gli XML del file unico,
finché il contratto non stabilirà diversamente.

### Virtual Project

È stato implementato `Compatibility/ProjectWorkspace.cs`. Per ogni
elaborazione corrente esso materializza il file unico in una directory
temporanea isolata, crea le sezioni del contenitore, replica
`archives/xml/*.xml` sotto `dbtempfiles/`, espone `xml/input.xml` e
`xml/output.xml` e fornisce i percorsi CAD logici usati dal Virtual CAD.

La facciata `GestProg` espone ora `PathProg`, `PathProgDB`,
`FileXMLPath`, `FileXMLOutPath` e `FileDXFPath(...)` sul workspace
corrente. Il workspace viene eliminato al termine della generazione corrente.

Questa è la base per i moduli Desktop file-based (`GestXml`, `CalcoloAPE`,
`Cened`, `IoPannelli` e successivi). Non è lo storage persistente pubblico:
la nuova commissione 2026-09-22 introduce invece il workspace stabile
`SavedProjects/{projectId}/`, aggiornato ad ogni elaborazione riuscita.

Il workspace temporaneo Core resta un adattatore interno, non il formato
autorevole del progetto. Il file unico resta l'input autorevole; gli output
dell'elaborazione diventano artifact correnti del `projectId` e non devono
essere reinseriti implicitamente nel progetto.

## 4. Storia consolidata dello sviluppo Service

### Studio di fattibilità

Il lavoro è iniziato valutando un motore Termodel eseguibile su server ASP.NET
Core con modifiche minime ai sorgenti desktop. Form, WPF e visualizzazione 3D
desktop sono stati esclusi dal runtime. Per la comunicazione col frontend resta
scelto un modello 3D JSON diretto. La decisione è stata successivamente
affinata: `Xbim.Essentials` viene usato come modello dati IFC **in memoria**
per mantenere invariato `Polig3D`, ma il Service non esporta IFC e non usa il
renderer geometrico xBIM.

### Soluzione separata

È stata creata la soluzione gemella `Termodelwebservice`, apribile in Visual
Studio 2022, con una libreria Core e una Web API. Il server locale usa HTTP
durante lo sviluppo per evitare la dipendenza dal certificato HTTPS developer.

### File unico di progetto

È stato definito `TERMODEL-PROJECT-TEXT-V1`, contenitore testuale UTF-8 pensato
anche per copia/incolla verso e da AI. Contiene manifest, impronta della
definizione dati, SVG multipiano, archivi XML/JSON, input termici e risorse del
progetto. `ProjectTextDocument` lo legge; `ProgFileUnico` lo produce.

La funzione Nuovo progetto non fabbrica più archivi vuoti dal solo JSON:
`POST /api/projects/new` clona il progetto base realmente proposto da Termodel,
incorporato in `Templates/ProgettoBase`. La copia di
`Definitions/definizionedati.json` elimina la dipendenza dalla cartella desktop
ma resta derivata dall'originale autorevole e non deve divergere.

Il progetto vuoto statico è anche pubblicato per il frontend in
`SorgentiTermodel/Library/projects/ProgettoVuoto/` (commit `f58a972`).

### Comunicazione browser → localhost

È stato configurato CORS per `https://www.termodel.it`, metodi GET/POST/OPTIONS,
header di preflight e `Access-Control-Allow-Private-Network` quando richiesto da
Chrome. Il browser può richiedere anche il permesso Local Network Access, che
non può essere aggirato dal server.

### Motore Modello3D headless

Sono state selezionate le classi strategiche `LeggiDxf`, `DXFLineCheck`,
`GeneraModello`, `GeneraPianta`, `Tetti`, `Confini`, `Polig3D` e
`Modello`. `Polig3D` è ora identico byte-per-byte al sorgente Desktop; la
compatibilità headless è ottenuta sotto la classe tramite xBIM in memoria e
facciate WPF/MainWindow/DrawBim. Una compatibilità `netDxf` minima viene
popolata dallo SVG del file unico; non è un lettore DXF generale. `UtiDb` e
`Database.DB` lavorano sugli archivi XML in memoria. La geometria topologica
continua a usare NetTopologySuite e lo stato storico resta protetto da un gate
seriale.

`POST /api/model/3d` riceve `text/plain; charset=utf-8` e restituisce direttamente
`TermodelWebModel` v3 JSON. Non produce IFC. `GET
/api/model/clean-floor/{floorName}` restituisce lo SVG architettonico pulito
dell'ultima generazione.

Verifica storica del 21 settembre 2026: GitHub Actions aveva build Release
con 0 errori e 154 warning e lo smoke HTTP verificava il precedente percorso
snapshot per-elaborazione. Questa implementazione è ora **legacy e destinata
alla sostituzione** dalla commissione projectId-only del 22 settembre 2026.
La prova con geometria reale e il confronto golden restano aperti.

## 5. API implementate

```text
GET  /
GET  /health
GET  /api/model/capabilities
GET  /api/model/clean-floor/{floorName}
GET  /api/projects
POST /api/projects/new
POST /api/projects/allocate-id
POST /api/projects/{projectId}/open
PUT  /api/projects/{projectId}/save
PUT  /api/projects/{projectId}/save-as
POST /api/projects/{projectId}/heartbeat
POST /api/projects/{projectId}/close
POST /api/projects/{projectId}/unlock
POST /api/model/3d
POST /api/dxf/to-svg
POST /api/calculations
GET  /api/projects/{projectId}/artifacts/model3d
GET  /api/projects/{projectId}/artifacts/pannelli
GET  /api/projects/{projectId}/artifacts/pannelli-esecutivo-svg
GET  /api/projects/{projectId}/artifacts/pannelli-esecutivo-dxf
GET  /api/projects/{projectId}/logs/termodel
POST /api/feedback
```

`POST /api/dxf/to-svg` è un servizio stateless di conversione degli sfondi:
riceve il DXF ASCII originale e le opzioni di importazione, delega la
trasformazione a `Termodel.Core.Cad.DxfSvgConverter` e restituisce SVG,
statistiche, bounds/viewBox e metadati di unità. Non crea né modifica un
workspace progetto e non contiene logica algoritmica duplicata nel WebService.

`POST /api/projects/new` continua a creare il file unico base e non assegna
silenziosamente un'identità persistente. Il frontend richiede il projectId una
sola volta con `POST /api/projects/allocate-id` e lo consolida come proprietà
top-level `manifest.projectId`.

`POST /api/calculations` usa esclusivamente quel `projectId`, ricostruisce il
modello una sola volta e, solo a elaborazione riuscita, sostituisce il workspace
corrente:

```text
SavedProjects/{projectId}/
├── project.tmdl
├── artifacts/
│   ├── model3d.json
│   ├── pannelli.json
│   ├── pannelli-esecutivo.svg   (quando generabile)
│   └── pannelli-esecutivo.dxf   (quando generabile)
└── logs/
    ├── calculation.log
    ├── diagnostics.txt
    └── TermodelLog.md
```

La root resta configurabile tramite `TERMODEL_SAVED_PROJECTS_DIR`.
`project.tmdl` è la copia UTF-8 del projectText realmente ricevuto; non viene
rigenerato dal Service e non acquisisce gli sfondi esclusivamente frontend.

Gli endpoint `GET /api/projects/{projectId}/artifacts/*` leggono gli artifact
persistiti e non eseguono un nuovo calcolo. Questo vale per `model3d`,
`pannelli` e per i due esecutivi pannelli SVG/DXF quando presenti. Gli
artifact restano quindi leggibili dopo il riavvio del Service.

Il precedente modello per-elaborazione è stato rimosso dal runtime:
non esistono più `CalculationSnapshotStore`, response `calculationId` o
route `/api/calculations/{id}/artifacts/model3d`.

Errori di progetto, projectId mancante/non riservato o funzioni non supportate
sono restituiti come Problem Details; Content-Type non valido produce 415.
Un calcolo fallito non sostituisce l'ultimo workspace valido.

### Workflow server concordato: AggiornaCalcolo

Decisione consolidata del 22 settembre 2026: **un progetto, un projectId, una
cartella corrente**.

```text
Frontend
  -> TERMODEL-PROJECT-TEXT-V1 con manifest.projectId
  -> POST /api/calculations
  -> Termodel.Core ricostruisce il progetto una sola volta
  -> genera gli elaborati disponibili
  -> WebService sostituisce SavedProjects/{projectId}/
  -> restituisce projectId + manifest degli artifact correnti
```

Le view non devono rilanciare i calcoli. Devono leggere gli elaborati correnti
dello stesso progetto tramite route del tipo:

```text
GET /api/projects/{projectId}/artifacts/model3d
GET /api/projects/{projectId}/artifacts/pannelli
GET /api/projects/{projectId}/artifacts/pannelli-esecutivo-svg
GET /api/projects/{projectId}/artifacts/pannelli-esecutivo-dxf
GET /api/projects/{projectId}/artifacts/xml-nazionale                 (futuro)
GET /api/projects/{projectId}/artifacts/report-dispersioni            (futuro)
GET /api/projects/{projectId}/artifacts/pianta-pulita/{piano}         (futuro)
```

Al momento sono implementati e persistiti `model3d`, `pannelli` e, quando
il progetto dispone di locali/tubi idonei, `pannelli-esecutivo.svg` e
`pannelli-esecutivo.dxf`. XML nazionale, report dispersioni e pianta pulita
persistente restano estensioni successive dello stesso workspace e non devono
introdurre storage paralleli o identificatori per-elaborazione.

Formati indicativi degli artifact:

- modello 3D: JSON;
- XML nazionale: `application/xml`;
- report dispersioni: dati JSON, non HTML generato dal Core;
- report pannelli: dati JSON;
- esecutivo pannelli corrente: SVG `image/svg+xml` e DXF
  `application/dxf`, derivati dallo stesso modello grafico neutro;
- pianta pulita: SVG per piano (futuro artifact persistente).

Compatibilità: gli endpoint legacy `POST /api/model/3d` e
`GET /api/model/clean-floor/{floorName}` restano disponibili finché non
saranno deprecati esplicitamente.

Regola di efficienza: `AggiornaCalcolo` ricostruisce il modello **una sola
volta**. Leggere un artifact non deve provocare una nuova elaborazione completa.


## 6. EnergyPlus, gbXML e IDF

EnergyPlus fa parte della direzione futura del Service, non dello stato già
implementato. Il desktop contiene un'integrazione storica avviata da UI e un
percorso macchina-specifico verso l'eseguibile EnergyPlus. Questo legame non è
portabile sul server e non va copiato alla cieca.

Direzione consolidata:

```text
Termodel.Core
  → modello energetico validato
  → esportatore gbXML e/o IDF
  → runner EnergyPlus isolato
  → risultati normalizzati e confrontabili
```

Decisioni ancora da prendere: versione EnergyPlus supportata, scelta primaria
gbXML/IDF, mapping completo degli archivi, gestione meteo EPW, sandbox del
processo, limiti di tempo/risorse e formato dei risultati. Nessun endpoint
EnergyPlus, gbXML o IDF è attualmente implementato.

## 7. Regression test, progetti campione e Golden Results

La strategia prevista è versionare input, output attesi, tolleranze numeriche e
versione del motore. I confronti non devono limitarsi al testo JSON: occorrono
conteggi per tipo, identificativi, vertici/indici, quote, superfici, volumi,
orientamenti e diagnostica, con tolleranze esplicite per i numeri floating point.

Campioni correnti:

- `ProgettoVuoto`: test del contenitore e del contratto, 0 primitive attese;
- `Fabbricato con tetto a due falde e piano mansardato`: golden test avanzato
  perché esercita piani, falde, colmi, mansarda e funzioni 3D. La cartella
  desktop contiene un precedente `WebBridge/TermodelWebModel.json` con 546
  primitive, ma manca ancora il corrispondente file unico SVG multipiano.

Non esiste ancora una suite automatica di regressione né una directory Golden
Results formalizzata. Il confronto avanzato non è quindi completato.

## 8. Sincronizzazione locale ↔ GitHub

Configurazione: `transfer-map.json`. Motore:
`tools/transfer/TermodelTransfer.ps1`. Il mapping `TermodelWebService` collega:

```text
locale: C:\DOCUMENTI\termomodel\codec\Termodelwebservice
GitHub: Server/Termodelwebservice
```

Sono esclusi `.git`, `.vs`, `bin`, `obj`, `packages`, `*.user`, `*.suo` e
`*.tmp`. Prima di ogni copia eseguire sempre `status`.

Da sorgente locale a GitHub:

```powershell
tools\transfer\TermodelTransfer.ps1 -Action status -Name TermodelWebService
tools\transfer\TermodelTransfer.ps1 -Action export -Name TermodelWebService
```

Da GitHub a sorgente locale:

```powershell
tools\transfer\TermodelTransfer.ps1 -Action status -Name TermodelWebService
tools\transfer\TermodelTransfer.ps1 -Action import -Name TermodelWebService
```

L'export è speculare soltanto sulla copia GitHub. L'import è non distruttivo e
crea prima un backup in `_backups/<data-ora>/TermodelWebService`.
`COPIA_TERMODEL_SERVICE_LOCALE_NEL_CLONE_GITHUB.cmd` resta disponibile per
copiare il Service locale nella cartella versionata del clone; non crea commit
e non esegue push. Per scaricare `origin/main` e poi predisporre il Service
locale alla compilazione usare
`SCARICA_GITHUB_E_PREPARA_TERMODEL_SERVICE_LOCALE.cmd` nella radice del
repository: richiede un working tree pulito, usa esclusivamente fast-forward e
non esegue build o avvio. Per pubblicare modifiche locali sul remoto usare il
distinto `PUBBLICA_MODIFICHE_LOCALI_NEL_GITHUB_REMOTO.cmd`.

Git pull/push restano operazioni separate. Non pubblicare automaticamente
modifiche frontend preesistenti o non pertinenti.

## 9. Compilazione ed esecuzione

### Build automatica GitHub

È presente:

```text
.github/workflows/termodel-service-build.yml
```

Il workflow viene avviato automaticamente dai push che modificano il Service
(o il workflow stesso) e può essere avviato anche manualmente. Su runner
Windows esegue:

```text
dotnet restore Termodel.WebService.sln
dotnet build Termodel.WebService.sln --configuration Release --no-restore
```

Prima esecuzione dopo l'introduzione del Virtual CAD/DB/Project: fallita con
3 errori tutti in `ProjectWorkspace.cs` per chiamata di metodo statico tramite
istanza; corretti nel commit `2753e468c7d1da6b9fb4602152b3fabb0abec17c`.

Seconda esecuzione GitHub Actions, run #2: **Build succeeded, 0 errori,
108 warning**. Questo certifica la compilazione cloud del codice corrente, non
l'esecuzione funzionale degli endpoint.

### Esecuzione locale

1. sincronizzare GitHub → locale e verificare le differenze;
2. aprire `C:\DOCUMENTI\termomodel\codec\Termodelwebservice\Termodel.WebService.sln`;
3. impostare `Termodel.WebService` come progetto di avvio;
4. scegliere il profilo HTTP;
5. compilare e avviare con Visual Studio;
6. verificare `http://localhost:5080/health` e
   `http://localhost:5080/api/model/capabilities`.

Non avviare direttamente `Termodel.Core`: è una libreria di classi.

## 10. Stato corrente e problemi aperti

Implementato e verificato:

- soluzione .NET 8 separata;
- progetto base incorporato e copia verificata della definizione dati;
- file unico e endpoint Nuovo progetto;
- CORS/PNA per il frontend pubblico;
- Virtual CAD: SVG multipiano → documento netDxf virtuale multi-layer per
  `NomeFile`, registro per `DxfDocument.Load` e riuso di `LeggiFileDxf`;
- Virtual DB: archivi XML in memoria, `GetDataDB`/ `TipoZona` allineati e
  `AggiungiZoneStandard`;
- Virtual Project: workspace temporaneo e facciata `GestProg` per percorsi
  Desktop-like;
- `Polig3D` Core byte-per-byte identico al riferimento Desktop;
- xBIM Essentials usato solo come struttura IFC in memoria, senza artifact IFC;
- facciate headless per WPF/MainWindow/filtri/DrawBim;
- `TermodelWebModel v3` completo dei metadati avanzati dei filtri;
- endpoint Modello3D e pianta pulita;
- GitHub Actions per restore/build automatico e smoke HTTP;
- build Release corrente verificata con 0 errori e 154 warning;
- smoke HTTP corrente: `/health`, `POST /api/projects/new` e
  `POST /api/model/3d` riusciti sul `ProgettoVuoto`, con v3 Z-up e 0
  primitive.

Incompleto:

- esecuzione locale Visual Studio del nuovo percorso xBIM/Polig3D (lo smoke
  HTTP cloud è già riuscito);
- file unico/golden test del progetto mansardato e confronto delle 546
  primitive;
- regression test automatici e Golden Results versionati;
- completamento del workspace projectId con `pianta-pulita/{piano}` e successivi artifact per le view;
- API CRUD archivi e concorrenza multiutente/autenticata;
- autenticazione e autorizzazione;
- EnergyPlus, gbXML e IDF;
- eliminazione progressiva delle copie `TERMODEL-SYNC`;
- gestione e riduzione dei 108 avvisi di nullabilità;
- pubblicazione su hosting remoto/container dopo i test Docker locali.

## 11. Prossimi passi consigliati

1. adeguare separatamente il frontend al flusso
   `allocate-id -> manifest.projectId -> POST /api/calculations`;
2. aggiungere `pianta-pulita/{piano}` e gli artifact successivi nello stesso
   workspace `SavedProjects/{projectId}/`;
3. generare lo SVG multipiano e il file unico del progetto mansardato;
4. confrontare il risultato con le 546 primitive del JSON desktop, definendo
   tolleranze e report;
5. creare una suite automatica di regression test e `GoldenResults/`;
6. integrare progressivamente XML nazionale/dispersioni e poi pannelli/spirali
   nel nuovo workflow projectId-only;
7. definire API autorevoli per schema, archivi, validazione e CRUD;
8. progettare il contratto energetico prima di scegliere gbXML o IDF;
9. provare build e runtime in Docker locale;
10. ridurre gradualmente `CopiedFromTermodel` spostando la logica condivisibile
    in un unico Core compatibile anche col desktop.

## 12. Vincoli permanenti

- `definizionedati.json` è il riferimento inderogabile e non si modifica senza
  autorizzazione specifica;
- il frontend Web resta funzionante e separato;
- `PROJECT-SUMMARY.md` Web e questo summary Service non si fondono;
- `SorgentiTermodel/Library` non si duplica e non si adatta durante il normale
  sviluppo Service; può essere integrata con copie desktop non modificate solo
  dopo autorizzazione esplicita e verifica SHA-256;
- nessun risultato proposto è dichiarato verificato senza build/test reali;
- compatibilità e reversibilità prevalgono sui refactoring opportunistici.

## 13. Strategia spirali Service corrente — `Diego_Vittorio`

Dal 28 settembre 2026 il motore predefinito del Service è
`Diego_Vittorio`. La selezione resta reversibile tramite
`TERMODEL_SPIRAL_ENGINE=Vittorio|GPT|Diego|Diego_Vittorio`.

Distinzione progettuale corrente:

- `StrategiaDiego` / motore `Diego` è **PARKED** perché il costo
  computazionale osservato è troppo elevato per l'uso operativo corrente. Il
  work in progress futuro dovrà ridurne drasticamente il costo per renderla
  utile soprattutto in configurazioni/locali geometricamente molto complessi;
- `Diego_Vittorio` deriva da `SpiraliVittorio` ma ha ricevuto una modifica
  strutturale fondamentale: il Return non è più il riflesso/parallelo della
  mandata, bensì un percorso generato autonomamente;
- la radice iniziale del Return nasce ancora dal parallelo gemello del tubo
  d'ingresso della mandata, ma **solo come collegamento iniziale**; lo sviluppo
  successivo è autonomo;
- ogni tratto del Return è condizionato dal perimetro disponibile del
  locale/edificio, dalla mandata già costruita e dal Return già costruito;
- questa libertà geometrica ha vantaggi ma introduce un limite noto:
  la mandata può creare corridoi o “budelli” nei quali il Return autonomo resta
  imprigionato, causando stop prematuri o geometricamente non corretti;
- **DV-TEST-001, quadrato pubblico:** uno stop che inizialmente sembrava un caso
  di intrappolamento è stato isolato come errore locale di classificazione
  dell'adiacenza Return-Return. La prosecuzione collineare dell'ultimo tratto
  non deve trattare il segmento immediatamente precedente al gomito come ramo
  remoto. La correzione è attiva per default e disattivabile con
  `TERMODEL_DIEGO_VITTORIO_COLLINEAR_ADJACENCY=false`; regression Fast
  `DV-PUBLIC-SQUARE-LEFT-P030-DIEGO-VITTORIO` verificata;
- il problema generale del “budello” **resta aperto** per casi realmente
  intrappolati e deve continuare a essere raccolto in regression prima di
  introdurre strategie strutturali di fuga.

Lo stato consolidato comprende inoltre:

- passo `p` variabile e derivazione coerente di `p/2`, `p` e `2p`;
- mandata a inseguimento ortogonale;
- condizionamento mandata-ritorno e ritorno-ritorno a distanza minima `p`;
- chiusura terminale deterministica LG-048, con massimo 35 configurazioni,
  arresto al primo candidato senza angoli acuti, lungo almeno `2p` e privo di
  incroci;
- raccordi adattivi LG-049 e chiusura raccordata con frammentazione limitata;
- flag diagnostici per disattivare raccordi, chiusura o ritorno autonomo senza
  cambiare il comportamento operativo predefinito.

`SpiraliVittorio` resta intatta e costituisce il riferimento per confronto e
ripristino. Il collaudo manuale corrente di `Diego_Vittorio` sul Service
pubblico è ancora in corso e non equivale ad approvazione geometrica generale.


### FASE 6D / STEP 4E — DECISIONE STRETTOIA T6: VITTORIO VS DIEGO_VITTORIO
Stato: ANALISI COMPLETATA, NESSUNA CORREZIONE APPLICATA

- Fast Harness run `36443765112` SUCCESS; tutte le regression Diego_Vittorio verdi.
- Vittorio originale non prende una decisione esplicita “entra/non entra” nel
  varco: arrotonda la Supply e deriva il Return traslando all'indietro i
  campioni tramite `CreaRientro`.
- Diego_Vittorio genera invece il Return autonomo sulla geometria rettilinea
  prima dei raccordi; ricerca e valida corridoi contro Supply e Return.
- Nel `locale_1` il primo varco 2p è prescritto direttamente da
  `GeneraCollegamentoRitorno` sulla mezzeria; il secondo varco, visivamente
  analogo, deve essere ritrovato da `FindConnectionWithOffset`.
- Sul secondo varco il candidato campionato y=3,82 fallisce a 0,28 m dalla
  Supply; la coordinata critica esatta y=3,84 è valida e produce il passaggio
  `(1,12;3,84)->(0,52;3,84)`.
- Dopo il passaggio, quel segmento entra nella storia Return e diventa
  ostacolo di autocondizionamento per le evoluzioni successive.
- Il quadrato pubblico funziona per una ragione diversa: il passaggio critico
  è una prosecuzione collineare riconosciuta come adiacenza topologica da
  `CandidatoProsegueUltimoSegmento` (DV-TEST-001).
- Arrotondamento: non può causare la decisione Diego_Vittorio perché viene
  applicato dopo `GenerateReturn`; in Vittorio invece partecipa alla forma
  del Return derivato.
- Riferimenti Vittorio run #49: locale_1 28 punti, quadrato pubblico 33 punti.



### 2026-09-28 — Mappa codice strettoie Vittorio vs Diego_Vittorio

Analisi completata senza modifiche algoritmiche.

- `SpiraliVittorio/Spiralgenerator.cs` e `ChiudiSpirale.cs` nel Service
  risultano byte-per-byte identici ai corrispondenti riferimenti Desktop in
  `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/`.
- Vittorio valuta le strettoie solo implicitamente tramite:
  `ComputeOffset` (lati corti/contrazione), soglie `minEdgeLength`,
  scelta del gomito verso il nuovo offset e controllo locale del punto
  intermedio; il Return è derivato dalla Supply già arrotondata con
  `CreaRientro` e non possiede una decisione autonoma entra/non entra.
- Diego_Vittorio eredita i filtri Supply di Vittorio e aggiunge sul Return:
  `OffsetHaTrattoParalleloTroppoVicino`,
  `FindConnectionWithOffset`,
  `ConnectionPathIsValid`,
  `SegmentoRispettaCondizionamento`,
  `SegmentoRispettaSpirale`,
  `FindConnectionWithTerminalTrim`,
  `TrovaMassimoPrefissoValido`.
- Il cuore attuale dell'ingresso nelle strettoie è
  `FindConnectionWithOffset`: genera percorsi locali finiti e sceglie il
  più corto fra quelli validi, senza valutarne la convenienza futura.
- `ProvaPortaleAnticipato` / `TracePortalsEnabled` costituisce già un
  look-ahead diagnostico di un offset, ma non influenza le decisioni.
- L'arrotondamento non decide l'ingresso in Diego_Vittorio perché viene
  applicato dopo la generazione del Return; in Vittorio invece il Return
  viene derivato dalla Supply già arrotondata.
- Linea guida consolidata: `LG-050 — Strettoie: decisione a visione media,
  non solo locale`. StrategiaDiego ad albero resta il riferimento
  concettuale globale, mentre Diego_Vittorio deve cercare euristiche finite a
  medio raggio per contenere il costo computazionale.


### 2026-09-28 — Debug strettoie: finestra dei portali e provenienza algoritmo

- `Diego_Vittorio` è stato analizzato esplicitamente come copia AI di Vittorio:
  ricerca adattiva fra offset aggiunta dall'AI, percorrenza dell'offset ancora
  strutturalmente derivata dal flusso deterministico Vittorio.
- Nuovi log puramente diagnostici (commit `9a7abde...` e `de2dfde...`) mostrano
  path scelti, segmenti accettati e portale verso l'offset successivo a ogni
  passo; default produttivo invariato.
- Fast Harness #51 e #53: SUCCESS, tutte le regression Diego_Vittorio verdi.
- `locale_1`, Return offset 2->3: il portale da 0,60 m è valido all'ingresso e
  resta valido dopo ogni lato dell'offset; l'ultimo portale è quello usato
  realmente. Quindi non è corretto correggere il caso uscendo al primo portale.
- Quadrato: i portali compaiono più tardi e restano validi; proseguire rende
  inoltre più corto il collegamento finale.
- Test verso di costruzione opposto (#52): fallisce immediatamente sia su
  `locale_1` sia sul quadrato; escluso un semplice errore orario/antiorario.
- Linea guida `LG-050` aggiornata: la futura media visione deve valutare la
  qualità futura del ramo, non la mera presenza del primo portale.
- Service workflow sul commit diagnostico: fase `Build` SUCCESS; workflow
  complessivo rosso per Golden Darcy indipendente (dP 1,3136749 Pa contro
  golden 1,353675 Pa), non per compilazione o regression spirali.


### 2026-09-28 — Vittorio_revisionato: copia pulita e prima astrazione controllata

Obiettivo:
- ripartire dal motore Vittorio stabile senza importare le euristiche accumulate
  in `Diego_Vittorio`;
- creare una copia separata `Vittorio_revisionato`;
- provare prima la parità completa;
- introdurre poi soltanto l'astrazione strutturale necessaria per invocare lo
  stesso generatore su percorsi indipendenti, con Supply opzionalmente
  condizionante il secondo percorso.

Implementazione:
- nuova cartella
  `src/Termodel.Core/CopiedFromTermodel/SpiraliVittorioRevisionato/`;
- fotografia iniziale: quattro sorgenti Vittorio con solo namespace
  `SpiralHeatingVittorioRevisionato`;
- benchmark `StrategiaVittorioRevisionatoBenchmark`;
- Harness engine `Vittorio_revisionato`;
- caso `LG041-SQUARE4X4-T1-P030-VITTORIO-REVISIONATO.json`;
- `SpiralGenerationInput` come ingresso neutro al ruolo;
- condizionamento opzionale implementato come gate dentro il flusso Vittorio:
  non cambia l'ordine di costruzione, non cerca alternative e si arresta al
  primo segmento che viola la distanza dalla geometria condizionante;
- nessun codice di rerouting/fallback/adiacenza importato da Diego_Vittorio.

Verifiche:
- run Fast `36465582271`: parità iniziale SUCCESS;
  SVG SHA-256
  `9673CD8D77A9963EC425FA69F54B8DCFF4C162312336D08D74AC722A2E0122A4`,
  XML SHA-256
  `9517A5BFFE56F7CCB2419F173A0020FAC0EEBF6B2FD3706C02CD29D32C0DDCA6`;
- run Fast `36466606034` (#62): SUCCESS dopo l'astrazione;
  la stessa parità completa Vittorio/Vittorio_revisionato resta verificata;
- probe strutturale:
  `neutralEquivalent=true`,
  Supply 37 punti,
  secondo percorso indipendente senza condizionamento 38 punti,
  con Supply condizionante a 0,15 m: 1 punto;
- tutte le regression Diego_Vittorio della run #62 sono SUCCESS;
- Service Build sullo stesso commit: compilazione, health e smoke pannelli
  precedenti SUCCESS; workflow finale FAILED nel test HTTP per il noto golden
  Darcy sintetico fuori tolleranza, non nel codice Vittorio_revisionato.

Interpretazione consolidata:
- la copia pulita è stabile ed equivalente a Vittorio;
- la sola astrazione del ruolo non rompe Vittorio;
- applicare semplicemente lo stesso percorso Vittorio una seconda volta e
  imporre un hard constraint rispetto alla Supply NON è sufficiente per
  ottenere un Return autonomo utile: il percorso di prova viene bloccato
  immediatamente;
- non è ancora dimostrato quale regola strutturale minima debba differenziare
  il Return (radice, lato/verso, ordine degli offset, distanza o altro);
- fermarsi qui e decidere insieme prima di integrare un Return autonomo nel
  flusso esecutivo o aggiungere qualsiasi euristica.

Stato:
- `Vittorio_revisionato` è sperimentale e non è motore di produzione;
- normale esecutivo `Vittorio_revisionato` continua intenzionalmente a
  riprodurre Vittorio;
- duplicazione tracciata in `TERMODEL-SYNC.md` come PENDING.


### INCARICO 2026-09-29 — Vittorio_revisionato: collaudo multi-progetto e pubblicazione
Stato: **COMMISSIONATO**

Correzione procedurale richiesta dall'utente:
- il collaudo sul solo quadrato non è sufficiente per promuovere
  `Vittorio_revisionato`;
- prima della pubblicazione deve essere confrontato con Vittorio su più
  geometrie/progetti già presenti nel banco prova;
- il confronto deve verificare almeno SVG ed XML risultante, non soltanto
  compilazione o numero di punti;
- se il banco multi-progetto è verde, esporre `Vittorio_revisionato` nel
  Service pubblico come motore selezionabile **per singola elaborazione**,
  senza cambiare il default operativo `Diego_Vittorio`;
- il frontend pubblico deve offrire una selezione esplicita per consentire
  all'utente di collaborare al test su propri progetti;
- la provenienza dell'esecutivo runtime deve mostrare il motore realmente
  usato nella singola elaborazione, non soltanto il default restituito da
  `/health`;
- dopo build/regression/deploy pubblico verificati, aggiornare Summary,
  Recovery e Issue #1.

Criterio di arresto:
- se una fixture diverge da Vittorio, non pubblicare come equivalente:
  registrare il primo caso divergente e fermarsi per analisi.


#### FASE 1 completata — equivalenza multi-progetto
Run Fast Harness `36503404032` (#64): **SUCCESS**.

`Vittorio_revisionato` è stato confrontato byte-per-byte con `Vittorio`
su sei casi: quadrato 4x4, concavo L, trapezio obliquo,
connection-terminal, appartamento corrente preparato e progetto pubblico
Pannelli radianti completo. Per tutti i casi sia lo SVG sia l'XML risultante
hanno SHA-256 identico tra i due motori. Il test sul solo quadrato non è più
considerato sufficiente né rappresentativo della procedura di promozione.

La FASE 2 può quindi esporre `Vittorio_revisionato` per test pubblico come
selezione per-request, mantenendo `Diego_Vittorio` default e senza alterare
il file progetto.


#### FASE 2 completata — pubblicazione per collaudo collaborativo

Implementazione:
- `RadiantExecutiveGenerator` accetta ora una scelta opzionale per-request
  senza modificare `TERMODEL_SPIRAL_ENGINE`;
- motori disponibili pubblicati da `/health.spiralEngines`;
- `POST /api/calculations?spiralEngine=Vittorio_revisionato` usa il motore
  richiesto soltanto per quella elaborazione;
- risposta JSON: campo `spiralEngine`; risposta diretta artifact:
  header `X-Termodel-Spiral-Engine`;
- default invariato: `Diego_Vittorio`;
- frontend pubblico v1.36: Help → “Motore spirali — test pubblico” con
  `Predefinito Service`, `Vittorio_revisionato`, `Vittorio`,
  `Diego_Vittorio`;
- la provenienza dell'esecutivo runtime usa il motore restituito dal calcolo,
  non il solo default di `/health`;
- contratto aggiornato in `docs/TERMODEL-FRONT-SERVICE-CONTRACT.md`.

Verifiche:
- Fast Harness `36503404032` (#64): SUCCESS, equivalenza Vittorio /
  Vittorio_revisionato su 6 casi, SVG + XML byte-identici;
- Fast Harness `36503807860` (#65): SUCCESS dopo l'esposizione Core;
- Service Build `36504429395` (#1067):
  - syntax frontend SUCCESS;
  - wiring frontend SUCCESS;
  - build soluzione SUCCESS;
  - smoke pubblico pannelli default SUCCESS;
  - smoke pubblico locale con
    `spiralEngine=Vittorio_revisionato` SUCCESS;
  - verifica deploy pubblico SUCCESS;
  - workflow globale FAILED più avanti per il golden Darcy sintetico già noto
    (flow 3,18267931870604 L/h, Re 123,401738358689,
    dP 1,31367490344266 Pa), indipendente da questa modifica.
- verifica pubblica del runner:
  - Service commit osservato: `c1a7637ba66728413045d44b75d973550d941082`;
  - default pubblico: `Diego_Vittorio`;
  - motori pubblici:
    `Vittorio,Vittorio_revisionato,GPT,Diego,Diego_Vittorio`;
  - frontend pubblico: `1.36`;
- GitHub Pages run `36504429539` (#1654): SUCCESS.

Stato:
- **pubblicato per test collaborativo**;
- non è motore default;
- non è ancora autorizzata alcuna nuova strategia Return;
- prossimo lavoro: raccogliere progetti reali dall'utente usando
  `Vittorio_revisionato`, documentare eventuali divergenze visive/funzionali
  e solo dopo decidere la minima differenza strutturale del Return.


### 2026-09-29 — politica notifiche GitHub Actions

Su richiesta utente sono state sospese tutte le notifiche ntfy generate dai
workflow tecnici/build. Build, test, deploy, harness e verifiche automatiche
continuano a poter pubblicare il Commit Status `Termodel/job`, ma non inviano
più push al telefono.

L'unica notifica telefonica Termodel resta la chiusura della **Issue #1**,
gestita da `.github/workflows/issue-work-notify.yml`, ora filtrato
esplicitamente su `github.event.issue.number == 1`.

Specifica canonica aggiornata:
`.github/TERMODEL-ACTION-NOTIFICATIONS.md`.


### 2026-09-29 — Vittorio_revisionato: modalità pubblica temporanea solo mandata

Per agevolare l'esame visivo dell'utente, il motore pubblico
`Vittorio_revisionato` è stato temporaneamente configurato per mostrare
**soltanto la mandata**.

Implementazione:
- `Program.SoloMandataPerEsameVisivo = true`;
- `AggiornaSpirali()` genera la mandata e non esegue
  `ChiudiSpiraleFiles()`;
- chiusura e ritorno non sono stati rimossi: restano nel sorgente e sono
  semplicemente sospesi;
- lo SVG pre-chiusura viene riclassificato da blu a rosso affinché il Service
  lo tratti come `*_PannelliMandata_Output`;
- nessuna modifica a `SpiralGenerator` o alla geometria della mandata;
- il benchmark di equivalenza chiama esplicitamente
  `AggiornaSpirali(false)`, conservando il confronto completo storico
  Vittorio/Vittorio_revisionato.

Verifiche reali:
- Service Build #1076, run `36509662811`:
  - build soluzione: SUCCESS;
  - smoke pubblico pannelli default: SUCCESS;
  - smoke override `spiralEngine=Vittorio_revisionato`: SUCCESS;
  - marker `VITTORIO_REVISIONATO_SUPPLY_ONLY_OK`: presente;
  - il test verifica presenza layer Mandata e assenza layer Ritorno e
    NumeriCircuiti/chiusura;
- verifica deploy pubblico: SUCCESS;
- commit Service pubblico osservato:
  `bdb1861be127fa977543b3c86cb0384cc0d6ebb2`;
- default pubblico resta `Diego_Vittorio`;
- frontend pubblico resta v1.36 con selettore
  `Vittorio_revisionato`;
- il workflow globale #1076 è rosso soltanto per il Golden Darcy sintetico già
  noto, successivo e indipendente da questa modifica.

Stato:
- **pubblicato e disponibile per il collaudo visivo dell'utente**;
- modifica temporanea e reversibile;
- per ripristinare il flusso completo basta disattivare
  `SoloMandataPerEsameVisivo` oppure usare
  `AggiornaSpirali(false)`.


### Aggiornamento 2026-09-29 — Vittorio_revisionato, copertura centrale Supply
- Pubblicata una correzione circoscritta alla modalità SOLO MANDATA di `Vittorio_revisionato`: nei soli ultimi anelli rettangolari ortogonali con fascia residua sfruttabile viene aggiunto un asse terminale centrale.
- La logica storica Vittorio resta invariata; benchmark/regression la eseguono con `TerminalCenterline=false`. Il percorso pubblico usa `true` ed è ripristinabile impostandolo a `false`.
- Fast Harness run `36510946051`: SUCCESS completo, inclusa equivalenza multi-progetto e tutte le regression Diego_Vittorio.
- Service Build run `36510945902`: build + smoke pannelli + override Vittorio_revisionato + verifica deploy pubblico SUCCESS; failure globale successiva nello smoke storage/lock, indipendente dalle spirali.
- Commit finale funzionale: `514bb71add522115dfb8358514ce712aa1d8bdf2`.
- Stato: pubblicato, in attesa di conferma visiva utente sul progetto reale.


### Aggiornamento 2026-09-29 — Vittorio_revisionato ibrido con chiusura Diego_Vittorio
- Approvata dall'utente la mandata con completamento centrale.
- Il percorso pubblico `Vittorio_revisionato` genera ora quella mandata e passa lo stesso `locale.xml` direttamente al post-processore `SpiralHeatingDiegoVittorio.ChiudiSpirale.Chiudi` per Return, raccordi e chiusura.
- Nessuna duplicazione nuova delle euristiche Diego: riuso diretto del codice esistente.
- Il benchmark storico resta separato tramite `AggiornaSpirali(false)`.
- Fast Harness #75: SUCCESS completo.
- Service Build #1089: build, smoke pannelli, smoke pubblico `Vittorio_revisionato` completo e verifica deploy: SUCCESS; failure globale successiva nello smoke storage/lock indipendente.
- Commit funzionale `d86a96cc1dcc3cd4293a99da4712184088175b57`; smoke adeguato al nuovo contratto `1c6966e289ec6173938452b12765059271d101ba`.
- Stato: **pubblicato**, in attesa del controllo visivo dell'utente.


### 2026-09-29 — correzione: Return Vittorio, solo raccordo Diego
Correzione esplicita della precedente interpretazione: il percorso pubblico `Vittorio_revisionato` mantiene mandata approvata + `TerminalCenterline`, genera il **Return con la duplicazione/offset storica Vittorio** e NON usa il Return autonomo Diego. Da `Diego_Vittorio` viene riusata direttamente soltanto `CreaCurvaCollegamentoAdattiva` per il raccordo finale migliorato; la chiusura/etichetta resta nel post-processore revisionato. Il benchmark storico resta isolato col raccordo Vittorio originale. Commit finale `8117c6e6629c61eaec0baade6f904ce90cb3f9b5`. Fast Harness #82: build, equivalenze Vittorio, regression pubbliche e fitting: SUCCESS. Service Build #1099: build + smoke pannelli + smoke pubblico Vittorio_revisionato + verifica deploy: SUCCESS; rosso globale solo nello smoke storage/lock indipendente.


### 2026-09-29 — adattamento verso Return Vittorio per chiusura Diego
Il collaudo visivo sul commit cb93b674 ha mostrato diagonali rosse ancora presenti. Causa individuata: incompatibilità di **verso della lista Return**. `CreaCurvaCollegamentoAdattiva` Diego usa `ritorno[^1]` come terminale centrale, mentre `CreaRientro` Vittorio memorizza il terminale centrale in `rientro[0]`. L'adattatore ora inverte temporaneamente il Return solo all'ingresso delle routine Diego (chiusura + raccordo) e lo reinverte in uscita; la geometria del Return Vittorio non viene rigenerata né modificata come algoritmo. Commit `2205e2427a27b925c209bd38019d3af030b7d5d6`. Pubblicato su main; CI #85 / Service #1105 avviate. Necessaria conferma visiva sul progetto reale per dichiarare risolta la diagonale.


### 2026-09-29 — ripristino esclusione raccordi con intersezione
Il controllo visivo ha evidenziato raccordi centrali che attraversavano tratti della serpentina. È stata ripristinata in modo esplicito la regola Diego_Vittorio: `CreaCurvaCollegamentoAdattiva` prova le Bézier candidate e, se nessuna è libera, valida anche la retta finale contro mandata e ritorno; se interseca, restituisce nessun raccordo invece di forzare il segmento. `Vittorio_revisionato` rispetta l'esclusione senza introdurre fallback propri. Return Vittorio e mandata approvata restano invariati. Commit finale `e588acabf00274b2550efcda668415102a33dd9c`; CI #87 / Service #1110 avviate.


### 2026-09-29 — chiusura U per Return Vittorio parallelo
Caso quadrato reale: terminali centrali mandata/Return paralleli e in verso opposto restavano aperti. Il raccordo generico Diego limitava la maniglia Bézier a distanza/3, insufficiente per una inversione a U di 180°. Aggiunta in `CreaCurvaCollegamentoAdattiva` una famiglia candidata U-turn quando il prodotto scalare delle tangenti <= -0.90, con maniglia base 2/3 della distanza tra terminali e tentativi decrescenti. Ogni candidata resta obbligatoriamente soggetta ai filtri anti-intersezione contro mandata e Return; nessun fallback intersecante. Mandata e Return Vittorio invariati. Commit `252022fff9b1f15205fddfcbb7481422e0826ad4`; Fast Harness #88 / Service #1114 avviati.


### 2026-09-29 — uso integrale procedura combinatoria Diego_Vittorio
Il test quadrato ha confermato che non va introdotta una nuova euristica U-turn. Rimossa la strategia aggiunta nel commit 252022f. Il percorso pubblico ora passa mandata revisionata + Return Vittorio duplicato, orientato soltanto come richiesto dall'API Diego, a un unico wrapper della procedura già esistente `GeneraPrimaChiusuraAccettabile`: enumerazione M0..M4, R0..R6 e RP, cancellazione/accorciamento terminali, test lunghezza/angoli/intersezioni, selezione candidato; solo sulla configurazione selezionata viene chiamato il raccordo adattivo esistente. Nessuna seconda chiamata indipendente che perda il candidato combinatorio. Commit integrazione `436de80eb7d1b657e37f92ce3a891174913e9499`; Fast Harness #90 / Service #1119 avviati.


### 2026-09-29 — harness quadrato dedicato per chiusura ibrida
Su richiesta utente è stato introdotto un gate Harness che esegue il **percorso pubblico** Vittorio_revisionato sul quadrato e fallisce se il log non contiene `Chiusura Diego combinatoria: APPLICATA`. Il primo test reale #95 ha dimostrato che la combinatoria veniva alimentata con 343/320 punti già raccordati: M/R cancellavano campioni di arco invece di tratti, quindi nessuna soluzione. È stato ripristinato `SpiraliDiegoVittorio/ChiudiSpirale.cs` al riferimento umano consolidato del commit fb26ed0, aggiungendo soltanto bridge pubblici. Il secondo test #98 ha lavorato correttamente su 33/26 punti rettilinei ma ha evidenziato che l'helper rettilineo usava la normale opposta rispetto al Return Vittorio. Corretto l'adattatore per conservare il lato Vittorio e poi adeguata la scala combinatoria al Return a metà passo. Commit corrente `8dc095b323b811ad97c30bcfd7794d51ce3acc50`; Harness #100 in esecuzione. La chiusura Diego_Vittorio consolidata resta autorità e non va sostituita con nuove euristiche.


### 2026-09-29 — quadrato pubblico chiuso in Harness
Correzione verificata dal gate dedicato Harness #100. Causa finale: l'adattamento del Return Vittorio alla combinatoria Diego richiedeva (1) lavorare sulle polilinee rettilinee prima dei fillet, (2) conservare il lato/segno dell'offset Vittorio e (3) usare la scala coerente col Return a metà passo. La procedura di chiusura interna Diego_Vittorio è stata ripristinata al riferimento umano consolidato `fb26ed0`; sono presenti soltanto bridge/adattatori esterni. Gate `Harness quadrato Vittorio_revisionato public closure`: SUCCESS; equivalenze, square Diego, public square, locale_1/5/8/9 e fitting regression: tutti SUCCESS. Commit funzionale corrente `8dc095b323b811ad97c30bcfd7794d51ce3acc50`. Nessuna nuova euristica di chiusura sostituisce Diego_Vittorio.


### 2026-09-29 — vincolo chiusura minimo 2P ripristinato
Corretto l'adattatore Vittorio/Diego: la scala geometrica del Return resta P/2, ma il criterio di accettazione della chiusura resta quello originale umano `lunghezza >= 2P` riferito al passo nominale. Prima il passaggio di P/2 alla combinatoria riduceva involontariamente la soglia a P. Commit `9f178819b9412d212fa06091c25c66b62216583d`. Harness #101: build SUCCESS e gate quadrato pubblico con vincolo corretto SUCCESS; suite restante in esecuzione al momento della pubblicazione.


### 2026-09-29 — Chiusura Diego_Vittorio: combinatoria simmetrica first-success

Commit `f2b78af0e860a5a52b3d7cc8fe833b799b271d93`.

La ricerca della chiusura centrale di `Vittorio_revisionato` usa ora la stessa matrice per mandata e ritorno: per 0..3 tratti terminali rimossi prova terminale invariato oppure accorciato a `P`; sono stati eliminati tutti i casi di accorciamento a `2P`. Il vincolo di accettazione sulla distanza tra gli estremi resta separato e pari a `>= 2P` nominale.

La ricerca è ora realmente first-success: ogni coppia viene tagliata/accorciata, valutata, raccordata e controllata per intersezioni sulla geometria risultante; il primo raccordo completo valido interrompe immediatamente la combinatoria. Sono state rimosse dalla selezione le proiezioni `RP*` e la successiva scelta del candidato “migliore”, che potevano selezionare un candidato prima della verifica finale del raccordo.

Stato: implementato e pubblicato su GitHub; compilazione/esecuzione Visual Studio locale ancora da verificare.


### 2026-09-29 — Direttiva rigida sul significato geometrico di P nelle spirali

Questa convenzione è vincolante per lo sviluppo delle spirali e prevale su formulazioni precedenti ambigue:

- `P` = distanza tra un tubo di **mandata** e il tubo di **ripresa/ritorno** adiacente;
- `2*P` = distanza tra **due tubi di mandata** adiacenti;
- `P/2` = distanza tra il tubo di **mandata** e le **linee della parete**;
- non chiamare genericamente `passo` una grandezza che vale `P/2` o `2*P`: ogni derivazione deve restare esplicita;
- gli adattatori Vittorio/Diego_Vittorio non possono ridefinire semanticamente `P` per comodità implementativa;
- prima di modificare algoritmi di generazione, Return o chiusura, verificare ogni uso di `P`, `P/2` e `2*P` contro questa convenzione.

La precedente descrizione di `P` come distanza tra due mandate / passo mandata-mandata è da considerarsi superata: quella distanza è `2*P`.

### 2026-09-29 — allineamento operativo Vittorio_revisionato alla convenzione P

Implementate le ultime direttive geometriche concordate senza eseguire Fast Harness:
- nell'adattatore `ApplicaChiusuraCombinatoriaSuRitornoVittorio`, il parametro `passo` e' trattato rigidamente come `P` = distanza Mandata-Ripresa; non viene piu' dimezzato prima della combinatoria;
- il vincolo minimo della chiusura resta `>= 2P`, dove `2P` e' la distanza Mandata-Mandata;
- la matrice simmetrica Mandata/Ripresa e' ridotta a `(0,I),(0,P),(1,I),(1,P),(2,I),(2,P)`: massimo 36 coppie e massimo 3 tratti originali coinvolti per lato;
- la modalita' `P` porta il terminale a lunghezza esattamente `P`: se e' piu' lungo lo accorcia, se e' piu' corto lo allunga;
- corretto anche il richiamo interno della chiusura Diego_Vittorio autonoma passando il `raggioCurvatura` richiesto dalla firma corrente;
- `P/2` resta riservato semanticamente alla distanza Mandata-Parete e non viene usato come scala della chiusura Vittorio.

Per disposizione utente il Fast Harness resta fermo. La verifica richiesta per questo job e' la compilazione/deploy del Service e la conferma del commit effettivamente servito da Render tramite `/health`.

### 2026-09-29 — quadrato Vittorio_revisionato: causa reale e chiusura M2P/R0P

Risolta e verificata la mancata chiusura del quadrato indicata visivamente dall'utente.

La soluzione geometrica richiesta e' precisamente:
- Return/Ripresa: nessun tratto eliminato, ultimo tratto portato a `P` -> `R0P`;
- Mandata: eliminare 2 tratti, nuovo terminale portato a `P` -> `M2P`;
- con il caso quadrato corrente `P = 0,15 m`.

Il trace reale precedente alla correzione mostrava che `M2P/R0P` veniva effettivamente generata ma scartata **prima** della costruzione/verifica del raccordo:
- Mandata terminale: `(2.2,1.8) -> (2.2,1.95)`, lunghezza `0,15 m = P`;
- Return terminale: `(2.35,1.65) -> (2.35,1.8)`, lunghezza `0,15 m = P`;
- distanza rettilinea fra estremi: `0,212132... m`;
- vecchio filtro: `0,212132 < 0,30` -> `reason=length`;
- se il filtro lunghezza viene rinviato, anche il filtro sulla **corda rettilinea** produce `cosSupply=-0,7071`, pur essendo possibile un raccordo curvo valido.

La causa era quindi concettuale: `2P` e' la distanza Mandata-Mandata e non puo' essere usata come lunghezza minima della corda rettilinea tra gli estremi di un raccordo curvo; inoltre l'angolo della corda non rappresenta la tangente del raccordo reale.

Correzione pubblicata nel commit `e60d9ed9c5536852dbb60c146cdb6abb72957e87`:
- modifica isolata nel bridge `ApplicaChiusuraCombinatoriaSuRitornoVittorio`;
- per `Vittorio_revisionato` le configurazioni con terminale normalizzato a `P` vengono provate prima della variante invariata;
- i filtri preliminari basati su lunghezza/angolo della corda rettilinea vengono rinviati: la decisione finale e' presa sul raccordo curvo realmente costruito e sul controllo delle intersezioni;
- il percorso Diego_Vittorio storico conserva i propri default di ordinamento e filtri;
- il gate del quadrato ora richiede esplicitamente `DV_CLOSURE_SELECTED ... seq=M2P/R0P` e verifica entrambi i terminali a `P=0,15`, eliminando il precedente controllo Harness errato che leggeva la proprieta' inesistente `case.Passo`.

Verifica reale GitHub Harness su main, run `36543729092`:
- build Harness/Core: SUCCESS;
- `Harness quadrato Vittorio_revisionato public closure`: SUCCESS;
- selezione verificata: `M2P/R0P`;
- terminali verificati: `P=0,15 m`;
- equivalenza iniziale Vittorio_revisionato: SUCCESS;
- equivalenza multi-progetto Vittorio_revisionato: SUCCESS;
- check astrazione Vittorio_revisionato: SUCCESS;
- Diego_Vittorio square: SUCCESS;
- il workflow completo resta rosso successivamente sul gate separato `Run public square left inlet regression` del motore Diego_Vittorio: questa regressione non fa parte della chiusura quadrato Vittorio_revisionato appena corretta e resta da trattare separatamente.

Verifica Service, run `36543729007`:
- compilazione Release: SUCCESS;
- smoke richiesta `Vittorio_revisionato`: SUCCESS;
- deploy pubblico Render: SUCCESS;
- `/health` ha esposto `serviceCommit=e60d9ed9c5536852dbb60c146cdb6abb72957e87`;
- il workflow Service complessivo resta rosso per lo smoke storage/lock locale `Termodel.WebService non ha risposto a /health`, problema separato dalla generazione della spirale e dal deploy pubblico.

Questa sezione **supera** le precedenti formulazioni che imponevano `lunghezza corda >= 2P` al bridge Vittorio_revisionato.

### 2026-09-29 — quadrato: vincolo `lunghezza raccordo >= 2P`

Dopo la prima chiusura M2P/R0P l'utente ha rilevato visivamente che il raccordo prodotto era troppo corto. Chiarimento vincolante: il requisito `>= 2P` non va applicato alla corda rettilinea fra gli estremi, ma alla **lunghezza reale della curva di raccordo finale**.

Correzione implementata:
- la configurazione resta `M2P/R0P` sul quadrato;
- per il bridge `Vittorio_revisionato` il raccordo adattivo riceve `lunghezzaMinima = 2P`;
- la maniglia della Bezier viene estesa progressivamente, entro la lunghezza disponibile dei terminali, finche' la polilinea campionata del raccordo raggiunge `2P`;
- un candidato e' valido solo se la lunghezza reale del raccordo e' `>= 2P` **e** non interseca Mandata/Return;
- se nessuna curva soddisfa entrambi i vincoli, quella combinazione viene scartata e la ricerca continua;
- il comportamento storico senza vincolo esplicito resta invariato.

Commit funzionale principale: `d0fd8c372792998a16bb3c78c998d86498a7872c`; commit diagnostico finale: `633acf94f27c797580402c24de762592bb9c7af7`.

Verifica Harness mirata, run `36553567099`:
- Build Harness/Core: SUCCESS;
- gate `Harness quadrato Vittorio_revisionato public closure`: SUCCESS;
- configurazione: `M2P/R0P`;
- `P = 0,15 m`;
- lunghezza raccordo misurata: `0,300501402127749 m`;
- minimo richiesto: `2P = 0,30 m`;
- esito: `REVISIONATO_PUBLIC_SQUARE_CURVE_2P_OK`.

Verifica Service, run `36553567271`:
- Build Release: SUCCESS;
- smoke pubblico `Vittorio_revisionato`: SUCCESS;
- deploy Render: SUCCESS;
- `/health` ha esposto `serviceCommit=633acf94f27c797580402c24de762592bb9c7af7`;
- il workflow complessivo resta rosso sullo smoke storage/lock locale gia' noto, separato dalla chiusura e dal deploy.

Il Fast Harness automatico e' stato nuovamente fermato dopo la verifica.

### 2026-09-29 — rollback completo dopo regressione visiva del Return blu esterno

Il collaudo manuale sul server ha evidenziato una regressione grave introdotta
dalla sequenza di modifiche successiva a `c4c7f1ff2b621090a74ec258b3e730377006a728`:
il Return blu usciva all'esterno della stanza e la successiva patch
"no acute angles" non correggeva la cuspide rossa.

Per disposizione utente sono state annullate **tutte e cinque** le modifiche
successive al baseline, non soltanto l'ultimo gate angolare:
- `699359e16202cb4e2a0bf0e88a2120fd4f6ee4a8` — normalizzazione runtime P=0,30;
- `17403b42ee52e04603cb6357027fbcab007a23e0` — Harness P=0,30;
- `cfae98d64beffe3d614545c15e0ee35fb88bb706` — documentazione P=0,30;
- `00802024038225314a5b682787395b1f6b0f82f5` — gate no-acute;
- `10e77fa647c0024cd046c65d7e2fd7625a9ccc64` — documentazione no-acute.

Il commit di rollback `db13de55c3589a2d6ef8ad5380944295758d7570`
usa esattamente lo stesso tree del baseline
`c4c7f1ff2b621090a74ec258b3e730377006a728`: il confronto Git tra i due
commit riporta **0 file differenti**.

Stato runtime ripristinato:
- `PassoTubi=0,30 m` come nel baseline storico;
- distanza Supply-parete del baseline: `0,30 m`;
- distanza Return usata dalla chiusura revisionata: `0,15 m`;
- chiusura quadrato precedente `M2P/R0P` e vincolo lunghezza reale raccordo
  `>=2P` restano quelli del baseline;
- la normalizzazione P=0,30 e il gate finale sugli angoli acuti **non sono
  attivi** dopo il rollback.

Motivo del rollback: ripristinare prima la geometria stabile in cui il Return
blu non veniva spinto fuori parete; la semantica P=0,30 potrà essere
reintrodotta solo con una modifica che preservi il lato corretto del Return.

La scomparsa visiva del blu esterno richiede conferma nel browser dell'utente;
build/deploy server verificano soltanto che il baseline sia stato pubblicato
correttamente.

### 2026-09-29 — ripresa dopo rollback: vincolo 2P sulla chiusura finale visibile

Il punto di ripristino `0df1d3bad2b9992a3cfd9af2e95f186301024f87` e' stato accettato
visivamente dall'utente come baseline: in particolare la geometria Mandata/Ripresa e il Return
blu non devono essere modificati.

Autorizzazione corrente limitata alle **sole funzioni di chiusura**.
Convenzione usata dal baseline:
- `P = distanza Mandata-Ripresa = distanzaRitorno`;
- nel quadrato corrente `P=0,15 m`;
- lunghezza reale del raccordo finale visibile richiesta: `>= 2P = 0,30 m`.

Problema individuato: il bridge Diego selezionava e validava il raccordo sulle polilinee
rettilinee, poi `Vittorio_revisionato` arrotondava Mandata e Ripresa ma continuava a
disegnare il raccordo calcolato prima dell'arrotondamento. Di conseguenza la geometria
visibile finale non era necessariamente la stessa che aveva superato il gate `>=2P`.

Correzione sperimentale commit `4aea9aac156912abde40397d5281a97fcccb0b91`:
- modificato **solo** `SpiraliVittorioRevisionato/ChiudiSpirale.cs`;
- nessuna modifica a `Program.cs`, `Spiralgenerator.cs`, offset, Supply, Return, API o frontend;
- dopo l'arrotondamento definitivo di Mandata e Ripresa viene rigenerato soltanto il raccordo
  centrale;
- la curva finale viene accettata solo se la sua lunghezza polilinea reale e' `>=2P` e non
  interseca tratti non adiacenti dei percorsi;
- se non esiste un raccordo valido, il bridge non forza una chiusura invalida;
- marker diagnostici: `VREV_FINAL_CLOSURE_2P_OK` / `VREV_FINAL_CLOSURE_2P_REJECT`.

Service Build run `36562384689`:
- build Release: SUCCESS;
- smoke progetto pubblico: SUCCESS;
- smoke override `spiralEngine=Vittorio_revisionato`: SUCCESS;
- deploy Render: SUCCESS;
- `/health` ha esposto `serviceCommit=4aea9aac156912abde40397d5281a97fcccb0b91`;
- rosso globale soltanto sul noto smoke locale storage/lock.

**Stato: implementato e pubblicato, NON ancora consolidato.**
Serve conferma visiva sul quadrato prima di introdurre qualunque ulteriore vincolo di chiusura.

