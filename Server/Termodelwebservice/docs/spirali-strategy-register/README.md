## Aggiornamento operativo 01/10/2026 — restore point Vittorio_revisionato

Per le attività correnti su `Vittorio_revisionato`, il restore point
visivamente approvato è:

```text
6132430e7907699cbf577c2ef869ffd03117f216
recovery/vittorio-revisionato-approved-offset-p-20261001
```

La variante approvata usa il generatore Vittorio come base con una sola
deviazione controllata in `ComputeOffset`: soglia di skip dei lati
`3P -> P`.

Resta un **problema aperto nelle strettoie**, osservato nel locale 4 del test
multi-locale: il percorso locale nella zona ristretta può essere
geometricamente non soddisfacente. Il difetto non è ancora formalizzato come
nuova strategia ATTIVA e non va corretto incidentalmente; sarà oggetto di una
missione dedicata. L'utente segnala che una precedente iterazione lo aveva
tamponato, ma prima di riusare quella soluzione va ricostruita la causa e
verificato quale modifica fosse realmente responsabile.

Questa nota prevale, per il solo stato corrente di `Vittorio_revisionato`,
sulle descrizioni storiche sottostanti.

---

# Registro strategie geometriche spirali

Classificazione: **AUTOREVOLE — vincoli strategici per evoluzioni future**  
Ambito: Termodel.Core / pannelli radianti / strategie di generazione spirali

Questo registro conserva le **decisioni strategiche** concordate sui casi
geometrici reali osservati durante lo sviluppo del generatore di spirali.

Non è un catalogo di semplici anomalie e non sostituisce i regression test.
Ogni scheda definisce invece un comportamento che le strategie future devono
rispettare anche quando cambia l'algoritmo usato per ottenerlo.

Il catalogo storico dei pattern difettosi in
`SorgentiTermodel/Library/Impianti/Pannelli/SpiraliGPT/PatternDifettosi/`
rimane consultivo e può contenere ipotesi sospese. Questo registro è separato:
qui entrano soltanto principi strategici esplicitamente concordati.

## Regola d'uso

Prima di modificare una strategia geometrica delle spirali:

1. leggere tutte le schede con stato **ATTIVA**;
2. verificare che la nuova strategia non violi nessuno dei comportamenti
   descritti;
3. usare, quando disponibile, il progetto regression indicato nella scheda;
4. confrontare il nuovo esecutivo con le immagini di riferimento;
5. se una modifica richiede di cambiare una regola, aggiornare prima la scheda
   con una decisione esplicita, invece di aggirarla nel codice.

Le schede non impongono necessariamente una specifica implementazione:
descrivono il **risultato strategico da preservare**.

## Linee guida generali

La specifica viva e lo stato operativo corrente sono mantenuti in
[LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md](LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md).

Dal 28/09/2026 il Service usa **`Diego_Vittorio`** come motore spirali
predefinito per la fase corrente di collaudo; gli override
`Vittorio | GPT | Diego | Diego_Vittorio` restano disponibili.
`SpiraliVittorio` rimane invariata come riferimento di confronto e rollback.

`StrategiaDiego` / motore `Diego` è invece **PARKED**: l'architettura di
ricerca ha mostrato un costo computazionale troppo elevato per l'uso operativo
corrente. La linea resta work in progress per una futura riduzione del costo,
con l'obiettivo di poterla usare soprattutto in locali/configurazioni molto
complessi, dove una ricerca più ampia delle alternative può risultare utile.

`Diego_Vittorio` deriva da Vittorio ma non è più una semplice variante con
correzioni locali. Ha ricevuto una modifica strutturale fondamentale: il
**Return è generato autonomamente** e non è più ottenuto come riflesso/parallelo
della mandata. Durante la crescita il Return è condizionato contemporaneamente
dal perimetro dell'edificio/locale, dalla mandata già costruita e dalla propria
geometria già costruita.

Questo approccio offre maggiore libertà geometrica ma introduce un limite noto:
la mandata può creare corridoi stretti o una sorta di **“budello”** nel quale
il Return autonomo resta imprigionato; in tali condizioni il generatore può
arrestare il Return troppo presto o in una posizione geometricamente non
corretta. Questo comportamento è un problema aperto della fase di collaudo,
non una caratteristica approvata.

L'utente ha avviato il **collaudo manuale sul Service pubblico** del disegno
spirali prodotto da `Diego_Vittorio`. Questo stato è distinto dalle prove
Harness/GitHub Actions già eseguite: i casi reali osservati durante il collaudo
devono essere registrati qui come nuove schede quando producono una regola
geometrica riutilizzabile, e trasformati in regression quando possibile.

Le schede di questo registro restano i vincoli geometrici puntuali che ogni
evoluzione della strategia deve rispettare.

## Indice

| ID | Titolo | Stato | Progetto di riferimento |
| --- | --- | --- | --- |
| [STRATEGY-001](STRATEGY-001-imbottigliamento-selettivo.md) | Imbottigliamento selettivo mandata/ritorno | **ATTIVA** | `RadiantPanelsReference` |

## Aggiunta di nuovi casi

Per nuovi principi usare [TEMPLATE.md](TEMPLATE.md).

Ogni nuova scheda deve contenere almeno:

- origine del caso;
- immagine di riferimento;
- osservazione dell'utente;
- principio strategico;
- comportamento ammesso e vietato;
- criteri per verificare una futura strategia;
- eventuale progetto regression associato.
