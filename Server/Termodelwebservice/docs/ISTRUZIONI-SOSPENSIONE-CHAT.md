# Istruzioni in caso di sospensione della chat

## Scopo

Questo documento definisce la procedura da seguire quando una conversazione ChatGPT impegnata sul progetto **Termodel Service** si interrompe, si esaurisce, viene sospesa o non può più proseguire normalmente.

L'obiettivo è consentire a una nuova esecuzione ChatGPT di riprendere il lavoro senza perdere il contesto tecnico e senza introdurre modifiche non concordate.

## Principio fondamentale

**GitHub è la fonte operativa principale e più aggiornata del progetto.**

Prima di riprendere qualunque attività, la nuova esecuzione deve ricostruire lo stato leggendo il repository:

`Fetonte1960/Termodel`

In caso di contrasto fra ricordi della conversazione, contesto precedente e repository, prevale lo stato documentato su GitHub, salvo diversa indicazione esplicita dell'utente.

## Documenti da consultare prima della ripresa

La nuova esecuzione deve leggere almeno:

- `PROJECT-SUMMARY.md`
- `Server/Termodelwebservice/PROJECT-SUMMARY-SERVICE.md`
- `docs/TERMODEL-FRONT-SERVICE-CONTRACT.md`
- eventuali file di handoff o stato presenti nel repository
- `Server/Termodelwebservice/docs/STRATEGIADIEGO-DEVELOPMENT-REGISTER.md`
- `Server/Termodelwebservice/docs/TUBAZIONI-DEVELOPMENT-REGISTER.md`
- `Server/Termodelwebservice/docs/LOCAL-RADIANT-HARNESS.md`
- documentazione presente in `Server/Termodelwebservice/docs/spirali-strategy-register/`
- issue GitHub e relativi commenti pertinenti
- ultimi commit rilevanti sul branch di lavoro
- ultimi workflow/test GitHub Actions pertinenti

## Ricostruzione obbligatoria dello stato

Prima di modificare codice o documentazione, ricostruire esplicitamente:

1. obiettivo corrente;
2. ultimo lavoro effettivamente completato;
3. attività ancora aperte;
4. vincoli tecnici e decisionali stabiliti con l'utente;
5. test già superati;
6. anomalie ancora presenti;
7. ultimo commit o checkpoint affidabile;
8. prossimo passo previsto;
9. eventuali modifiche che richiedono consenso umano prima di essere eseguite.

## Quando un'attività può essere considerata sospesa

Un'attività deve essere considerata sospesa solo in presenza di indizi concreti, per esempio:

- ultimo messaggio o handoff indica lavoro ancora in corso;
- esistono test diagnostici preparati ma non ancora conclusi;
- un registro indica esplicitamente un prossimo passo non ancora eseguito;
- sono presenti commit intermedi chiaramente diagnostici;
- una GitHub Action ha prodotto dati da analizzare ma manca la conclusione;
- una conversazione precedente risulta interrotta durante una sequenza operativa.

Non dedurre una sospensione soltanto perché esistono issue aperte, TODO generici o vecchi problemi documentati.

## Procedura di ripresa

Quando una vera attività sospesa è stata identificata:

1. riprendere dal checkpoint GitHub più recente e coerente;
2. non ricominciare da zero se esistono test, harness, snapshot o diagnostica già preparati;
3. usare il percorso di test più rapido disponibile;
4. minimizzare commit e modifiche durante la fase di indagine;
5. preservare i casi di riferimento già validati;
6. non introdurre modifiche strutturali o cambi di strategia non concordati con l'utente;
7. preferire correzioni circoscritte e verificabili;
8. eseguire i test di regressione pertinenti prima di pubblicare;
9. aggiornare i registri GitHub se l'indagine produce una nuova regola, una nuova anomalia classificata o una decisione strategica.

## Regola speciale per lo sviluppo delle spirali

Durante il lavoro sulle spirali dei pannelli radianti:

- il progetto quadrato di riferimento deve rimanere invariato se già validato;
- le anomalie devono essere isolate locale per locale;
- usare l'harness locale veloce quando disponibile;
- evitare correzioni globali per risolvere un singolo caso;
- prima di cambiare strategia, verificare se il problema nasce da geometria, tolleranze, portali, intrappolamento, chiusura o selezione del percorso;
- ogni nuova strategia deve rispettare i casi già consolidati e il registro strategico.

## Handoff minimo da lasciare prima di una possibile interruzione

Quando possibile, prima di terminare una lunga fase di lavoro aggiornare GitHub con un checkpoint che contenga almeno:

- attività corrente;
- file modificati;
- ultimo commit;
- test eseguiti e relativo esito;
- anomalia ancora aperta;
- ipotesi attuale;
- prossimo passo preciso;
- vincoli da non violare.

Il checkpoint può essere scritto nel registro pertinente, nel PROJECT-SUMMARY-SERVICE oppure in un file di handoff dedicato.

## Comportamento dell'operazione programmata di recovery

L'operazione programmata che controlla periodicamente Termodel Service deve:

1. istruirsi prima sul repository GitHub;
2. ricostruire lo stato secondo questa procedura;
3. verificare se esiste realmente un'attività sospesa;
4. non notificare nulla se non vi sono prove sufficienti;
5. se trova un'attività sospesa, riprendere il lavoro dal checkpoint documentato;
6. non dichiarare di avere aperto una nuova conversazione se ciò non è verificabile;
7. non inventare il nome o l'identificatore della chat precedente.

## Notifica di ripresa

Quando la ripresa è realmente iniziata, registrare la notifica sulla issue GitHub **#1** del repository `Fetonte1960/Termodel`.

Formato preferito:

```
La chat <nome/identificatore> è stata ripresa da un'altra esecuzione ChatGPT.
```

Se il nome o identificatore della chat non è verificabile:

```
Un'attività Termodel Service sospesa è stata ripresa da un'altra esecuzione ChatGPT.
```

La notifica deve essere scritta solo dopo che la ripresa è effettivamente iniziata.

Se la scrittura sulla issue fallisce, non dichiarare che la notifica è stata eseguita.

## Regola finale

La finalità della procedura non è soltanto "riaprire una chat", ma garantire **continuità tecnica del lavoro**.

Una nuova esecuzione deve essere in grado di capire rapidamente:

> dove eravamo, cosa era già stato verificato, cosa non deve essere modificato e qual è il prossimo passo concreto.

Questo documento deve essere considerato parte integrante della documentazione operativa di Termodel Service.
