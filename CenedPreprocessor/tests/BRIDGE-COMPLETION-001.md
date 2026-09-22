# BRIDGE-COMPLETION-001 — test schema sidecar

## Input

- schema: `../spec/bridge-completion-1.0.xsd`;
- sample: `../samples/BRIDGE-COMPLETION-001.xml`.

## Aspettative XSD

Il sample deve:
- avere namespace `urn:termodel:cened-bridge:completion:1.0`;
- dichiarare versione `1.0`;
- contenere `Header`;
- contenere riferimenti a gbXML e XML nazionale;
- contenere almeno il binding dimostrativo `BIND-001`;
- contenere il campo dimostrativo `FIELD-001`;
- validare contro `bridge-completion-1.0.xsd`.

## Aspettative semantiche

Il futuro validatore Bridge deve inoltre controllare regole non esprimibili completamente nello XSD:

1. nessun `Field` deve duplicare un dato già autorevole nel gbXML o nell'XML nazionale;
2. un `Binding` deve essere presente soltanto se l'associazione automatica non è certa;
3. un `scopeRef` deve risolversi nel modello normalizzato;
4. un `targetKey` `Confirmed` deve avere un mapping documentato;
5. un campo `Provisional` non può essere usato per output Motore di produzione;
6. in produzione gli hash delle due sorgenti devono corrispondere ai file effettivamente caricati;
7. le incongruenze tra sorgenti non vengono risolte tramite override nel sidecar.

## Verifica iniziale

Il sample è stato validato contro lo XSD 1.0 al momento della creazione con esito positivo.

## Nota

`PROVISIONAL.CENED.Project.CompletionExample` è un campo dimostrativo e non costituisce un requisito CENED.
