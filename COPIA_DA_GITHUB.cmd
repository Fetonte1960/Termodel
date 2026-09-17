@echo off
setlocal
cd /d "%~dp0"

echo ==============================================
echo   TERMODEL - COPIA DA GITHUB
echo   GITHUB REMOTO  --^>  PC LOCALE
echo   Viene aggiornato TUTTO, compreso Work
echo ==============================================
echo.

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 goto :NOTGIT

git pull --ff-only
if errorlevel 1 goto :ERRORE

echo.
echo OK: copia locale aggiornata da GitHub.
echo Anche SorgentiTermodel\Work e' stato aggiornato.
goto :FINE

:NOTGIT
echo ERRORE: questa cartella non e' un repository Git.
goto :FINE

:ERRORE
echo.
echo ATTENZIONE: copia interrotta per sicurezza.
echo Git non ha sovrascritto modifiche locali incompatibili.

:FINE
echo.
pause
endlocal
