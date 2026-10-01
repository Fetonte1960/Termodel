# CANDIDATO ATTIVO — MATRICE MANDATA 1,5P / 2P CON RETURN A P

Data: 2026-10-01

È stato pubblicato un nuovo candidato di `Vittorio_revisionato` mantenendo
integro il restore point precedente.

Recovery point **prima** della modifica:

```text
commit: 0b541f92cf74412a33d68ffc0603e3f319c4a82f
branch: recovery/vittorio-revisionato-before-split-wall-supply-20261001
```

Geometria del candidato:

```text
P = 0,30 m
Mandata-Parete = 1,5P = 0,45 m
Mandata-Mandata = 2P = 0,60 m
Mandata-Return = P = 0,30 m
Return-Parete risultante = P/2 = 0,15 m
Finalizzazione Mandata = P = 0,30 m
```

Motivazione:
il Return parallelo si sviluppa tra Mandata e parete. Per ottenere il Return
esterno a P/2 dalla parete, la Mandata esterna viene posta a 1,5P e il Return
viene traslato di P verso la parete.

Modifiche runtime autorizzate:
- `Program.cs`: parametri separati e Return a P;
- `Spiralgenerator.cs`: primo offset con distanza Mandata-parete, offset
  successivi con distanza stessa Mandata; finalizzazione separata a P;
- overload storico a distanza unica conservato;
- `ComputeOffset: edgeLength <= offset` invariato.

Non modificati:
- algoritmo combinatorio `chiusura_diego`;
- raccordatura;
- `SpiraliVittorio`;
- frontend;
- Golden;
- `definizionedati.json`;
- problema noto delle strettoie.

Questo candidato non sostituisce il recovery point finché il controllo
tecnico e visivo non lo approva.

---

# RESTORE POINT APPROVATO — VITTORIO_REVISIONATO OFFSET-P

Checkpoint: **2026-10-01 — APPROVATO VISIVAMENTE COME BASE DI RIPRISTINO**

Il collaudo reale sul progetto multi-locale ha confermato come base di
ripristino l'assetto corrente di `Vittorio_revisionato` con la sola deviazione
chirurgica in `ComputeOffset`:

```csharp
edgeLength <= offset
```

al posto della soglia storica:

```csharp
edgeLength <= offset * 3
```

Con `offset=0,30 m`, la soglia di skip dei vertici è quindi 0,30 m anziché
0,90 m.

## Return point approvato

```text
runtime funzionale:
6132430e7907699cbf577c2ef869ffd03117f216

snapshot documentale approvato:
edc1fc4cff0edad0700a9c9c2582b80c205efb57

branch recovery:
recovery/vittorio-revisionato-approved-offset-p-20261001
```

Questo è il **punto di ripristino prioritario** per una nuova chat o per un
rollback futuro. Non ricostruire manualmente una configurazione precedente se
serve tornare a questo stato.

Il precedente return point pre-esperimento
`f1544135c303abb8296ef784c86b3cca6d627e6c` resta storico, ma non è più il
restore point preferito: il punto approvato è quello sopra.

## Stato visivo approvato

Il test multi-locale fornito dall'utente mostra una generazione complessivamente
accettabile e sufficientemente stabile da diventare base di lavoro/recovery.

Questo giudizio **non equivale a dichiarare risolte tutte le geometrie**.

### Difetto residuo noto — strettoie

Nel locale 4 del test reale resta visibile un difetto nelle zone di
restringimento/strettoia: il percorso può produrre una geometria non
soddisfacente nella zona stretta, con andamento locale che deve essere studiato
separatamente.

Vincoli:
- il difetto è **APERTO**;
- l'utente segnala che era stato tamponato in una precedente iterazione;
- non è ancora stata ricostruita con certezza quale modifica producesse quel
  tamponamento;
- non correggerlo insieme ad altre modifiche centrali;
- non usare questo difetto come motivo per abbandonare il restore point
  approvato;
- quando verrà affrontato, partire da questo restore point e creare un nuovo
  return point prima di toccare l'algoritmo.

## Regola per recovery di una nuova chat

Prima di qualsiasi nuovo intervento su `Vittorio_revisionato`:
1. assumere come baseline approvata il branch
   `recovery/vittorio-revisionato-approved-offset-p-20261001`;
2. preservare la soglia `ComputeOffset = P` finché non viene esplicitamente
   rimessa in discussione;
3. trattare il problema delle strettoie come missione separata;
4. non confondere il problema strettoie con la chiusura centrale o con il
   Return parallelo;
5. creare sempre un nuovo return point prima di modificare la geometria.

---

# STATO ATTIVO — SOGLIA COMPUTEOFFSET RIDOTTA DA 3P A P

Checkpoint: **2026-10-01 — modifica chirurgica pubblicata e server verificato**

Dopo il test locale in Visual Studio, nel solo
`SpiraliVittorioRevisionato/Spiralgenerator.cs` è stata applicata una singola
deviazione rispetto al generatore Vittorio puro:

```csharp
// prima
edgeLength <= offset * 3

// ora
edgeLength <= offset
```

Con `offset=0,30 m` la soglia di esclusione dei vertici in
`ComputeOffset` passa quindi da `0,90 m` a `0,30 m`.

Non sono stati modificati:
- i due `break` su `minEdgeLength`;
- Return parallelo Diego;
- `chiusura_diego` e le permutazioni;
- raccordatura;
- frontend, `definizionedati.json` e Golden.

Il generatore revisionato non è quindi più byte-identico a Vittorio: è
**Vittorio puro + una sola deviazione sperimentale sulla soglia di
`ComputeOffset`**.

Return point obbligatorio prima di questa prova:

```text
commit:
f1544135c303abb8296ef784c86b3cca6d627e6c

branch:
recovery/vittorio-revisionato-before-offset-threshold-20261001
```

Verifica:
- Fast Harness run `36861645040`:
  - build Core/Harness SUCCESS;
  - Return parallelo Diego SUCCESS;
  - combinatoria SUCCESS;
  - quadrato pubblico `Vittorio_revisionato` SUCCESS;
  - equivalenza iniziale sul quadrato SUCCESS;
  - la vecchia equivalenza multi-progetto si interrompe su `concave-l`,
    dove la nuova soglia produce intenzionalmente una geometria diversa da
    Vittorio: questo gate non è più una invariabile valida per il candidato
    corrente e non è stato nascosto o aggiornato;
- Service Build run `36861644983`:
  - Build succeeded;
  - smoke `Vittorio_revisionato` chiuso SUCCESS;
  - smoke circuiti aperti SUCCESS;
  - verifica deploy pubblico SUCCESS con
    `serviceCommit=6132430e7907699cbf577c2ef869ffd03117f216`;
  - rosso globale soltanto sul noto smoke locale storage/lock `/health`.

Regola di recovery chat:
**questa modifica resta sperimentale fino al controllo visivo sul server**.
Se il risultato reale non è accettabile, tornare al branch/commit sopra.

---

# STATO ATTIVO — GENERATE VITTORIO PURO IN VITTORIO_REVISIONATO

Checkpoint: **2026-10-01 — implementazione tecnica riuscita, controllo visivo utente ancora da fare**

Il generatore della Mandata di `Vittorio_revisionato` è ora il vero
`Spiralgenerator.cs` storico copiato da Vittorio al commit
`5b8ddc11b4e23046bda1e1c5824af4d4bc084326`.

Verifica sorgente:
- SHA blob corrente `SpiraliVittorioRevisionato/Spiralgenerator.cs`:
  `95e99c7e420dab6b102f69a16a919c2ce0856bf3`;
- identico byte-per-byte alla copia del commit `5b8ddc11...`;
- identico al `SpiraliVittorio/Spiralgenerator.cs` corrente salvo il namespace;
- 270 righe in entrambi;
- non contiene `SpiralGenerationInput`, `GenerateCore`,
  condizionamento o `TerminalCenterline`.

Percorso corrente:

```text
Mandata
  = SpiralGenerator Vittorio puro

Return
  = ritorno_Parallelo_diego(..., -0,15)

Chiusura
  = chiusura_diego(..., 0,15)
  + log istituzionale SpiraliDiego

Raccordatura
  = fase finale revisionato
```

Il return point precedente alla modifica resta BLOCCATO e non va cancellato:

```text
commit:
45bff4b4d016bcd60aa0c18d26aefdcf51ad8a21

branch:
recovery/vittorio-revisionato-before-pure-vittorio-20261001
```

Se il controllo visivo reale boccia anche il generatore Vittorio puro,
ripristinare l'intero stato da quel branch/commit; non ricostruire manualmente
il precedente assetto.

Verifica Fast Harness run `36847338021`:
- build Core/Harness: SUCCESS;
- Return parallelo Diego isolato: SUCCESS;
- combinatoria `funzioni_diego`: SUCCESS;
- quadrato pubblico `Vittorio_revisionato`: SUCCESS;
- equivalenza iniziale con Vittorio: SUCCESS;
- equivalenza multi-progetto: SUCCESS su 6 casi;
- check diretto generatore puro:
  `VITTORIO_REVISIONATO_PURE_GENERATOR_OK`,
  `equivalentToVittorio=true`;
- chiusura quadrato in debug: `length=0,40`, `required=0,30`;
- workflow rosso soltanto sul Golden storico separato `Diego_Vittorio`
  (`5ddd0ffd... != fa8e6106...`), non aggiornato.

Verifica Service Build finale run `36847790853`:
- Build succeeded;
- smoke pubblico `Vittorio_revisionato` chiuso: SUCCESS;
- smoke circuiti aperti: SUCCESS;
- verifica deploy pubblico: SUCCESS con
  `serviceCommit=c8d21f9b14c32890d9ee9e810867e3be8cc81e7d`;
- rosso globale soltanto sul noto smoke locale storage/lock `/health`.

Verifica Render dedicata run `36847813764`: **SUCCESS**.
Il runtime pubblico ha raggiunto
`serviceCommit=c8d21f9b14c32890d9ee9e810867e3be8cc81e7d`,
`spiralEngine=Diego_Vittorio`.

Regola di recovery chat:
**il codice è tecnicamente verificato ma non va dichiarato visivamente
approvato finché Diego non conferma il disegno reale.**

---

# RETURN POINT BLOCCATO — PRIMA DEL RIPRISTINO GENERATORE VITTORIO PURO

Checkpoint: **2026-10-01 — return point vincolante prima della nuova modifica**

Prima di sostituire il generatore evoluto corrente di `Vittorio_revisionato`
con il vero `Spiralgenerator.cs` storico di Vittorio è stato creato un punto
di ritorno esplicito e separato da `main`.

```text
commit:
45bff4b4d016bcd60aa0c18d26aefdcf51ad8a21

branch:
recovery/vittorio-revisionato-before-pure-vittorio-20261001
```

Questo return point rappresenta l'intero stato corrente prima della nuova
commissione. Se il ripristino del generatore Vittorio puro fallisce tecnicamente
o viene bocciato dal controllo visivo, il recovery deve ripartire da questo
branch/commit senza ricostruire manualmente la configurazione.

Il nuovo tentativo autorizzato deve modificare soltanto quanto necessario per
ottenere nel namespace `SpiralHeatingVittorioRevisionato` il vero generatore
storico copiato originariamente al commit
`5b8ddc11b4e23046bda1e1c5824af4d4bc084326`, mantenendo separati:
- Return parallelo Diego;
- `ChiudiSpirale.cs`;
- `funzioni_diego.chiusura_diego`;
- log istituzionale `SpiraliDiego`.

Regola per recovery di una nuova chat:
**non usare la parola "storico" senza SHA.** Per questa missione:
- "return point prima della prova" = `45bff4b4...`;
- "vero SpiralGenerator Vittorio puro" = contenuto di `5b8ddc11...`.

---

# BASELINE ATTIVA — VITTORIO_REVISIONATO FUNZIONANTE PRE-P/2-2P

Checkpoint: **2026-10-01 — rollback completo verificato**

Questa sezione prevale su tutte le note sperimentali sottostanti relative al
tentativo P/2-2P.

Dopo due prove visive non accettabili è stata ripristinata **esattamente** la
fotografia runtime precedente all'esperimento, identificata dal commit
`b71931e6ccb3761b05b21abd07f6d73154b13b3f`.

File riportati byte-per-byte alla baseline:
- `SpiraliVittorioRevisionato/Program.cs`;
- `SpiraliVittorioRevisionato/Spiralgenerator.cs`;
- `RadiantPanels/StrategiaVittorioRevisionatoBenchmark.cs`;
- `tools/Termodel.RadiantPanels.Harness/Program.cs`;
- `.github/workflows/termodel-diego-vittorio-fast.yml`.

Sono rimasti intenzionalmente invariati perché già identici alla baseline:
- `SpiraliVittorioRevisionato/ChiudiSpirale.cs`;
- `SpiraliDiegoVittorio/funzioni_diego.cs`.

Configurazione attiva:

```text
PassoTubi       = 0,30 m
DistanzaPareti  = 0,30 m
DistanzaRitorno = 0,15 m

Supply          = Generate storico Vittorio
Return          = ritorno_Parallelo_diego(..., -0,15)
Chiusura        = chiusura_diego(..., 0,15)
Minimo chiusura = 2 * 0,15 = 0,30 m
```

La chiusura resta in debug tramite il log istituzionale
`SpiraliDiego`, con `Closure.Try`, `Closure.AttemptReport`,
`Closure.Selected` e `Closure.Summary`.

Verifica Fast Harness run `36839123030`:
- build Core/Harness: SUCCESS, 0 errori;
- quadrato pubblico `Vittorio_revisionato`: SUCCESS;
- chiusura: `length=0,40 m`, `required=0,30 m`;
- equivalenza iniziale con Vittorio: SUCCESS;
- equivalenza multi-progetto: SUCCESS su 6 casi;
- astrazione strutturale: SUCCESS;
- rosso finale soltanto sul Golden storico separato `Diego_Vittorio`
  già noto e non modificato.

Verifica Service Build run `36839116329`:
- Build succeeded;
- smoke `Vittorio_revisionato` chiuso: SUCCESS;
- smoke circuiti aperti: SUCCESS;
- rosso globale soltanto sul noto smoke locale storage/lock `/health`.

Regola operativa: **non riattivare né ricostruire il candidato P/2-2P senza
una nuova autorizzazione esplicita**. La baseline sopra è il punto di recovery
corrente.

---

# RECOVERY ATTIVO — DEFAULT PUBBLICO RIPRISTINATO A GENERATE STORICO

Checkpoint: **2026-10-01 — recovery richiesto dopo controllo visivo reale**

Il controllo visivo utente del percorso pubblico `Vittorio_revisionato` con
Supply P/2-2P ha mostrato una geometria non accettabile, con diagonali e
sviluppo della spirale giudicato disastroso.

Decisione immediata:
- il percorso pubblico torna a usare per default il **Generate storico
  Vittorio a distanza unica**;
- il candidato `GenerateRevisionato(...)` P/2-2P resta nel sorgente ma è
  disattivato dal percorso pubblico e utilizzabile soltanto esplicitamente per
  analisi future;
- non viene eseguito alcun revert globale;
- Return, combinatoria e raccordatura restano quelli correnti: il recovery è
  circoscritto alla generazione della Supply, come previsto dal contratto.

Switch attuale:

```text
AggiornaSpiraliConChiusura(
    chiudiCircuito,
    usaGenerateStoricoRecovery = true)
```

Per analisi controllate del candidato P/2-2P si può ancora passare
`usaGenerateStoricoRecovery=false`; ciò non rappresenta il default pubblico.

Commit di recovery:
- `dd7d411ab3de9223ec7d927aed407d59c60aa62e`.

---

# RECOVERY ATTIVO — GENERATE STORICO COME BASELINE DI RIPRISTINO

Checkpoint: **2026-10-01 — contratto implementato, compilato e verificato tecnicamente**

Questo checkpoint prevale sulle note storiche sottostanti quando si deve
ripristinare la sola generazione della Mandata di `Vittorio_revisionato`.

## Contratto di recovery

Il percorso storico a distanza unica resta disponibile e deve essere
considerato la baseline di ripristino della **sola Mandata**:

```text
SpiralGenerator.Generate(...)
    distanza unica Vittorio
    ↓
baseline recovery
```

Il nuovo percorso produttivo revisionato è separato:

```text
SpiralGenerator.GenerateRevisionato(...)
    primo offset parete = P/2
    offset Supply successivi = 2P
    finalizzazione topologica = P
```

Con `P=0,30 m`:

```text
DistanzaPareti = 0,15 m
DistanzaMandataMandata = 0,60 m
DistanzaRitorno = 0,30 m
chiusura minima = 0,60 m
```

Il metodo pubblico:

```text
AggiornaSpiraliConChiusura(
    chiudiCircuito,
    usaGenerateStoricoRecovery = false)
```

usa per default il nuovo `GenerateRevisionato`. Impostando
`usaGenerateStoricoRecovery=true` torna alla Supply storica senza revert
globale di commit e senza modificare Return, combinatoria o raccordatura.

## Confine del rollback

Il recovery storico ripristina soltanto:

```text
GENERAZIONE MANDATA
```

Non ripristina né modifica:

```text
ritorno_Parallelo_diego(P)
chiusura_diego(P)
raccorda_diego(...)
```

Quindi un problema nel nuovo generatore può essere isolato senza perdere il
lavoro consolidato sulla chiusura.

## Vincolo di compatibilità

L'overload storico `SpiralGenerator.Generate(...)` conserva il proprio
contratto a distanza unica. Il core condiviso riceve tre distanze; il percorso
storico gli passa lo stesso valore in tutti i ruoli, mantenendo il comportamento
precedente. Il percorso revisionato passa invece P/2, 2P e P in modo esplicito.

Commit implementativi:
- `2d6dc35f58541f4a5c32e17d74a7f749659a1dd6` — nuovo
  `GenerateRevisionato` e mantenimento del recovery storico;
- `4228c4b9e8a78eb4305af3a391c82815f688e1ee` — wiring pubblico P/2-2P,
  Return=P e switch di recovery;
- `8a5df44ec90eea3a6cc3ec48c4ae7b53a6d60b3c`,
  `913346cf454951c7c282307f24f2e7712bbb8c22` — gate diagnostici;
- `207b866bc21bb634b60b8f7bd6c179560b854b4b` — gate Fast Harness.

Nessuna modifica a `SpiraliVittorio`, `SpiraliDiegoVittorio`,
`funzioni_diego.chiusura_diego`, frontend, `definizionedati.json` o Golden.

## Verifica reale del checkpoint

Fast Harness run `36835095544`:
- build Core + Harness: **SUCCESS / 0 errori**;
- quadrato pubblico `Vittorio_revisionato`: **SUCCESS**;
- Return verificato a `P=0,30 m`;
- `chiusura_diego` verificata con `required=2P=0,60 m`;
- chiusura selezionata sul quadrato: lunghezza rettilinea `1,30 m >= 0,60 m`;
- contratto recovery verificato:
  `VITTORIO_REVISIONATO_HISTORICAL_GENERATE_RECOVERY_OK`;
- parametrizzazione misurata:
  `P=0.3 wall=0.15 supplySpacing=0.6 return=0.3`,
  `measuredWall=0.15 measuredSupplySpacing=0.6`;
- il workflow prosegue correttamente fino alla regression Golden separata
  `Diego_Vittorio`, dove resta la divergenza storica
  `5ddd0ffd... != fa8e6106...`; Golden non aggiornato.

Service Build run `36835001877`:
- soluzione: **Build succeeded**;
- smoke pubblico `Vittorio_revisionato` chiuso: **SUCCESS**;
- smoke pubblico `spiralClosure=false`: **SUCCESS**;
- deploy pubblico: **SUCCESS** con
  `publicServiceCommit=1b0f659d9113c97782b0ae5c5efb76c5defee563`;
- workflow complessivo rosso soltanto sul noto smoke locale storage/lock
  `Termodel.WebService non ha risposto a /health`, indipendente dalle spirali.

La vecchia regression di equivalenza completa
`Vittorio == Vittorio_revisionato` è ora **storica e non più valida come gate
del percorso pubblico**, perché Return e parametrizzazione P sono
intenzionalmente diversi. È stata sostituita dal gate sul `Generate` storico
come recovery della sola Supply.


---

# RECOVERY PRIORITARIO — RICOSTRUZIONE STORICA VITTORIO / DIEGO_VITTORIO / VITTORIO_REVISIONATO

Checkpoint: **2026-10-01 — decisione umana consolidata; nessuna modifica sorgente in questo checkpoint**

Questa sezione **prevale su tutte le note storiche sottostanti** quando si ragiona sulla
parametrizzazione geometrica e sulla responsabilità della chiusura centrale di
`Vittorio_revisionato`.

## Ricostruzione storica consolidata

La sequenza corretta dello sviluppo è:

```text
Vittorio storico
    ↓
Diego_Vittorio
    ↓
tentativo di Return autonomo
    ↓
Return autonomo non affidabile: la spirale del ritorno si blocca in casi reali
    ↓
creazione di Vittorio_revisionato
    ↓
ritorno alla generazione Vittorio come base robusta
    + riuso selettivo delle funzioni Diego per Return/chiusura/raccordatura
```

### 1. Vittorio storico

`Vittorio` nasce con un solo parametro geometrico di passo nel generatore.
Nel codice storico:

```text
PassoTubi = 0,30 m
DistanzaPareti = PassoTubi
```

e `SpiralGenerator` usa la stessa `distanza` sia per il primo offset dalla
parete sia per gli offset successivi.

Quindi **Vittorio non implementa la convenzione moderna P/2 - P - 2P**.
Il suo `PassoTubi` è un passo geometrico unico del generatore.

Vittorio contiene inoltre una logica storica di accorciamento del terminale
della Mandata: alla fine della generazione torna indietro lungo l'ultimo tratto
di una quantità pari a `distanza`. Lo scopo pratico è lasciare spazio nella
zona centrale prima della costruzione del Return/chiusura.

### 2. Diego_Vittorio

`Diego_Vittorio` introduce e implementa realmente la convenzione geometrica
che oggi deve essere considerata autorevole:

```text
P = PassoTubi = 0,30 m

Mandata - Parete  = P/2 = 0,15 m
Mandata - Mandata = 2P  = 0,60 m
Mandata - Ripresa = P   = 0,30 m
```

Il generatore Diego_Vittorio distingue infatti esplicitamente:

```text
distanzaParete
passoMandata
distanzaRitorno
```

e usa:
- primo offset Supply = `P/2`;
- offset Supply successivi = `2P`;
- Return = `P`.

Su questa base è stato tentato anche un **Return autonomo**, costruito
indipendentemente dalla Mandata. L'esperienza sui casi reali ha mostrato però
che il Return autonomo può bloccarsi durante lo sviluppo della propria spirale,
in particolare nelle geometrie con strettoie/corridoi. Per questo non è stato
assunto come base affidabile del nuovo motore.

### 3. Nascita di Vittorio_revisionato

`Vittorio_revisionato` nasce quindi per tornare alla **generazione Vittorio**
come base robusta, evitando di dipendere dal Return autonomo Diego_Vittorio.

Nel passaggio sono però rimaste incoerenti due responsabilità fondamentali.

#### A. Parametrizzazione delle distanze

La specifica moderna deve restare quella già implementata da Diego_Vittorio:

```text
P = PassoTubi
DistanzaPareti = P/2
DistanzaMandataMandata = 2P
DistanzaRitorno = P
```

Nello stato corrente di `Vittorio_revisionato` questa separazione non è
implementata nella generazione della Mandata: il generatore è tornato al
contratto Vittorio con una sola `Distanza`.

Inoltre il codice corrente contiene ancora:

```text
DistanzaPareti = PassoTubi
DistanzaRitorno = PassoTubi / 2
```

che è incompatibile con la convenzione autorevole sopra.

Con `P = 0,30 m`, i valori corretti sono:

```text
DistanzaPareti = 0,15 m
DistanzaMandataMandata = 0,60 m
DistanzaRitorno = 0,30 m
chiusura minima = 2P = 0,60 m
```

Qualunque test o nota storica che per `Vittorio_revisionato` riporti
`P=0,15`, `2P=0,30` o `required=0,30` deve essere considerato
**storico/non autorevole**.

#### B. Gestione dello spazio centrale

Vittorio storico crea spazio al centro tramite un accorciamento automatico del
terminale della Mandata durante la generazione.

Nel disegno architetturale corrente questa responsabilità **non deve più essere
affidata a un accorciamento generico del generatore**. Lo spazio centrale viene
gestito in modo mirato dalla combinatoria di chiusura:

```text
0I, 0P, 1I, 1P, 2I, 2P
```

applicata simmetricamente a Mandata e Ripresa.

La combinatoria decide esplicitamente se:
- lasciare invariato il terminale;
- eliminare 1 o 2 tratti terminali;
- normalizzare il nuovo terminale a `P`;
- accettare il primo setup che soddisfa i vincoli di chiusura.

Quindi la regola architetturale da preservare è:

```text
GENERATORE
    costruisce la Mandata con P/2 dalla parete e 2P fra mandate
    senza decidere la chiusura centrale

RETURN
    parallelo alla Mandata a distanza P

CHIUSURA
    sola fase autorizzata a tagliare/accorciare i terminali
    tramite le permutazioni 0I,0P,1I,1P,2I,2P

RACCORDATURA
    solo dopo la selezione definitiva
```

### Conseguenza operativa per i prossimi interventi

Quando si riprenderà il codice di `Vittorio_revisionato`:

1. non reinventare il Return autonomo Diego_Vittorio;
2. mantenere la base geometrica Vittorio dove serve robustezza;
3. ripristinare nel generatore revisionato la separazione
   `DistanzaParete=P/2` / `DistanzaMandataMandata=2P`;
4. impostare `DistanzaRitorno=P`;
5. non usare l'accorciamento storico del generatore come autorità della
   chiusura centrale;
6. lasciare a `funzioni_diego.chiusura_diego(...)` la responsabilità mirata
   di tagliare/normalizzare i terminali;
7. con `P=0,30 m`, il filtro minimo della chiusura deve essere
   `2P=0,60 m`, non `0,30 m`;
8. aggiornare i regression test che hanno consolidato la vecchia convenzione.

Nessun sorgente è stato modificato in questo checkpoint: questa è una
**ricostruzione storica e architetturale consolidata** da usare come base del
prossimo intervento.

---

# RECOVERY FINALE — LOG ISTITUZIONALE COMBINATORIA

Checkpoint: **2026-10-01 — pubblicato e verificato**

Rollback pre-modifica logging:
`96e1fcc6143b5eca6482ddae9bcae6c127bea0e3`.

Modifica funzionale:
- `SpiraliDiegoVittorio/funzioni_diego.cs::chiusura_diego(...)` non usa più
  `Console.WriteLine` né la variabile privata
  `TERMODEL_DIEGO_VITTORIO_TRACE_CLOSURE` per la diagnostica combinatoria;
- tentativi, scarti, accettazione, selezione e risultato passano da
  `TermodelLog.LogCategory.SpiraliDiego`;
- sottotag:
  `[SpiraliDiego][Closure.Try]`,
  `[Closure.Reject]`, `[Closure.Accept]`,
  `[Closure.Selected]`, `[Closure.Result]`;
- nel frontend la diagnostica si attiva con
  **Help → Log Aggiorna Modello → spiralidiego**;
- nessuna modifica alla geometria della combinatoria.

Commit funzionale:
`c87ea62e44099b931651f0dc6a0700251465435f`.

Wiring Harness:
- benchmark revisionato propaga la configurazione `TermodelLog`;
- il test pubblico revisionato abilita `SpiraliDiego` invece della vecchia
  variabile ambiente privata.

Verifica Fast Harness run `36823315279`:
- build: **SUCCESS / 0 errori**;
- `FUNZIONI_DIEGO_FINAL_CLOSURE_MATRIX_OK`;
- `FUNZIONI_DIEGO_INSTITUTIONAL_CLOSURE_LOG_OK`;
- `FUNZIONI_DIEGO_SINGLE_CLOSURE_AUTHORITY_OK`;
- quadrato pubblico `Vittorio_revisionato`:
  `REVISIONATO_PUBLIC_SQUARE_STRAIGHT_2P_OK length=0.4 required=0.3`;
- `REVISIONATO_PUBLIC_SQUARE_LG051_OK`;
- la regression `Diego_Vittorio` supera anche il nuovo controllo del log
  istituzionale e si arresta successivamente sul Golden SVG già noto
  `5ddd0ffd...`, diverso dalla baseline storica: Golden non aggiornato.

Service Build run `36822763861`:
- build riuscita;
- deploy pubblico verificato con
  `publicServiceCommit=c87ea62e44099b931651f0dc6a0700251465435f`;
- workflow complessivo rosso sul noto smoke locale `/health`, indipendente
  dal logging della combinatoria.

---

# RECOVERY PRIORITARIO — LOG ISTITUZIONALE COMBINATORIA

Checkpoint: **2026-10-01 — prima della modifica logging**

Punto di rollback sicuro: `96e1fcc6143b5eca6482ddae9bcae6c127bea0e3`.

Incarico: migrare la sola diagnostica della combinatoria consolidata da
`Console.WriteLine` / `TERMODEL_DIEGO_VITTORIO_TRACE_CLOSURE` a
`TermodelLog.LogCategory.SpiraliDiego`, attivata nel frontend dalla spunta
`spiralidiego`.

Vincolo principale: **nessuna modifica geometrica** a matrice, filtri,
first-success, Return o raccordatura.

---

# RECOVERY FINALE — COMBINATORIA CONSOLIDATA IN `funzioni_diego`

Checkpoint: **2026-10-01 — implementazione pubblicata e verificata tecnicamente**

Punto di rollback pre-funzionale:
`c99c75693d98becc92223e1c7b5b77401fe42eca`.

Implementazione autorevole:
`Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliDiegoVittorio/funzioni_diego.cs::chiusura_diego(...)`.

Contratto implementato:
```text
Mandata = Ripresa
0I, 0P, 1I, 1P, 2I, 2P
P = normalizzazione esatta a P
max 36 coppie
chiusura rettilinea >= 2P
nessun angolo acuto ai due innesti
il tratto di chiusura non interseca tratti non adiacenti
del setup risultante dopo tagli/normalizzazioni
first-success
nessun candidato = circuito aperto
nessun RP/ranking/preferenza P-I/Bezier/raccordo nella selezione
```

Commit funzionali:
- `b389436ddb6ad663dc662bf3224a0c8cc2f5afcd` — implementazione combinatoria in `funzioni_diego`;
- `becc425dd60c716469b7a855a8e52a7f37040508` — rimozione vecchio motore combinatorio da `ChiudiSpirale`;
- `250ecf653976860f0023aaadf8e15b68823d87d1` — ripristino del solo helper geometrico generico necessario alle curve legacy, senza reintrodurre la combinatoria;
- `5ab1161cae5468f99f7006ff3abb002c4e640d5b` — gate Fast Harness sull'autorità unica.

Verifica:
- Service Build run `36800489515`: **Build succeeded**; workflow complessivo rosso sul noto smoke locale `/health` storage/lock indipendente;
- nello stesso run il deploy pubblico è stato verificato con `publicServiceCommit=250ecf653976860f0023aaadf8e15b68823d87d1`;
- Fast Harness run `36800577329`: build SUCCESS, `RITORNO_PARALLELO_DIEGO_OK`, `FUNZIONI_DIEGO_FINAL_CLOSURE_MATRIX_OK`, `FUNZIONI_DIEGO_SINGLE_CLOSURE_AUTHORITY_OK`;
- quadrato pubblico `Vittorio_revisionato`: primo tentativo `M0I/R0I`; primo valido selezionato `M1P/R0P`; chiusura rettilinea `0,40 m`, requisito `2P=0,30 m`; `REVISIONATO_PUBLIC_SQUARE_LG051_OK`;
- il Fast Harness fallisce successivamente sul Golden separato `Diego_Vittorio`: SVG corrente `5ddd0ffd...` contro baseline storica, divergenza già nota e preesistente;
- nessun Golden aggiornato;
- confronto da `c99c756...` conferma nessuna modifica a `SpiraliVittorio`, frontend o `definizionedati.json`.

Resta da fare: **prova visiva/reale dell'utente sul server**. Non dichiarare il risultato visivamente approvato prima di tale prova.

---

# RECOVERY PRIORITARIO — CONSOLIDAMENTO COMBINATORIA `funzioni_diego`

Checkpoint: **2026-10-01 — prima di modificare i sorgenti**

Incarico autorizzato: consolidare in `SpiraliDiegoVittorio/funzioni_diego.cs` la combinatoria finale approvata, pubblicare e provare il percorso `Vittorio_revisionato`.

Punto di rollback sicuro prima delle modifiche funzionali:

`c99c75693d98becc92223e1c7b5b77401fe42eca`

Contratto da preservare:

```text
Mandata = Ripresa
azioni: 0I, 0P, 1I, 1P, 2I, 2P
I = invariato
P = lunghezza terminale esattamente P
max 36 coppie
chiusura rettilinea >= 2P
nessun angolo acuto ai due innesti
il tratto di chiusura non interseca tratti non adiacenti
  del setup risultante dopo tagli/normalizzazioni
first-success
nessun candidato = circuito aperto
nessun RP/ranking/P-I/Bezier/raccordo nella selezione
raccordatura solo dopo con raccorda_diego
```

Vincoli: `SpiraliVittorio`, frontend e `definizionedati.json` intoccabili; Golden non aggiornati automaticamente.

---

# PUNTO DI RIPRISTINO PRIORITARIO — VITTORIO_REVISIONATO / CONTAMINAZIONE RETURN

Checkpoint: **2026-09-30 — diagnosi architetturale da cui riprendere in caso di blocco chat**

Questo checkpoint **prevale operativamente sui vecchi “prossimo passo” presenti più sotto** quando si riprende lo sviluppo di `Vittorio_revisionato`.

## Obiettivo corretto

```text
Vittorio_revisionato
    = Vittorio fino a Mandata + Return completi
    + sola nuova logica di chiusura LG-051
    + sola nuova raccordatura finale
```

`SpiraliVittorio` resta intoccabile.

## Punto chiave individuato

Il percorso pubblico di `Vittorio_revisionato` crea inizialmente il Return storico con:

```text
CreaRientro(...)
```

ma quel Return **non viene poi conservato come geometria effettiva**. Viene passato a:

```text
SpiralHeatingDiegoVittorio.ChiudiSpirale
    .PreparaRitornoRettilineoVittorio(...)
```

che internamente esegue:

```text
CreaRientroRettilineo(...)
    -> CreaOffsetRettilineo(...)
```

Quindi il Return realmente usato da `Vittorio_revisionato`, anche con `spiralClosure=false`, è **rigenerato dal codice Diego_Vittorio**. Il Return Vittorio originale viene usato solo come riferimento geometrico iniziale.

Questa è la contaminazione principale da eliminare.

## Contaminazione Mandata già corretta

Il percorso pubblico usava anche:

```text
GeneraSpirale(terminalCenterline: true)
```

Questa contaminazione è stata rimossa: il percorso pubblico usa ora `terminalCenterline:false` e quindi la Mandata torna quella di Vittorio.

Commit funzionale:
`281ef61730437963d4f6c21a470660c5591ac7c6`.

Verifica Fast Harness run `36722913206`:
- build Core/Harness: SUCCESS;
- equivalenza iniziale Vittorio/Vittorio_revisionato: SUCCESS;
- equivalenza multi-progetto su 6 casi: SUCCESS;
- quadrato LG-051 con Mandata Vittorio ripristinata: circuito aperto, coerente con l'assenza di un candidato valido nel percorso corrente;
- workflow globale rosso più avanti per il Golden separato `Diego_Vittorio`, già divergente e non causato da questa correzione.

## Baseline visivo: precisazione importante

Il baseline visivamente accettato:

`0df1d3bad2b9992a3cfd9af2e95f186301024f87`

**conteneva già la rigenerazione Diego del Return** tramite il bridge sopra descritto. È quindi utile come riferimento visivo, ma **non è una baseline architetturalmente pulita**.

## Prossimo passo esatto dopo recovery

NON lavorare ancora sulla chiusura.

Prima:
1. eliminare dal percorso pubblico di `Vittorio_revisionato` la rigenerazione del Return tramite `PreparaRitornoRettilineoVittorio -> CreaRientroRettilineo -> CreaOffsetRettilineo`;
2. fare in modo che `spiralClosure=false` mostri realmente **Mandata Vittorio + Return Vittorio originale**, senza chiusura;
3. verificare il quadrato e almeno i casi di equivalenza già esistenti;
4. solo dopo applicare LG-051 ai **soli terminali** di Mandata e Return preservati: tagli/accorciamenti, `>=2P`, nessun angolo acuto, nessuna intersezione, first-success;
5. raccordare soltanto dopo la scelta definitiva della chiusura.

La frontiera architetturale corretta è quindi:

```text
Vittorio: genera Mandata + Return
---------------- CONFINE ----------------
Vittorio_revisionato: decide chiusura + raccorda
```

Checkpoint documentale precedente nel Summary:
`85074447f842f8da4e066c5d7d0bb91550eae1ba`.

---

# RECOVERY ACTIVE — Termodel Service

Checkpoint: 2026-09-30 Europe/Rome — audit chiusura/raccordatura Vittorio_revisionato registrato
Stato: ATTIVITÀ IN CORSO / RIPRESA DOPO SOSPENSIONE
Branch: `main`
Repository: `Fetonte1960/Termodel`
HEAD tecnico validato: `49f28610128096e87db27fbea58f5d7f73f9d27d`
HEAD documentale prima del presente checkpoint: `4c79d1ad8bad407d9998bc2605f4e943cf5ffffa`

## Attività corrente

**DV-TEST-002 — Pannelli radianti pubblico: locali rettangolari uno per uno**

Origine della richiesta utente:
- il quadrato base dell'esempio 1 è corretto e deve restare invariato;
- il progetto pubblico **Pannelli radianti** produce geometrie molto errate/non ripetibili su più locali;
- indagare i locali separatamente, iniziando dai rettangolari, usando il Fast Harness;
- applicare soltanto correzioni circoscritte;
- nessuna modifica strutturale o cambio strategia senza accordo umano;
- ogni correzione deve conservare byte/geometricamente il quadrato base.

## Riferimenti autorevoli

- `Server/Termodelwebservice/PROJECT-SUMMARY-SERVICE.md`
- `Server/Termodelwebservice/docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md`
- `Server/Termodelwebservice/docs/LOCAL-RADIANT-HARNESS.md`
- `Server/Termodelwebservice/docs/ISTRUZIONI-SOSPENSIONE-CHAT.md`
- fixture condivisa:
  `Server/Termodelwebservice/tests/radiant-harness/prepared/PannelliRadiantiPublic.pannelli.xml`

## Vincolo protetto

Quadrato pubblico approvato:
- case: `DV-PUBLIC-SQUARE-LEFT-P030-DIEGO-VITTORIO`
- SVG SHA-256:
  `fa8e61061050a1f18026b3d2150270c013d2b4ca1d72e1f72f5fb7c21375fa39`
- punti baseline: 16
- una correzione che modifica questa baseline non può essere consolidata senza nuova approvazione umana.

## Casi rettangolari reali

- `locale_1` — T6 — 3,09 × 5,50 m
- `locale_5` — T1 — 5,43 × 4,24 m
- `locale_8` — T3 — 3,91 × 4,24 m
- `locale_9` — T5 — 2,57 × 4,41 m

Input pubblico estratto dal vero `GeneraModello`:
SHA-256 `15E9F73DEB570F4E17385FF3CD7335916DD8023C69A630925CF083C24A41109A`.

## Fasi

### FASE 1 — estrazione casi reali
Stato: **COMPLETATA**

Risultato:
- estratto il vero `RadiantPanelInputXml`;
- 9 locali classificati, 6 con pannello, 4 rettangolari con pannello;
- aggiunto filtro `localeId/--locale` all'Harness;
- creati i quattro case rettangolari;
- quadrato base protetto da baseline esatta.

Commit principali:
- `3b1193fbdd814af6598a4bf08ba8fd800b7cff1c`
- baseline/test consolidati fino al Fast Harness run `36385818334` SUCCESS.

### FASE 2 — locale_1
Stato: **COMPLETATA TECNICAMENTE**

Causa Return:
- corridoio Supply largo esattamente `2p = 0,60 m`;
- campionamento storico a `p/2` non colpiva l'unica mezzeria valida.

Correzione:
- fallback deterministico sulle coordinate critiche
  `estremo mandata ± distanzaCondizionamento`,
  attivo soltanto se la ricerca precedente fallisce.
- commit `9c0aa251250fd2058e34189b225aa96c3bbd1601`.

Esito Return:
- 6 → 18 punti;
- offset 2 e 3 completati.

Causa chiusura:
- tutte le 35 configurazioni LG-048 dirette fallivano realmente;
- esisteva proiezione ortogonale naturale lunga `2p`.

Correzione:
- fallback di chiusura proiettata solo dopo il fallimento delle configurazioni dirette;
- accettato `M4/RP3`, lunghezza 0,60 m;
- commit finale `401bd0c7e018553800a0378ecdf9a4516a69ccca`.

Regression:
- Fast Harness run `36402218998` SUCCESS;
- `DIEGO_VITTORIO_PUBLIC_PANELS_LOCALE1_OK`;
- `DIEGO_VITTORIO_APPROVED_SQUARE_BASELINE_OK`.

Nota:
- tecnicamente risolto e SVG Harness ispezionato;
- conferma visiva utente nel progetto completo ancora da effettuare.

### FASE 3 — locale_5
Stato: **COMPLETATA TECNICAMENTE**

Causa e correzione Return:
- il collegamento raggiungeva il varco `2p`, ma sovrapponeva all'indietro il terminale Return già occupato;
- commit `ab09475b8afb482b6fa948aebb828f7356ad225e`: trim/sostituzione del solo terminale Return come fallback, senza rilassare autointersezioni o distanze;
- risultato: Return **16 punti**, 3 offset utili completati.

Problema residuo di chiusura:
- LG-048 storico sceglieva `M3/R5`, obliquo, **2,454 m**, rimozione 3,75 m;
- diagnostica completa ha trovato anche `M2/RP3`, ortogonale, **1,24 m**.

Decisione e implementazione:
- l'utente ha autorizzato il cambio circoscritto del criterio LG-048;
- prima prova `aedf756a44beb9039e4faed76fdfda071a031e4f`: preferenza assoluta per la chiusura ortogonale più corta;
- Fast Harness `36405315739`: **FAILED correttamente** sul Golden del quadrato, perché una variazione marginale 0,753 -> 0,740 m ne cambiava l'SVG;
- criterio ristretto nel commit `fb26ed054149a222c54cf706c099af9c066837ea`: il primo candidato storico resta invariato salvo che sia obliquo e una chiusura ortogonale valida riduca la lunghezza di almeno un passo `p`; nessun vincolo geometrico viene rilassato;
- regression `locale_5` aggiunta al Fast Harness nel commit `a6507361ef69fa8dcb7e3520888814abeb2396ec`.

Verifica finale:
- Fast Harness run `36405693422`: **SUCCESS**;
- build Harness + Core: SUCCESS;
- quadrato pubblico byte-identico, SHA-256 `fa8e61061050a1f18026b3d2150270c013d2b4ca1d72e1f72f5fb7c21375fa39`;
- `locale_1`: regression SUCCESS, `M4/RP3` 0,60 m invariata;
- `locale_5`: Return 16 punti, `M2/RP3` ortogonale **1,24 m**, regression SUCCESS;
- SVG artifact ispezionato: la precedente diagonale centrale da 2,454 m non è più presente e i livelli interni risultano ordinati.

### FASE 4 — locale_8
Stato: **COMPLETATA TECNICAMENTE**

Causa:
- il Return iniziale conteneva dogleg locali A-B -> B-C -> C-D;
- `SegmentoRispettaSpirale` trattava A-B come ramo remoto rispetto a C-D,
  imponendo `p` anche quando la distanza minima coincideva soltanto con la
  lunghezza del raccordo B-C;
- nel primo dogleg il raccordo è 0,22 m: i rami A-B e C-D non hanno sviluppo
  parallelo sovrapposto e divergono sui lati opposti del raccordo;
- lo stesso schema ricompare fra primo e secondo livello;
- lato Destro e verso di costruzione opposto erano già stati provati e
  peggioravano il risultato.

Diagnostica:
- commit `d10e31d2b02b39b504dcde8db9e0d92f94e09619`: riconoscimento dogleg
  solo sotto flag;
- Fast Harness diagnostico `36406990692`: SUCCESS;
- `locale_8`: 3 -> **18 punti** Return; due dogleg locali riconosciuti;
- SVG ispezionato: percorso ordinato, nessun ramo remoto sovrapposto;
- chiusura `M3/R5`, obliqua, 0,971 m.

Correzione consolidata:
- commit `18cd798a22c72d39d5dfbbfaba647e1e91fdcf5a`: classificazione dogleg
  locale attiva per default;
- rollback: `TERMODEL_DIEGO_VITTORIO_LOCAL_DOGLEG_ADJACENCY=false`;
- la regola si applica soltanto al penultimo ostacolo separato da un unico
  raccordo, quando la distanza minima coincide con la lunghezza del raccordo
  e i due rami divergono sui lati opposti;
- tutti gli altri segmenti mantengono integralmente la distanza minima.

Regression:
- commit `109dac86a8703f8d21b04b6486e00cda0fd49a01`: regression `locale_8`;
- Fast Harness run `36407499506`: **SUCCESS** senza flag diagnostici;
- quadrato approvato byte-identico;
- `locale_1`, `locale_5`, `locale_8` e fitting regression tutti SUCCESS;
- `locale_8`: Return 18 punti, chiusura presente 0,971 m.

### FASE 5 — locale_9
Stato: **COMPLETATA TECNICAMENTE**

Verifica:
- workflow inspection commit `6f4abb6a56ed515ddae776c4ed08c27e9f2dd28b`;
- Fast Harness run `36407962757`: SUCCESS;
- `locale_9`: Return **13 punti**, 2 offset utili, nessun arresto;
- la selezione LG-048 già consolidata usa `M3/RP2`, ortogonale, **0,77 m**
  invece della precedente `M3/R5` obliqua 1,875 m;
- SVG ispezionato: geometria ordinata e chiusura locale;
- nessuna nuova modifica al motore necessaria.

Regression:
- commit `3f055f37132643e4e09b9ec0bc3dc3615b122b75`: regression `locale_9`;
- Fast Harness run `36408292815`: **SUCCESS**;
- quadrato approvato + `locale_1` + `locale_5` + `locale_8` + `locale_9` +
  fitting regression tutti verdi.

### FASE 6 — ricomposizione progetto completo
Stato: **VALIDATA TECNICAMENTE — IN ATTESA DI CONFERMA VISIVA UTENTE**

Verifica completa eseguita:
- commit workflow `a4f478c9a44c7764df45b8ce8b2801938c96fde7`;
- Room Extraction run `36408840730`: **SUCCESS**;
- build Harness + Core: 0 errori;
- vero progetto pubblico ricostruito attraverso `GeneraModello`;
- input estratto SHA-256:
  `15E9F73DEB570F4E17385FF3CD7335916DD8023C69A630925CF083C24A41109A`,
  identico alla fixture reale già consolidata;
- verifiche sul progetto reale:
  - `locale_1`: Return 18 punti, `M4/RP3` ortogonale 0,60 m;
  - `locale_5`: Return 16 punti, `M2/RP3` ortogonale 1,24 m;
  - `locale_8`: Return 18 punti, `M3/R5` obliqua 0,971 m;
  - `locale_9`: Return 13 punti, `M3/RP2` ortogonale 0,77 m;
- marker workflow `FULL_PROJECT_RECTANGULAR_REGRESSION_OK`;
- artifact finale `diego-vittorio-room-extraction` prodotto e ispezionato;
- SVG dei quattro rettangolari ispezionati: geometrie ordinate, nessuna
  ricomparsa della diagonale patologica di `locale_5`.

Anomalia esterna alla presente campagna:
- durante `GeneraModello` compaiono messaggi
  `Il valore 'Solaio piano' non è un numero intero valido per il colore della copertura`;
- il workflow e le regression pannelli restano SUCCESS;
- non viene corretta in DV-TEST-002 perché non riguarda il motore spirali.

**PROSSIMO PASSO ESATTO:**
1. l'utente apre il progetto pubblico `Pannelli radianti` sul frontend aggiornato;
2. esegue `Aggiorna Modello` e visualizza l'esecutivo pannelli;
3. conferma se il risultato complessivo è visivamente corretto;
4. solo dopo conferma positiva aggiornare registri permanenti finali,
   notificare la conclusione sulla issue #1 e rimuovere
   `RECOVERY-ACTIVE.md`;
5. in caso di anomalia, conservare screenshot/caso e riaprire soltanto il
   locale o la geometria effettivamente difettosa.

## Sottofase FASE 6A — provenienza visibile dell'esecutivo CAD2D
Stato: **COMPLETATA TECNICAMENTE — ATTESA SOLA VERIFICA VISIVA UTENTE**

Origine richiesta utente:
- prima del collaudo finale, rendere immediatamente visibile nel CAD2D / Disegno esecutivo chi ha generato il disegno;
- indicare se l'esecutivo è consolidato nell'esempio oppure calcolato dal Service corrente;
- mostrare motore spirali e versione/commit del Service;
- mantenere la zona informativa discreta e non interferente con il disegno.

Provenienza storica verificata:
- gli esecutivi statici degli esempi furono generati dal vero Termodel WebService nel workflow run `36301010185`, sul commit sorgente `aba9bd293936396c9861f521d5ffebdb0fe8b769`;
- il motore usato era `GPT / SpiraliGPT`;
- i file furono consolidati nel catalogo pubblico dal commit `9a4c0b7d982ea42c1b73a4a5a36975935d1bfece` del 27/09/2026;
- per gli esecutivi runtime la fonte autorevole è `GET /health` del Service corrente (`serviceCommit`, `spiralEngine`).

Implementazione:
- frontend portato a **v1.34**;
- commit funzionale `b33ffcc9f505c3dc9ac06c1d405f7b7e732b57e0`;
- fix cache-busting `e694e191542bbdc133d552b879b35d1fb933998d`;
- allineamento regression identità Service `90bb914e7bcdb0cff17d9bd19d1bf2701ccf8424`;
- aggiunto box discreto `cadExecutiveProvenance`, esterno all'SVG e quindi senza modificare la geometria;
- esempio statico: mostra `CONSOLIDATO NELL'ESEMPIO`, generatore, motore, commit Service di generazione, commit/data di consolidamento;
- artifact runtime: mostra `CALCOLO CORRENTE · NON CONSOLIDATO`, generatore, motore e commit reali del Service letti da `/health`, oltre al projectId e allo stato stale;
- metadata storici aggiunti a `examples/catalog.json`;
- nessuna modifica a Core, motore spirali, SVG esecutivi o `definizionedati.json`.

Verifica:
- run finale `36411206078`:
  - JavaScript syntax: **SUCCESS**;
  - `CAD_EXECUTIVE_PROVENANCE_OK`: **SUCCESS**;
  - build Service: **SUCCESS**, 0 errori;
  - smoke progetto pubblico Pannelli radianti: **SUCCESS**;
- il workflow complessivo termina rosso soltanto sul Golden Darcy sintetico già noto e indipendente: dP corrente 1,313675 Pa contro golden storico 1,343675 Pa; non è causato né toccato dalla FASE 6A;
- GitHub Pages run `36411205191`: build + deploy **SUCCESS**;
- verifica HTTP diretta del dominio non disponibile dallo strumento di questa sessione: la prova visuale browser resta umana.

Vincoli rispettati:
- nessuna modifica al motore geometrico;
- nessuna modifica a `definizionedati.json`;
- nessuna alterazione dell'SVG esecutivo;
- la FASE 6 principale resta tecnicamente validata e in attesa del collaudo visivo utente.

**PROSSIMO PASSO ESATTO:**
1. aprire il frontend v1.34 e l'esempio `Pannelli radianti`;
2. in `Disegno esecutivo` verificare che il box indichi chiaramente lo statico consolidato GPT/SpiraliGPT;
3. eseguire `Aggiorna Modello` e verificare che lo stesso box passi a `CALCOLO CORRENTE · NON CONSOLIDATO` mostrando il motore e commit Service correnti;
4. proseguire quindi con la conferma visiva finale della FASE 6.

## Sottofase FASE 6B — congelamento esecutivi Diego_Vittorio negli esempi
Stato: **COMPLETATA**

Decisione utente 28/09/2026:
- il nuovo esecutivo `Pannelli radianti` mostrato dal Service corrente è giudicato sicuramente migliorativo;
- congelati gli esecutivi dei due esempi pubblici:
  - `Pannelli radianti`;
  - `Quadrato con pannelli`;
- l'ispezione degli esempi non richiede più un calcolo Service;
- `Aggiorna Modello` resta disponibile per produrre un nuovo esecutivo runtime e confrontarlo col consolidato.

Asset congelati:
- commit asset `e0121145ca88014edb6204e2d97bf99366497989`;
- `Pannelli radianti`:
  - sorgente artifact run `36411641717`;
  - Service/head `e23f3a6698f0166a6752fbdd3aac5fd6346cada7`;
  - motore `Diego_Vittorio`;
  - SHA-256 statico `6a1c79ed23b8dcfde6fcffb484a029f54d5355793b32422e30c6e19cca0f2a3d`;
- `Quadrato con pannelli`:
  - sorgente workflow pubblico run `36383027266`;
  - Service/head `5de2ccab955dd3146ee23089afe41fb9040eb3ac`;
  - motore `Diego_Vittorio`;
  - SHA-256 statico `1cd73beba29edb1c44adc7dd4719123872ed58de5f9f5c901a88f39a3f52f8f6`;
  - baseline Harness umana protetta `fa8e61061050a1f18026b3d2150270c013d2b4ca1d72e1f72f5fb7c21375fa39`.

Frontend:
- versione portata a **v1.35** nel commit `ed87c6ad59cd60d008e7ffe2ed13885bea3dcaf3`;
- `loadProjectBrowserExamples()` trasferisce ora anche `executiveProvenance`;
- il badge dello statico mostra quindi correttamente `CONSOLIDATO NELL'ESEMPIO`, motore Diego_Vittorio, commit Service sorgente e commit di consolidamento;
- catalogo aggiornato con provenance separata per i due esempi;
- il workflow temporaneo usato esclusivamente per trasferire gli artifact è stato rimosso nello stesso commit v1.35.

Verifica:
- workflow di trasferimento `36414320457`: **SUCCESS**, inclusa verifica SHA-256 dei due artifact prima del commit;
- TermodelService Build `36414512616`:
  - sintassi JavaScript: **SUCCESS**;
  - `CAD_EXECUTIVE_PROVENANCE_OK`: **SUCCESS**;
  - `RADIANT_STATIC_EXECUTIVES_OK`: **SUCCESS**;
  - `RADIANT_PUBLIC_EXAMPLE_OK`: **SUCCESS**;
  - build: **SUCCESS**, 0 errori;
  - smoke progetto pubblico `Pannelli radianti`: **SUCCESS**;
  - `RADIANT_REFERENCE_PROJECT_OK`: **SUCCESS**;
  - il workflow termina poi rosso esclusivamente sul Golden Darcy sintetico già noto e indipendente: dP corrente 1,3136749 Pa contro golden storico 1,343675 Pa;
- GitHub Pages run `36414512118`: build + deploy **SUCCESS**.

Vincoli rispettati:
- nessuna modifica a Termodel.Core o al motore;
- nessuna modifica a `definizionedati.json`;
- nessuna modifica ai progetti di input;
- modificati solo gli output SVG statici, catalogo/provenienza e wiring frontend necessario a mostrarla.

**PROSSIMO PASSO ESATTO:**
1. aprire `Quadrato con pannelli` e `Pannelli radianti` dal catalogo senza premere `Aggiorna Modello`;
2. verificare che `Disegno esecutivo` sia subito disponibile e che il badge riporti `CONSOLIDATO NELL'ESEMPIO` + `Diego_Vittorio`;
3. riprendere quindi il collaudo geometrico della FASE 6 usando questi due statici come riferimenti rapidi.

## Sottofase FASE 6C — diagnosi mandata Supply prima di Return/chiusura
Stato: **DIAGNOSI GENERALE COMPLETATA — PROPOSTA 6C.4 RESPINTA — INDAGINE LOCALE_1 IN CORSO**

Origine utente 28/09/2026:
- partendo dall'esecutivo `Pannelli radianti` congelato e approvato come migliorativo,
  si osserva un'anomalia quasi generalizzata: l'evoluzione della spirale di
  **mandata rossa** sembra arrestarsi prima del previsto;
- indagare in modalità Harness;
- ignorare esplicitamente Return e chiusura LG-048 durante la diagnosi;
- seguire il protocollo recovery e registrare ogni checkpoint.

Obiettivo tecnico:
- osservare la polilinea Supply grezza nel punto immediatamente precedente alla
  costruzione del Return e alla chiusura;
- misurare locale per locale quanti offset/livelli Supply vengono costruiti;
- per ogni arresto identificare il primo livello non prodotto e la causa
  concreta di rifiuto/assenza geometrica;
- distinguere errore di generazione Supply da effetti successivi di Return o
  LG-048, che in questa fase non devono influenzare la diagnosi.

### 6C.1 — strumentazione diagnostica Supply
Stato: **COMPLETATA**

Commit:
- `b2d9511a2721637bddeb838272163ca15e255513`.

Implementazione diagnostica:
- aggiunto `Program.AggiornaSoloMandata(p)`, che esegue esclusivamente
  `GeneraSpirale` e non richiama `ChiudiSpiraleFiles`;
- Harness: nuova opzione `--supply-only`, valida soltanto per
  `Diego_Vittorio`;
- benchmark: `StrategiaDiegoVittorioBenchmark.RunSupplyOnly`;
- trace non invasivo `DV_SUPPLY_*` per generazione offset e percorrenza;
- nessun criterio geometrico produttivo modificato.

Verifica:
- Fast Harness run `36416240750`, job `108907958748`: **SUCCESS**;
- build Harness + Core SUCCESS;
- tutte le regression preesistenti SUCCESS;
- quadrato approvato byte-identico:
  `fa8e61061050a1f18026b3d2150270c013d2b4ca1d72e1f72f5fb7c21375fa39`.

### 6C.2 — matrice locale-per-locale
Stato: **COMPLETATA**

Input condiviso:
`tests/radiant-harness/prepared/PannelliRadiantiPublic.pannelli.xml`.

Risultati Supply-only, prima di Return/LG-048:

- **quadrato pubblico di controllo**
  - offset utili: 3;
  - minEdge: 3,44 -> 2,24 -> 1,04 m;
  - livello 4: `invalid-offset`, 0 punti;
  - Supply: 16 punti;
  - tutti gli offset ammessi vengono percorsi e finalizzati correttamente.

- **locale_1**
  - offset utili: 2;
  - minEdge: 2,79 -> 1,59 m;
  - livello 3: `invalid-offset`, 0 punti;
  - Supply: 13 punti;
  - SVG SHA-256:
    `c4abe23db71675c15c17d2322a081020e54b54215390fed8b03302bf45d2ee46`.

- **locale_2**
  - offset utile: 1;
  - livello 2 calcolato con 6 punti e minEdge **0,36 m**;
  - rifiuto: `min-edge-below-step`, soglia 0,60 m;
  - Supply: 8 punti;
  - SVG SHA-256:
    `a8d8dfa2f5888a96e574502f38f241e278653909b73cf3863861ba8f3eb888c0`.

- **locale_5**
  - offset utili: 3;
  - minEdge: 3,94 -> 2,74 -> 1,54 m;
  - livello 4: `invalid-offset`, 0 punti;
  - Supply: 17 punti;
  - SVG SHA-256:
    `1ec390739cfeed733746ff4846492e2ae73428775a18a557ef7066190a2e0a59`.

- **locale_6**
  - offset utile: 1;
  - livello 2 calcolato con 6 punti e minEdge **0,29 m**;
  - rifiuto: `min-edge-below-step`, soglia 0,60 m;
  - Supply: 8 punti;
  - SVG SHA-256:
    `0130cb668972ec9be246343f2c44eb731508a681539984d9f7ad6e86b250d260`.

- **locale_8**
  - offset utili: 3;
  - minEdge: 3,61 -> 2,41 -> 1,21 m;
  - livello 4: `invalid-offset`, 0 punti;
  - Supply: 18 punti;
  - SVG SHA-256:
    `4a777551785a46e5504d4fcc71cc50926dae38d7b131fe5d8e0f7b90ebd06d00`.

- **locale_9**
  - offset utili: 2;
  - minEdge: 2,27 -> 1,07 m;
  - livello 3: `invalid-offset`, 0 punti;
  - Supply: 13 punti;
  - SVG SHA-256:
    `91911b1160a8f91f5af560f9caa554e97c0af3dbbd999d20ab0c401616469454`.

Conclusioni accertate:
- l'arresto osservato dall'utente **esiste già nella Supply grezza**:
  Return e LG-048 sono esclusi come causa;
- non si osservano fallimenti di collegamento/percorrenza sugli offset ammessi:
  tutti i livelli accettati vengono percorsi e finalizzati;
- l'arresto avviene nella **generazione/ammissione del livello interno successivo**;
- per `locale_2` e `locale_6` il livello successivo esiste come poligono
  a 6 vertici, ma viene respinto globalmente perché un singolo lato misura
  rispettivamente 0,36 m e 0,29 m contro `passoMandata = 0,60 m`;
- per i rettangolari `locale_1/5/8/9` il livello successivo collassa già in
  `ComputeOffset` e torna nullo/vuoto;
- anche il quadrato approvato termina con un successivo offset invalido:
  quindi il solo fatto che non esista un altro **anello chiuso completo** non
  implica automaticamente un errore; va verificato se resta invece un
  avanzamento Supply parziale utile verso il centro;
- ipotesi corrente: il generatore Supply è quantizzato per anelli chiusi
  completi e manca un percorso terminale/parziale dopo l'ultimo anello valido;
  nei concavi 2/6 il filtro `minEdgeLength < passoMandata` dimostra già che
  un intero offset viene scartato per un solo lato corto;
- inoltre la finalizzazione di ogni offset arretra il terminale di un intero
  `passoMandata`; questo può contribuire alla sensazione di Supply corta e
  deve essere misurato separatamente.

### 6C.3 — causa comune
Stato: **COMPLETATA**

Diagnostica aggiuntiva:
- commit `466da9d141799ec2bcd548a83c1293ccd86b4543`: trace `ComputeOffset` + finalizzazione Supply; prima esecuzione non compilata esclusivamente per `CultureInfo` mancante nel codice diagnostico;
- fix solo diagnostico `3bc7fae41e643a3baa1273a5cc3694da04d7ebb7`;
- Fast Harness run `36417080491`, job `108910674388`: **SUCCESS**;
- tutte le regression preesistenti, incluso il quadrato approvato, SUCCESS.
- Summary Service aggiornato nel commit `4e0ff119c744aa87ff07b04a7a6393f34d5e3004`;
- linee guida spirali aggiornate nel commit `4c79d1ad8bad407d9998bc2605f4e943cf5ffffa`.

Confronto col riferimento Desktop:
- `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Spiralgenerator.cs` contiene sia la stessa logica `ComputeOffset` con `skipIndices`, sia la stessa finalizzazione storica del giro;
- l'anomalia è quindi **ereditata dalla strategia storica** e non introdotta dalle recenti correzioni Return/LG-048 di `Diego_Vittorio`.

Causa comune accertata:
- la Supply storica evolve esclusivamente per **anelli chiusi completi**;
- quando il successivo anello completo non è più ammissibile, non esiste una fase terminale che trasformi lo spazio residuo in un asse/ramo parziale verso il centro;
- per i rettangoli `ComputeOffset` marca un lato come corto quando `edgeLength <= 3 * passoMandata` e il lato si è ridotto di oltre un passo; i due vertici del lato vengono esclusi;
- se i due lati opposti corti soddisfano la condizione, gli `skipIndices` eliminano tutti e quattro i vertici e `ComputeOffset` restituisce `null`, anche se può esistere un singolo asse centrale ancora rispettoso della distanza Supply-Supply.

Con `passoMandata = 0,60 m`:
- un solo asse centrale richiede lato corto dell'ultimo anello >= `2 * passoMandata = 1,20 m`;
- un ulteriore anello completo richiede invece spazio per due nuovi lati paralleli e viene escluso dal criterio storico prima del collasso.

Matrice ultimo anello completo:
- quadrato approvato: lato corto **1,04 m**, semilarghezza 0,52 m -> asse centrale **non ammissibile**;
- `locale_1`: lato corto **1,59 m**, semilarghezza 0,795 m -> asse centrale possibile; residuo teorico **2,80 m**;
- `locale_5`: lato corto **1,54 m**, semilarghezza 0,77 m -> asse centrale possibile; residuo teorico **1,53 m**;
- `locale_8`: lato corto **1,21 m**, semilarghezza 0,605 m -> asse centrale appena possibile; residuo teorico **0,34 m**;
- `locale_9`: lato corto **1,07 m**, semilarghezza 0,535 m -> asse centrale non ammissibile.

Manifestazione concava dello stesso limite tutto-o-niente:
- `locale_2`: il livello successivo ha 6 vertici; dopo `FixIntersections` conserva più lati lunghi ma contiene un lato da **0,36 m** e il lato di chiusura collassa a **0,00 m**; il filtro globale scarta l'intero livello;
- `locale_6`: il livello successivo ha 6 vertici e cinque lati >= 0,60 m, ma un solo lato da **0,29 m** fa scartare l'intero livello;
- per i concavi è dimostrato il rifiuto globale di una geometria parzialmente ancora sviluppabile, ma non è ancora autorizzata né definita una strategia locale di riduzione/scheletro.

Secondaria anomalia diagnostica:
- il calcolo storico `minEdgeLength` usa `j < nextOffset.Count - 1` e quindi non misura il lato di chiusura ultimo->primo;
- in `locale_2` quel lato vale 0 dopo `FixIntersections`;
- il caso viene comunque scartato per il lato da 0,36 m, quindi questa omissione non causa l'arresto corrente ma resta registrata.

Finalizzazione Supply chiarita:
- la regola storica lascia un'apertura di `passoMandata = 0,60 m` rispetto al punto di ingresso del giro, per permettere il passaggio al livello successivo;
- i grandi valori misurati come spostamento del terminale non sono metri di percorso cancellati: il tratto di chiusura viene percorso fino al nuovo terminale e resta un'apertura finale di 0,60 m;
- sull'ultimo anello l'apertura resta inutilizzata perché manca la fase terminale/parziale; è quindi un punto naturale da cui innestare una futura prosecuzione centrale, non una causa primaria separata.

Conclusione 6C.3:
- Return e LG-048 restano esclusi;
- la causa primaria della mandata corta è la strategia **anelli chiusi completi oppure stop**, senza terminale mediale/parziale;
- per i rettangoli esiste un criterio locale misurabile che può migliorare `locale_1/5/8` senza attivarsi sul quadrato approvato o su `locale_9`;
- i concavi 2/6 richiedono una seconda strategia e non devono essere inclusi implicitamente nella prima correzione.
### 6C.4 — proposta circoscritta
Stato: **RESPINTA DALL'UTENTE — NON IMPLEMENTARE**

Decisione utente 28/09/2026:
- esclusa esplicitamente la scorciatoia dell'asse terminale centrale;
- non correggere l'effetto dopo l'aborto;
- indagare invece le cause dell'**aborto spontaneo della mandata**;
- lavorare step by step;
- discutere **un solo caso alla volta**;
- primo e unico caso corrente: `locale_1`;
- per ogni passo documentare quale codice ha lavorato, in quale contesto, quale decisione ha preso e perché ha fallito.

Conseguenza:
- ogni ipotesi/prototipo di asse centrale terminale è archiviato come **non autorizzato**;
- nessuna modifica geometrica verrà introdotta finché non sarà compreso il fallimento interno di `locale_1`.
### 6C.5 — regression e ricomposizione
Stato: **NON INIZIATA**

Vincoli:
- durante 6C.3 non modificare la geometria produttiva;
- non usare Return o LG-048 per spiegare/arbitrare l'arresto Supply;
- `SpiraliVittorio` invariata;
- quadrato approvato invariato;
- nessuna modifica frontend;
- nessuna modifica a `definizionedati.json`;
- usare il Fast/Local Harness come percorso primario;
- ogni nuova evidenza significativa aggiorna questo recovery e issue #1.

**PROSSIMO PASSO ESATTO:** FASE 6D su `locale_1` soltanto; ricostruire il percorso di chiamata e il calcolo del livello 3 in `ComputeOffset`, senza alcuna modifica geometrica.

## FASE 6D — autopsia Supply `locale_1`
Stato: **IN CORSO — STEP 1/2/3 COMPLETATI**

Ambito rigidamente limitato:
- unico caso: `locale_1` della fixture reale
  `tests/radiant-harness/prepared/PannelliRadiantiPublic.pannelli.xml`;
- ingresso reale: `T6`;
- geometria locale XML: 5 vertici utili + chiusura, con un vertice intermedio
  collineare sul lato destro;
- geometria usata dal generatore dopo normalizzazione: rettangolo 3,09 × 5,50 m;
- passo `p = 0,30 m`;
- `distanzaParete = p/2 = 0,15 m`;
- `passoMandata = 2p = 0,60 m`;
- Return, LG-048, raccordi finali e altri locali sono fuori discussione.

### STEP 1 — percorso di chiamata reale
Stato: **COMPLETATO**

Catena verificata:
1. Harness `Run` legge l'intera fixture reale.
2. `SelectSingleLocale` elimina soltanto gli altri elementi `<Locale>`;
   **non elimina né ricostruisce le linee T1..T12**.
3. per `--engine Diego_Vittorio --supply-only` il banco chiama
   `RunCopiedSpiralStrategy`.
4. `StrategiaDiegoVittorioBenchmark.RunSupplyOnly` crea il workspace
   temporaneo e chiama `Program.AggiornaSoloMandata(0.30)`.
5. `AggiornaSoloMandata` deriva:
   - parete = 0,15 m;
   - Supply-Supply = 0,60 m;
   - Return = 0,30 m, non usato in supply-only;
   e chiama `GeneraSpirale(... traceSupply:true)` senza `ChiudiSpiraleFiles`.
6. `GeneraSpirale` seleziona realmente `T6`, calcola l'intersezione col
   perimetro e passa a `SpiralGenerator.Generate`:
   - start = `(1,5700000000000003 ; 4,74316)`;
   - distanzaParete = 0,15;
   - passoMandata = 0,60;
   - `lineeCondizionamento = null`, quindi nessun Return condiziona la Supply.

Conclusione STEP 1:
- il caso Harness riproduce il percorso Supply produttivo;
- non è una geometria sintetica né ricostruita;
- Return e LG-048 sono effettivamente esclusi.

### STEP 2 — normalizzazione del perimetro
Stato: **COMPLETATO**

Input XML `locale_1` dopo arrotondamento a 2 decimali:
- `(-1,52 ; -0,08)`;
- `(-1,52 ; 5,42)`;
- `(1,57 ; 5,42)`;
- `(1,57 ; 4,29)`;
- `(1,57 ; -0,08)`;
- chiusura sul primo punto.

`RoundAndSnapVertices` arrotonda e allinea coordinate quasi uguali.
Il duplicato finale viene rimosso.
`RemoveCollinearVertices` elimina `(1,57 ; 4,29)` perché è esattamente
collineare fra `(1,57 ; 5,42)` e `(1,57 ; -0,08)`.
`EnsureCounterClockwise` inverte solo l'ordine di percorrenza.

Perimetro effettivamente passato agli offset:
- A `(1,57 ; -0,08)`;
- B `(1,57 ; 5,42)`;
- C `(-1,52 ; 5,42)`;
- D `(-1,52 ; -0,08)`.

Conclusione STEP 2:
- nessuna geometria significativa viene persa prima dell'aborto;
- `locale_1` arriva a `ComputeOffset` come rettangolo ortogonale regolare
  3,09 × 5,50 m.

### STEP 3 — ricostruzione dell'aborto in `ComputeOffset`
Stato: **COMPLETATO**

Codice coinvolto:
`SpiraliDiegoVittorio/Spiralgenerator.cs`, ciclo offset e
`ComputeOffset(polygon, polygon_pre, offset, ...)`.

Livello 1:
- offset richiesto 0,15 m;
- nessun lato viene marcato `skip`;
- risultato 4 vertici, rettangolo 2,79 × 5,20 m;
- livello accettato.

Livello 2:
- offset richiesto 0,60 m;
- rettangolo corrente 2,79 × 5,20 m;
- confronto col precedente 3,09 × 5,50 m;
- shrink osservato 0,30 m;
- nessun lato soddisfa la soglia di skip;
- risultato 4 vertici, rettangolo 1,59 × 4,00 m;
- livello accettato.

Livello 3 — punto esatto dell'aborto:
- offset richiesto 0,60 m;
- poligono corrente:
  - edge 0 = 4,00 m;
  - edge 1 = 1,59 m;
  - edge 2 = 4,00 m;
  - edge 3 = 1,59 m;
- poligono precedente:
  - lati corrispondenti 5,20 / 2,79 / 5,20 / 2,79 m;
- shrink = circa 1,20 m su tutti i lati.

Regola storica:
`skip = edgeLength <= offset * 3 && (edgeLength_pre - edgeLength) > offset`.

Con `offset = 0,60`:
- soglia `offset * 3 = 1,80 m`;
- edge 1: 1,59 <= 1,80 e shrink 1,20 > 0,60 -> `skip=true`;
  vengono aggiunti `skipIndices {1,2}`;
- edge 3: 1,59 <= 1,80 e shrink 1,20 > 0,60 -> `skip=true`;
  vengono aggiunti `skipIndices {3,0}`;
- unione: `{0,1,2,3}`;
- seconda passata: **tutti i vertici vengono saltati**;
- `result.Count = 0` -> `ComputeOffset` restituisce `null`;
- ciclo superiore emette `reason=invalid-offset` e interrompe la generazione.

Fatto nuovo importante:
- il trace diagnostico calcola anche i candidati che il codice produttivo
  evita di creare;
- senza applicare gli skip, il livello 3 sarebbe ancora un rettangolo
  geometricamente finito **0,39 × 2,80 m**;
- coordinate teoriche:
  - `(0,22 ; 1,27)`;
  - `(0,22 ; 4,07)`;
  - `(-0,17 ; 4,07)`;
  - `(-0,17 ; 1,27)`.

Quindi:
- l'aborto **non deriva da un fallimento numerico di ComputeOffset**;
- l'aborto è causato intenzionalmente dalla regola preventiva dei
  `skipIndices`, prima che `FixIntersections`, `NormalizePolygon` o la
  percorrenza possano esaminare il terzo offset;
- il codice non prova a validare il poligono 0,39 × 2,80: lo sopprime a monte.

### Decisione metodo diagnostico — logging categorizzato
Stato: **IMPLEMENTATA E VERIFICATA**

Decisione 28/09/2026:
- non introdurre snapshot JSON o un secondo sistema di debug;
- riusare `Termodel.utilities.TermodelLog`, già adottato dal Service;
- categoria permanente Service/Core `SpiraliDiegoVittorio`, controllabile
  con gli stessi parametri generali `logEnabled/logCategories`;
- sottotag testuali stabili per il contesto Supply;
- l'Harness abilita la stessa categoria con
  `--log-enabled true --log-categories SpiraliDiegoVittorio` e riversa
  `TermodelLog.Messages` nel consueto `.log.txt`;
- dopo ogni elaborazione si legge il log; se manca una variabile necessaria,
  si aggiunge esclusivamente quel punto di log e si riesegue;
- unico caso corrente sempre `locale_1`.

Implementazione:
- commit `e35f05099179aae5f1af6df80527c00d0704c1c5`:
  - aggiunta `LogCategory.SpiraliDiegoVittorio` nell'adattatore headless;
  - collegato `Program` / `SpiralGenerator` a `TermodelLog` senza modificare
    la Library Desktop;
  - benchmark/Harness accettano la configurazione log;
  - eventi permanenti iniziali: `Supply.Context`, `Supply.Generate.Begin`,
    `Supply.Offset.Begin`, `Supply.ComputeOffset.Edge`,
    `Supply.ComputeOffset.Vertex`, `Supply.ComputeOffset.Result`,
    `Supply.ComputeOffset.Raw`, `Supply.Offset.Candidate`,
    `Supply.Offset.Accept`, `Supply.Offset.Stop`, `Supply.Result`;
  - `logCategories=all` del Service aggiornato da 10 a 11 categorie;
- Fast Harness run `36422697579`, job `108929052555`: **SUCCESS**;
  il log categorizzato di `locale_1` riproduce integralmente l'aborto L3;
- dopo lettura del primo log mancava il percorso reale dell'ultimo offset;
  come da protocollo è stato aggiunto soltanto quel dettaglio;
- commit `49f28610128096e87db27fbea58f5d7f73f9d27d`:
  `Supply.Traverse.Connection`, `Supply.Traverse.Candidate`,
  `Supply.Traverse.Accept`, `Supply.Finalize.Plan`,
  `Supply.Finalize.Result`, `Supply.Traverse.End`;
- Fast Harness run `36423105809`, job `108930409465`: **SUCCESS**;
- tutte le regression Fast Diego_Vittorio sono rimaste verdi.

Verifica Service:
- TermodelService Build run `36423105927`: build **0 errori**,
  public Pannelli radianti model3d SUCCESS;
- il nuovo `logCategories=all` con 11 categorie viene eseguito nel medesimo
  smoke; il workflow si arresta successivamente sul Golden Darcy sintetico
  già noto e indipendente:
  `dP=1,31367490344266 Pa` contro golden `1,343675 Pa`;
- nessuna geometria, tolleranza o regola del motore è stata modificata.

Obiettivo metodologico raggiunto:
il log esistente è ora il corrispettivo remoto e ripetibile della sessione
Watch/Locals di Visual Studio per `Diego_Vittorio`, senza infrastruttura
diagnostica parallela.

### STEP 4 — significato del limite e stato reale dell'ultimo anello
Stato: **IN CORSO — PRIMA PARTE CHIARITA**

#### 4A — cosa protegge `3 * offset`

Sul solo `locale_1`:
- ultimo rettangolo accettato: 1,59 × 4,00 m;
- tentativo successivo a `offset=0,60`: raw 0,39 × 2,80 m;
- per un rettangolo vale `nuova_larghezza = larghezza_corrente - 2*offset`;
- chiedere `larghezza_corrente > 3*offset` equivale a chiedere che la
  nuova larghezza resti maggiore di `offset`;
- il raw L3 avrebbe due rami Supply paralleli distanti **0,39 m**, quindi
  meno dei **0,60 m** richiesti.

Conclusione 4A:
- il fattore `3*offset` non è casuale nel rettangolo;
- un **anello chiuso completo** L3 da 0,39 × 2,80 m non è ammissibile come
  nuovo giro Supply completo;
- anche bypassando `skipIndices`, il successivo controllo storico
  `minEdgeLength < passoMandata` respingerebbe indipendentemente il lato
  da 0,39 m;
- pertanto non va rimossa semplicemente la protezione e non va forzato il
  rettangolo L3.

#### 4B — limite strutturale da indagare

Il codice genera la lista degli offset chiusi **prima** di costruire la
polilinea reale:
- `SpiralGenerator.Generate`, blocco pre-generazione offset circa righe
  333–452;
- solo dopo, da circa riga 464, `FindConnectionWithOffset` e la percorrenza
  costruiscono la spirale aperta.

Quindi l'aborto L3 viene deciso quando `ComputeOffset` non conosce ancora:
- il punto reale di ingresso nel giro;
- la sequenza già percorsa;
- il varco lasciato dalla finalizzazione;
- il terminale reale della mandata.

Il nuovo log categorizzato ha ricostruito l'offset 2 reale:
- connessione da `(1,42 ; 4,14316)` a `(0,82 ; 4,14316)`;
- percorso:
  `(0,82;4,14316) -> (0,82;4,67) -> (-0,77;4,67) ->`
  `(-0,77;0,67) -> (0,82;0,67) -> (0,82;3,54316)`;
- tutti i candidati sono `respectConditioning=true` e `respectSelf=true`;
- terminale reale `(0,82 ; 3,54316)`;
- sul lato destro resta un'apertura esatta di **0,60 m** rispetto al punto
  di connessione `(0,82 ; 4,14316)`.

Conclusione provvisoria 4B:
- il percorso effettivamente accettato non fallisce;
- l'unico aborto avviene nella rappresentazione preventiva del *prossimo*
  livello come poligono chiuso completo;
- non è ancora dimostrato che esista una prosecuzione corretta;
- va ora individuato il **primo tratto geometricamente illegale** di una
  eventuale evoluzione successiva, partendo dallo stato reale della spirale
  e non dall'ipotesi di anello intero.

**PROSSIMO PASSO ESATTO — SOLO `locale_1`:** usare il log categorizzato per
diagnosticare, senza applicarla, la transizione dal terminale reale
`(0,82 ; 3,54316)` verso la geometria raw L3. Per ogni segmento candidato
registrare raggiungibilità e distanza minima dalla Supply già costruita,
finché si identifica il primo segmento che viola realmente `0,60 m`.
Nessun bypass, nessuna modifica geometrica e nessun altro locale.


## File/componenti attualmente coinvolti

- `src/Termodel.Core/CopiedFromTermodel/SpiraliDiegoVittorio/Spiralgenerator.cs`
- `src/Termodel.Core/CopiedFromTermodel/SpiraliDiegoVittorio/ChiudiSpirale.cs`
- `tools/Termodel.RadiantPanels.Harness/`
- `tests/radiant-harness/`
- `.github/workflows/termodel-diego-vittorio-fast.yml`
- `.github/workflows/termodel-diego-vittorio-room-extraction.yml`
- linee guida spirali e Summary Service.

## Vincoli da non violare

- `SpiraliVittorio` invariata.
- `StrategiaDiego` resta PARKED.
- Nessuna ulteriore modifica frontend, salvo interventi esplicitamente autorizzati come FASE 6A.
- Nessuna modifica a `definizionedati.json`.
- Nessun refactoring strutturale durante questa campagna.
- Nessuna strategia globale di fuga/backtracking senza consenso umano.
- Ogni correzione deve attivarsi solo nei casi non risolti dal percorso
  precedente, quando tecnicamente possibile.
- Il quadrato base deve restare byte/geometricamente invariato.
- Procedere **un locale alla volta**.

## Criteri di conclusione dell'attività

- i quattro locali rettangolari con pannello sono stati analizzati uno per uno;
- ogni locale ritenuto risolto ha una regression dedicata;
- il quadrato base resta invariato;
- Fast Harness complessivo verde;
- linee guida e Summary aggiornati con cause/correzioni realmente verificate;
- progetto completo rieseguito e sottoposto a conferma visiva utente;
- Issue #1 notificata con esito finale;
- solo allora eliminare questo file `RECOVERY-ACTIVE.md`.


### STEP 4C — identificazione visiva del punto reale da indagare
Stato: **IN CORSO — TARGET CONFERMATO DALL'UTENTE**

Conferma utente 28/09/2026:
- nel disegno pubblico il caso in esame è il locale visibile **R001**;
- nel payload/Harness corrente questo locale corrisponde a **locale_1**;
- il difetto da seguire non va cercato genericamente nel centro del locale:
  il punto visivamente significativo è la zona di **scavalcamento del punto di accesso** mostrata nel dettaglio fornito dall'utente;
- i punti di accesso/innesto sono storicamente una zona critica perché introducono una discontinuità/convessità nel percorso.

Chiarimento sugli identificatori:
- `R001` è l'identificatore/nome del locale nel disegno CAD;
- `locale_1` è l'identificatore interno sequenziale generato nel payload pannelli;
- nel progetto pubblico corrente la corrispondenza verificata è `R001 <-> locale_1`, ma i due nomi appartengono a livelli diversi e non devono essere assunti equivalenti per convenzione generale.

Nuova evidenza dal codice reale:
- `Program.GeneraSpirale` seleziona la linea di ingresso `T6` e ne calcola l'intersezione col perimetro:
  circa `(1,5693 ; 4,74316)`;
- subito dopo chiama `SpiralGenerator.Generate(perimetro, startPoint, ...)`;
- la geometria completa di `T6` **non viene passata** al generatore Supply: dentro `Generate` resta soltanto il punto di intersezione `startPoint`;
- quindi la fase Supply non possiede esplicitamente il segmento di accesso come geometria/ostacolo. Questa è ora un'ipotesi diagnostica prioritaria, non ancora una causa provata.

**PROSSIMO PASSO ESATTO — SOLO locale_1/R001:** usare `Debug_Avanzato_harness_rapido` per tracciare dal primo ingresso T6 la sequenza reale di connessione/percorrenza degli offset nella zona del punto di accesso. Registrare per ogni tratto candidato: origine, destinazione, offset, relazione col punto/segmento T6 e decisione presa. Nessuna modifica geometrica finché non viene identificata la prima decisione errata.


#### STEP 4C.1 — strumentazione accesso T6
Stato: **IMPLEMENTATA — TEST GITHUB ACTION IN CODA**

Implementazione solo diagnostica, nessuna modifica geometrica:
- commit `9923b5edad744249c47bc62284e3ae9f9d38adc2`:
  `Program.GeneraSpirale` passa al logger Supply i due estremi reali della linea di ingresso selezionata;
- commit `c3c8b254b0388588671671f152ef21ff4736cfb3`:
  `SpiralGenerator.Generate` riceve i due estremi solo come parametri diagnostici opzionali;
  registra `Supply.Access.Context`, `Supply.Access.Connection`,
  distanza/intersezione T6 su ogni `Supply.Traverse.Candidate` e
  `Supply.Access.Finalize`;
- il controllo distingue la distanza dal segmento T6 completo e dal solo tratto interno
  `startPoint -> endpoint interno`;
- i valori osservati non entrano in nessuna decisione del motore.
- commit `68e11f56acc4e83a1c100a8350f71468107bba36`:
  Fast Harness richiede i nuovi marker diagnostici nel caso categorizzato `locale_1`.

Test avviato:
- workflow `Termodel Diego_Vittorio Fast Harness` run `36438139064`, run #46;
- stato al checkpoint: **pending/in coda**.

**PROSSIMO PASSO ESATTO:** attendere il run 36438139064; se compila e il caso categorizzato passa,
leggere il log `locale_1` e isolare i segmenti che toccano/intersecano o passano vicino al tratto interno T6.
Se il run fallisce, leggere il primo errore e correggere esclusivamente la strumentazione.


#### STEP 4C.2 — primo errore causale nella zona T6
Stato: **COMPLETATO — PRIMA DECISIONE ERRATA IDENTIFICATA**

Verifica reale:
- Fast Harness run `36438139064` (#46), job `108981900699`: **SUCCESS**;
- build Harness + Core: SUCCESS;
- matrice Supply-only: SUCCESS;
- log categorizzato `locale_1`: SUCCESS;
- quadrato approvato e tutte le regression Diego_Vittorio: SUCCESS;
- nessuna geometria produttiva modificata.

Geometria accesso reale `R001 / locale_1 / T6`:
- punto sul perimetro/start Supply: `(1,57000 ; 4,74316)`;
- endpoint T6 interno al locale: `(1,31155 ; 4,74316)`;
- tratto interno fisico T6: orizzontale, lungo circa 0,25845 m.

Sequenza osservata:
1. connessione iniziale Supply:
   `(1,57000;4,74316) -> (1,42000;4,74316)`;
   coincide con T6: è il tratto iniziale comune, quindi non è un ramo remoto;
2. primo candidato:
   `(1,42000;4,74316) -> (1,42000;5,27000)`;
   parte dal tratto T6 ed è topologicamente adiacente;
3. **primo ramo non adiacente**:
   `(1,42000;5,27000) -> (-1,37000;5,27000)`;
   distanza minima dal tratto T6 = **0,52684 m**;
   distanza Supply-Supply richiesta = **0,60 m**;
   deficit = **0,07316 m**;
   il logger registra tuttavia `respectSelf=true` e il segmento viene accettato.

Causa della decisione errata:
- `SegmentoRispettaSpirale` controlla soltanto i segmenti già presenti in `spiral`;
- il tratto fisico T6 non viene inserito in `spiral`: `Generate` riceveva storicamente solo lo `startPoint`;
- quindi il ramo superiore viene accettato senza confrontarlo con il tubo di accesso reale;
- geometricamente il corridoio disponibile fra T6 e il primo offset superiore misura
  soltanto 0,52684 m, meno di 0,60 m: il problema nasce già al primo giro nella zona
  indicata dall'utente come scavalcamento del punto di accesso.

Conferma downstream:
- offset 2, primo tratto verticale e successivo orizzontale arrivano a
  **0,496964574 m** dal terminale interno T6, ancora sotto 0,60 m;
- anche questi vengono accettati perché T6 non partecipa al controllo di autocondizionamento.

Conclusione:
- il collasso preventivo L3 resta un fatto reale per un anello rettangolare completo,
  ma non è più corretto considerarlo il primo errore della Supply di `locale_1`;
- la prima decisione geometricamente incoerente col vincolo Supply-Supply è già nel
  primo giro, quando il motore percorre il lato superiore a 0,52684 m da T6;
- l'indicazione visiva dell'utente sullo scavalcamento dell'accesso è quindi confermata
  dal log numerico.

Nessuna correzione applicata.
Il prossimo intervento è una decisione algoritmica e richiede accordo umano:
trattare il tratto interno T6 come parte della Supply esistente durante la validazione,
definendo l'eccezione topologica per i segmenti iniziali realmente adiacenti e il
comportamento quando il verso iniziale non dispone dei 0,60 m richiesti.


### STEP 4D — SVG completo senza chiusura
Stato: **COMMISSIONATO / IN CORSO**

Decisione utente 28/09/2026:
- per il solo test diagnostico `R001 / locale_1 / T6`, mantenere Supply + Return autonomo;
- sospendere la chiusura centrale perché può tagliare/sostituire segmenti terminali e nascondere il difetto;
- generare uno SVG Harness pre-chiusura.

Implementazione prevista:
- non modificare l'algoritmo produttivo;
- riusare il flag già esistente `TERMODEL_DIEGO_VITTORIO_DRAW_CLOSURE=false`;
- esporlo nell'Harness con un'opzione diagnostica dedicata;
- generare artifact SVG e log del solo `locale_1`;
- confrontare visivamente e numericamente lo stato prima della chiusura.

**PROSSIMO PASSO ESATTO:** aggiungere il flag Harness, lanciare il Fast Harness sul caso `locale_1`, recuperare lo SVG pre-chiusura e renderlo disponibile all'utente.


#### STEP 4D.1 — SVG pre-chiusura generato e confronto eseguito
Stato: **COMPLETATO**

Implementazione:
- commit `50e8808769343f5500af095a5f62fd656e045173`:
  Harness Diego_Vittorio espone `--skip-close`;
- il flag è valido solo per `Diego_Vittorio`, è incompatibile con `--supply-only`
  e riusa esclusivamente `TERMODEL_DIEGO_VITTORIO_DRAW_CLOSURE=false`;
- il valore precedente della variabile d'ambiente viene ripristinato a fine run;
- nessuna modifica alla geometria produttiva del motore;
- commit `39c83fd1194acacbb5a9e129418c2f4eb828d8ac`:
  workflow Fast aggiunge il caso `DV-LOCALE1-T6-PRECLOSE` e pubblica lo SVG.

Verifica:
- GitHub Actions Fast Harness run `36441043047`, job `108991866603`: **SUCCESS**;
- build Harness + Core: SUCCESS;
- step `Generate locale_1 pre-closure SVG`: SUCCESS;
- tutte le regression Diego_Vittorio successive: SUCCESS;
- SVG SHA-256:
  `8620835cf47f6b47f55942f55ae5b628db53033557beb0eb862aaa0104bec5db`;
- SVG dichiara:
  `data-termodel-closure="disabled"`,
  `data-termodel-autonomous-return="enabled"`;
- Return autonomo mantenuto: **18 punti** prima dell'arrotondamento.

Confronto con l'esecutivo chiuso dello stesso locale:
- pre-chiusura: mandata rossa arrotondata 46 punti SVG, Return blu 66 punti SVG;
- chiuso: mandata rossa principale 46 punti SVG + collegamento rosso di chiusura 9 punti,
  Return blu ridotto a 54 punti SVG;
- log della chiusura normale:
  `M4/RP3`, lunghezza 0,60 m, `tagli=0/3`, **3,81 m rimossi dal Return**;
- quindi l'osservazione utente è confermata: la chiusura modifica effettivamente la
  geometria terminale e rimuove segmenti; il nuovo SVG pre-chiusura è il riferimento
  corretto per proseguire il debug del punto di accesso T6.

Artifact generato:
- `DV-LOCALE1-T6-PRECLOSE.svg`;
- artifact workflow `diego-vittorio-fast`, id `10979495282`.

**PROSSIMO PASSO ESATTO:** usare lo SVG pre-chiusura come riferimento visivo per
analizzare il tratto di scavalcamento T6 senza l'interferenza della chiusura.


### STEP 4E — focus decisionale sulla strettoia di scavalcamento T6
Stato: **CONTESTO DEFINITO DALL'UTENTE — ANALISI DA AVVIARE**

Contestualizzazione utente 28/09/2026, da assumere come riferimento per il debug:
- il tratto evidenziato si è posizionato correttamente alla distanza imposta dal tratto frontale a destra;
- nel punto critico l'algoritmo dovrebbe poi decidere se **girare a sinistra**;
- la situazione è particolare perché lo scavalcamento dell'accesso genera una **curva convessa** e quindi una **strettoia geometrica**;
- il problema centrale non è soltanto una distanza locale, ma la decisione fondamentale dell'algoritmo: **entrare o non entrare nella strettoia**;
- questa decisione rappresenta il cuore della valutazione di bontà del percorso.

Confronti obbligatori richiesti prima di qualsiasi correzione:
1. ricostruire cosa decide **Diego_Vittorio** nella strettoia;
2. ricostruire cosa decide **Vittorio** nella stessa situazione;
3. produrre due diagrammi decisionali separati;
4. confrontare il caso reale `R001 / locale_1 / T6` con il **progetto quadrato**, dove una situazione apparentemente equivalente funziona;
5. ancora prima, spiegare perché nel caso reale il **primo giro funziona** e il **secondo no**, pur con contesto topologico apparentemente identico;
6. verificare esplicitamente se la differenza dipende da:
   - arrotondamenti/raccordi;
   - geometria rettilinea pre-arrotondamento;
   - soglie/tolleranze numeriche;
   - ordine di costruzione e disponibilità dei segmenti nel controllo;
   - differenze fra offset 1 e offset 2;
   - differenze fra motore Vittorio e copia Diego_Vittorio.

Vincolo:
- usare come riferimento visivo lo SVG **pre-chiusura** `DV-LOCALE1-T6-PRECLOSE.svg`;
- nessuna modifica algoritmica finché i quattro confronti sopra non sono ricostruiti.

**PROSSIMO PASSO ESATTO:** leggere e confrontare i rami decisionali di Vittorio e Diego_Vittorio nelle funzioni di generazione Supply/offset/percorrenza, poi confrontare numericamente `locale_1` con il quadrato e con offset 1 vs offset 2; produrre due diagrammi decisionali e una tabella delle differenze causali.


#### STEP 4E.1 — confronto decisionale completato
Stato: **ANALISI COMPLETATA — NESSUNA CORREZIONE APPLICATA**

Verifica reale:
- Fast Harness run `36443765112` (#49): **SUCCESS**;
- commit diagnostico workflow `d391ca359906865e9289e7e6236f732cb1591aca`;
- trace Return Diego_Vittorio eseguito su `locale_1` e sul quadrato pubblico;
- riferimento Vittorio eseguito sugli stessi due casi;
- tutte le regression Diego_Vittorio successive sono rimaste verdi.

### 1. Differenza strutturale Vittorio / Diego_Vittorio

**Vittorio originale**
- genera la mandata con offset chiusi e percorrenza deterministica;
- in `ChiudiSpirale` arrotonda PRIMA la mandata con `ArrotondaSpirale`;
- il Return viene poi DERIVATO dalla mandata arrotondata tramite `CreaRientro`;
- `CreaRientro` percorre i campioni della mandata all'indietro e li trasla di
  `distanzaRitorno` lungo la normale locale;
- non esistono ricerca di corridoi, scelta entra/non entra nella strettoia,
  `SegmentoRispettaCondizionamento` o autocondizionamento Return-Return.

Conclusione: in Vittorio la strettoia non è una decisione esplicita; il Return
eredita la forma della mandata (già arrotondata).

**Diego_Vittorio**
- il Return è autonomo e viene generato sulla geometria RETTILINEA, prima
  dell'arrotondamento;
- costruisce un collegamento iniziale esplicito;
- calcola offset Return, scarta quelli paralleli troppo vicini alla Supply;
- per collegarsi all'offset successivo `FindConnectionWithOffset` prova:
  diretto, due L ortogonali, corridoi a due gomiti campionati p/2 e infine
  coordinate critiche Supply +/- p;
- ogni tratto è validato a distanza p dalla Supply e p dal Return già costruito;
- sceglie il percorso valido più corto;
- solo dopo la generazione completa `ChiudiSpirale` arrotonda Supply e Return
  per l'esecutivo SVG.

Conclusione: in Diego_Vittorio la domanda **entrare o non entrare nella
strettoia** è realmente una decisione geometrica del motore.

### 2. Perché NON è un problema di arrotondamento in Diego_Vittorio

L'arrotondamento avviene DOPO `GenerateReturn`.
Quindi le curve convesse visibili nello SVG non partecipano alla decisione:
la decisione viene presa sui segmenti ortogonali raw.

L'arrotondamento può rendere meno evidente il punto di decisione nel disegno,
ma non può essere la causa del rifiuto/accettazione in Diego_Vittorio.

In Vittorio, invece, l'arrotondamento è parte della costruzione del Return,
perché `CreaRientro` riceve la mandata già arrotondata.

### 3. Perché il primo scavalcamento funziona e il secondo è diverso

Sul `locale_1` la mandata lascia due varchi verticali destri larghi esattamente
`2p = 0,60 m`.

Primo varco:
- Supply esterna x=1,42, apertura y=4,14..4,74;
- il Return non deve scoprirlo;
- `GeneraCollegamentoRitorno` costruisce direttamente la radice
  `(1,57;4,44) -> (1,12;4,44)`, cioè sulla mezzeria esatta del varco;
- quindi il primo ingresso è **prescritto**, non selezionato dalla ricerca.

Secondo varco:
- Supply interna x=0,82, apertura y=3,54..4,14;
- mezzeria geometrica esatta: y=3,84;
- qui il Return deve invece **ritrovare** il corridoio con
  `FindConnectionWithOffset`;
- il campionamento p/2 produce, fra gli altri, y=3,82: viene respinto perché
  resta a 0,28 m dal tratto Supply (deficit 0,02 m);
- il fallback sulle coordinate critiche individua y=3,84 e consente il
  collegamento raw `(1,12;3,84) -> (0,52;3,84)`.

Quindi il contesto visivo è simile ma il contesto algoritmico NON è identico:
**primo varco = collegamento costruito a priori; secondo varco = corridoio
cercato e validato**.

Dopo il secondo scavalcamento il segmento
`(1,12;3,84) -> (0,52;3,84)` entra inoltre nella storia del Return e diventa
a sua volta ostacolo di autocondizionamento per le evoluzioni successive.
Il trace mostra, per esempio, candidati verticali successivi respinti perché
intersecano o passano a meno di p da quel segmento.

### 4. Perché il quadrato pubblico funziona

Il quadrato pubblico aveva un difetto diverso già isolato come DV-TEST-001:
- il raccordo arriva a circa `(1,18;2,82)`;
- il passo successivo è una prosecuzione COLLINEARE nello stesso verso;
- il vecchio controllo la scambiava per un ramo remoto e la respingeva;
- Diego_Vittorio ora riconosce la continuità topologica con
  `CandidatoProsegueUltimoSegmento` e applica
  `DV_RETURN_SKIP_COLLINEAR_ADJACENT`;
- trace run #49 conferma:
  `DV_RETURN_SKIP_ZERO candidate=(1.18,2.82)`
  e
  `DV_RETURN_SKIP_COLLINEAR_ADJACENT ... (1.18,2.82)->(1.18,1.18)`.

Nel `locale_1`, invece, lo scavalcamento richiesto è una svolta/corridoio
ortogonale attraverso un'apertura esatta 2p; non è una semplice prosecuzione
collineare e quindi la regola che salva il quadrato non descrive questo caso.

### 5. Esito riferimenti Vittorio

Run #49, stesso input:
- Vittorio `locale_1`: 28 punti, SVG SHA
  `50a67c7cf7958c966381a399139c23c9ebaef7fb46761f0aea6a3753db83feae`;
- Vittorio quadrato pubblico: 33 punti, SVG SHA
  `0688a4e4bed2a7e07ad84174f1862c6a95df544d52853a6ecbcd2742e3cfdb1a`.

Questi risultati non sono direttamente comparabili punto-per-punto col Return
autonomo Diego_Vittorio perché Vittorio costruisce il rientro per offset dei
campioni della mandata arrotondata, non mediante la stessa macchina decisionale.

**CONCLUSIONE OPERATIVA:** prima di correggere, il focus deve restare sulla
macchina decisionale Diego_Vittorio nel passaggio fra offset: riconoscere la
strettoia 2p, distinguere adiacenza topologica da ostacolo remoto e decidere se
il corridoio è realmente percorribile. L'arrotondamento non è la causa nel
motore Diego_Vittorio.


### STEP 4F — mappa del codice che valuta le strettoie
Stato: **COMPLETATO — ANALISI FUNZIONALE, NESSUNA MODIFICA AL MOTORE**

Incarico utente:
- identificare prima di ogni correzione quali porzioni di codice valutano le
  strettoie in Vittorio e Diego_Vittorio;
- confrontare i due flussi decisionali.

Verifiche:
- `SpiraliVittorio/Spiralgenerator.cs` Service è byte-per-byte identico al
  riferimento Desktop
  `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Spiralgenerator.cs`;
- anche `SpiraliVittorio/ChiudiSpirale.cs` è identico al Desktop.

Esito Vittorio:
- `ComputeOffset`: filtro locale su lato corto + contrazione;
- soglie `minEdgeLength`: arresto locale di un nuovo anello;
- `FindIntersectionWithOffset` + controllo `isTooCloseToSpiral`: sola
  euristica sul gomito di connessione;
- una volta entrato nell'offset, percorre tutti i vertici senza valutare
  conseguenze future;
- `CreaRientro` deriva il Return dalla mandata già arrotondata: nessuna
  decisione autonoma entra/non entra nella strettoia.

Esito Diego_Vittorio:
- eredita i filtri Supply di Vittorio;
- il Return autonomo decide localmente con:
  `OffsetHaTrattoParalleloTroppoVicino`,
  `FindConnectionWithOffset`,
  `ConnectionPathIsValid`,
  `SegmentoRispettaCondizionamento`,
  `SegmentoRispettaSpirale`,
  `FindConnectionWithTerminalTrim`,
  `TrovaMassimoPrefissoValido`;
- `FindConnectionWithOffset` è oggi il cuore della decisione di ingresso:
  genera una famiglia finita di corridoi e sceglie il percorso valido più
  corto, ma non valuta cosa succede dopo l'ingresso;
- `ProvaPortaleAnticipato` con `TracePortalsEnabled` è già un look-ahead
  diagnostico di un offset, ma oggi non influenza la geometria.

Conclusione:
- Vittorio non possiede una vera macchina decisionale di strettoia per il
  Return;
- Diego_Vittorio possiede una macchina locale di ricerca/validazione, ma non
  ancora una funzione di convenienza a medio raggio;
- il punto di estensione naturale è
  `FindConnectionWithOffset + traversal`, non l'arrotondamento.

Linee guida aggiornate:
- `LG-050 — Strettoie: decisione a visione media, non solo locale`;
- commit `b4c948582094f072d93f0014eee0a3f3d054c266`.

**PROSSIMO PASSO ESATTO:** fase interattiva: scegliere un singolo punto di
strettoia nel `locale_1` e seguire, chiamata per chiamata, quali candidati
`FindConnectionWithOffset` costruisce, quali vengono respinti, quale viene
premiato e quale informazione sul futuro manca al momento della scelta.


## CONSAPEVOLEZZA OPERATIVA OBBLIGATORIA PER LA CHAT SUCCESSIVA

Questa sezione è intenzionalmente ridondante rispetto ai checkpoint precedenti:
serve a riportare rapidamente una nuova chat allo stesso livello di comprensione
raggiunto nell'analisi corrente, senza ricostruzioni interpretative.

### Modello mentale del problema

Il problema da risolvere NON è:
- “questo singolo segmento passa oppure no?”;
- “la curva arrotondata è troppo vicina?”;
- “il secondo giro è uguale al primo e quindi dovrebbe comportarsi uguale?”.

Il problema corretto è:
> **quando Diego_Vittorio incontra una strettoia, una scelta può essere
> localmente valida ma strategicamente cattiva perché compromette i passi
> successivi. Serve quindi distinguere validità locale e convenienza a medio
> raggio.**

La StrategiaDiego completa avrebbe risolto il problema esplorando un albero di
rami alternativi e premiando la soluzione globalmente migliore, soprattutto
per lunghezza utile di tubazione. Questo approccio è stato sospeso perché troppo
costoso computazionalmente.

Diego_Vittorio deve quindi restare una strategia intermedia:
- più intelligente di Vittorio nelle strettoie;
- visione più ampia del solo prossimo segmento;
- niente tree-search combinatorio completo;
- euristiche finite, deterministiche e a costo controllato.

### Cosa fa Vittorio

Vittorio NON possiede una vera decisione “entro/non entro nella strettoia” sul
Return:
- `ComputeOffset` e `minEdgeLength` filtrano localmente la formazione degli
  anelli;
- `FindIntersectionWithOffset` usa una connessione semplice e una piccola
  euristica sul gomito;
- una volta raggiunto un offset, lo percorre;
- `CreaRientro` deriva il Return dalla Supply già arrotondata.

Quindi Vittorio è un riferimento geometrico/storico, non un motore con ricerca
autonoma della miglior scelta nella strettoia.

### Cosa fa Diego_Vittorio

La macchina decisionale corrente del Return è:
1. `FindConnectionWithOffset` genera percorsi candidati finiti;
2. `ConnectionPathIsValid` li verifica;
3. `SegmentoRispettaCondizionamento` controlla Supply;
4. `SegmentoRispettaSpirale` controlla Return già costruito;
5. tra i candidati validi `FindConnectionWithOffset` sceglie oggi il
   **più corto**;
6. la successiva percorrenza dell'offset continua finché il prossimo tratto è
   localmente valido;
7. non viene ancora premiato o penalizzato il candidato in base a ciò che
   succederà 1-N decisioni dopo.

`ProvaPortaleAnticipato`, sotto `TracePortalsEnabled`, è già un embrione di
look-ahead: verifica se dal punto corrente esiste un collegamento al prossimo
offset, ma oggi produce solo diagnostica e NON modifica la scelta.

### Caso R001 / locale_1 / T6 da non reinterpretare

Riferimento visivo:
- usare lo SVG `DV-LOCALE1-T6-PRECLOSE.svg`;
- chiusura centrale disabilitata perché rimuove segmenti e maschera il fenomeno.

Punti già stabiliti:
- il primo scavalcamento e il secondo sono simili visivamente ma NON equivalenti
  algoritmicamente;
- primo scavalcamento: la mezzeria del varco viene costruita direttamente da
  `GeneraCollegamentoRitorno`;
- secondo scavalcamento: deve essere scoperto da `FindConnectionWithOffset`;
- sul secondo varco il campione y=3,82 è invalido (0,28 m < p=0,30), mentre la
  coordinata critica y=3,84 è valida;
- il passaggio raw valido è
  `(1,12;3,84) -> (0,52;3,84)`;
- dopo essere stato aggiunto, questo stesso segmento entra nella storia del
  Return e può diventare ostacolo per le decisioni successive;
- il quadrato pubblico è un caso diverso: lì il problema era una prosecuzione
  collineare risolta da `CandidatoProsegueUltimoSegmento` /
  `DV_RETURN_SKIP_COLLINEAR_ADJACENT`;
- l'arrotondamento NON causa la decisione Diego_Vittorio perché avviene dopo
  `GenerateReturn`.

### Ipotesi di lavoro corrente — NON ancora regola

Il limite probabile non è che Diego_Vittorio non trovi il varco: nel caso
`locale_1` il secondo varco viene trovato. Il limite da verificare è che la
scelta viene premiata con criteri troppo locali (validità + lunghezza del
collegamento) senza valutare abbastanza ciò che rimarrà percorribile dopo.

NON trasformare questa ipotesi in una correzione senza trace causale.

### Prossimo debug esatto

Sul singolo punto di strettoia del `locale_1`:
1. enumerare TUTTI i candidati prodotti da `FindConnectionWithOffset`;
2. per ciascuno registrare:
   - geometria completa del path;
   - lunghezza;
   - validità Supply;
   - validità Self;
   - motivo preciso di eventuale rigetto;
3. identificare il candidato oggi vincente e il criterio con cui viene premiato;
4. per ogni candidato localmente valido eseguire SOLO diagnosticamente una
   previsione finita:
   - esiste un portale verso l'offset successivo?
   - quanti segmenti/vertici successivi risultano immediatamente percorribili?
   - quale margine minimo resta rispetto a Supply e Return?
5. confrontare il vincitore locale con almeno un'alternativa valida;
6. NON cambiare ancora il motore;
7. solo dopo questi numeri proporre un'euristica di “media visione”.

Obiettivo del debug:
> capire quale informazione sul futuro manca esattamente nel momento in cui
> `FindConnectionWithOffset` sceglie il percorso più corto.

Questa è la conoscenza minima che una chat di recovery deve possedere prima di
toccare il codice.


### STEP 4G — nuova analisi strutturale strettoie, prima dei nuovi log
Stato: **IN CORSO**

Decisione utente:
- ripartire con una nuova analisi dopo il consolidamento concettuale;
- aggiungere nuovi log solo se la comprensione del software è sufficiente;
- tenere esplicitamente conto che `Diego_Vittorio` è stato scritto interamente da AI a partire da una copia di Vittorio, quindi ogni euristica aggiunta va distinta dal comportamento ereditato.

Metodo:
1. mappa di provenienza funzione-per-funzione:
   - invariato da Vittorio;
   - adattato;
   - nuovo codice AI;
2. ricostruzione del flusso strettoie senza modificare il motore;
3. uso prioritario dei log già esistenti (`TRACE_RETURN`, `TRACE_PORTALS`, log Supply);
4. solo se restano buchi causali, introdurre log diagnostici minimi e non decisionali;
5. nessuna correzione algoritmica in questa fase.

**PROSSIMO PASSO:** confrontare Vittorio/Diego_Vittorio sulle funzioni
`GenerateReturn`, `FindConnectionWithOffset`, validatori, traversal,
portali anticipati e fallback, quindi lanciare un test mirato con i trace già
esistenti su `R001 / locale_1 / T6` e sul quadrato pubblico.


#### STEP 4G.1 — trace esistente dei portali: primo risultato decisivo
Stato: **COMPLETATO**

Nessun log nuovo nel motore in questa fase. È stato attivato soltanto il trace
già esistente `TERMODEL_DIEGO_VITTORIO_TRACE_PORTALS=true` nel Fast Harness.

Riferimenti:
- commit workflow `5ecf0d1b7a59c49e11d914fc3c270bb99585b01f`;
- Fast Harness run `36461086582` (#50): **SUCCESS**;
- tutte le regression successive: SUCCESS.

Risultato `R001 / locale_1 / T6`:
- offset 1 -> offset 2: il primo portale utile viene trovato durante la
  percorrenza, da `(1,12;0,37)` verso `(0,52;4,37)`, lunghezza 4,60 m;
- **offset 2 -> offset 3: un portale valido esiste già all'INGRESSO
  dell'offset 2**, da `(0,52;4,37)` verso `(0,22;4,07)`,
  lunghezza 0,60 m, pathPoints=2;
- nonostante questo, `ProvaPortaleAnticipato` è solo diagnostica:
  il motore non usa il portale trovato e continua a percorrere l'offset 2;
- subito dopo compaiono numerosi rifiuti Self causati anche dal segmento
  di scavalcamento `(1,12;3,84)->(0,52;3,84)`, ormai entrato nella memoria
  geometrica del Return.

Confronto quadrato pubblico:
- offset 1 -> 2: portale trovato solo DURANTE la percorrenza;
- offset 2 -> 3: portale trovato solo DURANTE la percorrenza, non all'ingresso;
- quindi il quadrato non presenta la stessa opportunità immediata del
  `locale_1`.

Interpretazione corrente, ancora diagnostica:
- il caso `locale_1` mostra già nel codice una informazione di medio raggio
  utile che viene calcolata e poi ignorata;
- il problema potrebbe quindi non essere soltanto “scegliere male il
  collegamento verso l'offset corrente”, ma anche “continuare troppo a lungo
  sull'offset corrente quando esiste già una uscita valida verso il successivo”.

Questa è un'ipotesi causale forte, NON ancora una regola produttiva.

**PROSSIMO PASSO:** aggiungere solo diagnostica non decisionale, dietro
`TRACE_RETURN`, per registrare:
- il path realmente scelto per entrare in ogni offset;
- ogni tratto realmente accettato durante la percorrenza;
- il path geometrico del portale anticipato.
Poi rieseguire `locale_1` e quadrato per confrontare il ramo effettivo con
l'uscita anticipata già disponibile.


#### STEP 4G.2 — trace non decisionale del ramo effettivo
Stato: **COMPLETATO**

Sono stati aggiunti esclusivamente log dietro `TRACE_RETURN` /
`TRACE_PORTALS`, senza alterare condizioni, tolleranze, ordinamento o
geometria:
- `DV_RETURN_CONNECTION_CHOSEN`: path realmente scelto per entrare in ogni offset;
- `DV_RETURN_TRAVERSE_ACCEPT`: segmenti realmente accettati sulla percorrenza;
- `DV_RETURN_PORTAL_FOUND`: ora include anche il path geometrico del portale.

Commit diagnostico:
- `9a7abdeef2cd76ab36e4b36b4240bc66fc8a1ade`.

Verifica:
- Fast Harness run `36461538127` (#51): **SUCCESS**;
- tutte le regression Diego_Vittorio successive: SUCCESS.

### Ramo effettivo locale_1 / Return

Offset 1:
- ingresso: `(1,12;4,44)`;
- percorre quasi integralmente l'anello esterno;
- da `(1,12;0,37)` trova il primo portale verso offset 2:
  `[(1,12;3,84);(0,52;3,84);(0,52;4,37)]`, lunghezza 4,60 m;
- questo stesso path viene poi scelto realmente per entrare in offset 2.

Offset 2:
- ingresso reale `(0,52;4,37)`;
- **prima di percorrere un solo lato**, esiste già un portale valido verso
  offset 3:
  `[(0,22;4,37);(0,22;4,07)]`, lunghezza 0,60 m;
- il motore lo ignora perché il portale è solo diagnostico;
- percorre invece:
  `(0,52;4,37)->(-0,47;4,37)->(-0,47;0,97)->(0,52;0,97)`;
- soltanto da `(0,52;0,97)` entra davvero nell'offset 3 con:
  `[(0,52;1,27);(0,22;1,27)]`, lunghezza 0,60 m.

Offset 3:
- percorre:
  `(0,22;1,27)->(0,22;4,07)->(-0,17;4,07)->(-0,17;1,27)`;
- la finalizzazione conserva poi il terminale ammesso.

### Confronto col quadrato

Nel quadrato:
- i portali verso l'offset successivo compaiono DURANTE la percorrenza;
- il motore continua comunque fino al proprio terminale storico e poi usa un
  collegamento diverso/più corto verso l'offset successivo;
- quindi anche nel quadrato il trace anticipato non guida la scelta, ma il
  contesto regolare non produce l'intrappolamento osservato nel caso reale.

### Nuova comprensione architetturale

`Diego_Vittorio` è un ibrido:
- ha aggiunto con AI una ricerca intelligente del collegamento fra offset
  (`FindConnectionWithOffset`);
- ma conserva da Vittorio la regola strutturale “una volta entrato
  nell'offset, percorri i vertici nel verso prefissato finché puoi”.

Questo accoppiamento è il punto sospetto:
il collegamento fra offset è diventato adattivo, mentre la decisione
**quando abbandonare l'offset corrente** è rimasta sostanzialmente
deterministica e locale.

Non è ancora dimostrato che il portale anticipato vada preso appena appare:
farlo subito potrebbe ridurre inutilmente la lunghezza di tubo. Il problema
da misurare è piuttosto il **momento ultimo conveniente/sicuro di uscita**.

**PROSSIMO PASSO:** test diagnostico già supportato dal codice, senza nuove
modifiche geometriche: invertire globalmente il verso di costruzione del Return
(`TERMODEL_DIEGO_VITTORIO_DIAG_REVERSE_BUILD_DIRECTION=true`) su locale_1 e
quadrato. Scopo: separare il problema “verso di percorrenza” dal problema
“momento di uscita dall'offset”.


#### STEP 4G.3 — inversione globale del verso: esclusa come causa principale
Stato: **COMPLETATO**

Test diagnostico con flag già esistente:
`TERMODEL_DIEGO_VITTORIO_DIAG_REVERSE_BUILD_DIRECTION=true`.

Riferimenti:
- commit workflow `1975df1396507227423e0bccb8f87f3f76b1c2ca`;
- Fast Harness run `36462013287` (#52): **SUCCESS**;
- tutte le regression normali successive: SUCCESS.

Esito con verso di costruzione invertito:
- `locale_1`: il Return entra nell'offset 1 ma non trova alcun tratto
  percorribile; offset 2 e 3 non trovano collegamento; Return finale = 2 punti;
- quadrato pubblico: stesso comportamento, Return finale = 2 punti.

Conclusione:
- il difetto di `locale_1` NON si risolve invertendo globalmente il verso;
- il verso corrente è strutturalmente coerente con il raccordo iniziale e con
  l'ordine dei vertici degli offset;
- la questione resta **quando abbandonare l'offset corrente**, non il semplice
  senso orario/antiorario globale.

Questo test evita di introdurre una falsa soluzione basata sul “girare
dall'altra parte”.

**PROSSIMO PASSO:** estendere esclusivamente la diagnostica `TRACE_PORTALS`
per non fermarsi al primo portale trovato: a ogni ingresso e dopo ogni tratto
accettato registrare se il prossimo offset è ancora raggiungibile, il path e
la sua lunghezza. Obiettivo: ricostruire la finestra temporale
`primo portale -> ultimo portale ancora valido` e confrontarla fra
`locale_1` e quadrato.

#### STEP 4G.4 — finestra dei portali misurata
Stato: **COMPLETATO — NESSUNA CORREZIONE AL MOTORE**

Diagnostica aggiunta:
- commit `de2dfde7d7cba1599c48bfe976ea7626a36ca123`;
- solo sotto `TRACE_PORTALS`, il controllo viene eseguito a ingresso e dopo
  ogni tratto accettato, registrando `found/none`, path e lunghezza;
- nessuna condizione, tolleranza, ordinamento o geometria modificata.

Fast Harness:
- run `36462466585` (#53): **SUCCESS**;
- build Harness + Core: SUCCESS;
- tutte le regression Diego_Vittorio: SUCCESS.

Risultato `locale_1`, offset 2 -> 3:
- ingresso `(0,52;4,37)`: portale valido 0,60 m;
- `(-0,47;4,37)`: portale valido 0,60 m;
- `(-0,47;0,97)`: portale valido 0,60 m;
- `(0,52;0,97)`: portale valido 0,60 m e poi realmente scelto.

Quindi il passaggio al livello successivo NON viene perso durante il giro.
L'ipotesi semplice “bisogna uscire appena compare il portale” è smentita:
l'algoritmo può percorrere tutto l'offset e conserva comunque una uscita valida.

Quadrato:
- offset 1->2: none, none, none, found, found;
- offset 2->3: none, none, found, found;
- continuare fino all'ultimo punto mantiene il portale e riduce la lunghezza
  del collegamento finale.

Comprensione aggiornata:
- `Diego_Vittorio` ha una parte AI adattiva per trovare i collegamenti;
- la percorrenza ereditata da Vittorio è deterministica, ma in questi due casi
  non distrugge il portale verso il livello successivo;
- la futura “media visione” non deve premiare il primo portale in modo cieco;
- occorre trovare il punto in cui la prosecuzione futura **peggiora davvero**
  (portale perso, margine ridotto, ramo futuro accorciato/bloccato, minor
  lunghezza utile globale).

Verifica Service generale sul commit diagnostico:
- `dotnet build` nello workflow Service: **SUCCESS**;
- il workflow completo `36462466657` risulta FAILURE in uno smoke idraulico
  indipendente dalla geometria spirali: Golden Darcy atteso dP=1,353675 Pa,
  osservato dP=1,3136749 Pa (flow e Reynolds entro i valori attesi);
- non è stata modificata in questo job alcuna logica Darcy/idraulica.

Pulizia:
- il test temporaneo di inversione globale del verso è stato rimosso dal
  workflow dopo aver concluso la diagnosi, commit
  `785cadb3ed4822713be0b8df57ef31724b432a72`;
- i log `TRACE_RETURN/TRACE_PORTALS` restano disponibili solo su richiesta.
- Fast Harness di pulizia `36463116793` (#54): **SUCCESS**, confermando il workflow senza il test temporaneo.

Linee guida aggiornate con l'evidenza della finestra portali:
- commit `49f02ded2d6306dd3981b47c670893ded1def3a4`.

**PROSSIMO PASSO INTERATTIVO:** ritornare al particolare visivo indicato
dall'utente e identificare con coordinate/colore quale svolta è giudicata
errata. Il trace dimostra che, per il Return offset 2->3, la svolta a sinistra
avviene e il portale resta valido; quindi non attribuire automaticamente il
difetto a quel passaggio. Una volta identificato il tratto esatto, seguire
solo la catena di decisione che lo genera.


### STEP 4H — revisione critica della storia Diego_Vittorio
Stato: **PRIMA AUTOPSIA STORICA COMPLETATA — NESSUNA CORREZIONE APPLICATA**

Nuova chiave stabilita dall'utente:
- `Diego_Vittorio` doveva nascere come copia fedele di Vittorio, resa astratta
  per poter applicare lo stesso algoritmo indipendentemente alla Supply e al Return;
- dopo l'astrazione iniziale sono emerse anomalie;
- molte anomalie sono state interpretate come difetti già presenti in Vittorio;
- sono quindi state introdotte numerose correzioni/migliorie;
- oggi `Diego_Vittorio` appare instabile anche in casi in cui Vittorio è stabile;
- missione corrente: determinare quali anomalie erano realmente ereditate e quali
  sono state introdotte o amplificate dalla copia/astrazione AI.

Prima ricostruzione verificata:
1. commit `d4f4a57ab8b373ff7382585084d3f31b719adb83`
   - creazione `Diego_Vittorio`;
   - copia indipendente di Vittorio con solo namespace separato;
   - parità iniziale dichiarata e verificata su rettangolare e concavo;
   - `Spiralgenerator.cs`: ~272 righe, sostanzialmente copia del Vittorio da ~270.
2. commit `faa8c7122f45f6700b26b9e3bcb8581ce0081771`
   - prima deviazione semantica intenzionale:
     separazione `distanzaParete` e `passoMandata`,
     parete Supply = p/2, Supply-Supply = 2p, Supply-Return = p;
   - la struttura dell'algoritmo resta ancora quasi quella Vittorio;
   - `ComputeOffset` e `FixIntersections` risultano ancora identici al riferimento.
3. commit `9c311cb96738c2c82d3da5a1f5d3b4c533f036b0`
   - salto architetturale principale;
   - `Spiralgenerator.cs` passa da ~287 a ~987 righe;
   - introdotto Return autonomo;
   - `Generate` non è più soltanto parametrizzato: riceve direzione, tratto iniziale,
     linee di condizionamento e autocondizionamento;
   - `FindIntersectionWithOffset` viene di fatto sostituito nel percorso operativo da
     `FindConnectionWithOffset`, che esplora più collegamenti e sceglie il valido più corto;
   - la percorrenza storica "raggiungi l'offset e percorri tutti i vertici" viene sostituita
     da validazione tratto-per-tratto con arresto sul primo tratto non valido;
   - aggiunti `SegmentoRispettaCondizionamento`, `SegmentoRispettaSpirale`,
     `TrovaMassimoPrefissoValido`, `OffsetHaTrattoParalleloTroppoVicino`;
   - `ChiudiSpirale` smette, nel percorso autonomo, di derivare il Return dalla Supply
     arrotondata con `CreaRientro` e usa invece `GenerateReturn`.
   Questa fase non è più una semplice astrazione di Vittorio ma una nuova strategia AI.
4. dal 28/09 in poi
   - i fix DV-TEST-001/002 (zero segment, adiacenza collineare, dogleg locale,
     corridoi fallback, terminal trim, ecc.) sono correzioni di anomalie osservate
     dentro questa nuova macchina decisionale, non prove che Vittorio possedesse
     gli stessi difetti.

Punto metodologico:
- non assumere più che un difetto di Diego_Vittorio sia un difetto di Vittorio;
- per ogni anomalia va verificata prima la parità del comportamento Vittorio;
- il test chiave deve essere una **prova di equivalenza della generalizzazione**:
  la versione astratta, con condizionamenti disabilitati e parametri equivalenti,
  deve riprodurre Vittorio prima di poter essere usata come base affidabile per
  Supply e Return.

**PROSSIMO PASSO ESATTO:** costruire un confronto di equivalenza sul solo
`SpiralGenerator.Generate`: stesso perimetro, stesso start, stessa distanza,
nessun condizionamento. Confrontare Vittorio e Diego_Vittorio prima delle
euristiche Return. Se divergono, isolare la prima istruzione/decisione diversa.


### STEP 4I — nuovo ramo pulito Vittorio_revisionato
Stato: **FASE 1 IMPLEMENTATA — TEST EQUIVALENZA IN ESECUZIONE**

Commissionato:
1. creare una nuova copia pulita di Vittorio denominata
   `Vittorio_revisionato`;
2. verificare subito equivalenza sul quadrato;
3. soltanto dopo, astrarre strutturalmente l'algoritmo per poterlo applicare
   in modo indipendente a Supply e Return;
4. il Return dovrà poter ricevere la Supply come linea condizionante;
5. fermarsi dopo il secondo test e ragionare insieme prima di introdurre
   euristiche ulteriori.

Implementato finora:
- nuova cartella
  `CopiedFromTermodel/SpiraliVittorioRevisionato/`;
- i quattro sorgenti derivano direttamente da `SpiraliVittorio` e nella
  fotografia iniziale cambia esclusivamente il namespace;
- facciata `StrategiaVittorioRevisionatoBenchmark`;
- selettore Harness `Vittorio_revisionato`;
- caso quadrato
  `LG041-SQUARE4X4-T1-P030-VITTORIO-REVISIONATO.json`;
- workflow Fast confronta SHA-256 di SVG e XML fra Vittorio e
  Vittorio_revisionato e fallisce su qualsiasi differenza;
- `TERMODEL-SYNC.md` aggiornato.

Run equivalenza iniziale:
- Fast Harness run `36465275147` (#56);
- al momento del checkpoint: PENDING.

Vincolo: nessuna modifica strutturale prima di esito SUCCESS della parità iniziale.


#### STEP 4I.1 — parità iniziale confermata e astrazione strutturale introdotta
Stato: **FASE 1 COMPLETATA / FASE 2 IN TEST**

Parità iniziale:
- Fast Harness run `36465582271` (#57): **SUCCESS**;
- step `Verify Vittorio_revisionato initial equivalence`: SUCCESS;
- SVG Vittorio e Vittorio_revisionato identici:
  `9673CD8D77A9963EC425FA69F54B8DCFF4C162312336D08D74AC722A2E0122A4`;
- XML risultato identico:
  `9517A5BFFE56F7CCB2419F173A0020FAC0EEBF6B2FD3706C02CD29D32C0DDCA6`;
- tutte le regression Diego_Vittorio della stessa run sono rimaste verdi.

Astrazione introdotta:
- `SpiralGenerationInput` è un ingresso neutro rispetto al ruolo;
- il metodo storico `Generate(List<Punto>, Punto, double, bool)` è rimasto
  letteralmente intatto e continua a essere il core usato da Program;
- il nuovo overload `Generate(SpiralGenerationInput)` richiama prima il
  Generate storico;
- opzionalmente riceve `LineeCondizionamento` e
  `DistanzaCondizionamento`;
- il condizionamento iniziale è deliberatamente minimale: tronca il percorso
  al primo segmento che viola la distanza dalla Supply;
- NON cerca percorsi alternativi, NON introduce fallback, NON cambia la
  selezione geometrica Vittorio;
- questa scelta serve a separare nettamente “astrazione” da “strategia nelle
  strettoie”.

Probe aggiunto:
- verifica che l'ingresso neutro senza condizionamento produca punto-per-punto
  lo stesso percorso del Generate storico;
- genera un secondo percorso indipendente e verifica che la Supply lo
  condizioni realmente a distanza p/2;
- Harness command `revisionato-check`;
- workflow Fast ora verifica sia la parità completa Vittorio sia il probe.

**PROSSIMO PASSO:** attendere il run Fast della fase 2. Se verde, fermarsi e
ragionare con l'utente sui risultati prima di integrare il Return nel flusso
esecutivo o aggiungere qualunque strategia di rerouting.


#### STEP 4I.2 — test finale dell'astrazione: STOP PER DISCUSSIONE
Stato: **COMPLETATO — FERMARSI QUI PRIMA DI NUOVE STRATEGIE**

Sorgente testato:
- `a1e86149577116ea6abc5d6009a3ebec0f52ff28`
  `refactor(radiant): integra gate condizionante nel core Vittorio_revisionato`.

Fast Harness:
- run `36466606034` (#62): **SUCCESS**;
- Build Harness + Core: SUCCESS;
- parità iniziale Vittorio/Vittorio_revisionato: SUCCESS anche dopo
  l'astrazione;
- SVG SHA-256:
  `9673CD8D77A9963EC425FA69F54B8DCFF4C162312336D08D74AC722A2E0122A4`;
- XML SHA-256:
  `9517A5BFFE56F7CCB2419F173A0020FAC0EEBF6B2FD3706C02CD29D32C0DDCA6`;
- probe astrazione:
  - `neutralEquivalent=true`;
  - `supplyPoints=37`;
  - `unconditionedReturnPoints=38`;
  - `conditionedReturnPoints=1`;
  - `conditioningDistance=0.15`;
- tutte le regression Diego_Vittorio della run: SUCCESS.

Service Build dello stesso commit:
- build: SUCCESS;
- smoke pannelli precedente: SUCCESS;
- workflow complessivo FAILED nello smoke HTTP sul **golden Darcy sintetico
  fuori tolleranza**, non su Vittorio_revisionato.

Conclusione da preservare:
- la copia pulita riproduce Vittorio;
- l'astrazione neutra non rompe Vittorio;
- il semplice riuso dello stesso algoritmo una seconda volta, con Supply come
  vincolo hard, si blocca quasi immediatamente: 38 punti senza vincolo -> 1
  punto con vincolo;
- questo NON dimostra che Vittorio sia errato;
- dimostra che “Vittorio due volte + vincolo Supply” non definisce ancora un
  Return autonomo geometricamente utilizzabile;
- non introdurre adesso rerouting, corridoi, fallback o fix di Diego_Vittorio.

Documenti aggiornati:
- `SpiraliVittorioRevisionato/README.md`;
- `CopiedFromTermodel/TERMODEL-SYNC.md`;
- `PROJECT-SUMMARY-SERVICE.md`.

**RECOVERY POINT / PROSSIMA CONVERSAZIONE:** ragionare con l'utente su quale
debba essere la minima differenza strutturale del secondo percorso rispetto alla
Supply (punto/radice di partenza, lato e verso di percorrenza, ordine degli
offset, distanza di generazione/condizionamento). Nessuna implementazione prima
di questa decisione.


### STEP 4J — correzione procedura: collaudo multi-progetto e pubblicazione
Stato: **COMMISSIONATO / IN CORSO**

Nuova decisione utente:
1. il quadrato da solo non è una base sufficiente;
2. confrontare `Vittorio_revisionato` con Vittorio su più casi reali e
   sintetici già disponibili;
3. se l'equivalenza multi-progetto è confermata, pubblicare il motore come
   scelta di test nel Service/Frontend pubblico;
4. mantenere `Diego_Vittorio` come default;
5. fermarsi se emerge una divergenza;
6. segnalare la conclusione su Issue #1.

Set minimo previsto per FASE 1:
- quadrato 4x4;
- concavo L;
- trapezio obliquo;
- connection-terminal;
- appartamento corrente preparato;
- progetto pubblico Pannelli radianti completo.

Confronto richiesto per ogni caso:
- esecuzione Vittorio;
- esecuzione Vittorio_revisionato;
- SHA-256 SVG;
- SHA-256 XML risultante.

FASE 2 prevista solo dopo FASE 1 verde:
- query per-request `spiralEngine=Vittorio_revisionato`;
- selezione frontend pubblica esplicita;
- provenienza runtime coerente con il motore richiesto;
- build/regression/deploy pubblico.


#### STEP 4J.1 — FASE 1 collaudo multi-progetto completata
Stato: **COMPLETATO — EQUIVALENZA CONFERMATA SU 6 CASI**

Fast Harness:
- run `36503404032` (#64): **SUCCESS**;
- Build Harness + Core: SUCCESS;
- step `Verify Vittorio_revisionato multi-project equivalence`: SUCCESS;
- tutte le regression Diego_Vittorio successive: SUCCESS.

Confronto Vittorio vs Vittorio_revisionato, SVG + XML byte-identici:
- `square-4x4`:
  SVG `9673CD8D77A9963EC425FA69F54B8DCFF4C162312336D08D74AC722A2E0122A4`;
  XML `9517A5BFFE56F7CCB2419F173A0020FAC0EEBF6B2FD3706C02CD29D32C0DDCA6`;
- `concave-l`:
  SVG `8B969D9C25D5EB20F759EF6C0BF9407A190F87F770D01D776EFD7E6DEE80EB0C`;
  XML `3187DCA854CEE0BF7FA8313FCDC1640EF12C6F8E1A3886B4DBD4403ED0387E23`;
- `oblique-trapezoid`:
  SVG `9C2A4934ABE4C6715801DEE649A373D3C0EED720121FF8B200AEDA37C0E9BAA0`;
  XML `4535E93D4AAB0D08FB86CED3A595307E3F2FEB55B880DD1DDB3ACE966A6C1772`;
- `connection-terminal`:
  SVG `954C1952BA521452572CBFF449066F044AE33DA864CDB7B00185AD421DFA2CFA`;
  XML `5BA66E35EB23F32B5F05A32C78F674E00F7DF7C3496DF67B6A23F8AFC6233BB3`;
- `current-apartment`:
  SVG `90A8695EFFFF896587742ADD4D785ACD060DC71ED533A6DF6C9779D7B6E057C6`;
  XML `07221BD4633D0A2726054EF6D578B67C414779C7B1EB5383C9AD389CAA410442`;
- `public-radiant-panels` completo:
  SVG `41E7E4D89BE381FA8C1C9704C6CBCC87C052EF0206322733DF78CEF30FD5A222`;
  XML `2E89EE98F7065C93911096650CFC1C9D5546CB0DD89823C46686B8ECA32E2A13`.

Conclusione procedurale:
- il precedente collaudo sul solo quadrato è superato;
- la base `Vittorio_revisionato` è ora confrontata su casi rettangolari,
  concavi, obliqui, terminali e due progetti complessi;
- è autorizzata la FASE 2 di pubblicazione come motore **selezionabile per
  richiesta**, senza cambiare il default `Diego_Vittorio`.

**PROSSIMO PASSO:** implementare selezione per-request nel Service, selettore
pubblico Web e provenienza esecutivo col motore realmente usato; poi build,
regression e verifica deploy Render + Pages.


#### STEP 4J.2 — FASE 2 pubblicata e verificata
Stato: **COMPLETATO — PRONTO PER COLLAUDO COLLABORATIVO**

Implementato:
- Service: selezione per-request
  `spiralEngine=Vittorio_revisionato`;
- nessuna mutazione globale dell'environment e nessuna modifica al file
  progetto;
- default mantenuto `Diego_Vittorio`;
- `/health` espone anche l'elenco `spiralEngines`;
- risposta calcolo e responseArtifact espongono il motore effettivamente usato;
- frontend pubblico v1.36: selettore Help → Motore spirali — test pubblico;
- provenienza esecutivo runtime usa il motore della singola elaborazione;
- contratto Front/Service aggiornato.

Test:
- Fast multi-progetto #64 `36503404032`: SUCCESS su 6 casi;
- Fast post-esposizione Core #65 `36503807860`: SUCCESS;
- Service Build #1067 `36504429395`:
  - build: SUCCESS;
  - frontend syntax/wiring: SUCCESS;
  - smoke progetto pubblico default: SUCCESS;
  - smoke override `Vittorio_revisionato`: SUCCESS;
  - verifica deploy pubblico: SUCCESS;
  - rosso finale esclusivamente per Golden Darcy sintetico già noto.
- verifica pubblica:
  - Render raggiungibile e `Vittorio_revisionato` presente in
    `spiralEngines`;
  - default pubblico `Diego_Vittorio`;
  - frontend pubblico `1.36`;
  - Pages #1654 `36504429539`: SUCCESS.

**RECOVERY POINT / PROSSIMO PASSO:** l'utente può aprire il frontend pubblico,
selezionare Help → Motore spirali — test pubblico →
`Vittorio_revisionato`, aprire o creare progetti diversi e usare
`Aggiorna Modello`. Per ogni anomalia annotare progetto/locale/ingresso e
confrontare prima con `Vittorio`. Non modificare ancora l'algoritmo Return
senza un caso reale riproducibile e una decisione esplicita.


### 2026-09-29 — notifiche build sospese
Stato: **COMPLETATO**

Decisione utente:
- sospendere completamente le notifiche telefoniche generate da build, test,
  deploy, harness e verifiche automatiche;
- mantenere esclusivamente la notifica associata alla chiusura della GitHub
  Issue #1.

Applicato:
- rimossi secret/uso ntfy da:
  - `.github/workflows/termodel-service-build.yml`;
  - `.github/workflows/termodel-radiant-harness.yml`;
  - `.github/workflows/termodel-render-verify.yml`;
  - `.github/workflows/termodel-diego-vittorio-public-square.yml`;
  - `.github/workflows/termodel-diego-vittorio-fast.yml`;
  - `.github/workflows/termodel-diego-vittorio-room-extraction.yml`;
- i workflow mantengono il Commit Status `Termodel/job`, ma senza push ntfy;
- `.github/workflows/issue-work-notify.yml` resta l'unico workflow autorizzato
  a usare ntfy ed è ora filtrato esplicitamente con
  `github.event.issue.number == 1`;
- aggiornata la specifica canonica
  `.github/TERMODEL-ACTION-NOTIFICATIONS.md`.

Verifica:
- nei sei workflow tecnici sopra risultano zero riferimenti a ntfy /
  `TERMODEL_NTFY_TOPIC` / `PHONE_NOTIFICATION_SENT`;
- tali riferimenti restano soltanto in `issue-work-notify.yml`.

Regola corrente:
> **nessuna notifica di build; unica notifica telefonica = chiusura Issue #1.**


### 2026-09-29 — Vittorio_revisionato solo mandata per esame visivo
Stato: **IMPLEMENTATO — BUILD/DEPLOY IN VERIFICA**

Commissionato:
- riprendere il lavoro su `Vittorio_revisionato`;
- sospendere temporaneamente chiusura e ritorno;
- lasciare visibile esclusivamente la mandata per agevolare il confronto
  visivo dell'utente;
- pubblicare e notificare il completamento tramite Issue #1.

Implementazione:
- `SpiraliVittorioRevisionato/Program.cs`:
  - aggiunta costante `SoloMandataPerEsameVisivo = true`;
  - il percorso pubblico `AggiornaSpirali()` esegue soltanto
    `GeneraSpirale()`, non `ChiudiSpiraleFiles()`;
  - lo SVG pre-chiusura viene riclassificato da blu a rosso affinché
    `RadiantExecutiveGenerator` lo esponga come
    `*_PannelliMandata_Output`;
  - chiusura e Return restano nel codice e sono semplicemente sospesi;
- `StrategiaVittorioRevisionatoBenchmark` chiama esplicitamente
  `AggiornaSpirali(false)`: la regression completa contro Vittorio resta
  quindi separata e continua a verificare il flusso storico completo;
- `smoke-radiant-reference.ps1` per override
  `Vittorio_revisionato` verifica:
  - presenza layer Mandata;
  - assenza layer Ritorno;
  - assenza layer NumeriCircuiti/annotazione chiusura.

Vincolo:
- nessuna modifica a `SpiralGenerator` o alla geometria della mandata;
- modalità dichiaratamente temporanea e reversibile.

**PROSSIMO PASSO:** attendere build/smoke, verificare deploy Render aggiornato,
poi chiudere Issue #1 Completed se il percorso pubblico è disponibile.


#### 2026-09-29 — Vittorio_revisionato solo mandata PUBBLICATO
Stato: **COMPLETATO**

Verifica:
- Service Build #1076 / run `36509662811`;
- build: SUCCESS;
- smoke default pannelli: SUCCESS;
- smoke override `Vittorio_revisionato`: SUCCESS;
- `VITTORIO_REVISIONATO_SUPPLY_ONLY_OK`;
- layer Mandata presente;
- layer Ritorno assente;
- layer NumeriCircuiti/chiusura assente;
- deploy pubblico: SUCCESS;
- commit pubblico:
  `bdb1861be127fa977543b3c86cb0384cc0d6ebb2`;
- default pubblico invariato: `Diego_Vittorio`;
- frontend pubblico invariato: v1.36.

Nota:
- il rosso complessivo del Service Build resta dovuto al Golden Darcy
  sintetico già noto e non alla modifica spirali;
- chiusura e Return sono sospesi solo per il percorso pubblico
  `Vittorio_revisionato`; il benchmark completo continua a usare
  `AggiornaSpirali(false)`.

**RECOVERY POINT:** continuare il collaudo visivo della sola mandata su
progetti reali. Non modificare Return/chiusura finché l'utente non lo richiede.


### 2026-09-29 — Vittorio_revisionato: completamento asse centrale della sola mandata
Stato: **IMPLEMENTATO, REGRESSION VERDE, PUBBLICATO**

Osservazione utente:
- nei locali rettangolari la mandata lasciava al centro una fascia eccessivamente ampia pur essendoci spazio utile residuo;
- Return e chiusura restano esclusi dall'indagine.

Causa/soluzione circoscritta:
- Vittorio termina correttamente quando non può costruire un ulteriore anello chiuso completo; questo criterio può però lasciare una fascia centrale sfruttabile;
- aggiunta solo a `Vittorio_revisionato` una estensione terminale per rettangoli ortogonali: dopo l'ultimo anello valido, se la fascia corta residua è compresa fra 2p e 4p, la mandata aggiunge una piega verso la mezzeria e un asse terminale centrale;
- nessuna modifica a ComputeOffset, percorrenza Vittorio, Return o chiusura;
- rollback immediato: `TerminalCenterline = false` nel percorso pubblico; il benchmark storico usa già false.

Commit funzionali: `398db746`, `455f9110`, `29b0240b`, fix isolamento benchmark `514bb71a`.

Verifica:
- Fast Harness #74 / run `36510946051`: **SUCCESS** completo;
- equivalenza iniziale e multi-progetto Vittorio/Vittorio_revisionato: SUCCESS sul percorso storico con feature disattivata;
- tutte le regression Diego_Vittorio: SUCCESS;
- Service Build #1084: build, smoke pannelli, override Vittorio_revisionato e verifica deploy pubblico: SUCCESS;
- failure globale successiva nello smoke storage/lock, indipendente dalla geometria spirali.

**RECOVERY POINT:** chiedere conferma visiva dell'utente sul nuovo centro dei rettangoli. Se il risultato non è soddisfacente, disattivare `TerminalCenterline` senza toccare Vittorio/Diego_Vittorio.


### 2026-09-29 — Vittorio_revisionato: chiusura e raccordi riattivati da Diego_Vittorio
Stato: **IMPLEMENTATO, PUBBLICATO, SMOKE SPECIFICO VERDE**

Su approvazione visiva della nuova mandata centrale, il percorso pubblico è ora volutamente ibrido e chirurgico:
- Supply: `Vittorio_revisionato` con `TerminalCenterline=true`;
- Return, raccordi e chiusura: riuso diretto di `SpiralHeatingDiegoVittorio.ChiudiSpirale.Chiudi`;
- nessuna copia delle euristiche Diego_Vittorio dentro Vittorio_revisionato;
- benchmark storico `AggiornaSpirali(false)` resta invariato e continua a usare la chiusura Vittorio_revisionato originale.

Commit funzionale: `d86a96cc1dcc3cd4293a99da4712184088175b57`.
Smoke aggiornato al nuovo contratto: `1c6966e289ec6173938452b12765059271d101ba`.
Fast Harness #75: **SUCCESS completo**. Service Build #1089: build SUCCESS, smoke pannelli SUCCESS, smoke override Vittorio_revisionato con Return Diego SUCCESS, verifica deploy pubblico SUCCESS. Workflow globale resta rosso solo nello smoke HTTP storage/lock indipendente.

**RECOVERY POINT:** il prossimo controllo è esclusivamente visivo sul progetto reale: verificare che la mandata approvata sia rimasta identica e che Return/raccordi/chiusura corrispondano alla qualità Diego_Vittorio.


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

### 2026-09-30 — AUDIT FINALE `Vittorio_revisionato`: separazione chiusura / raccordatura
Stato: **DECISIONI UMANE CONSOLIDATE E DOCUMENTATE — IMPLEMENTAZIONE NON AVVIATA**

Origine:
- il collaudo della chiusura finale di `Vittorio_revisionato` ha mostrato un
  circuito non affidabile/non sempre chiuso;
- l'audit ha confermato che il flusso corrente mescola due problemi distinti:
  scelta della chiusura e raccordatura grafico-geometrica successiva;
- nessun file di codice geometrico è stato modificato durante l'audit.

#### Diagnosi verificata sul codice corrente

Il percorso sperimentale attuale:
1. sceglie un candidato combinatorio su polilinee rettilinee;
2. usa `CreaCurvaCollegamentoAdattiva` nella validazione del candidato;
3. per il bridge `Vittorio_revisionato` disabilita i filtri della corda
   rettilinea e riferisce il requisito `>=2P` alla curva;
4. arrotonda Mandata e Return;
5. scarta il raccordo preliminare già approvato;
6. genera una seconda curva tramite `CreaCurvaCollegamentoVincolata`;
7. se la seconda curva fallisce, non prova il candidato combinatorio
   successivo;
8. può quindi arrivare allo SVG con Mandata/Return già tagliati ma senza
   collegamento finale.

Il workflow dedicato controlla il successo della chiusura preliminare/curva
(`DV_CLOSURE_SELECTED`, `curveLength`) e non rappresenta ancora il contratto
rettilineo deciso in questo audit.

#### Decisione architetturale vincolante

**La chiusura deve essere completata interamente sulla geometria rettilinea.
La raccordatura parte soltanto dopo.**

Nessuna Bézier, arco o `ArrotondaSpirale` deve partecipare alla scelta del
candidato di chiusura.

Flusso deciso:

```text
Mandata rettilinea + Ritorno rettilineo
  -> applicazione candidato (tagli/accorciamenti)
  -> tratto rettilineo di chiusura
  -> validazione candidato
  -> primo candidato valido
  -> unico percorso rettilineo continuo
  -> raccordatura circolare di tutti gli spigoli raccordabili
  -> output con identità grafica dei tratti conservata
```

#### Notazione del bridge revisionato

Per `Vittorio_revisionato`:
- `P = distanzaRitorno = 0,15 m` nel caso nominale;
- `2P = 0,30 m`;
- il requisito minimo riguarda il **tratto rettilineo di chiusura**.

Questa notazione locale non deve essere confusa con il `p = 0,30 m` usato
nelle sezioni storiche Diego_Vittorio.

#### Candidato valido: criteri definitivi dell'audit

Per ogni candidato:
1. applicare prima i suoi tagli/accorciamenti;
2. valutare soltanto la **nuova geometria risultante**;
3. costruire il tratto rettilineo fra i nuovi terminali;
4. scartare il candidato se il tratto è `<2P`;
5. scartarlo se il tratto interseca un tubo della **nuova geometria**
   risultante, ignorando i segmenti del setup iniziale già rimossi/modificati;
6. escludere naturalmente dal test i due tratti terminali adiacenti agli
   innesti;
7. scartarlo se uno dei due innesti produce un **angolo acuto** (<90°);
8. 90° o angoli maggiori sono accettabili.

Non è richiesto un ranking fra tutte le soluzioni valide. Per minimizzare il
carico computazionale la combinatoria usa una sequenza deterministica e si
ferma alla **prima valida**.

Se nessun candidato è valido:
- nessuna chiusura forzata;
- Mandata e Ritorno restano separati;
- il circuito aperto è intenzionalmente il feedback visivo sufficiente per il
  debug;
- non è richiesto, per ora, un nuovo marker di log dedicato.

#### Distanza dagli altri tubi

Per ora il filtro richiesto è la sola **intersezione**.

Non introdurre durante la prima implementazione un nuovo vincolo di distanza
minima fra tratto di chiusura e tubazioni vicine.

**Possibile perfezionamento futuro:** controllo della distanza minima dagli
altri tubi della geometria risultante, mantenendo invariata la combinatoria
base.

#### Percorso unico con identità dei tratti

Una volta accettata la chiusura:
- Mandata + Chiusura + Ritorno sono geometricamente **un unico percorso
  continuo**;
- l'unificazione serve anche a raccordare correttamente i due innesti della
  chiusura;
- ogni tratto conserva però identità/metadati di appartenenza e resa:
  Mandata / Chiusura / Ritorno, colore, tipo linea e altri attributi utili;
- non fondere semanticamente gli stili solo perché la geometria è continua.

#### Raccordatura: fase separata successiva

Dopo la chiusura definitiva:
- raccordare **tutti gli spigoli** del percorso continuo, inclusi gli innesti
  della chiusura;
- usare **archi circolari tangenti**;
- raggio configurabile localmente in `Vittorio_revisionato`;
- default raggio = valore corrente `0,10 m`;
- verificare che l'arco col raggio richiesto sia contenibile nei due tratti
  adiacenti;
- se i tratti sono troppo corti, **non ridurre il raggio**: non eseguire quel
  raccordo;
- lo spigolo vivo risultante è accettabile nell'esecutivo e non invalida la
  chiusura.

#### Discretizzazione degli archi

Decisione:
- discretizzazione **adattiva**;
- criterio = errore massimo/scostamento (sagitta) fra arco teorico e polilinea;
- parametro configurabile solo localmente a `Vittorio_revisionato`;
- default = **5 mm = 0,005 m**;
- usare il minor numero di segmenti sufficiente;
- evitare campionamenti fissi arbitrari (10, 48, ecc.).

#### Criteri approvati da riusare da Diego_Vittorio

Riutilizzabili:
- combinatoria deterministica;
- scarto candidati non validi;
- controllo angolare;
- controllo intersezioni sulla geometria effettivamente conservata;
- arresto al primo successo quando non serve ranking;
- principio degli archi circolari tangenti già presente in
  `SpiraliDiegoVittorio/Utilityfunctions.cs::ArrotondaSpirale`;
- principio di frammentazione adattiva.

Da **non** trasferire:
- Bézier come componente della decisione di chiusura;
- `>=2P` misurato sulla curva;
- riduzione del raggio effettivo al 45% dei tratti per far entrare il raccordo;
- conteggio fisso 2–6 segmenti come criterio definitivo di discretizzazione.

Le vecchie `LG-048`/`LG-049` restano valide per `Diego_Vittorio`; non
vanno riscritte per adattarle a `Vittorio_revisionato`.

#### Test richiesti nella futura implementazione

Separare i gate:

**Gate chiusura rettilinea**
- segmento >=2P;
- angoli non acuti;
- nessuna intersezione sulla geometria risultante;
- candidato invalido -> prova successivo;
- nessun candidato -> circuito aperto.

**Gate raccordatura**
- archi circolari col raggio configurato;
- nessuna riduzione del raggio per tratti corti;
- spigolo vivo ammesso quando il raccordo non entra;
- tutti gli spigoli del percorso continuo processati;
- errore discretizzazione <= tolleranza configurata, default 5 mm;
- nessuna modifica della topologia/candidato di chiusura già deciso.

#### Documentazione persistente

Regola formalizzata come:
`Server/Termodelwebservice/docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md`
→ **LG-051**.

Commit linee guida:
`99f796e44b5c66df03cc0d237f390f70c7ed203f`.

Il Summary Service ha registrato l'incarico prima delle modifiche documentali
nel commit:
`0349b2f26c942e5cb5342c539cfffabf351fc63a`.

**RECOVERY POINT ESATTO:** alla prossima fase NON riprendere la vecchia
sperimentazione Bézier. Prima di modificare il motore leggere LG-051 e
confrontare il codice corrente con il contratto sopra. L'implementazione deve
essere piccola e reversibile, lasciare `SpiraliVittorio` invariata e
riallineare i test separando chiusura rettilinea e raccordatura. Lo stato
corrente è **progettato/documentato**, non implementato, non compilato e non
testato rispetto a LG-051.

### 2026-09-30 — IMPLEMENTAZIONE LG-051 Vittorio_revisionato
Stato: **IMPLEMENTAZIONE PREPARATA PER MAIN — BUILD/DEPLOY DA VERIFICARE**

Applicato il contratto dell'audit:
- combinatoria dedicata alla chiusura rettilinea, senza Bézier;
- soglia >=2P, esclusione angoli acuti e controllo intersezioni sulla geometria
  risultante dal candidato;
- arresto al primo candidato valido; circuito aperto se nessuno è valido;
- eliminata dal percorso pubblico la seconda Bézier
  `CreaCurvaCollegamentoVincolata`;
- raccordatura successiva dell'intera catena con archi circolari;
- raggio locale default 0,10 m, mai ridotto per farlo entrare;
- spigolo vivo se il raccordo non è contenibile;
- discretizzazione adattiva per sagitta, tolleranza locale default 5 mm;
- etichetta verde di circuito chiuso emessa solo se esiste una chiusura;
- Fast Harness e gate quadrato riallineati a LG-051;
- `SpiraliVittorio` invariata.

Per richiesta esplicita dell'utente questa fase non usa Issue #1 e non deve
inviare notifiche ntfy. Il commit funzionale è predisposto con `[skip ci]`;
il Fast Harness aggiornato resta quindi **non eseguito** in questa fase.

RECOVERY POINT: verificare il commit su main e l'eventuale deploy Render.
Distinguere rigorosamente implementato / compilato / pubblicato / testato.
Non dichiarare il Fast Harness eseguito finché non viene lanciato.

### 2026-09-30 — LG-051 PUBBLICATA SU MAIN
Stato: **IMPLEMENTATA; CORE/HARNESS COMPILATI; GATE SPECIFICO ESEGUITO; DEPLOY SERVICE NON CERTIFICATO**

HEAD funzionale corrente: `7634d4e939556d9b23933f4b7cb5a4d9c488f9e3`.

Verifica Fast Harness #121 / run `36666975115`:
- Build Harness + Core: SUCCESS;
- gate quadrato pubblico `Vittorio_revisionato`: SUCCESS;
- equivalenza iniziale: SUCCESS;
- equivalenza multi-progetto (6 casi): SUCCESS;
- astrazione strutturale: SUCCESS;
- quadrato sintetico Diego_Vittorio: SUCCESS;
- il quadrato `Vittorio_revisionato` corrente resta aperto perché nessun
  candidato soddisfa tutti i filtri rettilinei LG-051; è il feedback visivo
  concordato per un fallimento di chiusura e non viene forzata alcuna curva.

Il Fast Harness completo termina FAILURE sul Golden storico del quadrato
pubblico `Diego_Vittorio`: SVG attuale `5ddd0ffd...`, Golden
`fa8e6106...`. L'artifact SUCCESS storico del run `36383265029` conferma
che il Golden rappresenta la geometria precedente; il codice Diego_Vittorio era
già cambiato fra `932fce5` e lo stato pre-LG-051 `cad2c29c`. Non aggiornare
automaticamente il Golden e non attribuire questa divergenza a LG-051 senza
un'indagine separata.

Service Build #1183 / run `36666543124` non certifica la build completa né il
deploy: il gate frontend si arresta su un controllo cache-busting v1.35 mentre
il frontend reale è v1.37; il controllo deploy attende inoltre frontend v1.36.
Non modificare il frontend nell'ambito LG-051.

**RECOVERY POINT ESATTO:** la geometria LG-051 è già su main. Il prossimo
passo funzionale è il collaudo visivo del percorso pubblico
`Vittorio_revisionato`. Se serve certificare il deploy, correggere
separatamente il gate infrastrutturale obsoleto oppure compilare/eseguire dal
Visual Studio locale; non cambiare la geometria per far diventare verde un test
infrastrutturale. La divergenza Golden Diego_Vittorio resta una questione
separata da investigare senza aggiornare il Golden.



### 2026-09-30 — CHECKPOINT ATTIVO: pipeline Diego pulita
Stato: **COMMISSIONATO — PRIMA DELLA MODIFICA FUNZIONALE**

Decisione corrente:
- `SpiraliVittorio` resta intoccabile;
- `Vittorio_revisionato` deve usare la Mandata rettilinea già generata;
- il Return deve nascere direttamente da
  `SpiralHeatingDiegoVittorio.funzioni_diego.ritorno_Parallelo_diego(...)`;
- il lato iniziale da preservare è quello del bridge corrente:
  `CreaOffsetRettilineo(..., -distanzaRitorno)`; quindi la prima sostituzione
  usa distanza `-distanzaRitorno` e mantiene lo stesso ordine della Mandata
  (esterno -> centro), senza `Reverse()`;
- eliminare dal percorso pubblico revisionato la catena
  `ArrotondaSpirale -> CreaRientro -> PreparaRitornoRettilineoVittorio`;
- la chiusura resta `funzioni_diego.chiusura_diego(...)`;
- la raccordatura finale resta inizialmente invariata per isolare il test del
  nuovo Return; solo dopo il gate verde verrà centralizzata in
  `funzioni_diego.raccorda_diego(...)`.

Rollback certo:
- commit di commissione precedente alla modifica funzionale:
  `9809518f260c671b18b02ef6083c11f580ded862`;
- in caso di chat interrotta ripartire da questo checkpoint, controllare HEAD
  e non modificare Golden automaticamente.

Vincolo operativo di questa sessione:
- richiesta utente **NON NOTIFICARE**;
- non usare Issue #1;
- evitare workflow con ntfy; i test automatici della fase devono usare un gate
  temporaneo privo di notifiche oppure restare locali.


### 2026-09-30 — CHECKPOINT FINALE: pipeline Diego pulita pubblicata
Stato: **IMPLEMENTATA, COMPILATA E TESTATA SU MAIN — NESSUNA NOTIFICA**

Flusso pubblico corrente di `Vittorio_revisionato`:

```text
Mandata Vittorio rettilinea
  -> funzioni_diego.ritorno_Parallelo_diego(..., -0,15 m)
  -> funzioni_diego.chiusura_diego(...)
  -> percorso unico Mandata -> Chiusura -> Ritorno
  -> funzioni_diego.raccorda_diego(...)
  -> output semantico Mandata / Chiusura / Ritorno
```

Cambiamenti consolidati:
- eliminato dal percorso pubblico il passaggio
  `ArrotondaSpirale -> CreaRientro -> PreparaRitornoRettilineoVittorio`;
- il Return parallelo nasce direttamente dalla spezzata rettilinea e conserva
  lo stesso lato storico del bridge precedente usando distanza con segno
  `-distanzaRitorno`;
- `raccorda_diego` contiene ora la raccordatura circolare LG-051 definitiva:
  raggio richiesto non ridotto, spigolo vivo se non contenibile,
  discretizzazione adattiva sulla sagitta;
- l'implementazione LG-051 duplicata in
  `SpiraliVittorioRevisionato/Utilityfunctions.cs` è stata rimossa;
- `SpiraliVittorio` non è stata modificata;
- nessun frontend e nessun `definizionedati.json` modificati.

Commit funzionali principali:
- `b3e54d7ce6c9d7089a455fd2d0a0316fa6252038` — attiva Return parallelo Diego;
- `86eea277f8171ea6d52afdbb1484c9b97dd35ffb` — raccordatura finale in `funzioni_diego`;
- `790a8025f1d2edfff834f4513d9f610ce08b89d8` — `Vittorio_revisionato` usa il raccordo centralizzato;
- `3eec67d65bd899d2d96e06759e877f8be738624c` — rimosso bridge pubblico di raccordo superato;
- `cdc6039084caf9310081368ad629950e9da04b3e` — test Harness riallineato;
- `761e96a41a757fbc67bf5304f2ea1b00d2344afb` + `0f36a5cd85576ad9f5665e87b8c532ed31822a80` — rimozione vecchio raccordo revisionato e fix sintattico.

Verifica reale senza ntfy:
- workflow temporaneo no-notify run `36759139735`: SUCCESS;
  build Harness + Core SUCCESS, 0 errori; guard statico SUCCESS;
  `parallel-return-check` SUCCESS su concavo/convesso/misto/lato opposto;
  `fillet-check` SUCCESS con
  `FUNZIONI_DIEGO_LG051_FILLET_OK`, sagitta massima ~0,003407 m;
  quadrato pubblico SUCCESS; concavo pubblico SUCCESS;
- matrice temporanea no-notify run `36759475306`: SUCCESS;
  6 casi pubblici eseguiti (quadrato, concavo L, trapezio obliquo,
  connection-terminal, appartamento corrente, pannelli pubblici);
  tutti 6 hanno usato `VREV_RETURN_PARALLEL_DIEGO` con offset `-0,15 m`;
  tutti 6 hanno chiusura applicata e raccordatura finale confermata;
  build SUCCESS, 0 errori;
- i due workflow temporanei no-notify sono stati eliminati dopo il test.

Rollback / recovery:
- ultimo punto certamente precedente alla modifica funzionale:
  `11b138506771977e0a123ac5d36c19adddb37d0a` (checkpoint documentale);
- commit di commissione pre-fase:
  `9809518f260c671b18b02ef6083c11f580ded862`;
- se una chat futura trova un problema, NON aggiornare Golden alla cieca:
  confrontare prima il percorso attuale con questi commit e con i log dei run
  sopra.

Nota operativa:
- per richiesta esplicita dell'utente questa fase non ha usato Issue #1 e non
  ha inviato notifiche ntfy;
- la pubblicazione qui certificata è su GitHub `main`; il deploy Render non
  è dichiarato verificato in questa fase.
