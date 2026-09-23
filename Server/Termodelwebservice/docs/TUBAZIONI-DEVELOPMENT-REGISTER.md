# CALCOLO TUBAZIONI — REGISTRO DI SVILUPPO AUTONOMO

Aggiornamento: **23 settembre 2026**  
Stato: **STUDIO E ARCHITETTURA REGISTRATI — MOTORE NON IMPLEMENTATO**  
Linea: **TermodelService / libreria di supporto ai pannelli radianti**

Questo documento è il registro autonomo della futura libreria **Calcolo
Tubazioni**. Non sostituisce `PROJECT-SUMMARY-SERVICE.md`, il contratto
Frontend↔Service o i riferimenti Desktop/Pascal. Serve a conservare nel tempo
fonti, decisioni, stato, prove, differenze e prossimi passi di questo
sottosistema.

## 1. Obiettivo

Realizzare una libreria headless per il calcolo delle reti idrauliche di
tubazioni, inizialmente destinata soprattutto a supportare i **pannelli
radianti**.

La libreria dovrà poter essere richiamata in futuro dal flusso autorevole:

```text
Aggiorna Modello
      |
      +--> modello Termodel
      |
      +--> pannelli / circuiti / collettori
      |
      +--> Calcolo Tubazioni
      |
      +--> risultati idraulici + diagnostica + output derivati
```

Il modulo è una linea di sviluppo autonoma perché possiede algoritmi, archivi,
test e risultati propri. L'integrazione finale deve però avvenire attraverso
`Termodel.Core` e non trasformare `Termodel.WebService` in un secondo
motore algoritmico.

## 2. Principi vincolanti

1. I vecchi sorgenti Pascal sono **fonte di ispirazione funzionale,
   algoritmica e documentale**, non codice da copiare automaticamente.
2. Il nuovo motore deve essere .NET/headless, deterministico e testabile senza
   WPF, BDE/Paradox, AutoCAD, dialoghi o file temporanei usati come flag.
3. Geometria/rete, calcolo idraulico, dati archivio e presentazione UI devono
   essere separati.
4. Il database Tubazioni deve essere **indipendente** dagli archivi Termodel.
5. Non modificare `definizionedati.json` per introdurre Tubazioni.
6. Il nuovo schema JSON Tubazioni deve usare la stessa filosofia e lo stesso
   formato di metadati di `definizionedati.json` per consentire
   l'automazione delle form.
7. Il vecchio `base.dat` è un riferimento dichiarativo: default, combo,
   lookup, griglia, decimali e relazioni vanno reinterpretati in JSON, non
   mantenuti come parser runtime obbligatorio.
8. La libreria DXF storica è un riferimento per capire entità e convenzioni,
   non un requisito per il nuovo solver.
9. L'integrazione con `Aggiorna Modello` verrà definita soltanto quando il
   nucleo Tubazioni sarà verificato autonomamente.
10. Nessun risultato può essere dichiarato equivalente al Pascal senza
    regression test su casi noti.

## 3. Fonti storiche studiate

### 3.1 Raccolta Pascal

Riferimento generale:

```text
SorgentiTermodel/Library/SorgentiPascal/
```

La raccolta è consultiva e conserva struttura/provenienza dei vecchi alberi
`C:\DOCUMENTI\sd` e `C:\DOCUMENTI\bmsistemi`.

Per Tubazioni il nucleo principale è:

```text
SorgentiTermodel/Library/SorgentiPascal/Pascal/02_Sottosistemi_Completi/
  origine/bmsistemi/drivepsviluppo/prjs/cpi win clima/versione_10/Tubi/
```

La scansione storica documentata per il sottosistema Tubazioni comprende 247
sorgenti selezionati, 204 dipendenze fuori dal nucleo, 1.113 riferimenti
risolti e 1.395 riferimenti non risolti. La quantità di dipendenze conferma che
non è opportuno tentare un porting monolitico del vecchio progetto.

### 3.2 Sorgenti algoritmici principali

| Sorgente Pascal | Ruolo osservato |
|---|---|
| `Calcolo_Tubi.pas` | orchestrazione del solver, portate, perdite distribuite, dimensionamento, percorso sfavorito, equilibratura, portate effettive |
| `PERDCONC.PAS` | perdite concentrate / coefficienti di perdita |
| `EQUIL.PAS` | variante/algoritmi di equilibratura |
| `UGrafoDXF.pas` | ricostruzione del grafo della rete da entità geometriche, terminali, valvole, curve e diramazioni |
| `RITORNO.PAS` | costruzione geometrica della rete di ritorno |
| `collettori.pas` | costruzione/disegno dei collettori |
| `iotubi.pas` | inizializzazione e I/O degli archivi storici |
| `DATITUBI.PAS` | gestione archivi tubazioni, terminali, perdite, fluidi, montaggi |
| `OutDXFBM.pas` | emissione di comandi geometrici linee/archi/quote per il risultato di disegno |
| `UMain_CalcTubi.pas` | UI/orchestratore Delphi, generazione DB/form, caricamento DXF, avvio calcoli |
| `CalcTubiDll.dpr` | DLL storica che espone `CalcTubi` e compone le dipendenze |
| `Calcolo_analitico_pannelli.pas` | tabelle/interpolazioni e formule storiche per pannelli radianti |
| `Pannelli.pas` | funzioni storiche collegate ai pannelli |

## 4. Comportamento storico ricostruito

Il flusso concettuale del vecchio sistema è:

```text
DXF + blocchi + archivi
        |
        v
ricostruzione entità di rete
        |
        v
grafo nodi/tronchi/terminali
        |
        v
controllo topologico
        |
        v
propagazione portate dai terminali verso l'origine
        |
        v
dimensionamento diametri
        |
        +--> perdita distribuita
        +--> perdite concentrate
        +--> eventuale dislivello
        |
        v
ricerca percorso più sfavorito
        |
        +--> eventuale equilibratura
        +--> eventuali valvole di taratura
        +--> eventuale iterazione portate effettive
        |
        v
portata/prevalenza + risultati per tronco
        |
        v
ritorno / collettori / quote / output grafico
```

### 4.1 Portate

`Portate` e la funzione ricorsiva `PortTronco` sommano le portate dei
terminali lungo l'albero della rete. Il codice contiene anche una modalità
storica per reti sanitarie basata su unità di carico; questa funzione non è
necessariamente parte della prima versione per pannelli radianti e dovrà essere
classificata come estensione separata.

### 4.2 Perdite distribuite

`F0` contiene più correlazioni storiche. La forma 1 implementa il
coefficiente di attrito Darcy/Colebrook, con gestione del regime laminare.

`Perdita_Tubo` conferma la struttura fisica:

```text
portata -> velocità -> Reynolds/attrito -> perdita lineare
```

Nel nuovo motore formule, unità e costanti non vanno trascritte senza test:
devono diventare funzioni pure con unità esplicite e casi di verifica
indipendenti.

### 4.3 Dimensionamento

`dimensiona` / `DimensTronco`:

- individua la famiglia di tubo;
- usa il diametro imposto in verifica oppure cerca nella serie disponibile;
- applica limiti di velocità e perdita specifica;
- tratta in modo particolare i rami di collettore;
- somma perdite distribuite e concentrate;
- percorre ricorsivamente i rami;
- determina il percorso più sfavorito.

Parametri storici di rete provengono da `Reti`:
`dps`, `maxvels`, `dpe`, `maxvele`, `maxvelColl`,
`Tolleranza`, `Iterazioni`.

### 4.4 Perdite concentrate ed equilibratura

Le perdite localizzate sono associate a curve, TEE, diramazioni, valvole e
terminali. `UGrafoDXF` riconosce anche la geometria degli angoli e associa i
componenti al tratto.

L'equilibratura storica prova a ridurre lo sbilanciamento dei rami modificando
diametri e/o usando elementi di taratura. L'opzione deve diventare esplicita
nel nuovo modello di calcolo.

### 4.5 Opzioni storiche da non replicare come file

Il vecchio `calcoli` attiva modalità tramite file come:

```text
ver.sce
equil.sce
Valv.sce
port.sce
sanit*.sce
```

Nel nuovo modulo queste devono diventare proprietà di un oggetto
`TubazioniCalculationOptions`, non file di controllo sul filesystem.

## 5. Grafo e geometria: separazione dal DXF

`UGrafoDXF.pas` contiene due responsabilità che nel nuovo progetto vanno
separate:

1. lettura/interpretazione delle entità CAD;
2. costruzione e validazione del grafo idraulico.

Il solver non deve ricevere un file DXF. Deve ricevere un modello neutro,
indicativamente:

```text
TubazioniNetwork
  Nodes[]
  Segments[]
  Terminals[]
  Manifolds[]
  Valves[]
  LocalLosses[]
```

Ogni segmento deve poter descrivere almeno:

- identificativo;
- nodo iniziale/finale;
- lunghezza;
- dislivello;
- famiglia tubo;
- diametro imposto o calcolabile;
- perdite concentrate/componenti;
- piano/circuito di appartenenza;
- eventuale relazione mandata/ritorno.

Un adattatore separato potrà costruire questo modello da:

- geometria Termodel corrente;
- grafo pannelli già prodotto dal Desktop/C#;
- SVG tecnico;
- DXF/netDxf quando realmente necessario;
- casi test costruiti direttamente in memoria.

### 5.1 Cosa conservare dalla vecchia libreria DXF

Da `UGest_cad.pas`, `UGrafoDXF.pas`, `leggi_dxf_bm.pas`,
`OutDXFBM.pas` vanno conservati come conoscenza:

- convenzioni per layer tubi/terminali/collettori/ritorno/quote;
- significato dei blocchi terminale, valvola, inizio rete e collettore;
- logica di prossimità/connessione;
- riconoscimento di curve e diramazioni;
- relazione fra geometria di mandata e ritorno;
- emissione di linee, archi e quote come risultato derivato.

Non vanno portati nel Core:

- script AutoCAD;
- `WinExec`;
- generazione di file `.scr`;
- dipendenza da prototipi DXF nel filesystem;
- naming di file temporanei come protocollo fra moduli.

`OutDXFBM` suggerisce invece un concetto utile: un **drawing result neutro**
(linea/arco/etichetta/metadata), convertibile successivamente in SVG, DXF o
altro artifact senza contaminare il solver.

## 6. Rapporto con i pannelli radianti

Il riferimento C# Desktop corrente è:

```text
SorgentiTermodel/Library/PannelliRadianti.cs
SorgentiTermodel/Library/Impianti/Pannelli/CalcoloPannelli.cs
SorgentiTermodel/Library/Impianti/Pannelli/IoPannelli.cs
SorgentiTermodel/Library/Impianti/Pannelli/IoTubi.cs
```

`CalcoloPannelli.cs` possiede già DTO logici per piani, locali e circuiti e
calcola, fra l'altro, lunghezza del circuito e potenze richiesta/erogabile.

`IoPannelli` genera un `retePannelli.xml` con nodi e tratti; `IoTubi`
usa già tale grafo per collettori, collegamenti mandata/ritorno ed esecutivo.

Quindi l'integrazione target non deve ricominciare dal DXF storico. La
direzione preferita è:

```text
Pannelli / Spirali
      |
      | circuiti + lunghezze + potenze + grafo
      v
TubazioniNetworkAdapter
      |
      v
Tubazioni.Core
      |
      +--> portate per circuito
      +--> perdite circuito
      +--> collettori/rami
      +--> prevalenza richiesta
      +--> bilanciamento
      +--> segnalazioni
```

Il calcolo Tubazioni deve essere utilizzabile anche senza pannelli radianti;
i pannelli costituiscono il primo produttore di input e il primo caso d'uso.

### 6.1 Prima funzione operativa — perdita di carico dei circuiti radianti

Decisione del 23 settembre 2026: la **prima funzione realmente utile** da
realizzare nella nuova libreria Tubazioni sarà il calcolo della perdita di
carico di ogni circuito del pannello radiante.

#### 6.1.1 La lunghezza geometrica della spirale non è autorevole

La lunghezza salvata/calcolata dal generatore grafico della spirale non deve
essere usata come input idraulico autorevole, perché può essere corrotta o
risentire di errori del generatore geometrico.

Il calcolo idraulico deve invece ricostruire una lunghezza indipendente a
partire da:

- superficie effettivamente servita dal circuito;
- passo/interasse dei tubi;
- fattore di conversione superficie/passo -> metri di tubo;
- lunghezza reale dei collegamenti fra collettore e circuito.

La lunghezza grafica della spirale potrà essere conservata soltanto come dato
diagnostico da confrontare con la lunghezza stimata.

#### 6.1.2 Fattore superficie/passo

Riferimento tecnico verificato: la guida Uponor per impianti radianti riporta
la quantità di tubo necessaria per unità di superficie in funzione del passo:

| Passo [mm] | Fattore tubo [m/m²] |
|---:|---:|
| 50 | 20.0 |
| 100 | 10.0 |
| 125 | 8.0 |
| 150 | 6.7 |
| 175 | 5.8 |
| 200 | 5.0 |
| 300 | 3.4 |

La stessa guida specifica che ai metri ricavati dalla superficie devono essere
aggiunte separatamente le lunghezze di mandata/ritorno fra collettore e
ambiente.

Fonte verificata:
https://www.uponor.com/getmedia/c5ab8a1f-9f02-43a4-8bcb-3b6a186dafeb/underfloor-heating-install-guidepdf?sitename=UK

Per i passi standard si userà quindi il fattore tabellato:

```text
L_spirale_stimata = Area_servita_m2 * F_passo_m_per_m2
```

Per un passo non presente in tabella, il fallback geometrico è:

```text
F_passo ~= 1 / passo_m
        ~= 1000 / passo_mm
```

Questa relazione produce, ad esempio:

```text
100 mm -> 10.0 m/m²
150 mm ->  6.67 m/m²
200 mm ->  5.0 m/m²
```

Il fattore è trattato come **dato empirico/configurabile**, non come lunghezza
letta dal disegno.

Non si deve aggiungere automaticamente un 5–10% di "scorta di posa": la scorta
commerciale serve per approvvigionamento/tagli, non rappresenta tubo realmente
attraversato dall'acqua e falserebbe la perdita di carico.

È previsto un coefficiente di calibrazione:

```text
K_layout = 1.000   (default)
```

e quindi:

```text
L_spirale_idraulica =
    Area_servita_m2 * F_passo_m_per_m2 * K_layout
```

`K_layout` resterà 1.000 finché regression test su spirali sane non
dimostreranno uno scostamento sistematico. Non va modificato per far coincidere
arbitrariamente un singolo caso.

#### 6.1.3 Collegamenti al collettore

Alla lunghezza stimata della spirale deve essere sommata la lunghezza
**geometrica reale** dei tubi di collegamento.

```text
L_collegamenti =
    somma lunghezze centrolinea mandata
  + somma lunghezze centrolinea ritorno
```

Questi tratti sono già rappresentabili dalla geometria/grafo prodotto dal
sistema Pannelli e non devono essere stimati con un coefficiente percentuale.

Per un circuito:

```text
L_idraulica_totale =
    L_spirale_idraulica
  + L_collegamenti
```

Se in futuro collegamento e spirale useranno diametri/materiali differenti, il
solver non userà più una sola lunghezza equivalente ma sommerà le perdite dei
singoli segmenti in serie.

#### 6.1.4 Confine del circuito

Per la prima versione il "circuito pannello" va inteso:

```text
uscita collettore
    -> collegamento mandata
    -> spirale nel pavimento
    -> collegamento ritorno
    -> ingresso collettore
```

Sono esclusi dalla prima versione:

- perdita interna del collettore;
- valvole di regolazione;
- flussimetri;
- attuatori;
- raccordi speciali esplicitamente modellati;
- prevalenza della distribuzione primaria.

Questi componenti entreranno nel successivo programma generalista attraverso
le perdite concentrate.

#### 6.1.5 Input minimo del calcolo

Per ogni circuito:

```text
AreaServita_m2
Passo_mm
LunghezzaCollegamenti_m
Portata_m3_s (o unità convertibile)
CodiceTubazione
CodiceFluido
TemperaturaMediaFluido_C
```

`TemperaturaMediaFluido_C` deve preferibilmente essere:

```text
(T_mandata + T_ritorno) / 2
```

La portata è un input autorevole proveniente dal calcolo pannelli. Una futura
funzione potrà ricavarla da potenza e salto termico, ma non fa parte di questa
prima specifica.

#### 6.1.6 Formula predefinita: Darcy-Weisbach

Formula primaria:

```text
DeltaP = f * (L / D) * (rho * v² / 2)
```

con:

```text
v  = 4 Q / (pi D²)
Re = rho v D / mu
```

dove:

- `L` = lunghezza idraulica totale [m];
- `D` = diametro interno [m];
- `Q` = portata volumetrica [m³/s];
- `rho` = densità fluido [kg/m³];
- `mu` = viscosità dinamica [Pa s];
- `f` = fattore di attrito Darcy.

Per il fattore di attrito:

- regime laminare: `f = 64 / Re`;
- regime turbolento: Colebrook-White con rugosità relativa `epsilon / D`;
- zona di transizione: deve produrre una diagnostica esplicita; la regola
  numerica definitiva sarà fissata durante l'implementazione del kernel.

Darcy-Weisbach è confermata come formula generale di default. Il vecchio
Pascal già contiene una forma Darcy/Colebrook, ma il nuovo kernel sarà
implementato e testato autonomamente.

Riferimenti verificati:
- https://www.engineeringtoolbox.com/darcy-weisbach-equation-d_646.html
- PPI, *PEX Pipe Design Manual for Water Oil Gas Industrial Applications*,
  edizione 2024:
  https://www.plasticpipe.org/common/Uploaded%20files/1-PPI/Manuals-Design%20Guides/PEX%20Pipe%20MRS%20Based/PEX%20Pipe%20Design%20Manual%20for%20WOG%20MRS%20Based.pdf

#### 6.1.7 Output minimo della prima funzione

Per ogni circuito il risultato dovrà almeno contenere:

```text
AreaServita_m2
Passo_mm
FattorePasso_m_m2
K_layout
LunghezzaSpiraleStimata_m
LunghezzaCollegamenti_m
LunghezzaIdraulicaTotale_m
Portata
DiametroInterno_mm
Velocita_m_s
Reynolds
FattoreAttritoDarcy
PerditaLineare_Pa_m
PerditaCircuito_Pa
PerditaCircuito_kPa
Diagnostiche[]
```

La prima versione calcola la perdita distribuita della tubazione. Finché le
perdite concentrate non saranno introdotte, il dato esposto come perdita del
circuito deve essere accompagnato nella diagnostica dalla qualificazione
"perdita distribuita; componenti locali non ancora modellati".

#### 6.1.8 Controllo di coerenza con la spirale grafica

Se è disponibile una lunghezza proveniente dal generatore della spirale:

```text
L_grafica
```

essa non entra nel calcolo Darcy, ma può generare un controllo diagnostico:

```text
scostamento =
    abs(L_grafica - L_spirale_idraulica) / L_spirale_idraulica
```

Una soglia verrà definita con i test. Uno scostamento elevato deve segnalare
possibile corruzione geometrica senza alterare automaticamente il risultato
idraulico.


## 7. Database Tubazioni indipendente

### 7.1 Precedente storico `base.dat`

Il `base.dat` Tubazioni storico è stato trovato in tre collocazioni della
versione 10; le tre copie lette hanno lo stesso Git blob:

```text
a643c307657969b756d53cbeca484a20463596dc
```

Il file descrive in modo dichiarativo tabelle, campi, default e relazioni.

Archivi particolarmente rilevanti:

- `Reti`;
- `Tubazioni`;
- `Diametri`;
- `MatTubi`;
- `Perdite`;
- `TipiRete`;
- `TipoTerminali` / `DettTerminali`;
- `Perdite_Conc` / `Dett_Perdite_Conc`;
- dati fluidi e valvole presenti negli altri sorgenti storici.

La sintassi storica contiene metadati equivalenti concettualmente a:

- `INI`: valore iniziale;
- `CMB`: scelta da elenco;
- `LKK`: lookup fra archivi;
- `GRD`: colonna visibile/griglia;
- `DEC`: precisione;
- relazioni master/slave.

### 7.2 Generatore storico e automazione form

Il vecchio programma `GENERA` leggeva `base.dat` e generava
automaticamente:

- strutture record;
- database;
- lettura/scrittura dati;
- griglie;
- form;
- combo;
- lookup;
- inizializzazioni;
- validazioni;
- relazioni master/slave.

Il codice generato `CompilaForm.pas` usa infatti primitive come
`etichetta`, `AddGrid`, `AddCombo`, `LookUp`.

Il nuovo sistema deve conservare **questa idea**, non il generatore Pascal:
i metadati JSON devono essere interpretati direttamente a runtime.

### 7.3 Nuovo schema JSON

Nome di lavoro:

```text
tubazioni-definizionedati.json
```

Deve essere separato da:

```text
SorgentiTermodel/Library/definizionedati/definizionedati.json
Server/.../Definitions/definizionedati.json
```

e usare la stessa forma concettuale del metadata Termodel corrente:

```json
{
  "Tubazioni": {
    "Codice": {
      "LunghezzaMassima": 50,
      "Descr": "Codice",
      "Ini": "",
      "Grid": ["Archivio"]
    },
    "Materiale": {
      "Descr": "Materiale",
      "Combo": ["auto_combo", "MaterialiTubi", "Codice", ""]
    }
  }
}
```

Le proprietà Termodel da mantenere compatibili dove applicabili sono:

- `LunghezzaMassima`;
- `NumeroCifre`;
- `NumeroDecimali`;
- `Descr`;
- `Ini`;
- `ReadOnly`;
- `Combo`;
- `Grid`;
- `Form`.

In particolare va mantenuta la convenzione:

```json
["auto_combo", "NomeArchivio", "Campo", "ValoreInizialeOpzionale"]
```

per i lookup dinamici.

### 7.4 Dati operativi JSON

Tubazioni avrà anche un archivio dati indipendente JSON. Nome di lavoro:

```text
tubazioni-database.json
```

La struttura logica deve mantenere la semantica già usata da Termodel in
memoria: **archivio -> elenco righe -> campi valore**, ad esempio:

```json
{
  "format": "TERMODEL-TUBAZIONI-DATABASE",
  "version": 1,
  "archives": {
    "MaterialiTubi": [
      {
        "Codice": "PEX",
        "Descrizione": "Polietilene reticolato",
        "RugositaMm": "..."
      }
    ],
    "Tubazioni": [],
    "Diametri": [],
    "PerditeLocalizzate": []
  }
}
```

I nomi definitivi, i tipi e i dati iniziali devono essere approvati dopo il
mapping completo di `base.dat` e degli archivi storici.

**Nota importante:** il Termodel Desktop corrente usa
`definizionedati.json` come metadata e persiste molti archivi operativi in
XML. Per Tubazioni la decisione è invece di usare JSON anche per il database
operativo, mantenendo però la stessa filosofia di collection di record e lo
stesso metadata/AutoForm. Non va dichiarato che l'attuale archivio Termodel
sia già persistito interamente in JSON.

### 7.5 Archivi candidati della prima versione

Da verificare nel mapping di dettaglio:

```text
Reti
MaterialiTubi
Tubazioni
Diametri
TipiRete
PerditeLocalizzate
PerditeConcentrate
DettaglioPerditeConcentrate
Terminali
Fluidi
ValvoleTaratura
Collettori
```

Le relazioni master/slave del vecchio `base.dat` devono diventare lookup e
chiavi esplicite, senza puntatori o dipendenza dall'ordine fisico delle righe.

### 7.6 Revisione archivi pannelli radianti — modello autorevole

**Revisione 23 settembre 2026 — la precedente ipotesi
`TipologiePannelli / Tubazioni / Fluidi` è SUPERATA.**

Per il completamento pannelli radianti gli archivi autorevoli sono due:

```text
Reti
TipologiePannelli
```

La separazione segue la responsabilità dei dati:

```text
Reti
  = cosa sto progettando e come deve funzionare

TipologiePannelli
  = quale prodotto/sistema costruttivo sto usando
```

#### 7.6.1 Archivio Reti

`Reti` è predisposto come archivio generalista della rete.

Tipi futuri previsti:

```text
PannelliRadianti
Tubazioni
Canali
...
```

Nella fase corrente è implementato soltanto:

```text
TipoRete = PannelliRadianti
```

Prima riga:

```text
Codice                     RAD-DEFAULT
Descrizione                Pannelli radianti - rete standard
TipoRete                   PannelliRadianti
CodiceTipologiaPannello    GEN-DEFAULT
PassoSelezionatoMm         300
Fluido                     Acqua
TemperaturaMandataC        35
TemperaturaRitornoC        30
TemperaturaAmbienteC       20
TemperaturaEsternaProgettoC 5
LunghezzaMassimaCircuitoM  100
PerditaCaricoMassimaCircuitoPa 25000
KLayout                    1.000
FormulaPerdita             Darcy-Weisbach
Attivo                     SI
```

Principio: in `Reti` vanno i dati che **non dipendono dal costruttore del
pannello**, ma dalla scelta progettuale e dalle condizioni di esercizio.

La temperatura media dell'acqua sarà ricavata da mandata/ritorno. Per la prima
versione il fluido è acqua e le proprietà termofisiche necessarie a Darcy
(densità e viscosità) verranno ricavate dal kernel in funzione della
temperatura, senza un archivio `Fluidi` separato.

Il passo selezionato appartiene alla rete, ma dovrà essere validato rispetto ai
passi ammessi dalla tipologia pannello selezionata.

#### 7.6.2 Archivio TipologiePannelli

Chiave funzionale:

```text
CasaProduttrice + Modello
```

La tipologia contiene dati legati al prodotto/sistema:

```text
Codice
CasaProduttrice
Modello
Descrizione
MaterialeTubo
DiametroEsternoTuboMm
SpessoreTuboMm
DiametroInternoTuboMm
RugositaAssolutaMm
BarrieraOssigeno
PassiDisponibiliMm
LunghezzaMatassaM
CoefficienteResaWm2K
Attivo
```

Prima riga:

```text
Codice                 GEN-DEFAULT
CasaProduttrice        Generico
Modello                Default Termodel
MaterialeTubo          PE-Xa
DiametroEsternoTuboMm  16
SpessoreTuboMm         2
DiametroInternoTuboMm  12
RugositaAssolutaMm     0.0007
BarrieraOssigeno       SI
PassiDisponibiliMm     50;100;150;200;250;300
LunghezzaMatassaM      600
CoefficienteResaWm2K   5
Attivo                 SI
```

L'elenco passi è esplicito perché alcuni sistemi, in particolare pannelli a
funghetti, permettono soltanto interassi discreti determinati dalla geometria
del pannello.

Il default della rete usa 300 mm per conservare l'attuale comportamento
`PassoTubi = 0,30 m`.

Il riferimento PE-Xa 16x2, barriera ossigeno e rugosità 0.0007 mm resta quello
già verificato nella specifica precedente.

#### 7.6.3 Dati non più separati

I nuovi progetti non generano più:

```text
Tubazioni
Fluidi
```

come archivi separati per il ramo pannelli.

Le caratteristiche del tubo usato dal pannello sono proprietà di
`TipologiePannelli`. Le condizioni dell'acqua e la formula idraulica sono
proprietà della rete/solver.

Eventuali vecchi progetti creati durante la breve fase precedente possono
contenere ancora `Tubazioni`, `Fluidi` e
`definition/pannelli-tubazioni-definizionedati.json`: il frontend li può
leggere per compatibilità e deve preservarli senza cancellazione automatica,
ma non sono più il modello autorevole.

### 7.7 Gestione frontend e futura selezione CAD

Implementato nel frontend:

```text
Modifica
  ├── Archivio Reti
  └── Archivio Tipologie pannelli
```

I due archivi usano il metadata:

```text
definition/reti-pannelli-definizionedati.json
```

e il motore unico `ArchivioWeb`.

#### Selezione della rete nel CAD 2D

Decisione registrata:

```text
CAD 2D
  -> combo Rete
  -> selezione Reti.Codice
  -> TipoRete determina il tipo di rete che si sta disegnando
```

**Stato: DA DEFINIRE / NON IMPLEMENTATO.**

Verranno definiti in seguito:

- posizione della combo;
- associazione fra primitive grafiche e codice rete;
- comportamento quando cambia rete;
- comandi grafici specifici per PannelliRadianti, Tubazioni, Canali;
- validazione del passo selezionato rispetto a
  `TipologiePannelli.PassiDisponibiliMm`.

## 8. Automazione Form

Il riferimento moderno è:

```text
SorgentiTermodel/Library/definizionedati/AutoForm.cs
SorgentiTermodel/Library/definizionedati/FormArchivio.xaml.cs
```

Il principio da riusare è:

```text
metadata JSON
    |
    +--> campi
    +--> etichette
    +--> default
    +--> combo/lookup
    +--> colonne griglia
    +--> readonly/validazione
    |
    v
form generata automaticamente
```

Il nuovo sviluppo non deve copiare WPF dentro il Core. Va separato:

- **Tubazioni.Metadata**: schema neutro;
- **Tubazioni.Data**: collezioni e validazione;
- **renderer UI**: Desktop/Web specifico.

Quando il frontend verrà coinvolto, la stessa definizione JSON dovrà poter
pilotare una form Web senza duplicare manualmente lo schema.

## 9. Architettura target

Struttura logica proposta:

```text
Termodel.Core
│
├── Pannelli / modello energetico
│
└── Tubazioni
    ├── Domain
    │   ├── Network
    │   ├── Node
    │   ├── Segment
    │   ├── Terminal
    │   ├── Manifold
    │   └── ComponentLoss
    │
    ├── Hydraulics
    │   ├── FlowPropagation
    │   ├── Friction
    │   ├── LocalLosses
    │   ├── PipeSizing
    │   ├── CriticalPath
    │   └── Balancing
    │
    ├── Data
    │   ├── metadata JSON
    │   ├── database JSON
    │   └── validation/lookups
    │
    ├── Adapters
    │   ├── RadiantPanels
    │   ├── TermodelGeometry
    │   └── DXF/SVG (solo se necessario)
    │
    └── Results
        ├── HydraulicResult
        ├── SegmentResult
        ├── CircuitResult
        ├── Diagnostics
        └── DrawingResult
```

La collocazione fisica definitiva dentro `Termodel.Core` verrà scelta nella
fase di implementazione. Non creare un nuovo servizio autonomo di rete se una
libreria Core è sufficiente.

## 10. Contratto interno preliminare

Il solver dovrà tendere a una API pura simile a:

```text
TubazioniResult Calculate(
    TubazioniNetwork network,
    TubazioniDatabase database,
    TubazioniCalculationOptions options)
```

Questa firma è solo una direzione progettuale; non è ancora contratto pubblico.

`TubazioniCalculationOptions` dovrà sostituire i vecchi flag/file e potrà
contenere, dopo verifica:

- modalità verifica/predimensionamento;
- equilibratura;
- inserimento valvole di taratura;
- calcolo portata effettiva;
- tolleranza;
- numero massimo iterazioni;
- eventuale trattamento mandata/ritorno.

## 11. Risultati attesi

Il risultato non deve limitarsi a un numero globale. Dovrà poter contenere:

- portata totale;
- prevalenza richiesta;
- percorso più sfavorito;
- risultato per ogni tronco:
  - portata;
  - diametro;
  - velocità;
  - perdita lineare;
  - perdita distribuita;
  - perdite concentrate;
  - perdita progressiva;
- eventuale sbilanciamento;
- taratura/valvola quando abilitata;
- risultati per circuito pannello;
- warning/errori strutturati;
- eventuale drawing result per mandata/ritorno/collettori/quote.

Le unità devono essere esplicite nel modello e nei test. Il nuovo codice non
deve dipendere dalle unità implicite del Pascal.

## 12. Diagnostica e logging

Il nuovo modulo non deve creare un logger globale separato.

Decisione provvisoria:

- il solver produce una lista strutturata di diagnostiche;
- l'adattatore Termodel potrà riversarle nel `TermodelLog` della singola
  elaborazione;
- l'eventuale nuova categoria `Tubazioni` di `TermodelLog` non viene
  introdotta in questa fase: richiederà una decisione esplicita e
  aggiornamento del contratto log.

## 13. Integrazione futura con Aggiorna Modello

**Non implementata in questa fase.**

La sequenza target è:

```text
POST /api/calculations
        |
        v
caricamento progetto
        |
        v
modello Termodel
        |
        +--> pannelli/spirali (quando richiesti)
        |
        +--> adattamento rete Tubazioni
        |
        +--> Tubazioni.Core.Calculate(...)
        |
        v
publish transazionale degli artifact
```

Prima dell'integrazione si dovranno decidere:

- come il progetto dichiara che il calcolo Tubazioni è richiesto;
- quali dati Tubazioni appartengono al progetto e quali al database generale;
- dove vengono collocati metadata e database iniziale;
- nome/formato dell'artifact risultante;
- eventuali endpoint di lettura;
- regole stale e persistenza;
- compatibilità col frontend.

Qualunque modifica a `TERMODEL-PROJECT-TEXT-V1` o al contratto
Frontend↔Service richiederà un incarico separato.

## 14. Strategia di regression test

Il Pascal storico va usato come riferimento di confronto, non come dipendenza
runtime.

### Livello A — formule pure

Test su:

- Reynolds;
- Darcy/Colebrook;
- perdita lineare;
- velocità;
- perdite concentrate Zeta/Kv dove applicabili;
- conversioni di unità.

### Livello B — singolo tronco

Input noto:

```text
portata + lunghezza + tubo + diametro + fluido + perdite concentrate
```

Confrontare:

```text
velocità
perdita lineare
perdita totale
```

### Livello C — albero semplice

Rete con una origine, una diramazione e due terminali:

- propagazione portate;
- scelta diametri;
- percorso sfavorito;
- prevalenza.

### Livello D — equilibratura

Rete asimmetrica con risultati Pascal approvati:

- sbilanciamento iniziale;
- scelta diametri;
- eventuale taratura;
- convergenza entro tolleranza.

### Livello E — pannelli radianti

Caso reale ridotto:

```text
collettore
  +-- circuito locale A
  +-- circuito locale B
```

Confrontare lunghezze, portate, perdite dei circuiti, collettore e prevalenza.

### Golden Results

Quando saranno disponibili esecuzioni Pascal riproducibili, salvare input e
risultati approvati in una struttura coerente con la strategia generale
`TestProjects / GoldenResults / RegressionRunner`.

Un Golden Result non deve essere aggiornato automaticamente quando il nuovo
motore produce un valore differente.

## 15. Fasi di sviluppo

| Fase | Contenuto | Stato |
|---|---|---|
| T0 | studio sorgenti Pascal, `base.dat`, generatore form/DB, DXF e Pannelli C# | **ESEGUITO** |
| T1 | specifica metadata/database reti e mapping progressivo `base.dat` | **IN CORSO** — modello pannelli revisionato in `Reti` + `TipologiePannelli` |
| T2 | dominio neutro `TubazioniNetwork` + validazione topologica | DA FARE |
| T3 | kernel idraulico puro: portate, attrito, perdite, sizing, percorso sfavorito | DA FARE |
| T4 | equilibratura / valvole / portate effettive selezionate | DA FARE |
| T5 | adapter Pannelli radianti usando il grafo C# corrente | DA FARE |
| T6 | regression test Pascal/golden | DA FARE |
| T7 | drawing result neutro e adapter DXF/SVG | DA FARE |
| T8 | integrazione controllata in `Aggiorna Modello` | DA FARE |
| T9 | eventuale UI Web/Desktop guidata dai metadata | DA FARE |

## 15.1 Milestone — completamento dati di base pannelli radianti

Aggiornamento 23 settembre 2026 — **REVISIONATO**.

La prima implementazione aveva separato:

```text
TipologiePannelli
Tubazioni
Fluidi
```

Questa struttura è stata riconosciuta come eccessivamente frammentata ed è
stata sostituita dal modello:

```text
Reti
TipologiePannelli
```

Metadata autorevole:

```text
definition/reti-pannelli-definizionedati.json
```

### Reti

Contiene il tipo di rete e i dati di progetto/esercizio non dipendenti dal
costruttore. La prima riga è `RAD-DEFAULT / PannelliRadianti`, collega la
tipologia `GEN-DEFAULT`, usa passo 300 mm, acqua 35/30 °C,
limite circuito 100 m, limite perdita 25 kPa, `KLayout=1` e
`Darcy-Weisbach`.

### TipologiePannelli

Contiene casa produttrice/modello e caratteristiche costruttive: tubo PE-Xa
16x2, diametro interno 12 mm, rugosità 0.0007 mm, barriera ossigeno, matassa,
coefficiente resa e lista dei passi ammessi.

### Consolidamento progetto

`ProgFileUnico` e il `ProgettoVuoto` generano ora soltanto
`Reti` e `TipologiePannelli` fra gli archivi estesi del ramo pannelli.

Il vecchio `definizionedati.json` resta invariato.

Il frontend espone:

```text
Archivio Reti
Archivio Tipologie pannelli
```

La futura combo Rete del CAD 2D è registrata ma non ancora implementata.

Stato della milestone:

```text
metadata Reti/TipologiePannelli: IMPLEMENTATO
dati iniziali:                  IMPLEMENTATI
integrazione progetto nuovo:    IMPLEMENTATA
ProgettoVuoto frontend:         IMPLEMENTATO
voci archivio frontend:         IMPLEMENTATE
compatibilità metadata legacy:  PRESERVATA IN LETTURA
combo Rete CAD 2D:              DA DEFINIRE
lettura archivi dal solver:     DA FARE
perdita Darcy circuito:         DA FARE
```

## 16. Decisioni consolidate

- Nome linea: **Calcolo Tubazioni**.
- Sviluppo autonomo, ma destinato a vivere come libreria riusabile dal Core.
- Primo utilizzo: supporto idraulico ai pannelli radianti.
- Prima funzione operativa: perdita di carico distribuita del singolo circuito radiante.
- Fonte algoritmica primaria: vecchio sottosistema Pascal `Tubi`.
- `base.dat` e `GENERA` sono precedenti storici del nuovo metadata system.
- Per il ramo pannelli i dati progetto sono organizzati in `Reti` e `TipologiePannelli`.
- Il metadata esteso è JSON autonomo e compatibile con le convenzioni di
  `definizionedati.json`.
- Automazione form: obbligatoria come principio; non creare una form rigida per
  ciascun archivio.
- Nessuna modifica all'attuale `definizionedati.json`.
- Nessuna dipendenza necessaria da AutoCAD.
- Il solver deve lavorare su grafo/rete neutri, non direttamente su DXF.
- I risultati grafici sono derivati e separati dall'algoritmo idraulico.
- Il collegamento con `Aggiorna Modello` verrà fatto solo dopo test autonomi.

## 17. Questioni aperte

- estendere in futuro `Reti.TipoRete` oltre `PannelliRadianti` verso
  Tubazioni/Canali senza creare archivi concorrenti;
- definire la combo `Reti` nel CAD 2D e l'associazione delle primitive alla rete;
- implementare la validazione del passo selezionato rispetto ai passi ammessi
  dalla tipologia pannello;
- verificare quali dati storici siano ancora tecnicamente/normativamente
  appropriati;
- definire nel kernel le proprietà dell'acqua in funzione della temperatura
  media e l'eventuale futura estensione ad altri fluidi;
- identificare progetti Pascal ancora eseguibili per produrre Golden Results;
- formalizzare la relazione circuiti Pannelli ↔ terminali Tubazioni;
- decidere il formato finale del drawing result;
- decidere se introdurre una categoria log `Tubazioni`;
- definire in un incarico futuro il contratto di integrazione con
  `POST /api/calculations`.

## 18. Stato di verifica

```text
studiato sorgenti storici:       SI, prima mappatura
architettura progettata:         SI, livello registro
metadata JSON Reti/Pannelli:     SI
dati progetto Reti/Pannelli:     SI
solver idraulico implementato:   NO
adapter Pannelli implementato:   NO
integrazione Aggiorna Modello:   NO
compilato:                       NON APPLICABILE in questa fase documentale
eseguito:                        NO
regression test Pascal:          NO
confronto Golden:                NO
```

La prossima attività corretta per il ramo pannelli è collegare il calcolo
pannelli ai due archivi `Reti`/`TipologiePannelli` e implementare il primo
caso Darcy-Weisbach su un circuito sintetico. La combo Rete del CAD 2D verrà
progettata separatamente.
