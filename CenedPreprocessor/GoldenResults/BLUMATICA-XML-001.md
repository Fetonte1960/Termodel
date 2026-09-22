# Golden Reference — XML nazionale testato con Blumatica

Identificativo: **BLUMATICA-XML-001**  
Data acquisizione: **2026-09-22**  
File originale fornito: `output.xml`  
Stato: **RIFERIMENTO ESTERNO ACQUISITO — FILE GREZZO NON PUBBLICATO**

## Provenienza e valore del riferimento

L'utente ha fornito un file XML dichiarato **testato con la funzione di import di Blumatica**.  
Blumatica svolge, per questo scenario, una funzione di import analoga a quella che il Software Bridge WebJS dovrà supportare come riferimento di interoperabilità.

Il documento viene quindi assunto come **Golden Reference strutturale e funzionale** per discutere e verificare l'XML nazionale prodotto dalla futura versione WebJS.

La validazione con Blumatica è un'evidenza operativa fornita dall'utente; non è stata rieseguita da questa sessione.

## Integrità del file originale

- nome: `output.xml`
- dimensione: **415492 byte**
- SHA-256: **4988a0700ad1aeb60ef6906235411a176baee514f7a902533dfcc1ad86980647**
- XML: **ben formato**, parsing riuscito
- radice: `<documento>`

Il digest SHA-256 è l'identificatore autorevole del file originale. Se lo stesso documento verrà fornito in futuro, il digest deve coincidere prima di considerarlo lo stesso Golden Reference.

## Struttura principale rilevata

```xml
<documento>
  <ape2015>
    ...
  </ape2015>
  <datiCalcolo>
    ...
  </datiCalcolo>
</documento>
```

Versioni dichiarate nel file:
- `ape2015/info/versione`: **12.00**
- `datiCalcolo/info/versione`: **5.00**
- `datiCalcolo/info/dataVersione`: **2016-12-19**

Il file dichiara inoltre:
- software utilizzato: **Blumatica Energy 6**
- numero certificato software: **64**

## Contenuto strutturale rilevato

Il documento contiene contemporaneamente:
- dati dell'Attestato APE;
- dati generali dell'edificio;
- prestazione energetica globale;
- dati impianti;
- dati fabbricato;
- soggetto certificatore;
- dati extra;
- blocco completo `datiCalcolo`;
- dati climatici mensili;
- fabbricato;
- sub-edificio;
- locali;
- superfici opache;
- superfici vetrate;
- ponti termici;
- impianti;
- generatori;
- fabbisogni e risultati mensili.

Conteggi utili del campione:
- `subEdificio`: **1**
- `locale`: **5**
- `superficieOpaca`: **39**
- `superficieVetrata`: **25**
- `PonteTermico`: **184**
- `impianto`: **42**
- `generatore`: **2**

I conteggi descrivono questo specifico campione e non costituiscono vincoli dello schema.

## Uso nel progetto WebJS

Il riferimento BLUMATICA-XML-001 deve essere utilizzato per:

1. definire la struttura dell'output XML nazionale del Bridge;
2. verificare la presenza dei macro-blocchi `ape2015` e `datiCalcolo`;
3. mappare il modello intermedio WebJS verso sezioni e campi XML;
4. verificare gerarchie e cardinalità osservate;
5. costruire test di serializzazione;
6. confrontare XML prodotti dal Bridge con un documento realmente accettato da un software terzo;
7. discutere quali campi siano input, derivati o risultati di calcolo.

## Limiti

Questo file NON dimostra da solo:
- compatibilità con CENED+2 Motore Lombardia;
- conformità alle specifiche ARIA correnti;
- obbligatorietà di tutti i campi;
- validità di ogni codice/enumerazione per CENED;
- equivalenza fra XML nazionale APE e XML proprietario/operativo del Motore CENED.

Il documento è quindi un riferimento fondamentale per l'**output nazionale/interoperabile**, ma deve essere tenuto distinto dal futuro XML/API specifico CENED+2 Motore.

## Privacy e repository pubblico

Il file originale contiene dati personali e identificativi reali.

Poiché il repository `Fetonte1960/Termodel` è pubblico:
- il file grezzo NON viene copiato in GitHub;
- non viene prodotta automaticamente una copia anonimizzata spacciandola per "testata", perché una modifica ai valori invaliderebbe tale qualifica;
- nel repository restano soltanto hash, metadati tecnici e struttura di riferimento.

Se in futuro verrà creato un XML anonimizzato, dovrà avere un nuovo identificativo e uno stato distinto, ad esempio **DERIVATO-NON-VALIDATO**, finché non verrà nuovamente importato con successo in Blumatica/CENED.

## Regola futura

Per il primo XML generato dalla WebJS:
- confrontare struttura e campi con BLUMATICA-XML-001;
- mantenere distinto ciò che deriva direttamente dal modello importato da ciò che è risultato di calcolo;
- non replicare valori specifici del campione;
- documentare tutte le differenze deliberate.
