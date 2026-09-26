# STRATEGIADIEGO — REGISTRO DI SVILUPPO

Data avvio: **25/09/2026**  
Stato generale: **IN SVILUPPO — BANCO PROVA APPARTAMENTO REALE CORRENTE**

Scopo: registrare fasi indipendenti e recuperabili dell'implementazione,
attivazione e benchmark della StrategiaDiego.


## R19 — Return/Return a passo p
Stato: **ESEGUITO — SIMULAZIONE GEOMETRICA POSITIVA / COSTO COMBINATORIO ELEVATO**

Decisione utente 26/09/2026:
- distinguere il passo funzionale delle due famiglie;
- Supply/Supply resta `2p`, perché la mandata crea le anse;
- Return/Return diventa `p`, perché il ritorno deve riempire le anse;
- Supply/Return e Return/Supply restano `p`;
- tubo/architettura resta `p/2`;
- simulare sul prototipo PR #8 senza merge automatico e notificare tramite Issue #1.

Implementazione sperimentale:
- branch `experiment/lg041-supply-first-return-after`, commit `db380ea6af1fad8de4fed1df45aca64b395372c1`, PR #8;
- modificata soltanto `RequiredDistance()` per il caso `newFamily=Return` / `referenceFamily=Return`;
- nessuna modifica all'albero o alla funzione di merito.

Risultati Harness:
- run `36228623930`: **SUCCESS**;
- quadrato: 374 Supply + 43.670 Return = 44.044 nodi totali;
- 12.545 terminali combinati, 8.192 accettati, maxDepth 35;
- selected Supply invariata: activeLength `28,05 m`, goodness `1,052`;
- selected Return: activeLength `21,05 m`, goodness `0,789`;
- confronto LG-045: Return precedente activeLength `20,15 m`, goodness `0,756`; guadagno `+0,90 m` attivi e `+0,033` di goodness;
- SVG SHA `ca3ba4bbda4a6e95398f3d155f7009d05e0e378843b06b26b86f9fe0a82e8ce0`;
- log: 7.328 candidati Return/Return accettati con `d=0,30 m`; nessun Return/Return accettato con `d=0,60 m`;
- appartamento preconfezionato: SUCCESS, 43 Supply + 198 Return = 241 nodi, 4 terminali accettati, 117 ms diagnostici.

Confronto geometrico selezionato sul quadrato:
- la mandata è identica alla LG-045;
- il ritorno aggiunge una percorrenza più fitta nelle anse interne, inclusi tratti corti coerenti col passo `p`;
- il terminale blu selezionato migliora senza alterare il terminale rosso.

Sostenibilità:
- build completa: compilazione SUCCESS;
- benchmark quadrato: 20/20 deterministico, 44.044 nodi, P95 `3.904 ms`, memoria delta max ~12,62 MB, 8.192 terminali accettati;
- numero nodi ancora entro budget 50.000, ma P95 oltre budget 2.000 ms -> `not-sustainable`;
- la regression completa si ferma già sul quadrato, quindi fixture successive non verificate in questa run;
- nessun limite alzato e nessuna potatura euristica introdotta.

Decisione:
- LG-046 registrata come approvata e simulata;
- geometria del ritorno migliorata e principio `Return/Return=p` confermato;
- PR #8 resta sperimentale e non integrata in `main`;
- prossimo problema: deduplicazione esatta degli stati Return, ora molto più numerosi.

## R18 — Perché il ramo anticipato 47→49 risulta più efficiente
Stato: **ESEGUITO — DIAGNOSI LOG / NESSUNA MODIFICA CODICE**

Domanda utente 26/09/2026:
- approfondire perché il ramo anticipato `47->49` produce goodness maggiore di `47->48`; ipotesi: il ramo `47->48` non viene poi sviluppato normoticamente.

Confronto dei migliori terminali:
- sottoalbero `47->48`: miglior terminale nodo 74, activeLength `25,45 m`, goodness `0,954`;
- sottoalbero `47->49`: miglior terminale nodo 123, activeLength `28,05 m`, goodness `1,052`;
- differenza activeLength: `+2,60 m` a favore del ramo anticipato.

Ricostruzione del ramo `47->48`:
- `47->48`: `(0.75,0.15)->(1.40,0.15)`;
- `48->50`: salita a `(1.40,0.75)`;
- sviluppo normotico fino a `(3.25,3.25)->(1.40,3.25)`;
- al nodo 62 `(1.40,3.25)` esiste correttamente `PROSEGUI_DRITTO 62->63` fino a `(0.75,3.25)`;
- il terminale migliore del sottoalbero però non usa `62->63`: gira anticipatamente con `62->65`, verticale su `x=1.40` fino a `y=1.35`;
- se si segue `62->63`, al nodo 63 entrambe le parallele vengono respinte e il nodo diventa terminale con goodness `0,812`.

Motivo del blocco al nodo 63:
- da `(0.75,3.25)` la prosecuzione verticale verso il basso trova come fronte successivo la retta del tratto interno a `y=0.75`, con `rayTravel=2,50 m`;
- in quel punto `x=0.75` la retta `y=0.75` è soltanto il **prolungamento laterale** del segmento reale, che nel ramo `47->48` inizia a `x=1.40`;
- `TryExtend()` usa oggi la stessa regola anche per `PARALLELA_A/B`: se il riferimento è laterale, applica LG-034/LG-035 come `tEnd = I + d`, cioè prosegue **oltre** il prolungamento di `2p`;
- partendo da `y=3.25`, intersezione teorica `y=0.75`, `2p=0.60`: il candidato arriva fino a `y=0.15` invece di fermarsi a `y=1.35`;
- il candidato così sovra-esteso collide/tocca la mandata inferiore e viene respinto (`VALIDATE ... distance=0 required=0.6`);
- quindi il ramo `47->48` perde la discesa normotica su `x=0.75` e ripiega prima su `x=1.40`.

Perché `47->49` riesce invece a completarsi:
- il ramo anticipato crea subito il verticale su `x=0.75` e poi il tratto reale a `y=0.75` a partire proprio da `x=0.75`;
- quando più avanti torna a `(0.75,3.25)`, l'intersezione col fronte `y=0.75` è **fisica**, non laterale;
- `TryExtend()` in caso fisico applica `I - d`, quindi si ferma correttamente a `y=1.35`;
- da lì il ramo continua a costruire una spirale interna molto più completa.

Origine esatta dei `+2,60 m`:
- `+0,65 m`: il ramo `47->49` completa in alto `(1.40,3.25)->(0.75,3.25)`, tratto che il miglior ramo `47->48` sacrifica girando prima;
- `+0,70 m`: sulla corsia `y=1.35` il ramo anticipato copre circa `1,90 m`, contro `1,20 m` del ramo alternativo;
- `+1,25 m`: sulla corsia `y=2.65` il ramo anticipato costruisce il traverso interno lungo circa `1,25 m`, quasi assente nel terminale del ramo `47->48`;
- somma: `0,65 + 0,70 + 1,25 = 2,60 m`, esattamente il vantaggio misurato.

Diagnosi strutturale:
- la bontà maggiore di `47->49` è quindi un **artefatto dello sviluppo incompleto del ramo 47->48**, non la prova che la svolta anticipata sia geometricamente migliore;
- il problema è che la semantica `oltre il prolungamento` di LG-034/LG-035 viene riutilizzata indistintamente anche quando una `PARALLELA_A/B` sta cercando un normale fronte di arresto per completare una spira;
- per il normale circuito normotico, quando una parallela usa la retta estesa di un fronte come limite, il terminale atteso è **prima del fronte di `d`**, non oltre;
- da discutere come prossima correzione: separare la semantica dei candidati `PROSEGUI_DRITTO` laterali (che possono richiedere `oltre I`) dalla semantica delle svolte `PARALLELA_A/B` di chiusura normotica (che devono potersi arrestare `prima di I`).
## R17 — Diagnosi distanza 45→47 rispetto a 1→3
Stato: **ESEGUITO — DIAGNOSI LOG / NESSUNA MODIFICA CODICE**

Osservazione utente 26/09/2026:
- nel quadrato ormai quasi normotico, il tratto selezionato `45->47` termina troppo lontano dal tratto iniziale `1->3`.

Coordinate del percorso selezionato:
- nodo 45 = `(0.15,0.15)`;
- nodo 47 = `(0.75,0.15)`;
- nodo 1 = `(2.00,0.15)`;
- nodo 3 = `(3.85,0.15)`;
- quindi `45->47` è collineare a `1->3`, ma il vuoto fra 47 e 1 misura `1,25 m`, maggiore dei `2p=0,60 m` attesi.

Risultato log al nodo 47:
- `PROSEGUI_DRITTO 47->48` viene **generato e accettato**: `(0.75,0.15)->(1.40,0.15)`;
- il punto 48 = `(1.40,0.15)` è esattamente a `0,60 m = 2p` dal nodo 1 = `(2.00,0.15)`; quindi geometria e distanza attese sono disponibili;
- contemporaneamente viene accettato `PARALLELA_B 47->49`: `(0.75,0.15)->(0.75,0.75)`;
- il percorso vincente usa `47->49`, quindi il tratto orizzontale selezionato resta fermo a 47 e appare troppo lontano da `1->3`.

Confronto dei due sottoalberi:
- sottoalbero `47->48`: miglior terminale rilevato = nodo 74, activeLength `25,45 m`, goodness `0,954`;
- sottoalbero `47->49`: miglior terminale = nodo 123, activeLength `28,05 m`, goodness `1,052`; è il terminale Supply selezionato;
- il ramo corretto rispetto alla distanza non viene quindi scartato geometricamente: perde esclusivamente per la funzione di selezione finale.

Diagnosi strutturale:
- non è un errore di `RequiredDistance`: il punto a `2p` viene calcolato correttamente;
- non è un problema di mancata generazione: `47->48` esiste ed è valido;
- il comportamento deriva dal fatto che l'albero ammette un **cambio di direzione anticipato al nodo 47** (`47->49`) e la bontà basata sulla copertura/lunghezza premia quel sottoalbero più lungo;
- la funzione di merito corrente non contiene una nozione di continuità/normoticità che imponga di completare il tratto diritto fino al fronte disponibile prima di una nuova svolta.

Possibile regola da discutere prima di modificare:
- quando esiste un `PROSEGUI_DRITTO` valido che porta alla distanza corretta dal prossimo fronte della stessa evoluzione, valutare se le svolte `PARALLELA_A/B` anticipatrici debbano essere rinviate al terminale di quel tratto invece di competere subito col ramo diritto;
- evitare di introdurre un semplice premio numerico alla normoticità: preferibile una regola geometrica locale e deterministica.
## R16 — Esclusione catena collineare-contigua negli at-node
Stato: **ESEGUITO — SIMULAZIONE GEOMETRICA POSITIVA / REGRESSION ANCORA NON SOSTENIBILE**

Decisione utente 26/09/2026:
- correggere il cambio guida prematuro diagnosticato in R15;
- negli `at-node` escludere l'intera catena collineare e contigua dell'evoluzione di arrivo, non tutti gli `at-node`;
- mantenere LG-034/LG-035 per fronti geometricamente distinti;
- simulare con Harness e notificare via Issue #1.

Implementazione sperimentale:
- branch `experiment/lg041-supply-first-return-after`, commit `1a734a98bc699d585c4fe80ad5dc791b913c5da1`, PR #8;
- aggiunto `IsSameArrivalStraightChain()`;
- la catena è la componente connessa per estremi, stessa famiglia e stessa retta di supporto del segmento corrente;
- `FindSequenceContinuation()` applica l'esclusione soltanto con `rayTravel=0` e registra `SEQUENCE skip-same-arrival-chain`.

Risultato Harness:
- run `36226870346`: **SUCCESS**;
- quadrato: 374 Supply, 110 terminali Supply, 8.854 Return, 9.228 nodi totali, 2.560 terminali accettati, maxDepth 30;
- percorso rosso vincente nella zona critica: `(2.60,0.75)->(3.25,0.75)->(3.25,3.25)->(1.40,3.25)->(0.75,3.25)->(0.75,1.35)`;
- quindi il ramo verticale/normotico prevale e il cambio guida spurio verso `48->50` scompare;
- benchmark quadrato 20/20 deterministico: P95 788 ms, memoria delta max ~16,77 MB, SVG SHA `e1e7565aa0007e7530175879cdf3589966a32e9ef7cc2b5c3b85e157e264f4cf`;
- appartamento preconfezionato: SUCCESS, 93 nodi totali, 4 terminali accettati, 61 ms diagnostici.

Regression:
- build completa PR: compilazione SUCCESS;
- quadrato sostenibile;
- `ConcaveL`: 99.419 nodi, 4 terminali accettati, P95 6.812 ms, quindi `not-sustainable` rispetto ai budget 50.000 nodi / 2.000 ms;
- la run si ferma su ConcaveL, pertanto trapezio e ConnectionTerminal non risultano verificati in questa iterazione;
- nessun limite alzato e nessuna potatura euristica introdotta.

Decisione:
- LG-045 registrata come approvata e simulata;
- PR #8 resta sperimentale e non integrata in main;
- prossimo lavoro: deduplicazione esatta degli stati per ridurre i 99.419 nodi del concavo senza perdere il comportamento normotico ottenuto.

## R15 — Diagnosi nodo 95/97: cambio guida prematuro su 48→50
Stato: **ESEGUITO — DIAGNOSI LOG / NESSUNA MODIFICA CODICE**

Analisi utente 26/09/2026:
- dopo il primo scavalcamento corretto, il percorso selezionato gira da nodo 97 verso sinistra, risultando parallelo a `48->50`, mentre ci si attende la prosecuzione normotica parallela a `3->39`;
- richiesta verifica log per distinguere generazione/scarto/merito.

Risultato log:
- percorso selezionato: `... 48 -> 50 -> 95 -> 97 -> 99 ...`;
- nodo 95 = `(3.25,0.75)`, `front` con `SequenceIndex=2`, cioè riferimento della famiglia del tratto `3->39`; direzione parallela cercata verticale;
- `FindSequenceContinuation()` al nodo 95 trova però `next=10` con `rayTravel=0`; sequence 10 corrisponde al tratto orizzontale `48->50`;
- ciò avviene perché la retta/prolungamento di `48->50` passa esattamente per nodo 95 ed LG-034/LG-035 ammettono la continuazione `at-node`;
- il tratto `48->50` è inoltre collineare e contiguo alla corsa di arrivo `50->95`: è quindi geometricamente la stessa evoluzione rettilinea spezzata in due segmenti, ma l'esclusione corrente opera solo per ID del segmento di arrivo e non per evoluzione collineare;
- da `48->50` il motore costruisce `95->97` come `EXTEND beyond-extended-front`, `d=2p=0,60 m`, e assegna al nodo 97 proprio `48->50` come nuovo `front`;
- al nodo 97 viene comunque generato e accettato `PROSEGUI_DRITTO` verticale `97->98`, `(3.25,1.35)->(3.25,3.25)`: quindi la prosecuzione attesa parallela a `3->39` non è assente;
- contemporaneamente viene accettata `PARALLELA_B` orizzontale `97->99`, `(3.25,1.35)->(1.40,1.35)`, coerente col nuovo front orizzontale `48->50`;
- il terminale selezionato `1098` discende dal ramo `97->99`;
- il ramo alternativo `97->98` produce anch'esso terminali con gli stessi valori visualizzati del vincente: activeLength `29,25 m`, goodness `1,097`, length totale `29,40 m` (es. terminale 603);
- la selezione non contiene un criterio di preferenza per continuità/normoticità e i log arrotondano a tre decimali, quindi non distinguono un eventuale delta floating-point minimo fra terminali apparentemente pari.

Diagnosi strutturale:
- il problema primario è il **cambio guida prematuro al nodo 95**: un segmento collineare della stessa corsa di arrivo (`48->50`) viene interpretato come nuovo fronte `at-node`;
- la sola esclusione del `currentSegment` per ID introdotta da LG-044 non basta: il tratto precedente collineare `48->50` ha ID diverso;
- ipotesi da discutere prima di modificare: nella ricerca della continuazione, escludere l'intera evoluzione collineare/contigua al segmento di arrivo quando viene incontrata solo tramite prolungamento `rayTravel=0`, lasciando invece validi gli `at-node` appartenenti a un fronte geometricamente distinto;
- nessuna modifica al prototipo in R15.

## R14 — Eco 1→3: esclusione del segmento di arrivo
Stato: **ESEGUITO — SIMULAZIONE GEOMETRICA POSITIVA / REGRESSION NON SOSTENIBILE**

Decisione utente 26/09/2026:
- usare i log per determinare se la parallela a `1->3` veniva generata e poi scartata oppure non arrivava alla valutazione;
- diagnosi: `node.Front` conservava già il riferimento guida, ma `FindSequenceContinuation()` selezionava il segmento appena percorso perché intersecava il nodo a distanza zero;
- approvata la correzione minima: escludere sempre il segmento corrente/di arrivo dalla ricerca della continuazione;
- nessun nuovo `GuideReference` se non necessario; nessun merge in main senza verifica visuale.

Implementazione sperimentale:
- branch `experiment/lg041-supply-first-return-after`, commit `8664e780dc810d6d9ff34cbaa7c9b82e671a2fcf`, PR #8;
- `FindSequenceContinuation()` riceve il segmento corrente e lo esclude sia nella ricerca sequenziale sia nella ricerca geometrica own-family/return-follows-supply;
- log aggiunge `excludedCurrent`.

Risultato Harness:
- run `36225982580`: **SUCCESS**;
- quadrato: 8.940 Supply, 3.642 terminali Supply, 6.317 Return, 15.257 nodi totali, 12 terminali accettati, maxDepth 30;
- benchmark quadrato 20/20: P95 1.055 ms, memoria delta max ~17,77 MB, SVG SHA `52ca8f50765ea10beda90dc24c320f90134f910173739f39633f7c1ff37827d5`;
- percorso vincente: `(0.15,0.15)->(0.75,0.15)->(1.40,0.15)->(1.40,0.75)->(2.60,0.75)->(3.25,0.75)`;
- il tratto `(1.40,0.75)->(2.60,0.75)` è la parallela eco a `1->3` a distanza `2p=0,60 m` ed entra realmente nella soluzione selezionata;
- mandata selezionata: activeLength 29,25 m, goodness 1,097;
- appartamento preconfezionato: SUCCESS, 66 nodi totali, 2 accettati, 81 ms diagnostici.

Regression:
- build PR compila;
- benchmark quadrato sostenibile;
- `ConcaveL` supera nuovamente 250.000 nodi: la riapertura corretta delle alternative aumenta fortemente la combinatoria;
- nessun limite alzato e nessuna potatura euristica introdotta.

Decisione:
- LG-044 registrata come approvata e simulata;
- PR #8 resta sperimentale e non viene integrata;
- prossimo problema separato: deduplicazione esatta/stati equivalenti per contenere la ricerca senza perdere le alternative geometriche corrette.

## R13 — Raccordo entrante promosso a Return sequence 0
Stato: **ESEGUITO — SIMULAZIONE REALE POSITIVA / GEOMETRIA VINCENTE INVARIATA**

Decisione utente 26/09/2026:
- verificare l'ipotesi che il raccordo entrante del ritorno, mantenuto come `ReturnConnection`, potesse disturbare la capacità del blu di infilarsi fra due mandate;
- approvata la modifica sperimentale: dopo l'ingresso il raccordo diventa normale `Return`, sequence 0, e partecipa a LG-041;
- mantenere supply-first LG-042 e nessun merge in main senza verifica.

Prototipo:
- branch `experiment/lg041-supply-first-return-after`, commit `7946cc0096cec52db7611a42f21402185ae72414`, PR #8;
- il segmento entrante blu non viene più riclassificato `ReturnConnection`; resta `GeoFamily.Return` con `SequenceIndex=0`;
- log esplicito `promotedTo=Return sequence=0 strategic=true`;
- LG-041 può usare `D-RETURN-0` come riferimento fisico/laterale.

Risultati Harness:
- run `36225285732`, job `108358001545`: **SUCCESS**;
- quadrato: 290 nodi Supply, 1.046 Return, 1.336 totali, 16 terminali accettati;
- 42 candidate LG-041 riferiti a `D-RETURN-0`: 32 ACCEPT, 8 REJECT, 2 DUPLICATE;
- esempio nodo Return 300: candidato laterale generato dal raccordo da `(2.95,3.55)` a `(1.10,3.55)`, `d=0,60 m`;
- ritorno selezionato su `x=1,05` fra mandate `x=0,75` e `x=1,35`: distanza `p=0,30 m` da entrambe;
- benchmark quadrato 20/20: 1.336 nodi, P95 250 ms, memoria delta max 3.556.896 byte;
- appartamento preconfezionato: SUCCESS, 80 nodi, 3 terminali accettati, 33 ms.

Confronto con R12:
- geometria finale rossa e blu sul quadrato invariata;
- nodi 1.016 -> 1.336: l'estendibilità del raccordo apre più alternative Return ma non cambia il terminale vincente;
- il corridoio blu a `p` fra due mandate era già presente nella soluzione vincente supply-first;
- quindi il trattamento speciale del raccordo non è la causa del mancato eco rosso dopo `29->30`.

Regression:
- `ConcaveL`: 4.455 nodi / 72 accettati / P95 362 ms;
- `ObliqueTrapezoid`: 1.931 nodi / 36 accettati / P95 224 ms;
- `ConnectionTerminal`: ancora oltre 250.000 nodi; build completa PR fallisce sul benchmark di questo caso.

Decisione:
- LG-043 registrata come approvata e simulata;
- PR #8 resta sperimentale;
- problema successivo da affrontare separatamente: persistenza del riferimento guida/eco della mandata dopo lo scavalcamento.

## R12 — Supply-first: mandata completa prima del ritorno
Stato: **ESEGUITO — SIMULAZIONE REALE POSITIVA / NON INTEGRATA**

Decisione utente 26/09/2026:
- approvata la modifica strutturale: il ritorno deve essere costruito soltanto dopo la conclusione della mandata;
- durante la ricerca della mandata nessuna geometria `Return` o `ReturnConnection` può condizionare il rosso;
- il ritorno può invalidare una mandata terminata ma non modificarne la costruzione;
- usare Radiant Harness e Issue #1 per il collaudo/notifica;
- nessun merge in `main` prima della valutazione visuale.

Prototipo:
- branch `experiment/lg041-supply-first-return-after`, PR #8;
- albero mandata costruito una sola volta con architettura + collegamenti esterni + mandata corrente;
- terminali mandata ordinati per `TerminalGoodness`, poi lunghezza attiva e totale;
- radici e raccordi ritorno creati solo dopo il terminale mandata in esame;
- la mandata completa viene usata come `fixedPath` del ritorno;
- primo terminale mandata che ammette almeno un ritorno viene selezionato; per quella mandata si sceglie la migliore configurazione blu corrente.

Risultati quadrato:
- Harness run `36224330125`, job `108355311328`: **SUCCESS**;
- percorso rosso selezionato: `... 27 -> 28 -> 29 -> 30 ...`; il tratto `28 -> 29` resta verticale e indipendente dal ritorno;
- 290 nodi Supply, 64 terminali Supply, 726 nodi Return, 1.016 nodi totali, 16 terminali accettati, maxDepth 25;
- run diagnostico Harness ~393 ms;
- benchmark 20/20 deterministico: P95 313 ms, memoria delta max ~10,95 MB;
- SVG SHA-256 `d2af75acfb1b717c6d08ad82dfb0bfa89fc5dd6fd9b2ebfaa1d9db8e3b84bc7f`;
- rispetto al prototipo LG-041 precedente sul quadrato (17.616 nodi), riduzione a 1.016 nodi (~94,2%).

Altri casi:
- appartamento preconfezionato Harness: SUCCESS, 42 Supply + 38 Return = 80 nodi, 3 terminali accettati, ~65 ms diagnostici;
- `StrategiaDiegoConcaveL`: ora sostenibile, 4.455 nodi, 72 terminali accettati, P95 382 ms;
- `StrategiaDiegoObliqueTrapezoid`: sostenibile, 1.587 nodi, 24 terminali accettati, P95 312 ms;
- `StrategiaDiegoConnectionTerminal`: ancora non sostenibile; supera 250.000 nodi nel warm-up.

Decisione:
- LG-042 registrata come regola approvata e simulata;
- PR #8 resta sperimentale e non viene integrata automaticamente;
- prossimo passo: valutazione visuale utente del nuovo SVG e successiva analisi del caso `ConnectionTerminal`.

## R11 — Collaudo reale LG-041 con Radiant Harness
Stato: **ESEGUITO — PROTOTIPO VALIDATO SUL QUADRATO / NON INTEGRABILE SUL CONCAVO**

Decisione utente 26/09/2026:
- testare la strategia LG-041 con il nuovo Harness reale e usare Issue #1 come notifica di fine incarico;
- non mascherare la crescita combinatoria alzando limiti o introducendo potature euristiche non concordate.

Prototipo:
- branch `feature/lg041-multi-straight-candidates`, PR #7;
- `PROSEGUI_DRITTO` genera tutti i candidati validi dai riferimenti pertinenti e conserva il fronte generatore nel nodo figlio;
- candidati `Connection` e `ReturnConnection` restano esclusi come generatori strategici e continuano a essere vincoli fisici;
- candidati laterali visitati in lunghezza decrescente; nessuna potatura;
- diagnostica sperimentale aggiunta nel prototipo con `LG041 CANDIDATE` e `LG041 SUMMARY`.

Risultati Harness:
- run `36223457471`, job `108352924546`: **SUCCESS**;
- quadrato: 17.616 nodi, 312 Supply, 17.304 Return, 66 terminali Supply, 5.808 combinazioni, 412 terminali accettati, maxDepth 25;
- benchmark quadrato 20/20 deterministico: P95 1.039 ms, memoria delta max ~4,56 MB, SVG SHA-256 `37ba2ccaf728f3ee20b2a1e8220d552df912dd72913422c4c8b2be58dbd3e644`;
- baseline precedente quadrato: 1.328 nodi; crescita LG-041 ~13,3x, soprattutto nel ritorno (17.304 contro 1.164);
- 3.606 nodi hanno almeno 2 candidati validi; 3.724 nodi hanno almeno un candidato laterale; massimo 4 candidati validi per nodo;
- verifica automatica sull'intero log: zero violazioni dell'ordine decrescente fra candidati laterali;
- nodo Supply 66: coesistono candidato laterale da `D-INITIAL-Supply` lungo 1,25 m e candidato fisico lungo 1,90 m; entrambi vengono mantenuti;
- appartamento preconfezionato: SUCCESS, 160 nodi, 16 terminali accettati, ~40 ms;
- diagnostica estesa quadrato: ~465.000 messaggi e ~76 MB di log; il consumo memoria elevato del run diagnostico deriva principalmente dalla raccolta log, non dal benchmark senza log.

Regression completa:
- PR Action `36223457467`: compilazione SUCCESS;
- benchmark `StrategiaDiegoConcaveL.locale.xml` FAILED nel warm-up: superato il limite tecnico di 250.000 nodi;
- il failure avviene prima di ottenere un terminale parziale e quindi LG-041, nella forma universale provata, non è sostenibile sull'intero set corrente.

Decisione:
- PR #7 chiuso senza merge;
- LG-041 resta **CONSOLIDATA — NON IMPLEMENTATA**;
- nessun limite aumentato e nessun Golden aggiornato;
- prossimo approfondimento: riduzione esatta degli stati duplicati/equivalenti o altra formulazione che mantenga tutte le alternative geometricamente distinte senza esplosione combinatoria.

## R10 — Harness pannelli rapido e base dati preconfezionata
Stato: **ESEGUITO — BUILD FOCALIZZATA E CASI RAPIDI SUCCESS**

Decisione utente 26/09/2026:
- adottare come setup preferenziale di test rapido un Harness Console .NET che richiama direttamente il vero `Termodel.Core`;
- evitare ASP.NET, HTTP, frontend e pipeline completa durante le iterazioni strategiche sui pannelli;
- preconfezionare il solo input pannelli a partire dal progetto esempio, così le prove successive non ripetono l'elaborazione completa del progetto;
- mantenere SVG, log diagnostico e metriche come output standard;
- conservare GitHub Actions completa come verifica finale di integrazione, non come ciclo principale di ricerca.

Implementazione corrente:
- creato `tools/Termodel.RadiantPanels.Harness/Termodel.RadiantPanels.Harness.csproj`, Console .NET 8 con riferimento diretto a `Termodel.Core`;
- comando `run`: usa `StrategiaDiegoBenchmark.Run`, quindi il vero `StrategiaDiegoEngine`, e produce SVG/log/metriche JSON;
- comando `prepare`: usa il vero `GeneraModello` per estrarre `RadiantPanelInputXml` da un progetto completo;
- creata base dati `tests/radiant-harness/` con case JSON corrente `LG041-SQUARE4X4-T1-P030`, che riusa la fixture canonica senza duplicarla;
- aggiunta workflow focalizzata `.github/workflows/termodel-radiant-harness.yml`, che compila soltanto Core + Harness;
- aggiunta canonicalizzazione in-memory del vecchio `geometry/project.svg` prima del `prepare`, necessaria per la snapshot appartamento che precede il payload server canonico.

Verifica reale:
- run Harness #1 `36222253304`: restore Core+Harness SUCCESS, build Release Core+Harness SUCCESS, caso rapido quadrato SUCCESS; primo `prepare` appartamento fallito sulla forma legacy dello SVG (`data-termodel-units='cm'` mancante);
- run `36222392601`: build e quadrato ancora SUCCESS; individuato e corretto un errore del solo ricomponitore Harness che scriveva `\\n` letterali nelle sezioni del progetto;
- run `36222504481`: **SUCCESS completo**; build Core+Harness, quadrato, `prepare` del progetto appartamento e riesecuzione sull'input prodotto tutti SUCCESS;
- artifact `radiant-harness-fast`, id `10899108905`; input prodotto `StrategiaDiegoCurrentApartment.pannelli.xml`, SHA-256 `b31b5c2bac4dbd8a13507daef4022c5ad2301fb6503ff6d666e427a2eb5d4a80`;
- sul quadrato della run di preparazione: 1328 nodi totali, 46 terminali accettati, 290 ms runtime interno, SVG SHA-256 `46d2ec137be52ef350a62a6497bd6bb4f3cb58603339874cc03657163c62f8f2`;
- sull'appartamento appena preconfezionato: 151 nodi totali, 15 terminali accettati, 44 ms runtime interno, SVG SHA-256 `5678620a7a895d56886c2108ae9f3f8eab50e2aaaeff9deb1f3f1dea03e2ec96`;
- il file pannelli prodotto è stato poi versionato in `tests/radiant-harness/prepared/StrategiaDiegoCurrentApartment.pannelli.xml` e associato al case `CURRENT-APARTMENT-P030.json`;
- la workflow finale è stata alleggerita: usa direttamente i dataset preconfezionati e non riesegue `prepare` ad ogni iterazione;
- run finale PR `36222745007` / Harness #16: **SUCCESS**, con build Core+Harness, quadrato e appartamento preconfezionato tutti SUCCESS;
- PR #6 integrato su `main` nel merge `9764218dfaceceb2ebbf73602ce28e1adf1b97c7`;
- main Action `36222822652`, job `108351158157`: **SUCCESS** completo; build Release, benchmark StrategiaDiego, smoke esecutivo pannelli, riferimento reale, appartamento corrente e snapshot tutti SUCCESS;
- linee guida aggiornate con setup Harness e base dati preconfezionata; nessuna modifica a `StrategiaDiegoEngine`, frontend, Library Desktop o `definizionedati.json`.

Esito:
- il percorso rapido operativo è ora `input pannelli preconfezionato -> vero Termodel.Core -> vero StrategiaDiegoEngine -> SVG/log/metriche`;
- il comando `prepare` resta disponibile per rigenerare la base dati quando cambia il progetto sorgente;
- la build completa Service resta la verifica finale di integrazione, distinta dal ciclo rapido di sviluppo.


## R9 — Protocollo di collaudo preliminare e contesto corrente
Stato: **ESEGUITO — DIRETTIVA OPERATIVA REGISTRATA**

Decisione utente 26/09/2026:
- prima dell'implementazione GitHub/Core, le nuove strategie geometriche possono essere collaudate rapidamente in chat con un simulatore temporaneo indipendente;
- per la massima fedeltà al comportamento finale il linguaggio preferito è C#/.NET;
- il simulatore deve usare, quando disponibili, la stessa fixture/input del caso reale, le stesse distanze, tolleranze, primitive geometriche e criterio di merito pertinenti;
- il collaudo preliminare produce log di candidati/nodi e SVG diagnostico numerato quando il disegno cambia;
- il risultato della simulazione non sostituisce build, runtime e regression del motore reale;
- GitHub Actions viene usato dopo il consolidamento della strategia per verificare l'implementazione reale e confrontarla con la simulazione;
- introdotta la variabile documentale canonica `STRATEGIADIEGO_TEST_CONTEXT_CURRENT`, da mantenere aggiornata nelle linee guida prima di ogni cambio di banco prova o condizione di test.

Contesto iniziale:
- `STRATEGIADIEGO_TEST_CONTEXT_CURRENT = LG041-SQUARE4X4-T1-P030`;
- fixture: `tests/fixtures/StrategiaDiegoSquare4x4.locale.xml`;
- locale R001, quadrato 4x4 m;
- ingresso T1 `(2,-1)->(2,1)`, direzione `+Y`;
- `p=0,30 m`;
- regola sotto test: LG-041;
- simulatore preliminare preferito: C#/.NET;
- output richiesto: log candidati/nodi + SVG diagnostico numerato.

Vincolo di manutenzione:
- se cambia fixture, locale, geometria, `p`, LG/condizione sotto test o output diagnostico, aggiornare prima il blocco `STRATEGIADIEGO_TEST_CONTEXT_CURRENT` nelle linee guida;
- i vecchi contesti significativi devono essere trasferiti nel registro o nelle fixture quando diventano regression/checkpoint; la variabile corrente resta singola e descrive solo il banco attivo.

Implementazione:
- solo documentazione; nessuna modifica a `StrategiaDiegoEngine`;
- nessuna build o smoke richiesti per questa fase.


## R8 — Consolidamento LG-041: PROSEGUI_DRITTO multi-candidato universale
Stato: **ESEGUITO — SPECIFICA CONSOLIDATA / NON IMPLEMENTATA**

Decisione utente 26/09/2026:
- `PROSEGUI_DRITTO` non è più concettualmente un singolo ramo, ma un generatore di `0..N` candidati;
- ogni linea pertinente dello scenario corrente può generare un candidato lungo la direzione corrente;
- linee pertinenti: architettura, mandata già costruita e ritorno già costruito nel ramo corrente;
- esclusioni minime: segmento di provenienza, intersezioni dietro al nodo, parallele senza intersezione utile e duplicati geometrici entro tolleranza;
- una intersezione sul segmento reale è un fronte fisico; una intersezione sulla sua retta fuori dal segmento è un riferimento laterale teorico;
- il fronte fisico produce arresto prima del vincolo alla distanza `d`; il riferimento laterale produce un terminale oltre il riferimento alla distanza `d`; per obliqui si usa l'offset LG-034/LG-035;
- ogni candidato conserva l'identità del riferimento che lo ha generato nello stato del nodo figlio;
- la validazione resta sulla geometria fisica reale: un candidato teorico che attraversa un ostacolo viene scartato da `TrattoPossibile`; non serve una precedenza strategica speciale del fronte fisico;
- i candidati laterali vengono esplorati per lunghezza valida decrescente, ma nessun candidato valido viene potato per questa priorità;
- nessun verso speciale viene imposto dopo uno scavalcamento: restano tutte le alternative geometricamente valide;
- la stessa regola vale per mandata e ritorno;
- la precedente procedura specifica di scavalcamento del tubo entrante è superata sul piano strategico: il caso deve emergere da LG-041 universale;
- la funzione di merito finale resta l'unica autorità di selezione fra i terminali.

Relazione con le regole esistenti:
- LG-006/LG-037 forniscono la distanza `d` fra famiglie;
- LG-034/LG-035 forniscono la costruzione offset per il caso oltre linea e per gli obliqui;
- LG-039 continua a rendere il raccordo entrante del ritorno un vincolo fisico reale;
- LG-033 resta utile per identità/continuità delle evoluzioni, ma non deve ridurre a un solo `S_k+1` la generazione quando più riferimenti sono pertinenti;
- LG-036 richiederà SVG reale quando la regola verrà implementata.

Stato implementativo:
- nessuna modifica al motore in R8;
- nessuna build o smoke necessari per questo solo consolidamento documentale;
- la futura implementazione dovrà diagnosticare per ogni candidato: riferimento, famiglia, classificazione fisico/laterale, `I`, `T`, `d`, lunghezza e ordine di esplorazione;
- prima di introdurre limiti o potature dovrà essere misurata la crescita combinatoria sui regression correnti.


## R7 — LG-034/LG-035: oltre linea estesa dal nodo corrente
Stato: **ESEGUITO — COMPILATO / REGRESSION SUCCESS / PUBBLICATO SU MAIN**

Decisione utente 26/09/2026:
- al nodo 8 il riferimento desiderato è la precedente mandata raggiunta tramite il suo prolungamento;
- l'intersezione teorica cade sul nodo corrente;
- non va scartata: nel caso convesso deve essere valutato il punto oltre la linea alla distanza di rispetto;
- per mandata su mandata la distanza è 2p, quindi con p=0,30 m il nuovo punto è 0,60 m oltre la retta estesa;
- la possibilità resta un ramo dell'albero e deve passare tutte le normali verifiche geometriche.

Implementazione:
- `FindSequenceContinuation()` conserva le intersezioni teoriche a distanza circa zero invece di eliminarle;
- `TryExtend()` conserva l'intersezione circa zero; se il riferimento tubazione è incontrato solo sul prolungamento usa la costruzione oltre linea già prevista;
- nuovo marker log `EXTEND beyond-extended-front`;
- LG-034/LG-035 aggiornate con stato implementativo parziale, distinto dalla futura geometria miter generale.

Verifica reale:
- prima PR Action `36210011831` (#571): build/benchmark SUCCESS, smoke volutamente rosso perché la soglia simulata `B>=1,00` non è stata confermata; runtime reale `B=0,882`;
- regression riallineata al dato reale mantenendo i vincoli funzionali: marker oltre-linea presente, almeno 15 tratti attivi, `B>=0,88`;
- PR #4 head finale `c79f2aa73cce7fd5c8986b24d46846dd21d531d3`;
- PR Action `36210173917` (#575): **SUCCESS** completo;
- merge su `main`: `b02c692b160bac34961ac1af775a81a20f02cfea`;
- main Action `36210449283`, job `108315651971`: **SUCCESS** completo;
- Commit Status `Termodel/job=SUCCESS`;
- artifact main `strategia-diego-square-executive`, id `10896115041`;
- miglior terminale mandata reale per entrambi i lati ritorno:
  **15 tratti attivi**, `20,56 m`, area empirica `12,336 m²`,
  superficie locale `13,988 m²`, Fattore di Bontà **0,882**;
- la simulazione in memoria che stimava circa `1,105` non è confermata nella
  lunghezza: il dato runtime autorevole è `0,882`;
- soluzione complessiva selezionata dal criterio di merito corrente:
  mandata attiva `17,72 m`, bontà `0,760`; ritorno attivo `11,88 m`,
  bontà `0,510`; merito `32,758 m`;
- SVG SHA-256
  `875042179e3d2df58e38f2e9c5867e67b2caa5aff3bb8879e34bb3d107f63d0a`;
- DXF SHA-256
  `18444400dc3ba48b7730b90d094934ce101b28d8972f2ea537fbb2b1ce974f82`;
- numerazione diagnostica SVG: 22 nodi;
- smoke progetto radiante reale, banco appartamento corrente e snapshot:
  **SUCCESS**.

Pubblicazione:
- il merge su `main` ha attivato il normale auto-deploy Render;
- l'SVG/log reale è disponibile per il controllo visuale dell'utente secondo LG-036;
- la geometria offset/miter generale per angoli arbitrari resta futura e non viene dichiarata completata da R7.

## R6 — Riaggancio geometrico della mandata dopo il primo giro
Stato: **ESEGUITO — COMPILATO / REGRESSION SUCCESS / PUBBLICATO SU MAIN**

Decisione utente 26/09/2026:
- sul quadrato reale la mandata arriva al nodo 8 dopo un giro completo e si
  arrestava prematuramente pur esistendo spazio per il secondo giro;
- la causa individuata era l'uso rigido di `SequenceIndex+1` per scegliere il
  riferimento successivo durante l'inseguimento della propria evoluzione;
- il successore deve essere la prima retta pertinente incontrata **davanti**
  nella direzione corrente;
- la geometria teorica può usare i prolungamenti delle rette, mentre collisioni
  e distanze continuano a usare i segmenti fisici reali;
- la regola è applicata alla propria famiglia sia per mandata sia per ritorno;
  resta invariato il caso ritorno che insegue la mandata.

Implementazione:
- `StrategiaDiegoEngine.FindSequenceContinuation()` usa la ricerca geometrica
  orientata per `pathFamily == front.Family`;
- mantenuta la ricerca geometrica per `Return -> Supply`;
- gli altri casi conservano il comportamento sequenziale precedente;
- log esteso con marker `SEQUENCE own-family geometric-continuation`;
- LG-033/LG-035 chiarite: “successivo” è geometrico-orientato e non equivale
  automaticamente a `SequenceIndex+1`;
- smoke quadrato bloccante: almeno 10 tratti attivi e bontà mandata >= 0,80.

Verifica reale:
- PR #3 head `820a390cee4184d888af6d7149a2b567f932e5eb`;
- PR Action `36207700577` (#562), job `108307606275`: **SUCCESS**;
- merge su `main`: `599a980aca95af14d982e25911a1507aece0c21c`;
- main Action `36207858838`, job `108308085490`: **SUCCESS**;
- Commit Status `Termodel/job=SUCCESS`;
- artifact main `strategia-diego-square-executive`, id `10894901931`;
- miglior terminale mandata reale, per entrambi i lati ritorno:
  **10 tratti attivi**, `19,96 m`, area empirica `11,976 m²`,
  superficie locale `13,988 m²`, Fattore di Bontà **0,856**;
- la soluzione complessiva selezionata dal criterio di merito corrente usa
  mandata attiva `17,72 m` con bontà `0,760` e ritorno attivo
  `11,88 m` con bontà `0,510`; merito complessivo `32,758 m`;
- SVG SHA-256
  `5e5e04b7c1f88956bd9dbef14e1b8e8eb3981b9ee430551ac03458c63b0f50d4`;
- DXF SHA-256
  `d70039f2504f18fe7148179b141adab22ca1f905cfa0d722ef0187ffd02ac1e1`;
- numerazione diagnostica SVG: 19 nodi;
- smoke progetto radiante reale e banco appartamento corrente: **SUCCESS**.

Pubblicazione:
- il merge su `main` ha attivato il normale auto-deploy Render;
- l'artifact SVG reale è disponibile per la verifica visuale dell'utente,
  distinta dalla verifica automatica SUCCESS.

## R5 — Consolidamento debug in memoria: ritorno preliminare, bontà e node-id
Stato: **ESEGUITO — COMPILATO / REGRESSION SUCCESS / ARTIFACT REALE DISPONIBILE**

Decisioni utente 26/09/2026:
- la radice del ritorno non usa più 0,50 m: distanza mandata-ritorno lungo la
  parete = `p`;
- il raccordo entrante blu viene costruito prima della mandata e diventa
  geometria fisica limitante, senza diventare automaticamente front strategica;
- il primo nodo dopo il raccordo è ordinario: valuta anche
  `PROSEGUI_DRITTO`, senza eccezioni basate su depth/ordine;
- introdotto il Fattore di Bontà diagnostico
  `B=(2*Lattiva*p)/Alocale`;
- introdotti identificativi univoci dei nodi dell'albero Diego, riportati nel
  log e, di default, come numerazione diagnostica nell'SVG;
- parametro Service `numerazioneSpirali=true|false`, default `true`;
- overlay numerazione escluso dal DXF e dal conteggio primitive tecniche.

Documentazione:
- LG-012 rettificata;
- LG-038 Bontà terminale;
- LG-039 raccordo ritorno come linea limitante;
- LG-040 numerazione diagnostica;
- contratto Frontend-Service v1.27.

Implementazione e integrazione:
- PR #2, head finale `e0118fc0e3cde43def856836669c89e95adf2a6d`;
- PR Action `TermodelService Build` run `36205218493` (#550): **SUCCESS**;
- merge su `main`: `a15d29e6407f41d3b245c418bc02103ba08227f6`;
- main Action run `36205436426`, job `108300854209`: **SUCCESS**;
- lo step finale `Finalize Termodel job status and notify phone` è **SUCCESS**.

Verifica reale quadrato:
- artifact main `strategia-diego-square-executive`, id `10893840445`;
- SVG SHA-256
  `6d8f8c281af51ccceeb20f082f58fe5b00a80ee497d66f7e1d4ef3843c9b511a`;
- DXF SHA-256
  `a159bb6529ad84d6415538a6adc82535edb844f89ff60d6c4fd7df9cdb06d7b9`;
- `primitiveCount=4` tecniche e `svgDebugNodeCount=13`;
- il log conferma radici ritorno distanti `p=0,30 m` lungo la parete e
  raccordi entranti blu preliminari marcati `limit=true strategicFront=false`;
- terminale mandata migliore per bontà nello scenario selezionato:
  6 tratti attivi, 13,16 m, superficie empirica 7,896 m²,
  superficie effettiva locale 13,988 m², fattore `0,564`;
- soluzione finale corrente: merito 24,405 m, 8 punti mandata e 8 ritorno;
  bontà soluzione selezionata: mandata `0,564`, ritorno `0,317`;
- node-id soluzione mandata `1,3,4,5,6,7,8`, ritorno
  `15,17,19,25,26,27`, presenti sia nell'SVG sia nel log;
- smoke progetto radiante reale e banco appartamento corrente: **SUCCESS**;
- l'artifact SVG reale è disponibile per verifica visuale dell'utente; la sua
  approvazione geometrica resta distinta dal successo tecnico automatico.

Pubblicazione:
- merge/push su `main` ha attivato il normale auto-deploy Render configurato;
- gli strumenti di rete della sessione non riescono a interrogare
  `https://termodel.onrender.com/health`, quindi non viene dichiarata una
  verifica HTTP indipendente del commit runtime.

## R4 — Uniformità evoluzioni e inversione corsie iniziali mandata/ritorno
Stato: **ESEGUITO — VERIFICATO NEL CONSOLIDAMENTO R5**

Decisione utente 26/09/2026:
- eliminato il concetto di una "prima evoluzione" con distanza propria;
- il solo elemento distinto resta il raccordo tecnico proveniente dal tubo di
  collegamento;
- tutte le evoluzioni usano la stessa matrice di distanze;
- mandata rossa a `p/2` dalla parete;
- ritorno blu a `p` dalla mandata, quindi `1,5p` dalla parete nel corridoio
  iniziale ordinario;
- con `p=0,30 m`: mandata 0,15 m, ritorno 0,45 m, separazione 0,30 m.

Implementazione:
- `StrategiaDiegoEngine.BuildTree` non riceve più una quota iniziale
  arbitraria diversa per mandata e ritorno;
- il raccordo tecnico usa `EntryConnectorTargetDistance()`, che deriva le
  quote dalla funzione generale `RequiredDistance()`;
- aggiornate LG-013 e nuova LG-037;
- aggiornato il regression harness dell'appartamento: attese 0,15 m per il
  raccordo mandata e 0,45 m per il raccordo ritorno.

Verifica:
- la fase R4 era stata inizialmente pubblicata senza compilazione per richiesta
  esplicita dell'utente;
- la successiva fase R5 ha compilato ed eseguito realmente la stessa rettifica
  insieme al consolidamento delle ulteriori regole: main Action
  `36205436426`, job `108300854209`, **SUCCESS**;
- artifact SVG reale prodotto; approvazione geometrica visuale dell'utente
  ancora distinta dal successo tecnico.


## R3 — Riallineamento fondamentali geometrici GPT
Stato: **ESEGUITO — FONDAMENTALI COMPATIBILI CON LE LG ALLINEATI**

Obiettivo:
- recuperare in Diego le garanzie geometriche fondamentali già maturate in
  SpiraliGPT, senza importarne le euristiche locali e senza indebolire albero,
  esplorazione completa o merito massimo definiti dalle LG;
- classificare ogni differenza prima della modifica;
- rendere ogni correzione verificabile sul banco appartamento corrente e con
  regression isolate.

Vincoli:
- LG-001..LG-036 restano l'autorità;
- Vittorio e GPT sono riferimenti consultivi e non vengono modificati;
- una differenza intenzionale Diego non viene "corretta" per imitazione;
- una regola non coperta dalle LG viene documentata prima di essere
  implementata;
- ogni cambiamento grafico segue LG-036.

Audit:
- documento: `docs/STRATEGIADIEGO-GPT-FUNDAMENTALS-AUDIT.md`;
- fondamentali corretti: contenimento deterministico, terminale d'ingresso
  LG-011, rete diversa dall'ingresso come ostacolo anti-attraversamento;
- differenze intenzionali conservate: albero, merito massimo, alternative
  `PARALLELA_A/B`, distanze esplicite LG-006;
- rinviati perché richiedono regole/stato dedicati: arrotondamento, forcina
  avanzata, strettoia `STRATEGY-001`, stato orientato completo LG-035.

Regression aggiunte:
- `StrategiaDiegoObliqueTrapezoid.locale.xml`;
- `StrategiaDiegoConnectionTerminal.locale.xml`, con
  `ExpectedConnectionId="T-B"` verificato dal benchmark;
- il workflow ora propaga realmente gli exit code dei benchmark e pubblica
  l'errore nel Check Run.

Verifica finale:
- run `36133802860`, build #495, job `108066963980`: **SUCCESS**;
- quadrato: 104 nodi, 2 terminali, p95 8 ms;
- concavo L: 183 nodi, 2 terminali, p95 21 ms;
- trapezio obliquo: 104 nodi, 2 terminali, p95 9 ms;
- rete ramificata: 56 nodi, 4 terminali, p95 5 ms;
- tutte le fixture: 20 iterazioni, deterministiche e nei budget;
- smoke esecutivo, progetto reale e banco appartamento: SUCCESS;
- artifact LG-036: `strategia-diego-current-apartment`, id `10862238283`.

Iterazioni diagnostiche:
- #491: falso verde dei benchmark nativi individuato;
- #492: workflow bloccante, perdita terminali riprodotta;
- #493/#494: tentativo LG-035 con stato incompleto scartato;
- #495: varco del collegamento assegnato corretto e suite completa riuscita.

Commit principali:
- `f7a4fe82405c2690f972b3af59f9ff95331e4da5` — audit, fondamentali e fixture;
- `057575228ac6d910b3c894a3b8ef8c361fcd4078` — benchmark bloccanti;
- `efccddddd569ddcf28e39704d46640c15cfeb05a` — rinvio prudenziale LG-035;
- `fc287c9b7ae9cfe30f8bfa1c7a8818962e54d392` — varco ingresso assegnato.

## F0 — Registrazione incarico e registro di sviluppo
Stato: **ESEGUITO**

Risultato:
- incarico registrato in `PROJECT-SUMMARY-SERVICE.md`;
- definite le fasi F0..F6;
- questo registro diventa checkpoint operativo per il recupero da crash/chat interrotta.

Commit incarico:
- `885f375cb92dee96e8764af051b9d798159cc6f3`

## F1 — Audit finale Vittorio/GPT e specifica code-ready
Stato: **ESEGUITO**

Sorgenti esaminati:
- `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Program.cs`;
- `.../Spiralgenerator.cs`;
- `.../ChiudiSpirale.cs`;
- `SorgentiTermodel/Library/Impianti/Pannelli/SpiraliGPT/Program.cs`;
- `.../Spiralgenerator.cs`;
- `.../ChiudiSpirale.cs`;
- `SorgentiTermodel/Library/Impianti/Pannelli/IoPannelli.cs`.

Conclusioni:
- Desktop possiede già il selettore `Vittorio|GPT`, con GPT default;
- Vittorio genera anelli successivi mediante offset con normali/bisettrici,
  aggancio al segmento dell'offset e chiusura separata;
- GPT mantiene lo stesso contratto `locale.xml -> locale.svg`, ma usa offset
  robusti NetTopologySuite, conserva più candidati di raccordo, controlla
  strettoie/intersezioni e costruisce il ritorno in modo più esplicito;
- StrategiaDiego non deve essere una variante interna di GPT: deve essere un
  terzo motore headless con proprio albero decisionale e proprie metriche;
- il punto comune da riusare è il **contratto geometrico**, non l'euristica di
  scelta: input locale/perimetro/tubi, output mandata+ritorno e diagnostica;
- la geometria offset mitrata di GPT è il riferimento preferibile per la
  robustezza numerica, mentre la semantica Diego resta quella consolidata nelle
  LG-001..LG-035;
- il Service oggi incorpora solo copie temporanee GPT; per rendere realmente
  selezionabile Vittorio senza modificare la Library, la sua implementazione
  Desktop verrà copiata byte-identical nel Core e tracciata in
  `CopiedFromTermodel/TERMODEL-SYNC.md` finché non esisterà un package/core
  condiviso stabile.

Esito:
- audit sufficiente per passare all'implementazione;
- nessuna modifica ai sorgenti Desktop Vittorio/GPT.

## F2 — Implementazione e dispatcher Vittorio|GPT|Diego
Stato: **ESEGUITO — IMPLEMENTATO, NON ANCORA COMPILATO**

Risultato:
- aggiunto `RadiantPanels/StrategiaDiegoEngine.cs` con albero mandata, sottoalberi
  ritorno, metriche e limiti tecnici espliciti;
- aggiunto dispatcher nel `RadiantExecutiveGenerator` con selezione tramite
  `TERMODEL_SPIRAL_ENGINE=Vittorio|GPT|Diego`;
- default lasciato a `GPT` per retrocompatibilita;
- aggiunte nel Core copie temporanee **byte-identical** del motore Vittorio,
  senza modificare la Library Desktop;
- aggiornato `CopiedFromTermodel/TERMODEL-SYNC.md`.

Commit principali:
- `79ad50c9ce9720219d2c05e2814fbafed2ad4534` — motore Diego;
- `8c34e10b2db8a07ca8342097122d2cc67480540c` — dispatcher;
- `e665f9d4`, `d7987644`, `475b998f`, `c51f481e` — copie Vittorio;
- `23a2d6ee9fdd8d7c592f26d358a333621b0c760b` — tracciatura sync.

Verifica:
- implementato su Git;
- compilazione reale demandata alla fase F3.

## F3 — Build reale
Stato: **ESEGUITO — COMPILAZIONE RELEASE RIUSCITA**

Tentativo 1:
- commit `49e9a61f566e4d05d78de3fff6ab23379d7bedb5`;
- GitHub Actions run `36086188268`, job `107918524934`, run number 438;
- `Termodel/job=RUNNING` pubblicato correttamente;
- build FALLITA con 6 errori C# locali a `StrategiaDiegoEngine.cs`
  (named argument `SequenceIndex`, accesso nullable `GeoSegment?`,
  conversione nullable e formattazione SVG);
- step finale: `TERMODEL_JOB_STATUS=FAILED`;
- `PHONE_NOTIFICATION_SENT status=FAILED`.

Correzione:
- commit `32937f99e27342dc53cd8a71c8d40b3363c0f7b4`;
- corretti esclusivamente errori di tipizzazione/compilazione, senza cambiare
  le regole geometriche.

Tentativo 2:
- GitHub Actions run `36086401306`, job `107919165262`, run number 439;
- restore, controlli frontend e **Build Release completati con successo**;
- compilazione reale quindi verificata;
- gli smoke generali della stessa run possono proseguire indipendentemente e
  non sono usati per dichiarare la sola fase di compilazione.

## F4 — Fixture quadrato 4x4 m / unico tubo entrante
Stato: **ESEGUITO**

Risultato:
- creata `tests/fixtures/StrategiaDiegoSquare4x4.locale.xml`;
- locale `R001` quadrato 4,00 x 4,00 m;
- unico tubo `T1` da `(2,-1)` a `(2,1)`, quindi ingresso centrato
  sulla parete inferiore e direzione entrante `+Y`;
- creata `tests/fixtures/README-StrategiaDiegoSquare4x4.md` con geometria,
  radici teoriche ritorno e obiettivi del test;
- la fixture non contiene Golden Result prematuri.

Commit:
- `4bf2e2b3696b51a04e7d9b964ac4f96fc9cd01ac` — XML caso 4x4;
- `e07bc1db5e3d2c9b968136913f5b853089c3fba0` — documentazione fixture.

## F1B — Audit di allineamento implementazione vs LG-033..LG-035
Stato: **ESEGUITO**

Verifica eseguita sul codice corrente dopo la prima implementazione:
- riesaminati i generatori paralleli Vittorio e GPT e il nuovo `StrategiaDiegoEngine`;
- confermato che Diego mantiene il proprio albero esplorativo e non modifica semanticamente Vittorio/GPT;
- confermato che la formula corrente `respect / |cross|` e' la generalizzazione geometrica corretta dello spostamento `±d` nel caso ortogonale;
- individuato uno scarto rispetto a LG-033/LG-035: quando il ramo sta inseguendo un tratto precedente, il motore corrente cerca ancora la prossima linea frontale fra **tutti** i vincoli; non privilegia/vincola ancora il successore `S_k+1` della stessa evoluzione;
- il benchmark corrente e' quindi una **baseline pre-allineamento**, non ancora il benchmark finale della specifica completa.

Baseline Action verificata:
- commit `0a6e58658382e806f80ef975760c2e4b83ab88ff`;
- run GitHub Actions `36087631862` / build #450: SUCCESS;
- 20 iterazioni: 1176 nodi, 2 terminali accettati, p95 98 ms,
  max memory delta 7.408.856 byte;
- notifica finale telefono: SUCCESS.

Decisione:
- introdurre una sottofase F2B minima e reversibile che renda esplicito
  l'inseguimento `S_k -> S_k+1` senza alterare Vittorio/GPT;
- rieseguire poi build e benchmark prima di chiudere F5.

## F2B — Allineamento inseguimento sequenziale LG-033..LG-035
Stato: **ESEGUITO — IMPLEMENTATO, DA RIVERIFICARE IN BUILD/BENCHMARK**

Obiettivo:
- quando un nodo Diego sta seguendo un segmento di tubo gia' appartenente al
  path, usare il suo `SequenceIndex` per individuare il successore
  `S_k+1`;
- per i rami paralleli, il successore deve essere il riferimento di troncatura
  strategico quando esiste;
- `PROSEGUI_DRITTO` resta un'alternativa separata e continua a escludere la
  linea che ha appena troncato il tratto precedente;
- nessuna modifica ai motori Vittorio/GPT.

Risultato:
- aggiunta ricerca del successore geometrico `S_k+1` tramite `SequenceIndex`;
- i rami `PARALLELA_A/B` usano `S_k+1` come frontale richiesta quando disponibile;
- `PROSEGUI_DRITTO` resta separato ed esclude la frontale appena usata;
- Vittorio/GPT non modificati.

Commit:
- `90f76ff47e4822b00d7ba3d57b524017e377f092`.

## F5 — Batteria benchmark GitHub Actions
Stato: **ESEGUITO — SOSTENIBILE SUL CASO 4x4**

Verifica finale:
- commit HEAD testato: `77c7d44f1b089dc302b49bbd6f86af4f2a330863`;
- GitHub Actions `TermodelService Build` run `36096201896`, build #453;
- job build `107949117086`: SUCCESS;
- `Termodel/job=SUCCESS`;
- notifica telefono: `PHONE_NOTIFICATION_SENT status=SUCCESS`;
- build Release completata con successo;
- benchmark eseguito per 20 iterazioni sulla fixture
  `tests/fixtures/StrategiaDiegoSquare4x4.locale.xml`.

Metriche finali:
- nodi totali massimi: **104**;
- terminali preliminarmente accettati: **2**;
- p95: **22 ms**;
- max memory delta: **368.800 byte**;
- output deterministico verificato dal benchmark tramite firma strutturale e
  SHA-256 SVG costante fra le iterazioni;
- budget benchmark rispettati: 50.000 nodi, p95 2.000 ms, memoria 128 MiB.

Confronto con baseline pre-F2B:
- baseline run #450: 1176 nodi, p95 98 ms, 7.408.856 byte, 2 terminali;
- dopo inseguimento sequenziale LG-033..LG-035: 104 nodi, p95 22 ms,
  368.800 byte, 2 terminali;
- la riduzione deriva dall'eliminazione di frontali non appartenenti alla
  sequenza `S_k -> S_k+1`, non da potatura euristica predittiva.

Giudizio:
- **sostenibile sul caso campione 4x4 / un ingresso**;
- il giudizio non viene esteso automaticamente a progetti più complessi:
  servono fixture aggiuntive con concavità, strettoie, più locali/circuiti.

## F6 — Consolidamento finale
Stato: **ESEGUITO**

Risultato:
- Summary Service aggiornato con stato finale dell'incarico;
- mantenuto distinto il documento vivo delle linee guida StrategiaDiego;
- registrata separatamente la baseline pre-allineamento e la misura finale;
- stato reale distinto:
  - progettato: SI;
  - implementato: SI;
  - compilato: SI, GitHub Actions build #453;
  - eseguito: SI, fixture 4x4/un ingresso;
  - testato: SI, 20 iterazioni benchmark;
  - confrontato con riferimento: confronto architetturale/algoritmico con
    Vittorio e GPT eseguito; non esiste ancora un Golden Result approvato per
    l'output geometrico Diego.

Commit consolidamento Summary:
- `0936dcb6a35ea7fd449ee9a98a780893bb51073c`.

Limiti residui:
- sostenibilità verificata soltanto sul caso quadrato 4x4 con un ingresso;
- mancano regression dedicati a concavità, strettoie, più circuiti e più locali;
- la chiusura avanzata resta successiva alla valutazione preliminare LG-029.

## R1 — Regressione locale concavo a L
Stato: **ESEGUITO**

Obiettivo:
- verificare il motore su una prima geometria non convessa, mantenendo un solo
  locale e un solo ingresso per isolare l'effetto della concavità;
- riutilizzare i controlli di determinismo e i budget del benchmark F5;
- produrre artifact con nomi distinti da quelli del quadrato 4x4;
- non assimilare questa prova alla strettoia reale di `STRATEGY-001`, che
  richiederà una regressione dedicata successiva.

Criteri di completamento:
- fixture concava e README tracciati;
- benchmark quadrato e concavo eseguiti dal workflow;
- Action riuscita e metriche del caso concavo registrate;
- nessuna modifica ai motori Vittorio/GPT, al frontend o allo schema dati.

Implementazione:
- aggiunti `tests/fixtures/StrategiaDiegoConcaveL.locale.xml` e
  `tests/fixtures/README-StrategiaDiegoConcaveL.md`;
- il perimetro a L introduce una rientranza concava in (3,2), mantenendo un
  solo ingresso dal lato inferiore;
- il benchmark nomina report e SVG in base alla fixture;
- GitHub Actions esegue in sequenza quadrato 4x4 e locale concavo e rende le
  metriche disponibili nel Job Summary e nelle annotazioni del Check Run.

Verifica reale:
- run `36097485997`, build #458, job `107952701779`: **SUCCESS**;
- quadrato 4x4, 20 iterazioni: 104 nodi, 2 terminali accettati, p95 23 ms,
  360.576 byte, deterministico;
- locale concavo a L, 20 iterazioni: 183 nodi, 2 terminali accettati, p95
  48 ms, 720.896 byte, deterministico;
- build e tutti gli smoke test del Service: SUCCESS;
- budget F5 rispettati da entrambe le fixture.

Commit:
- `78f9f3a5b27e2472fee7686d0ac163eec25aa19b` — commissione R1;
- `78b0529ecbbcbe2eda5baa763e74844a9c4ec60e` — fixture e regressione;
- `cabacac1715c97adf01c22596dfd08032e615c10` — esposizione metriche.

Limite successivo:
- costruire una regressione dedicata alla strettoia/imbottigliamento di
  `STRATEGY-001`, senza confonderla con la sola concavità validata in R1.

## R2 — Banco prova appartamento reale corrente
Stato: **IN CORSO — FIXTURE CONSOLIDATA, CICLO DI MIGLIORAMENTO APERTO**

Direttiva:
- il progetto fornito dall'utente il 25/09/2026 diventa il banco prova
  operativo primario di StrategiaDiego;
- fixture:
  `tests/fixtures/StrategiaDiegoCurrentApartment.project.tmdl`;
- SHA-256 originale:
  `1a5855490adcbac25e5585f9ba89c624eb2381874eb2de8bdc74821a40d2a9a5`;
- projectId originale:
  `07bf8dca-dc86-41ea-8844-1aaca58888f0`;
- il contenuto della fixture, incluso `definition/definizionedati.json`,
  resta immutato.

Uso Action:
- harness:
  `tools/smoke-strategia-diego-current-apartment.ps1`;
- motore forzato:
  `TERMODEL_SPIRAL_ENGINE=Diego`;
- risposta richiesta direttamente:
  `responseArtifact=pannelli-esecutivo-svg`;
- artifact diagnostico previsto:
  `strategia-diego-current-apartment`;
- devono essere conservati almeno SVG, catalogo generated-files, metadati del
  test e log/artifact pannelli disponibili.

Stato algoritmo all'apertura di R2:
- motore Diego implementato e compilato;
- dispatcher Vittorio|GPT|Diego attivo;
- Diego default Service quando non esiste override;
- LG-033..LG-035 allineate nel codice tramite successore `S_k+1`;
- regression 4x4: riuscita;
- regression concavo a L: riuscita;
- prestazioni sintetiche entro budget;
- nessun Golden geometrico completo approvato;
- casi complessi reali, strettoie e interazioni fra più locali/circuiti:
  validazione ancora aperta.

Metodo di lavoro R2:
1. l'utente fornisce screenshot e numero locale;
2. si riproduce il caso sul banco prova corrente con Action;
3. si individua la prima scelta strategica errata;
4. si stabilisce se è una violazione di LG esistente o una regola mancante;
5. se manca una regola, si aggiunge LG-036 o successiva prima della correzione;
6. si modifica solo StrategiaDiego salvo diversa decisione esplicita;
7. si riesegue la stessa fixture e si confrontano gli artifact prima/dopo;
8. il caso significativo diventa regression permanente quando isolabile.

Il **R2 resta IN CORSO** finché procede l'analisi locale-per-locale:
l'esito positivo della harness non significa che l'intero appartamento sia
geometricamente approvato.

Verifica infrastruttura R2:
- Action #473, run `36103180758`: build e regression precedenti SUCCESS, ma
  nuovo banco FAILED con HTTP 422 `data-termodel-units='cm'` mancante;
- causa: la snapshot è correttamente un **progetto locale**, mentre
  `POST /api/calculations` riceve il payload tecnico prodotto da
  `buildTermodelServerPayload()`; nessun difetto StrategiaDiego dimostrato;
- harness corretta senza modificare la fixture: canonicalizzazione applicata
  soltanto alla copia temporanea inviata al Service;
- commit correzione harness:
  `a789f85f433959dddeeff9e60a65a180d69416f5`;
- Action #474, run `36103622680`, job `107971255939`: **SUCCESS**;
- marker `STRATEGIA_DIEGO_CURRENT_APARTMENT_OK`;
- fixture SHA verificato:
  `1a5855490adcbac25e5585f9ba89c624eb2381874eb2de8bdc74821a40d2a9a5`;
- motore della prova: `Diego` forzato esplicitamente;
- risposta SVG diretta: HTTP 200;
- SHA-256 SVG baseline del banco:
  `71921972d16085fab3071e56cd53a0695661536436678b2c64e7051f1312ecb8`;
- `generatedFileCount=8`; calculation: `radiantPanelCircuitCount=1`,
  `radiantExecutivePrimitiveCount=6`, `radiantExecutiveFloorCount=1`;
- artifact diagnostico `strategia-diego-current-apartment`, id `10850671585`,
  verificato e contenente 10 file: server payload, SVG, DXF, pannelli JSON,
  generated-files, metadati e log;
- Commit Status finale e notifica telefono della #474: SUCCESS.

Conclusione R2 corrente:
- il banco prova è tecnicamente operativo e riproducibile in GitHub Actions;
- l'analisi geometrica locale-per-locale resta il lavoro in corso;
- la baseline SVG corrente non è un Golden Result approvato.
