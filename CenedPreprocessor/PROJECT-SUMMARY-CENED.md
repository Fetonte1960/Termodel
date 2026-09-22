# TERMODEL CENED — PROJECT SUMMARY

> Documento primario di continuità del progetto Cened.
>
> Ogni nuova sessione che lavora sul branch `TermodelCened` deve leggere questo file prima di proporre o modificare codice.

Ultimo aggiornamento: **2026-09-22**  
Branch di riferimento: **TermodelCened**  
Versione iniziale di progetto: **0.1.0-dev**

---

## 1. Obiettivo

Realizzare un preprocessore Cened con identità propria, capace di trasformare un modello termico strutturato in dati idonei al motore Cened.

Il preprocessore viene sviluppato in parallelo in due versioni:

1. **WebJS**, online e sperimentale, pubblicabile su termodel.it;
2. **Desktop**, destinata al reale percorso di certificazione.

L'obiettivo architetturale è mantenere le due versioni semanticamente equivalenti mediante specifiche, casi prova e Golden Results condivisi.

## 2. Separazione da Termodel

Termodel è una possibile sorgente dei dati, non il componente da certificare.

Flusso concettuale:

```text
Termodel / altro software / import standard
        ↓
modello termico intermedio strutturato
        ↓
Preprocessore Cened
        ↓
input conforme richiesto dal motore Cened
        ↓
motore Cened
        ↓
output / anteprima / elaborati
```

Il formato intermedio deve avere identità propria e non dipendere dall'interfaccia grafica di Termodel.

## 3. Struttura

```text
CenedPreprocessor/
├── PROJECT-SUMMARY-CENED.md
├── README.md
├── VERSION.txt
├── docs/
│   ├── COMMISSIONI.md
│   ├── DECISIONI.md
│   ├── ARCHITETTURA.md
│   └── CERTIFICAZIONE.md
├── spec/
│   └── README.md
├── src/
│   ├── WebJS/
│   │   └── README.md
│   └── Desktop/
│       └── README.md
├── tests/
│   └── README.md
├── GoldenResults/
│   └── README.md
└── samples/
    └── README.md
```

## 4. Regola commissioni

Prima di ogni intervento:
1. leggere questo summary;
2. verificare lo stato reale del branch e i commit successivi;
3. registrare l'incarico in `docs/COMMISSIONI.md` come `COMMISSIONATO`;
4. rileggere i file coinvolti prima di modificarli.

Dopo l'intervento:
1. verificare le modifiche;
2. eseguire i test disponibili;
3. aggiornare questo summary quando cambiano architettura o stato;
4. cambiare la commissione in `ESEGUITO`;
5. indicare commit/versione risultante.

Le deliberazioni architetturali consolidate vengono registrate separatamente in `docs/DECISIONI.md`.

## 5. Versionamento

Ogni versione software deve avere un numero esplicito.

La fonte iniziale è `VERSION.txt`. WebJS e Desktop dovranno mostrare la versione nelle rispettive caption/interfacce. Ogni modifica funzionale dovrà incrementare il numero secondo la convenzione che verrà consolidata prima della prima release certificabile.

## 6. Stato corrente

La struttura Git iniziale è stata creata nel branch `TermodelCened`.

Sono predisposti:
- summary autonomo;
- registro commissioni;
- storico decisioni;
- specifica comune;
- aree WebJS e Desktop;
- documentazione di certificazione;
- test, Golden Results ed esempi;
- versione iniziale `0.1.0-dev`.

Non è ancora implementata alcuna trasformazione verso input Cened.

## 7. Prossimo passo

Studiare e documentare con precisione:
- formato/input accettato dal motore Cened;
- tabelle, campi e vincoli;
- eventuali XML o altri file prodotti dal preprocessore esistente;
- sequenza minima necessaria per costruire un primo caso prova riproducibile.

Da questo studio nascerà la **specifica intermedia autorevole** in `spec/`.
