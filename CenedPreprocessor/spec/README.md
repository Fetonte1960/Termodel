# Specifica comune

Questa cartella diventerà la fonte autorevole del contratto dati del preprocessore.

Contenuti previsti:
- modello termico intermedio;
- tabelle e campi;
- tipi e unità di misura;
- obbligatorietà e valori ammessi;
- relazioni tra entità;
- regole di validazione;
- mapping verso l'input del motore Cened;
- versionamento della specifica.

Nessun campo deve essere introdotto soltanto perché comodo a una singola UI: WebJS e Desktop devono consumare la stessa semantica.


## Contratto di ingresso — decisione corrente

Il modello intermedio del Bridge viene costruito a partire da una **coppia obbligatoria di file**:

1. `gbXML` — fonte primaria del modello geometrico/termico;
2. XML nazionale — fonte complementare per i dati mancanti o specifici del flusso nazionale.

La fase di import deve:
- associare i due file allo stesso edificio/progetto;
- estrarre i dati da entrambe le fonti;
- applicare autorità per dominio;
- rilevare e segnalare incoerenze;
- produrre un unico modello normalizzato;
- conservare la provenienza di ogni campo significativo.

Regola fondamentale: un risultato derivato presente nell'XML nazionale non può sostituire una causa fisica richiesta dal modello intermedio. Ad esempio, un fattore di ombreggiamento mensile non sostituisce la geometria dell'aggetto quando questa è necessaria per il mapping successivo.

Il Bridge non modifica manualmente il modello tecnico: una discordanza deve essere corretta nel software sorgente e risolta mediante nuova esportazione.


## Principio dei formati di scambio

La specifica del Bridge distingue tra:

- **formati esterni di scambio**: pubblici, documentati e riconosciuti;
- **modello intermedio interno**: struttura propria del Bridge usata per normalizzazione, validazione e mapping.

I formati esterni non vengono unificati artificialmente in un file proprietario.

Ogni adapter deve dichiarare almeno:
- formato;
- versione/schema;
- dominio coperto;
- campi importati;
- trasformazioni applicate;
- priorità/autorità rispetto ad altre sorgenti;
- diagnostica per dati mancanti o discordanti.

La prima coppia supportata è:
- `gbXML`;
- XML nazionale APE/calcolo.

L'obiettivo è poter aggiungere altri formati pubblici riconosciuti senza cambiare il contratto interno del Bridge.
