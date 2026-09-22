# Termodel Cened — preprocessore Cened

Progetto autonomo per la costruzione di un preprocessore capace di produrre input idonei al motore Cened.

Il progetto vive nel branch Git `TermodelCened` ed è deliberatamente separato dal normale sviluppo Termodel Web/Service.

## Linee di prodotto

- **WebJS** — versione JavaScript online, pubblicabile su termodel.it, usata per sviluppo, verifica e dimostrazione.
- **Desktop** — versione desktop destinata al percorso reale di certificazione.
- **Spec** — contratto tabellare/strutturato comune alle due implementazioni.
- **Tests / GoldenResults** — casi prova e risultati attesi comuni per verificare che WebJS e Desktop si comportino allo stesso modo.

Termodel potrà alimentare il preprocessore attraverso un formato di scambio, ma **Termodel non fa parte del perimetro da certificare**.

Punto di ingresso per ogni nuova sessione di sviluppo:

`PROJECT-SUMMARY-CENED.md`
