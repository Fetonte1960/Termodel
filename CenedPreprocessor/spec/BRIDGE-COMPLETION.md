# Bridge Completion XML 1.0

## Scopo

`BridgeCompletion.xml` è il terzo file del contratto di ingresso del Software Bridge.

Non sostituisce:
- gbXML;
- XML nazionale.

Serve esclusivamente per rappresentare dati che, dopo l'importazione e il confronto delle due sorgenti principali, risultano:

- mancanti in uno o entrambi i formati;
- specifici del profilo CENED;
- non associabili con certezza fra le due sorgenti.

Lo schema autorevole è:

`bridge-completion-1.0.xsd`

Namespace:

`urn:termodel:cened-bridge:completion:1.0`

## Obbligatorietà

Il file è **opzionale a livello di protocollo**.

Diventa **obbligatorio per uno specifico progetto** quando la validazione del Bridge individua almeno un dato necessario all'output CENED che non può essere ricavato con certezza da gbXML + XML nazionale.

Se non esistono lacune residue, il Bridge deve poter lavorare senza sidecar.

## Autorità delle sorgenti

Ordine per dominio:

1. **gbXML** — autorità per geometria e cause fisiche;
2. **XML nazionale** — autorità per dati nazionali/energetici e dati APE/calcolo già rappresentati;
3. **Bridge Completion XML** — autorità esclusivamente sui campi residui non rappresentati dalle prime due sorgenti.

Il Completion XML non può essere usato per sovrascrivere silenziosamente un dato già presente nella sorgente autorevole.

Se un `Field` duplica un dato già disponibile:
- la validazione deve segnalarlo;
- il campo non deve essere applicato automaticamente;
- l'anomalia deve essere risolta nella sorgente appropriata.

## Struttura

### Header

Identifica:
- progetto;
- profilo di destinazione;
- eventuale versione target;
- descrizione.

`TargetVersion` può essere omesso nello studio preliminare. Per un output destinato a un Motore reale deve essere valorizzato con la versione effettivamente supportata.

### Inputs

Riferisce la coppia di sorgenti a cui il sidecar appartiene:
- `GbXML`;
- `NationalXML`.

Ogni riferimento può contenere:
- nome file;
- SHA-256;
- versione formato.

Per fixture e studi l'hash è opzionale; per workflow produttivi dovrà essere richiesto per impedire l'associazione del sidecar a file diversi da quelli per cui è stato creato.

### Bindings

I `Binding` servono solo quando l'associazione automatica fra entità delle due sorgenti non è determinabile con certezza.

Esempio:

`Window-South-01` ↔ `FN0001`

Relazioni previste:
- `SameEntity`;
- `Hosts`;
- `CorrespondsTo`.

Un binding determinabile automaticamente non deve essere scritto nel sidecar.

### CompletionFields

Ogni `Field` dichiara obbligatoriamente:

- `id`;
- `scopeType`;
- `scopeRef`;
- `targetKey`;
- `dataType`;
- `reason`;
- `provenance`;
- `status`;
- `Value`.

Attributi opzionali:
- `unit`.

Elementi opzionali:
- `Note`;
- `Evidence`.

## Scope

Valori previsti:

- Project
- Building
- Zone
- Space
- Surface
- Opening
- ThermalBridge
- System
- Generator
- Other

`scopeRef` identifica l'entità nel modello normalizzato o nel dominio di origine.

## Motivo del completamento

Valori previsti:

- `MissingInGbXML`
- `MissingInNationalXML`
- `MissingInBoth`
- `AmbiguousMapping`
- `CenedSpecific`

## Provenienza

Valori previsti:

- `SourceSoftware`
- `ProjectMetadata`
- `UserDeclared`
- `OfficialSpecification`
- `ExternalDocument`

Il Bridge deve conservare questa provenienza nel modello interno.

## Stato del mapping

Ogni binding e campo è:

- `Provisional`;
- `Confirmed`.

Regola di sicurezza:

**un campo Provisional può essere usato nei test e nello studio di fattibilità, ma non deve alimentare un output Motore qualificato come produzione.**

Il passaggio a `Confirmed` richiede un mapping documentato e verificato contro la specifica CENED pertinente.

Quando `provenance="OfficialSpecification"`, il documento di mapping dovrebbe valorizzare `Evidence` con il riferimento alla specifica, se disponibile.

## Regola di minimizzazione

Il Completion XML deve tendere a ridursi nel tempo.

Quando un dato inizialmente inserito nel sidecar diventa:
- ricavabile dal gbXML;
- ricavabile dall'XML nazionale;
- determinabile automaticamente dal Bridge;

quel campo deve essere eliminato dal sidecar.

Il numero di campi residui è quindi una misura utile della qualità dell'interoperabilità.

## Flusso

```text
gbXML ------------------------┐
                             │
XML nazionale ---------------┼──> import / confronto / normalizzazione
                             │
Bridge Completion XML -------┘
                                      ↓
                           modello intermedio unico
                                      ↓
                         validazione completezza CENED
                                      ↓
                              output Motore CENED
```

## Divieti

Il sidecar non deve:
- duplicare sistematicamente gbXML;
- duplicare sistematicamente XML nazionale;
- diventare un modello energetico proprietario alternativo;
- contenere correzioni geometriche che dovrebbero essere fatte nel software sorgente;
- essere usato per nascondere conflitti fra le sorgenti;
- trasformare valori provvisori in dati CENED confermati senza evidenza.

## Sample

`../samples/BRIDGE-COMPLETION-001.xml`

Il sample contiene volutamente:
- un binding provvisorio fra una finestra gbXML e una finestra dell'XML nazionale;
- un campo `PROVISIONAL.*` dimostrativo.

Questi valori provano il contratto dello schema e **non rappresentano requisiti ufficiali CENED**.
