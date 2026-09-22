@echo off
setlocal
cd /d "%~dp0"

echo ==============================================
echo   TERMODEL - AGGIORNA GITHUB
echo   PC LOCALE  --^>  GITHUB REMOTO
echo   SorgentiTermodel\Work viene SEMPRE ESCLUSO
echo ==============================================
echo.

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 goto :NOTGIT

for /f %%B in ('git branch --show-current') do set "BRANCH=%%B"
if "%BRANCH%"=="" set "BRANCH=main"

rem Work e' di competenza del lavoro remoto: una copia locale vecchia non deve mai essere pubblicata.
git restore --staged --worktree -- "SorgentiTermodel\Work" >nul 2>&1

rem Prepara tutte le modifiche locali, tranne Work.
git add -A -- . ":(exclude)SorgentiTermodel/Work" ":(exclude)SorgentiTermodel/Work/**"
if errorlevel 1 goto :ERRORE

git diff --cached --quiet
if errorlevel 1 (
    echo Creo il salvataggio delle modifiche locali...
    git commit -m "Aggiornamento locale %date% %time%"
    if errorlevel 1 goto :ERRORE
) else (
    echo Nessuna nuova modifica locale da pubblicare.
)

echo.
echo Ricevo eventuali modifiche fatte su GitHub...
git pull --rebase origin "%BRANCH%"
if errorlevel 1 goto :ERRORE

echo.
echo Invio a GitHub le modifiche locali autorizzate...
git push origin "%BRANCH%"
if errorlevel 1 goto :ERRORE

echo.
echo OK: GitHub aggiornato.
echo Work locale NON e' stato inviato.
goto :FINE

:NOTGIT
echo ERRORE: questa cartella non e' un repository Git.
goto :FINE

:ERRORE
echo.
echo ATTENZIONE: operazione interrotta per sicurezza.
echo Nessun Work locale viene forzato su GitHub.

:FINE
echo.
echo Premi un tasto per chiudere questa finestra...
pause >nul
endlocal
