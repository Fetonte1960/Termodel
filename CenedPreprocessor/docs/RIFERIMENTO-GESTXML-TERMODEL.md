# Riferimento sorgente Termodel — GestXml.cs

Identificativo: **TERMODEL-GESTXML-001**  
Data acquisizione: **2026-09-22**  
Ruolo: **fonte di ispirazione tecnica non vincolante per WebJS**

## 1. Snapshot acquisito

File fornito dall'utente:
- nome: `GestXml.cs`
- dimensione originale: **105061 byte**
- righe: circa **2069**
- SHA-256: **906cde73c919fa90359daae0df0c00a1a088e318e3c2b9130b293ab1e51c0736**

Il contenuto corrisponde sostanzialmente al sorgente già presente nel repository:

`SorgentiTermodel/Library/GestXml.cs`

Per evitare duplicazione e divergenze, il file non viene copiato in `CenedPreprocessor/`: il riferimento persistente resta il percorso sopra, mentre questo documento registra lo snapshot e il suo ruolo.

## 2. Ruolo nel progetto Cened WebJS

`GestXml.cs` è considerato utile perché mostra come Termodel:
- legge un XML nazionale di base;
- ricostruisce `fabbricato`, `subEdificio`, `listaLocali` e `locale`;
- classifica i componenti per tipo di confine;
- genera superfici opache;
- genera superfici vetrate;
- genera ponti termici;
- calcola superfici e volumi;
- gestisce esposizione e inclinazione;
- associa componenti a stratigrafie e vetrate;
- serializza e salva l'XML finale.

Questo lo rende una buona fonte per comprendere il **mapping Termodel → XML nazionale**.

## 3. Elementi concettualmente utili alla WebJS

### 3.1 Gerarchia edificio

Sequenza utile:

```text
zone
  ↓
subEdificio
  ↓
listaLocali
  ↓
locale
  ↓
trasmissione
  ↓
confini
  ↓
superficieOpaca / superficieVetrata / PonteTermico
```

Questa gerarchia è coerente con il Golden Reference BLUMATICA-XML-001 e può guidare il modello intermedio WebJS.

### 3.2 Classificazione dei confini

Il sorgente distingue:

- Esterno
- Interno
- AmbienteNonClimatizzato
- AmbienteClimatizzato
- Terreno
- Fittizia
- Dividi
- Sconosciuto

Per WebJS è utile soprattutto il principio di separare il **tipo geometrico** dal **tipo termico di confine**.

### 3.3 Superfici opache

Il sorgente costruisce nodi `superficieOpaca` con campi come:

- descrizione
- tipo
- superficieDisperdente
- trasmittanza
- fonteTrasmittanza
- idComponenteStratigrafia
- esposizione
- inclinazione
- fattoreOmbreggiaturaDiffusa
- capacitàTermica

Per ambienti non climatizzati aggiunge anche `idAmbienteConfinante`.

### 3.4 Superfici vetrate

La funzione `XMLFinestra(...)` mostra un mapping dettagliato fra geometria/archivio finestra e XML:

- superficieDisperdente
- areaVetro
- perimetroVetro
- areaTelaio
- trasmittanzaInfisso
- trasmittanzaInfissoCorretta
- idComponenteVetrata
- esposizione
- inclinazione
- fattori mensili

È utile come traccia per distinguere:
- dati geometrici;
- dati di archivio;
- dati derivati;
- valori mensili.

### 3.5 Ponti termici

`AggiungiPonte(...)` produce:

- descrizione
- categoria
- trasmittanzaLineare
- lunghezza

Questa struttura è direttamente utile per il modello intermedio WebJS.

### 3.6 Orientamento e inclinazione

Il sorgente contiene una conversione esplicita fra direzione geometrica, Nord del progetto e convenzione XML.

Principio da conservare:
- il modello WebJS deve avere una convenzione interna chiara;
- la conversione verso XML deve essere fatta solo nello strato di esportazione;
- evitare che la UI dipenda direttamente dalla convenzione angolare del formato di output.

### 3.7 Formattazione numerica

Il sorgente usa `InvariantCulture` e punto decimale.

Questo è un principio da adottare nella serializzazione XML WebJS.

## 4. Aspetti che NON devono essere copiati come architettura WebJS

Il sorgente è fortemente accoppiato all'applicazione Desktop.

Dipendenze da non trasferire:
- WPF / `MainWindow`;
- `Polig3D`;
- Xbim;
- database/collection globali Termodel;
- variabili statiche globali;
- report UI durante la generazione;
- accesso diretto agli archivi Desktop;
- logica pannelli e `CalcoloAPE` eseguita dentro `GeneraXml`.

La WebJS deve avere moduli separati:

```text
modello dati
    ↓
normalizzazione
    ↓
validazione
    ↓
mapper XML
    ↓
serializer XML
```

senza dipendere dall'interfaccia.

## 5. Aspetti da considerare solo come indizi

Nel sorgente sono presenti valori e logiche che NON vanno assunti come specifica normativa:

- valori mensili hard-coded per ombreggiamento, extraFlusso e apportiSolari;
- `capacitàTermica = 40.32`;
- `fonteTrasmittanza = 1`;
- `fattoreOmbreggiaturaDiffusa = 0.75` per finestre;
- dati climatici/temperature specifiche;
- formule o fallback per terreno;
- normalizzazione esposizioni a multipli di 45°;
- alcune associazioni desunte dagli archivi Termodel.

Questi elementi devono essere verificati contro:
1. specifiche ufficiali;
2. manuale CENED;
3. Golden Reference;
4. futuri casi prova.

## 6. Osservazione sulla modalità CENED

Nel sorgente corrente la generazione CENED è esplicitamente disattivata:

```text
Cened.IsCened = false; // in attesa di certificazione
```

Quindi questo file è soprattutto un generatore/mappatore per l'XML nazionale corrente di Termodel, non una specifica autorevole per CENED+2 Motore.

## 7. Priorità delle fonti

Per la WebJS l'ordine di autorità è:

```text
specifiche ufficiali ARIA / formato ufficiale
        ↓
Golden Reference validati
        ↓
specifica propria del Software Bridge
        ↓
GestXml.cs Termodel come fonte di ispirazione
```

Se `GestXml.cs` diverge da una fonte superiore, non deve essere seguito.

## 8. Uso consigliato nella prima bozza WebJS

Riutilizzare concettualmente:
- classificazione confini;
- struttura zone → locali → superfici;
- separazione opache / vetrate / ponti;
- calcolo degli aggregati geometrici;
- conversione orientamento/inclinazione;
- associazione agli archivi;
- serializzazione con punto decimale.

Riscrivere in JavaScript con modello dati indipendente e funzioni pure, senza traduzione riga-per-riga del codice C#.
