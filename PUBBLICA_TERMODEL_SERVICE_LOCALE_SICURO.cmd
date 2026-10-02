@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ============================================================
rem Bootstrap: esegue una copia temporanea del CMD.
rem Cosi' il file nella radice del clone puo' essere aggiornato/ripristinato
rem senza interferire con il batch in esecuzione.
rem ============================================================
if /I "%~1"=="--RUN-TEMP" goto :RUN_TEMP

set "TEMP_CMD=%TEMP%\TermodelServicePublisher_%RANDOM%_%RANDOM%.cmd"
copy /y "%~f0" "%TEMP_CMD%" >nul
if errorlevel 1 (
    echo ERRORE: impossibile creare la copia temporanea del comando.
    pause
    exit /b 1
)

call "%TEMP_CMD%" --RUN-TEMP "%~dp0"
set "RC=%ERRORLEVEL%"
del /q "%TEMP_CMD%" >nul 2>&1
exit /b %RC%

:RUN_TEMP
set "REPO_ROOT=%~2"
cd /d "%REPO_ROOT%"

title TermodelService - Pubblicazione sicura

set "BRANCH=main"
set "SERVICE_PATH=Server\Termodelwebservice"
set "TRANSFER_PS1=tools\transfer\TermodelTransfer.ps1"
set "SELF_NAME=PUBBLICA_TERMODEL_SERVICE_LOCALE_SICURO.cmd"
set "LOCAL_ONLY_1=Server\Termodelwebservice\src\Termodel.WebService\Calculations\CalculationSnapshotStore.cs"
set "LOCAL_ONLY_2=Server\Termodelwebservice\src\Termodel.WebService\Calculations\SavedProjectStore.cs"
set "EXPORTED="
set "BACKUP_STASH="
set "STAMP="

echo ============================================================
echo   TERMODEL SERVICE - PUBBLICAZIONE SICURA
echo   Service locale  --^>  clone GitHub  --^>  GitHub remoto
echo ============================================================
echo.
echo Usa questo comando DOPO che Codex o Visual Studio hanno modificato
echo il TermodelWebService locale e vuoi pubblicarlo su GitHub.
echo.
echo Pubblica SOLO codice/file operativi di:
echo   Server\Termodelwebservice
echo.
echo NON pubblica automaticamente:
echo   - documentazione Markdown (*.md)
echo   - definizionedati.json
echo   - CalculationSnapshotStore.cs
echo   - SavedProjectStore.cs
echo.
echo Eventuali vecchie modifiche del Service gia' presenti nel clone
echo vengono salvate automaticamente in un backup Git di sicurezza.
echo.
echo Se qualcosa non torna si ferma e NON forza GitHub.
echo ============================================================
echo.

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 goto :NOTGIT

for /f "delims=" %%B in ('git branch --show-current') do set "CURRENT_BRANCH=%%B"
if /I not "!CURRENT_BRANCH!"=="%BRANCH%" goto :WRONGBRANCH

if not exist "%TRANSFER_PS1%" goto :NOTOOL

echo [1/8] Controllo GitHub...
git fetch origin "%BRANCH%"
if errorlevel 1 goto :ERRORE_PRIMA_EXPORT

rem Se il CMD e' stato creato a mano ed e' ancora untracked, ma esiste gia'
rem su origin/main, rimuovo solo quella copia locale. Sto eseguendo dal TEMP.
git ls-files --error-unmatch "%SELF_NAME%" >nul 2>&1
if errorlevel 1 (
    git cat-file -e "origin/%BRANCH%:%SELF_NAME%" >nul 2>&1
    if not errorlevel 1 (
        if exist "%SELF_NAME%" del /q "%SELF_NAME%" >nul 2>&1
    )
) else (
    rem Il CMD e' uno strumento del repository: eventuali modifiche locali
    rem al wrapper non devono bloccare la pubblicazione del Service.
    git restore --staged --worktree -- "%SELF_NAME%" >nul 2>&1
)

echo.
echo [2/8] Metto al sicuro eventuali vecchie modifiche del Service nel clone...
set "SERVICE_DIRTY="
for /f "delims=" %%L in ('git status --porcelain --untracked-files^=all -- "%SERVICE_PATH%"') do set "SERVICE_DIRTY=1"

if defined SERVICE_DIRTY (
    for /f "delims=" %%T in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmmss"') do set "STAMP=%%T"
    set "BACKUP_STASH=AUTO-BACKUP-SERVICE-BEFORE-PUBLISH-!STAMP!"
    git stash push -u -m "!BACKUP_STASH!" -- "%SERVICE_PATH%"
    if errorlevel 1 goto :ERRORE_PRIMA_EXPORT
    echo Backup creato: !BACKUP_STASH!
) else (
    echo Nessuna vecchia modifica Service da mettere al sicuro.
)

rem Fuori dal Service non deve esserci nulla di modificato.
set "OUTSIDE="
for /f "delims=" %%L in ('git status --porcelain --untracked-files^=all -- . ":(exclude)Server/Termodelwebservice" ":(exclude)Server/Termodelwebservice/**" ":(exclude)%SELF_NAME%"') do set "OUTSIDE=1"
if defined OUTSIDE goto :MODIFICHE_ESTRANEE_PRIMA

echo.
echo [3/8] Aggiorno il clone da origin/main...
git pull --ff-only origin "%BRANCH%"
if errorlevel 1 goto :ERRORE_PRIMA_EXPORT

echo.
echo [4/8] Copio il TermodelService locale nel clone...
set "EXPORTED=1"
powershell -NoProfile -ExecutionPolicy Bypass -File "%TRANSFER_PS1%" -Action export -Name TermodelWebService
if errorlevel 1 goto :ERRORE_DOPO_EXPORT

rem I due sorgenti seguenti sono locali e NON devono partecipare ne' alla
rem build di verifica ne' alla pubblicazione. Se un giorno fossero versionati,
rem viene mantenuta la versione GitHub; altrimenti la copia locale viene
rem eliminata soltanto dal clone. Il sorgente Codex/Visual Studio resta intatto.
call :RIPRISTINA_FILE_LOCALE_ESCLUSO "%LOCAL_ONLY_1%"
if errorlevel 1 goto :ERRORE_DOPO_EXPORT
call :RIPRISTINA_FILE_LOCALE_ESCLUSO "%LOCAL_ONLY_2%"
if errorlevel 1 goto :ERRORE_DOPO_EXPORT

rem Dopo l'export deve essere cambiato soltanto il Service.
set "OUTSIDE="
for /f "delims=" %%L in ('git status --porcelain --untracked-files^=all -- . ":(exclude)Server/Termodelwebservice" ":(exclude)Server/Termodelwebservice/**"') do set "OUTSIDE=1"
if defined OUTSIDE goto :MODIFICHE_ESTRANEE

set "SERVICE_CHANGED="
for /f "delims=" %%L in ('git status --porcelain --untracked-files^=all -- "%SERVICE_PATH%"') do set "SERVICE_CHANGED=1"
if not defined SERVICE_CHANGED goto :NESSUNA_MODIFICA

echo.
echo Modifiche locali rilevate nel Service:
git status --short -- "%SERVICE_PATH%"

echo.
echo [5/8] Compilo la soluzione...
dotnet build "%SERVICE_PATH%\Termodel.WebService.sln" -c Release --nologo
if errorlevel 1 goto :BUILD_FAIL

echo.
echo [6/8] Preparo SOLO i file operativi del TermodelService...
echo Restano esclusi .md, definizionedati.json e i due sorgenti locali protetti.

git add -A -- "%SERVICE_PATH%" ^
  ":(exclude,glob)Server/Termodelwebservice/**/*.md" ^
  ":(exclude,glob)Server/Termodelwebservice/**/definizionedati.json" ^
  ":(exclude)Server/Termodelwebservice/src/Termodel.WebService/Calculations/CalculationSnapshotStore.cs" ^
  ":(exclude)Server/Termodelwebservice/src/Termodel.WebService/Calculations/SavedProjectStore.cs"
if errorlevel 1 goto :ERRORE_DOPO_EXPORT

rem Doppio controllo: nessun file protetto deve essere staged.
set "PROTECTED="
for /f "delims=" %%F in ('git diff --cached --name-only') do (
    echo %%F | findstr /I /R "\.md$ definizionedati\.json$" >nul
    if not errorlevel 1 set "PROTECTED=1"
)
if defined PROTECTED goto :PROTECTED_ERROR

git diff --cached --quiet
if not errorlevel 1 goto :SOLO_DOCUMENTAZIONE

echo.
echo ============================================================
echo FILE CHE VERRANNO PUBBLICATI
echo ============================================================
git diff --cached --name-status
echo ------------------------------------------------------------
git diff --cached --stat
echo.

echo [7/8] Build e controlli superati.
choice /C SN /N /M "Pubblicare adesso su GitHub? [S/N]: "
if errorlevel 2 goto :ANNULLATO

echo.
echo Creo il commit...
git commit -m "TermodelService: aggiornamento locale verificato"
if errorlevel 1 goto :ERRORE_DOPO_COMMIT

echo.
echo Controllo che GitHub non sia cambiato durante la compilazione...
git fetch origin "%BRANCH%"
if errorlevel 1 goto :ERRORE_DOPO_COMMIT

git merge-base --is-ancestor "origin/%BRANCH%" HEAD >nul 2>&1
if errorlevel 1 (
    echo GitHub e' avanzato. Provo un rebase sicuro...
    git pull --rebase origin "%BRANCH%"
    if errorlevel 1 goto :CONFLITTO
)

echo.
echo [8/8] Pubblico su GitHub...
git push origin "%BRANCH%"
if errorlevel 1 (
    echo Il remoto potrebbe essere cambiato negli ultimi secondi.
    echo Provo un solo aggiornamento con rebase...
    git pull --rebase origin "%BRANCH%"
    if errorlevel 1 goto :CONFLITTO
    git push origin "%BRANCH%"
    if errorlevel 1 goto :ERRORE_DOPO_COMMIT
)

echo.
echo Ripulisco nel clone le sole differenze locali NON pubblicate
echo (documentazione protetta, file temporanei). Il Service sorgente locale
echo di Codex/Visual Studio NON viene toccato.
git restore --staged --worktree -- "%SERVICE_PATH%" >nul 2>&1
git clean -fd -- "%SERVICE_PATH%" >nul 2>&1

echo.
echo ============================================================
echo   OK - TERMODEL SERVICE PUBBLICATO SU GITHUB
echo ============================================================
echo.
echo La build locale e' riuscita.
echo Nessun file fuori da Server\Termodelwebservice e' stato pubblicato.
echo Documentazione Markdown e definizionedati.json NON sono stati pubblicati.
echo CalculationSnapshotStore.cs e SavedProjectStore.cs NON sono stati pubblicati.
if defined BACKUP_STASH echo Backup di sicurezza conservato: !BACKUP_STASH!
echo.
echo Ora puoi chiudere questa finestra.
goto :FINE_OK

:RIPRISTINA_FILE_LOCALE_ESCLUSO
set "EXCLUDED_FILE=%~1"
git ls-files --error-unmatch "%EXCLUDED_FILE%" >nul 2>&1
if not errorlevel 1 (
    git restore --staged --worktree -- "%EXCLUDED_FILE%" >nul 2>&1
    if errorlevel 1 exit /b 1
) else (
    if exist "%EXCLUDED_FILE%" del /q "%EXCLUDED_FILE%" >nul 2>&1
    if exist "%EXCLUDED_FILE%" exit /b 1
)
exit /b 0

:NESSUNA_MODIFICA
echo.
echo Nessuna differenza tra il Service locale e GitHub.
echo Non c'e' nulla da pubblicare.
goto :PULISCI_E_FINE

:SOLO_DOCUMENTAZIONE
echo.
echo Le sole differenze locali riguardano documentazione/protezioni escluse.
echo Non pubblico nulla automaticamente.
goto :PULISCI_E_FINE

:ANNULLATO
echo.
echo Pubblicazione annullata.
echo I sorgenti locali restano intatti.
goto :PULISCI_E_FINE

:BUILD_FAIL
echo.
echo ============================================================
echo   STOP - BUILD FALLITA
echo ============================================================
echo Nulla e' stato pubblicato.
echo I sorgenti locali Codex/Visual Studio restano intatti.
echo.
echo Fai una foto di questa finestra e mandala a ChatGPT.
goto :PULISCI_E_FINE

:MODIFICHE_ESTRANEE_PRIMA
echo.
echo ============================================================
echo   STOP - MODIFICHE ESTRANEE NEL CLONE
echo ============================================================
echo Ho messo al sicuro il Service, ma esistono modifiche fuori dal Service.
echo Per sicurezza non continuo.
echo.
git status --short
echo.
echo Fai una foto e mandala a ChatGPT.
goto :FINE

:MODIFICHE_ESTRANEE
echo.
echo ============================================================
echo   STOP - MODIFICHE FUORI DAL TERMODELSERVICE
echo ============================================================
echo Per sicurezza non pubblico nulla.
echo.
git status --short
echo.
echo Fai una foto e mandala a ChatGPT.
goto :PULISCI_E_FINE

:PROTECTED_ERROR
echo.
echo ============================================================
echo   STOP - FILE PROTETTO FINITO NELLO STAGING
echo ============================================================
echo Per sicurezza non pubblico nulla.
git diff --cached --name-status
echo.
echo Fai una foto e mandala a ChatGPT.
goto :PULISCI_E_FINE

:WRONGBRANCH
echo.
echo ============================================================
echo   STOP - BRANCH NON CORRETTO
echo ============================================================
echo Branch attuale: !CURRENT_BRANCH!
echo Questo comando lavora solo su main.
goto :FINE

:NOTOOL
echo.
echo ERRORE: manca:
echo %TRANSFER_PS1%
goto :FINE

:NOTGIT
echo.
echo ERRORE: questo CMD deve trovarsi nella radice del clone GitHub.
goto :FINE

:ERRORE_PRIMA_EXPORT
echo.
echo STOP: errore prima della copia del Service locale.
echo Nulla e' stato pubblicato.
echo Fai una foto e mandala a ChatGPT.
goto :FINE

:ERRORE_DOPO_EXPORT
echo.
echo STOP: errore dopo la copia ma prima del commit.
echo Nulla e' stato pubblicato.
echo La copia nel clone verra' ripristinata.
echo I sorgenti locali restano intatti.
echo Fai una foto e mandala a ChatGPT.
goto :PULISCI_E_FINE

:CONFLITTO
echo.
echo ============================================================
echo   STOP - CONFLITTO GIT
echo ============================================================
echo Il commit locale e' salvo ma NON forzo GitHub.
echo NON rilanciare questo CMD.
echo Fai una foto e mandala a ChatGPT.
goto :FINE

:ERRORE_DOPO_COMMIT
echo.
echo ============================================================
echo   STOP - COMMIT CREATO, PUSH NON COMPLETATO
echo ============================================================
echo Il lavoro e' salvo nel clone locale.
echo NON rilanciare questo CMD.
echo Fai una foto e mandala a ChatGPT.
goto :FINE

:PULISCI_E_FINE
if defined EXPORTED (
    echo.
    echo Ripristino la sola copia del Service nel clone...
    git reset -- "%SERVICE_PATH%" >nul 2>&1
    git restore --worktree -- "%SERVICE_PATH%" >nul 2>&1
    git clean -fd -- "%SERVICE_PATH%" >nul 2>&1
)
goto :FINE

:FINE_OK
echo.
echo Premi un tasto per chiudere...
pause >nul
exit /b 0

:FINE
echo.
echo Premi un tasto per chiudere...
pause >nul
exit /b 1
