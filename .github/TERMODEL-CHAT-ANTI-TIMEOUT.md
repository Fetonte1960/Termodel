# TERMODEL — PROTOCOLLO OPERATIVO ANTI-TIMEOUT CHAT

Classificazione: **IMPORTANTE — REGOLA PERMANENTE DI PROGETTO**  
Introduzione: **25 settembre 2026**  
Stato: **ATTIVO**

Scopo: fare in modo che un timeout, refresh, sospensione del browser o nuova chat
non facciano perdere né blocchino un incarico Termodel.

## Principio

La chat è il punto di comando, **GitHub è lo stato persistente del lavoro**.

Un incarico lungo non deve dipendere dalla continuità dello stream della risposta
ChatGPT. Tutto ciò che serve a riprendere deve restare ricostruibile dal
repository, dal Summary, dai commit, dagli stati GitHub Actions e dagli artifact.

## Regole obbligatorie

1. **Registrare subito l'incarico.**  
   Dopo l'autorizzazione esplicita dell'utente, prima delle modifiche, aggiungere
   una voce `Stato: COMMISSIONATO` in
   `Server/Termodelwebservice/PROJECT-SUMMARY-SERVICE.md`.

2. **Lavorare per checkpoint piccoli e persistenti.**  
   Dopo ogni fase coerente e recuperabile lasciare su GitHub un commit o un
   aggiornamento di stato sufficiente a ricostruire ciò che è già stato fatto.

3. **Demandare i lavori lunghi a GitHub Actions.**  
   Build, regression, debug riproducibile, generazione artifact e verifiche
   pesanti devono essere eseguiti dalla Action quando possibile, invece di
   dipendere da una singola risposta lunga della chat.

4. **Applicare le notifiche permanenti.**  
   Ogni Action operativa significativa deve seguire
   `.github/TERMODEL-ACTION-NOTIFICATIONS.md`: stato
   `Termodel/job` RUNNING -> SUCCESS/FAILED e una sola notifica terminale ntfy.

5. **Evitare trasferimenti inutilmente grandi nella chat.**  
   Non riversare interi log o artifact quando non necessario. Prima leggere
   metadata, hash, riepiloghi e porzioni mirate; scaricare l'artifact completo
   soltanto quando serve davvero all'analisi.

6. **Separare stato tecnico da stato della chat.**  
   Un timeout della pagina non equivale a un fallimento di build, test o deploy.
   Lo stato reale è quello registrato su GitHub/Action/servizio remoto.

7. **Ripresa dopo timeout o nuova chat.**  
   La sequenza standard è:
   - leggere integralmente `PROJECT-SUMMARY-SERVICE.md`;
   - controllare i commit successivi all'ultimo aggiornamento rilevante;
   - individuare gli incarichi ancora `COMMISSIONATO`;
   - controllare Commit Status `Termodel/job`, workflow run e artifact;
   - riprendere dal primo checkpoint non concluso, senza rifare lavoro già
     verificato.

8. **Non dichiarare verifiche non osservate.**  
   Distinguere sempre: progettato, implementato, compilato, eseguito, testato,
   confrontato con riferimento e pubblicato.

9. **Chiusura dell'incarico.**  
   Solo al termine reale aggiornare la stessa voce del Summary a
   `Stato: ESEGUITO`, registrando commit, build/test e risultato. Chiudere la
   Issue #1 come `Completed` se riuscito o `Not planned` se fallito, così la
   notifica finale resta coerente.

## Comportamento consigliato per incarichi complessi

Preferire più cicli brevi:

```text
COMMISSIONATO
  -> modifica/checkpoint
  -> Action
  -> ispezione risultato
  -> eventuale correzione/checkpoint
  -> Action finale
  -> ESEGUITO + Issue #1
```

a una sola sessione molto lunga e fragile.

## Effetto atteso

Se compare un errore di stream o la pagina va in sospensione, l'utente può
aprire una nuova chat e dire semplicemente **"riprendi l'incarico"**. La nuova
chat deve poter ricostruire lo stato da GitHub senza richiedere all'utente di
ripetere il lavoro già commissionato.
