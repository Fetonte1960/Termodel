# WebJS

Versione browser attiva del Software Bridge CENED.

Versione corrente: **0.1.1-dev**

## Stato

Dal 22/09/2026 WebJS è l'unica linea attiva di sviluppo e discussione. La versione Desktop è sospesa.

La prima bozza navigabile è:

`src/WebJS/index.html`

È volutamente realizzata come pagina HTML/CSS/JavaScript autonoma, senza framework e senza build, per rendere immediata la discussione del prodotto.

## Funzioni presenti nella bozza 0.1.1-dev

- progetto demo con dati fittizi;
- navigazione fra:
  - Panoramica;
  - Dati generali;
  - Zone e locali;
  - Involucro;
  - Serramenti;
  - Ponti termici;
  - Impianti;
  - Risultati;
  - Anteprima APE;
  - XML;
- validazione preliminare di completezza;
- import locale di XML nazionale con radice `<documento>`;
- lettura preliminare dei blocchi `ape2015` e `datiCalcolo`;
- lettura di zone, locali, superfici opache, superfici vetrate e ponti termici;
- visualizzazione dei risultati APE già presenti nell'XML importato;
- anteprima APE marcata **ANTEPRIMA APE — NON UFFICIALE**;
- serializzazione XML dimostrativa scaricabile.

## Cosa NON fa

- non invoca CENED+2 Motore;
- non esegue un calcolo energetico ufficiale;
- non dichiara conformità CEER/CENED;
- non replica graficamente CENED+2 Client o Blumatica;
- non usa dati personali reali nei dati demo.

## Riferimenti

- `GoldenResults/BLUMATICA-XML-001.md`: riferimento strutturale XML nazionale;
- `GoldenResults/BLUMATICA-APE-PREVIEW-001.md`: riferimento di contenuto per l'anteprima APE;
- `docs/RIFERIMENTO-GESTXML-TERMODEL.md`: sorgente Termodel come ispirazione tecnica non vincolante;
- `docs/RIFERIMENTI-CENED.md`: manuale e riferimenti ufficiali.

## Avvio

Per la discussione è sufficiente servire questa cartella con un normale server statico e aprire `index.html`.

Esempio, se Python è disponibile:

```text
python -m http.server 8080
```

La WebJS resta un prototipo di studio: la fonte normativa delle regole dovrà essere la specifica in `../../spec/`.
