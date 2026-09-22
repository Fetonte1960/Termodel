# Riferimenti ufficiali CENED+2

Ultima verifica link: **2026-09-22**

Questo file raccoglie i riferimenti ufficiali ARIA/CENED da usare come punto di partenza nelle future attività del progetto.  
Scopo: evitare ricerche ripetitive e ridurre il rischio di usare documentazione non ufficiale o superata.

## 1. Manuale d'uso Software CENED+2.0 — pagina indice ufficiale

Pagina ARIA/CENED:

https://www.cened.it/download/-/asset_publisher/vamgUje8wyb4/content/manuale-d-uso-software-cened-2-0?inheritRedirect=true

È il riferimento principale. La pagina raccoglie:
- Copertina e Indice;
- Modulo A — Menu e comandi generali;
- Modulo B — Archivi;
- Modulo C — Edificio: gestione dati generali;
- Modulo D — Edificio: involucro;
- Modulo E — Edificio: impianti;
- Modulo F — Calcolo APE, Interventi e Verifiche NZEB;
- Appendice I — Elementi di archivio edificio.

La pagina ufficiale riporta per questi moduli la versione del **15/10/2019**; Appendice I è datata **24/02/2016**.

> Nota importante: la data del manuale non coincide con la versione software corrente.  
> La versione CENED+2 corrente verificata il 22/09/2026 è **Client 1.1.15 / Motore 1.1.15**.

---

## 2. PDF diretti del Manuale

### Copertina e Indice

https://www.cened.it/documents/22239/315150/Copertina%2Be%2BIndice.pdf/8d47728e-ae98-4580-866f-c13ee08ee0cf

### Modulo A — Menu e comandi generali

https://www.cened.it/documents/22239/315150/Modulo%2BA%2B-%2BMenu%2Be%2Bcomandi%2Bgenerali.pdf/aad58480-e854-44b1-9ae3-bf95db339835

Utilità per il progetto:
- architettura generale del Client;
- menu e workflow;
- avvio motore;
- verifiche;
- esportazione XML;
- comandi generali.

### Modulo B — Archivi

https://www.cened.it/documents/22239/315150/Modulo%2BB%2B-%2BArchivi.pdf/4a3fda50-304b-4033-9687-6cd90297dca5

Utilità per il progetto:
- archivio software;
- archivio utente;
- archivio edificio;
- materiali;
- strutture;
- ponti termici;
- dati anagrafici.

### Modulo C — Edificio: gestione dati generali

https://www.cened.it/documents/22239/315150/Modulo%2BC%2B-%2BEdificio%2Bgestione%2Bdati%2Bgenerali.pdf/cb12a3db-619e-4f05-a909-ccafeb549a6b

Utilità per il progetto:
- nuovo edificio;
- dati generali;
- subalterni;
- destinazioni d'uso;
- struttura logica iniziale del modello CENED.

### Modulo D — Edificio: involucro

https://www.cened.it/documents/22239/315150/Modulo%2BD%2B-%2BEdificio_%2BInvolucro.pdf/4fb693ca-4bd9-4ecd-9839-16bf4300e0ef

Utilità per il progetto:
- zone termiche;
- ambienti;
- portate;
- dispersioni;
- strutture opache e trasparenti;
- ponti termici;
- associazioni geometriche/termiche.

### Modulo E — Edificio: impianti

https://www.cened.it/documents/22239/315150/Modulo%2BE%2B-%2BEdificio_%2BImpianti.pdf/fc4b7160-5a4d-474b-8be2-98a52d57c29b

Utilità per il progetto:
- ACS;
- riscaldamento;
- raffrescamento;
- ventilazione;
- illuminazione;
- accumuli;
- distribuzione;
- terminali;
- generatori;
- centrali.

### Modulo F — Calcolo APE, Interventi e Verifiche NZEB

https://www.cened.it/documents/22239/315150/MODULO%2BF%2B-%2BCALCOLO%2BAPE%2C%2BINTERVENTI%2BE%2BVERIFICHE%2BNZEB.pdf/40ad09ff-bb97-46c0-a882-4ea0da0e94a8

Utilità prioritaria per il progetto:
- lancio del calcolo;
- risultati;
- notifiche e verifiche;
- **Preview APE**;
- esportazione XML;
- workflow finale del Client.

Il paragrafo **F|1.3 Preview APE** conferma che CENED+2 produce un PDF fac-simile dell'APE dopo il calcolo, mentre l'APE ufficiale viene generato nel flusso di deposito CEER.

### Appendice I — Elementi di archivio edificio

Il link diretto non è stato consolidato in questa verifica perché non è emerso in modo affidabile dai risultati indicizzati.

Usare la pagina indice ufficiale:

https://www.cened.it/download/-/asset_publisher/vamgUje8wyb4/content/manuale-d-uso-software-cened-2-0?inheritRedirect=true

Non inventare o ricostruire manualmente il link del PDF.

---

## 3. Pagina ufficiale Software CENED+2.0

https://www.cened.it/software-cened2

Questa pagina deve essere consultata quando serve verificare:
- versione Client corrente;
- versione Motore corrente;
- changelog;
- casi studio;
- manuale;
- video tutorial;
- importazione XML di terze parti;
- istruzioni operative.

Stato verificato il **22/09/2026**:
- Client: **1.1.15**;
- Motore: **1.1.15**;
- aggiornamento: **03/06/2026**.

---

## 4. Pagina generale Download documentazione

https://www.cened.it/download

Utile come fallback qualora ARIA modifichi gli URL profondi.

Contiene le sezioni:
- Condizioni d'uso;
- Procedura di calcolo;
- Software di calcolo;
- Manuale d'uso CENED+2.0;
- guide ai servizi;
- normativa e altra documentazione.

---

## 5. Regola di utilizzo nel progetto

Per qualsiasi analisi sulla struttura funzionale del Client CENED+2:

1. partire da questo file;
2. consultare il modulo specifico del manuale;
3. verificare sempre la pagina `software-cened2` quando la questione dipende dalla versione corrente;
4. per integrazione con CENED+2 Motore, dare priorità alle specifiche tecniche per Utenti Motore rispetto al manuale utente;
5. il manuale descrive il comportamento e il workflow del Client, ma **non sostituisce le specifiche tecniche del Motore**;
6. non copiare i PDF nel repository salvo esplicita verifica dei diritti di redistribuzione.

## 6. Priorità per il Software Bridge

Per la progettazione del Bridge, i moduli da considerare fondamentali sono:

```text
Modulo C → struttura edificio e dati generali
Modulo D → involucro / zone / dispersioni
Modulo E → impianti
Modulo F → calcolo / Preview APE / XML
Modulo B → archivi e codifiche
Modulo A → workflow generale e comandi
```

Questi documenti devono essere trattati come riferimenti permanenti insieme alle specifiche tecniche ARIA riservate agli Utenti Motore.
