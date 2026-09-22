@echo off
setlocal EnableExtensions

rem Aggiorna il clone GitHub e copia il Service nel workspace locale.
rem Non esegue reset, stash, commit, build o avvio del server.

for %%R in ("%~dp0.") do set "REPO=%%~fR"
set "TRANSFER=%REPO%\tools\transfer\TermodelTransfer.ps1"
set "SOLUTION=C:\DOCUMENTI\termomodel\codec\Termodelwebservice\Termodel.WebService.sln"
set "GIT_TERMINAL_PROMPT=0"
set "GCM_INTERACTIVE=Never"

echo.
echo ================================================================
echo AGGIORNAMENTO TERMODEL SERVICE DA GITHUB
echo ================================================================
echo Repository: %REPO%
echo Direzione : GitHub -^> Service locale
echo.

where git.exe >nul 2>&1
if errorlevel 1 goto :git_missing

if not exist "%TRANSFER%" goto :transfer_missing

git -c safe.directory="%REPO%" -C "%REPO%" rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 goto :not_repository

for /f "delims=" %%B in ('git -c safe.directory^="%REPO%" -C "%REPO%" branch --show-current 2^>nul') do set "BRANCH=%%B"
if /i not "%BRANCH%"=="main" goto :wrong_branch

for /f "delims=" %%S in ('git -c safe.directory^="%REPO%" -C "%REPO%" status --porcelain --untracked-files^=normal') do set "DIRTY=1"
if defined DIRTY goto :dirty_repository

echo [1/4] Recupero aggiornamenti da origin/main...
git -c safe.directory="%REPO%" -C "%REPO%" fetch --prune origin main
if errorlevel 1 goto :fetch_failed

echo [2/4] Aggiornamento fast-forward only...
git -c safe.directory="%REPO%" -C "%REPO%" merge --ff-only origin/main
if errorlevel 1 goto :merge_failed

echo [3/4] Copia GitHub -^> Service locale con backup...
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%TRANSFER%" -Action import -Name TermodelWebService
if errorlevel 1 goto :import_failed

echo [4/4] Verifica stato finale del repository...
git -c safe.directory="%REPO%" -C "%REPO%" status --short --branch
if errorlevel 1 goto :status_failed

for /f "delims=" %%H in ('git -c safe.directory^="%REPO%" -C "%REPO%" rev-parse HEAD') do set "FINAL_HEAD=%%H"

echo.
echo ================================================================
echo AGGIORNAMENTO COMPLETATO
echo ================================================================
echo HEAD: %FINAL_HEAD%
echo Soluzione pronta per Visual Studio:
echo %SOLUTION%
echo.
echo Apri la soluzione e usa Compila -^> Ricompila soluzione.
set "FINAL_RC=0"
goto :close_window

:git_missing
echo ERRORE: git.exe non e disponibile nel PATH.
goto :failed

:transfer_missing
echo ERRORE: script di trasferimento non trovato:
echo %TRANSFER%
goto :failed

:not_repository
echo ERRORE: la cartella dello script non appartiene a un repository Git valido.
goto :failed

:wrong_branch
echo ERRORE: branch corrente "%BRANCH%". E richiesto il branch "main".
echo Cambia branch manualmente e riesegui il comando.
goto :failed

:dirty_repository
echo ERRORE: il repository contiene modifiche locali o file non tracciati.
git -c safe.directory="%REPO%" -C "%REPO%" status --short
echo Nessun file e stato modificato, salvato nello stash o eliminato.
goto :failed

:fetch_failed
echo ERRORE: impossibile recuperare origin/main.
echo Verifica connessione Internet e configurazione Git. Nessuna richiesta interattiva e consentita.
goto :failed

:merge_failed
echo ERRORE: l'aggiornamento non puo essere eseguito in fast-forward.
echo Nessun merge automatico, reset o rebase e stato effettuato.
goto :failed

:import_failed
echo ERRORE: aggiornamento Git completato, ma copia verso il Service locale fallita.
echo Controlla il messaggio precedente e il backup creato dallo script di trasferimento.
goto :failed

:status_failed
echo ERRORE: copia completata, ma verifica finale Git fallita.
goto :failed

:failed
echo.
echo Aggiornamento interrotto in sicurezza.
set "FINAL_RC=1"

:close_window
echo.
echo Premi un tasto per chiudere questa finestra...
pause >nul
exit /b %FINAL_RC%
