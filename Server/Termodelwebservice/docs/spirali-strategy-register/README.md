# Registro strategie geometriche SpiraliGPT

Classificazione: **AUTOREVOLE — vincoli strategici per evoluzioni future**  
Ambito: Termodel.Core / pannelli radianti / SpiraliGPT

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

Prima di modificare la strategia geometrica di SpiraliGPT:

1. leggere tutte le schede con stato **ATTIVA**;
2. verificare che la nuova strategia non violi nessuno dei comportamenti
   descritti;
3. usare, quando disponibile, il progetto regression indicato nella scheda;
4. confrontare il nuovo esecutivo con le immagini di riferimento;
5. se una modifica richiede di cambiare una regola, aggiornare prima la scheda
   con una decisione esplicita, invece di aggirarla nel codice.

Le schede non impongono necessariamente una specifica implementazione:
descrivono il **risultato strategico da preservare**.

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
