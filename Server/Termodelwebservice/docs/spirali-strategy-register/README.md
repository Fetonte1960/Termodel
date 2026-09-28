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
