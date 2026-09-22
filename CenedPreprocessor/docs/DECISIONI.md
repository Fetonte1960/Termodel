# Storico decisioni — Termodel Cened

Questo file registra le decisioni architetturali e di prodotto consolidate. Non sostituisce il registro commissioni.

## 2026-09-22 — D-0001 — Prodotto autonomo

Il preprocessore Cened ha identità propria. Termodel è una possibile sorgente dati ma non fa parte del perimetro iniziale di certificazione.

## 2026-09-22 — D-0002 — Due implementazioni parallele

Si sviluppano:
- WebJS online su termodel.it;
- Desktop destinata alla certificazione.

Le due versioni devono condividere specifica semantica, casi prova e Golden Results.

## 2026-09-22 — D-0003 — Modello intermedio

Il preprocessore deve ricevere un modello termico strutturato e indipendente dalla UI. Il mapping verso Cened deve essere documentato nella specifica comune.

## 2026-09-22 — D-0004 — Versionamento visibile

Ogni versione software deve avere un identificativo incrementale e tale versione deve essere visibile nelle caption/interfacce delle applicazioni.

## 2026-09-22 — D-0005 — Tracciabilità

Ogni incarico viene registrato come COMMISSIONATO prima del lavoro e trasformato in ESEGUITO solo dopo verifica. Le decisioni architetturali vengono registrate in questo storico.
