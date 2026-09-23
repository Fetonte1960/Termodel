# Allineamento raccolta Pascal

Questi strumenti gestiscono esclusivamente la copia consultiva:

```text
C:\DOCUMENTI\sd\Termodel-Library-Appendice-Sorgenti-Pascal
    -> SorgentiTermodel\Library\SorgentiPascal
```

- `VERIFICA_RACCOLTA_PASCAL_LOCALE_VS_LIBRARY_GIT.cmd` confronta i due alberi tramite SHA-256 senza modificarli.
- `COPIA_RACCOLTA_PASCAL_LOCALE_NELLA_LIBRARY_GIT.cmd` chiede conferma, rende la destinazione Git speculare alla raccolta locale e verifica nuovamente tutti gli hash.

Non è previsto un comando automatico Git → locale: la Library Git è una copia derivata e di sola consultazione. Gli originali storici e la raccolta locale non devono essere sovrascritti da Git.

Gli strumenti non eseguono `git add`, commit, pull o push.
