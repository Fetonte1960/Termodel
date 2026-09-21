# SpiraliGPT

Workspace parallelo creato a partire dal motore conservato in
`Termodel-Vittorio-main/Termodel_new`.

## Regole della sfida

- Il motore **Vittorio** rimane nella cartella originale e non viene modificato.
- Il motore **GPT** usa il namespace `SpiralHeatingGPT` e può evolvere in modo indipendente.
- Entrambi ricevono lo stesso `locale.xml` e producono lo stesso formato `locale.svg`.
- La selezione del motore avviene nell'interfaccia Termodel o tramite l'argomento
  Workbench `--spiral-engine Vittorio|GPT`.
- Ogni confronto deve registrare il motore usato insieme agli output geometrici.

La copia iniziale era intenzionalmente equivalente all'originale e rimane
confrontabile tramite gli snapshot `locale-vittorio.*`.

## Prima evoluzione GPT

- Gli offset interni sono calcolati con buffer negativi NetTopologySuite a
  partire dal perimetro originale: pareti inclinate e concavità non vengono
  più forzate sugli assi X/Y.
- Il ritorno è costruito dai vertici essenziali e arrotondato soltanto dopo.
- L'avvio del ritorno usa una distanza fisica di 0,30 m, non un numero fisso di
  punti dipendente dal campionamento.
- Le correzioni terminali che tornavano sulla spira sono escluse dal motore
  GPT.
- Ogni esecuzione GPT produce `spirali-gpt-report.json` con lunghezze,
  auto-intersezioni, incroci mandata/ritorno, confinamento e continuità.

Il report è deliberatamente diagnostico: un circuito non valido viene
segnalato e non viene corretto eliminando automaticamente porzioni di tubo.

## Pattern difettosi sospesi

I casi conservati per l'analisi comparativa sono descritti in
[`PatternDifettosi/README.md`](PatternDifettosi/README.md), insieme agli
screenshot, alle cause ipotizzate e ai criteri di accettazione.

## Limiti aperti

- Il ritorno parallelo resta un offset euristico della mandata. Nei locali in
  cui il passaggio fra anelli è stretto può ancora intersecare mandata o
  ritorno.
- La generazione non distingue ancora pannello liscio e pannello bugnato. La
  posa libera su pareti inclinate è la priorità corrente; griglia, passo fisico
  delle bugne e direzioni ammesse richiedono parametri di prodotto prima di
  essere introdotti.
- Se un buffer interno si divide in più poligoni, la generazione si arresta
  invece di scegliere silenziosamente un'isola e lasciare scoperta l'altra.
- Copertura termica dei collegamenti, ottimizzazione globale e routing dal
  collettore sono fasi successive e non fanno parte di questa prima evoluzione.
