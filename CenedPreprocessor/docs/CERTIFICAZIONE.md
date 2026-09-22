# Percorso di certificazione — dossier di lavoro

Questo documento raccoglie progressivamente il materiale necessario al percorso di autorizzazione della versione Desktop come Client di terze parti integrato con CENED+2 Motore.

## Riferimento ARIA verificato

Verifica effettuata il 22/09/2026 sulla documentazione ufficiale CENED/ARIA disponibile in tale data, incluse le **Condizioni d'uso e modalità di adesione ai servizi CENED — revisione 01/09/2026** e la documentazione relativa a CENED+2 Motore.

Le condizioni correnti stabiliscono, tra l'altro, che:
- CENED+2 è composto da Client e Motore separati e integrabili;
- CENED+2 Motore può essere integrato con applicativi di terze parti sviluppati secondo le specifiche dell'O.d.A.;
- l'uso del Motore da parte di un Client di terze parti è subordinato all'autorizzazione dell'O.d.A.;
- il richiedente autodichiara la conformità del Client alle specifiche tecniche correnti;
- per l'autorizzazione finalizzata alla produzione XML deve essere inviato anche il software sviluppato con le istruzioni di installazione;
- dopo l'autorizzazione viene fornito quanto necessario affinché quella versione del Client possa generare tramite CENED+2 Motore XML conformi per il CEER;
- una major release del Client richiede una nuova autodichiarazione; aggiornamenti del Motore possono comportare una nuova autorizzazione su richiesta dell'O.d.A.

## Perimetro iniziale

Da sottoporre al percorso ARIA:
- Client Desktop del Software Bridge;
- integrazione con CENED+2 Motore;
- formato/i di input supportati e relativa normalizzazione;
- regole di validazione e trasformazione;
- corrispondenza tra modello intermedio e dati richiesti dal Motore;
- generazione dell'XML conforme;
- risultati dei casi prova.

Fuori dal perimetro iniziale:
- Termodel;
- CAD/3D di Termodel;
- versione WebJS, salvo diversa successiva definizione con ARIA.

## Proprietà intellettuale e UI

Le condizioni ARIA correnti indicano che la riproduzione delle interfacce grafiche del CENED+2 Client è consentita esclusivamente a fini didattici.

Il prodotto non copierà quindi la UI CENED+2. Verrà realizzata una interfaccia originale, pur organizzando i dati in sezioni funzionali utili e riconoscibili per il certificatore.

## APE e anteprima

Il Software Bridge può produrre una **anteprima APE / fac-simile di controllo**.

Tale stampa deve essere chiaramente distinta dall'APE ufficiale. Le condizioni ARIA correnti attribuiscono al servizio CEER il flusso di produzione/deposito del Nuovo APE e disciplinano i file XML/PDF e la firma digitale.

## Versionamento e autorizzazione

Il versionamento del Client non è soltanto tecnico ma anche regolatorio:
- ogni build sottoposta ad autorizzazione deve essere identificata in modo univoco;
- le major release richiedono nuova autodichiarazione;
- una minor release deve essere valutata con particolare attenzione se può modificare i risultati;
- ogni aggiornamento del CENED+2 Motore deve essere trattato come possibile evento di riallineamento/autorizzazione.

## Comunicazione commerciale

Le integrazioni con CENED+2 Motore devono essere rese evidenti nell'applicativo e nelle comunicazioni commerciali una volta autorizzate.

Prima del rilascio dell'autorizzazione non usare formulazioni che facciano intendere che il Client sia già autorizzato, accreditato o ufficialmente integrato.

## Evidenze da costruire

- specifica versionata;
- matrice campo → origine → trasformazione → destinazione;
- casi prova minimi e casi limite;
- Golden Results;
- log di versione;
- tracciabilità commissione → modifica → test;
- identificazione esatta della build sottoposta ad autorizzazione;
- documentazione di installazione della build;
- dossier delle differenze tra major/minor release.
