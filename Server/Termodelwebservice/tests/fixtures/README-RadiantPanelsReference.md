# RadiantPanelsReference — fixture reale pannelli radianti

Origine: progetto `TERMODEL-PROJECT-TEXT-V1` copiato dal CAD Web e fornito
dall'utente il 24/09/2026 come progetto di riferimento per il calcolo pannelli.

## Conservazione del progetto

Il file originale aveva:

- 987.311 byte;
- 34.125 righe;
- SHA-256 originale: `4af2675d670ed039f00d36e9c3fc82061db27a3c19cb4e5451faa69f3ebfe87a`;
- 33 sezioni;
- tutte le impronte delle sezioni dichiarate nel manifest coerenti con il file
  originale.

Per i limiti del canale di trasferimento AI→GitHub, il testo è stato
consolidato in quattro parti UTF-8 con fine riga normalizzato LF:

```text
RadiantPanelsReference.original.part01.txt
RadiantPanelsReference.original.part02.txt
RadiantPanelsReference.original.part03.txt
RadiantPanelsReference.original.part04.txt
```

Il regression runner le ricompone in ordine prima del test. L'hash sopra resta
quello del file utente originale, prima della sola normalizzazione dei fine riga.

## Dati pannelli

Rete:
- `RAD-DEFAULT`;
- `TipoRete=PannelliRadianti`;
- tipologia `GEN-DEFAULT`;
- passo 300 mm;
- acqua 35/30 °C;
- temperatura ambiente 20 °C;
- diametro interno 12 mm;
- limite circuito 100 m;
- limite perdita 25.000 Pa.

La geometria locale contiene 12 segmenti Tubo, `T002..T013`, tutti sul layer
`Unico_tubipannelli` e associati a `RAD-DEFAULT`.

## Difetto reale individuato

Il CAD precedente conservava rete/piano/layer ma non l'identità della sequenza
Tubo. Sei sequenze distinte condividono lo stesso punto di collettore
`(583.349, 474.316) cm`. La sola connettività geometrica produce quindi un
unico componente con nodo di grado 6 e il vecchio solver lo interpreta come un
solo circuito ramificato.

La correzione non sposta la geometria: assegna alle sequenze un metadato
`data-termodel-circuito`. La mappa autorevole della fixture è:

```text
RadiantPanelsReference.circuit-map.json
```

Atteso dopo la correzione:

- C001 = T002
- C002 = T003,T004
- C003 = T005,T006
- C004 = T007
- C005 = T008,T009
- C006 = T010,T011,T012,T013
- 6 circuiti distinti;
- lunghezza totale centerline invariata: 19,5997808425 m;
- nessun circuito ramificato.

La mancanza di `T001` non è considerata un errore: gli ID CAD non devono
essere contigui dopo cancellazioni.

## Progetto locale vs payload Service

Il progetto copiato è il progetto locale completo del frontend: contiene
sfondo raster e lo SVG operativo `calpestabile/copertura`. Non deve essere
inviato direttamente al Service. Il percorso normale
`buildTermodelServerPayload()` rimuove gli sfondi e costruisce
`TERMODEL-PROJECT-SVG-V1` con `data-termodel-units="cm"` e gruppi piano
canonici.

Il regression test riproduce la stessa canonicalizzazione essenziale prima di
`POST /api/calculations`.

## Scopo regression

Il test deve proteggere contemporaneamente:

1. trasporto dei metadati `rete/circuito` SVG → Virtual CAD;
2. raggruppamento per circuito dichiarato;
3. fallback legacy per Tubo senza `data-termodel-circuito`;
4. 6 circuiti e lunghezze della fixture reale;
5. generazione `pannelli.json`;
6. raccolta degli eventuali esecutivi SVG/DXF e dei log per diagnosi.
