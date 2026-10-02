@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0"

title TermodelService - Pubblicazione sicura

set "BRANCH=main"
set "SERVICE_PATH=Server\Termodelwebservice"
set "TRANSFER_PS1=tools\transfer\TermodelTransfer.ps1"
set "EXPORTED="
set "COMMITTED="

echo ============================================================
echo   TERMODEL SERVICE - PUBBLICAZIONE SICURA
echo   Service locale  --^>  clone GitHub  --^>  GitHub remoto
echo ============================================================
echo.
echo USA QUESTO CMD quando Codex o Visual Studio hanno modificato:
echo   C:\DOCUMENTI\termomodel\codec\Termodelwebservice\
echo e vuoi pubblicare quelle modifiche su GitHub.
echo.
echo NON usarlo per scaricare GitHub verso il PC.
echo Per quello usa:
echo   SCARICA_GITHUB_E_PREPARA_TERMODEL_SERVICE_LOCALE.cmd
echo.
echo Questo comando:
echo   1. controlla che il clone Git sia pulito;
echo   2. aggiorna il clone da origin/main;
echo   3. copia SOLO il TermodelService locale nel clone;
echo   4. verifica che non siano comparsi cambiamenti fuori dal Service;
echo   5. compila Termodel.WebService.sln;
echo   6. mostra i file che verranno pubblicati;
echo   7. chiede una sola conferma finale;
echo   8. crea commit e push SENZA force-push.
echo.
echo Se qualcosa non torna, si ferma e NON pubblica.
echo ============================================================
echo.

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 goto :NOTGIT

for /f "delims=" %%B in ('git branch --show-current') do set "CURRENT_BRANCH=%%B"
if /I not "!CURRENT_BRANCH!"=="%BRANCH%" goto :WRONGBRANCH

if not exist "%TRANSFER_PS1%" goto :NOTOOL

set "DIRTY="
for /f "delims=" %%L in ('git status --porcelain --untracked-files^=all') do set "DIRTY=1"
if defined DIRTY goto :DIRTY

echo [1/7] Aggiorno il clone GitHub...
git fetch origin "%BRANCH%"
if errorlevel 1 goto :ERRORE_PRIMA_EXPORT

git pull --ff-only origin "%BRANCH%"
if errorlevel 1 goto :ERRORE_PRIMA_EXPORT

set "DIRTY="
for /f "delims=" %%L in ('git status --porcelain --untracked-files^=all') do set "DIRTY=1"
if defined DIRTY goto :DIRTY_AFTER_PULL

echo.
echo [2/7] Copio il TermodelService locale nel clone...
powershell -NoProfile -ExecutionPolicy Bypass -File "%TRANSFER_PS1%" -Action export -Name TermodelWebService
if errorlevel 1 goto :ERRORE_PRIMA_EXPORT
set "EXPORTED=1"

set "OUTSIDE="
for /f "delims=" %%L in ('git status --porcelain --untracked-files^=all -- . ":(exclude)Server/Termodelwebservice" ":(exclude)Server/Termodelwebservice/**"') do set "OUTSIDE=1"
if defined OUTSIDE goto :MODIFICHE_ESTRANEE

set "SERVICE_CHANGED="
for /f "delims=" %%L in ('git status --porcelain --untracked-files^=all -- "%SERVICE_PATH%"') do set "SERVICE_CHANGED=1"
if not defined SERVICE_CHANGED goto :NESSUNA_MODIFICA

echo.
echo [3/7] Modifiche Service rilevate:
git status --short -- "%SERVICE_PATH%"

echo.
echo [4/7] Compilo la soluzione prima di pubblicare...
dotnet build "%SERVICE_PATH%\Termodel.WebService.sln" -c Release --nologo
if errorlevel 1 goto :BUILD_FAIL

echo.
echo [5/7] Preparo SOLO i file del TermodelService...
git add -A -- "%SERVICE_PATH%"
if errorlevel 1 goto :ERRORE_DOPO_EXPORT

git diff --cached --quiet
if not errorlevel 1 goto :NESSUNA_MODIFICA_STAGED

echo.
echo File pronti per la pubblicazione:
echo ------------------------------------------------------------
git diff --cached --name-status
echo ------------------------------------------------------------
echo.
echo Statistiche:
git diff --cached --stat
echo.

echo [6/7] Tutti i controlli automatici sono superati.
choice /C SN /N /M "Pubblicare adesso su GitHub? [S/N]: "
if errorlevel 2 goto :ANNULLATO

echo.
echo Creo il commit...
git commit -m "TermodelService: aggiornamento locale verificato"
if errorlevel 1 goto :ERRORE_DOPO_COMMIT
set "COMMITTED=1"

echo.
echo Controllo che GitHub non sia cambiato durante la compilazione...
git fetch origin "%BRANCH%"
if errorlevel 1 goto :ERRORE_DOPO_COMMIT

git merge-base --is-ancestor "origin/%BRANCH%" HEAD >nul 2>&1
if errorlevel 1 (
    echo GitHub e' avanzato nel frattempo. Provo un rebase sicuro...
    git pull --rebase origin "%BRANCH%"
    if errorlevel 1 goto :CONFLITTO
)

echo.
echo [7/7] Pubblico su GitHub...
git push origin "%BRANCH%"
if errorlevel 1 (
    echo Il remoto potrebbe essere cambiato negli ultimi secondi.
    echo Provo un solo aggiornamento con rebase e un nuovo push...
    git pull --rebase origin "%BRANCH%"
    if errorlevel 1 goto :CONFLITTO
    git push origin "%BRANCH%"
    if errorlevel 1 goto :ERRORE_DOPO_COMMIT
)

echo.
echo ============================================================
echo   OK - TERMODEL SERVICE PUBBLICATO SU GITHUB
echo ============================================================
echo.
echo La build locale del clone e' riuscita.
echo Nessun file fuori da Server\Termodelwebservice e' stato pubblicato.
echo Ora GitHub Actions / ntfy potranno notificare le verifiche remote.
goto :FINE

:NESSUNA_MODIFICA
echo.
echo Nessuna differenza tra il Service locale e quello nel clone GitHub.
echo Non c'e' nulla da pubblicare.
goto :PULISCI_E_FINE

:NESSUNA_MODIFICA_STAGED
echo.
echo Nessuna modifica Service risulta pronta dopo i controlli.
goto :PULISCI_E_FINE

:ANNULLATO
echo.
echo Pubblicazione annullata dall'utente.
echo I sorgenti locali restano intatti.
goto :PULISCI_E_FINE

:BUILD_FAIL
echo.
echo ============================================================
echo   STOP - LA BUILD NON E' RIUSCITA
echo ============================================================
echo Nulla e' stato pubblicato su GitHub.
echo I sorgenti locali modificati da Codex restano intatti.
echo La sola copia temporanea nel clone verra' ripulita.
echo.
echo Fai una foto a questa finestra e mandala a ChatGPT.
goto :PULISCI_E_FINE

:MODIFICHE_ESTRANEE
echo.
echo ============================================================
echo   STOP - TROVATE MODIFICHE FUORI DAL TERMODELSERVICE
echo ============================================================
echo Per sicurezza non pubblico nulla.
echo I sorgenti locali restano intatti.
echo.
git status --short
echo.
echo Fai una foto a questa finestra e mandala a ChatGPT.
goto :PULISCI_E_FINE

:DIRTY
echo.
echo ============================================================
echo   STOP - IL CLONE GITHUB NON E' PULITO
echo ============================================================
echo Ci sono modifiche gia' presenti nel clone prima di iniziare.
echo Non faccio alcuna copia, commit o push.
echo.
git status --short
echo.
echo Fai una foto a questa finestra e mandala a ChatGPT.
goto :FINE

:DIRTY_AFTER_PULL
echo.
echo ============================================================
echo   STOP - STATO GIT INATTESO DOPO L'AGGIORNAMENTO
echo ============================================================
git status --short
echo.
echo Non pubblico nulla. Manda questa schermata a ChatGPT.
goto :FINE

:WRONGBRANCH
echo.
echo ============================================================
echo   STOP - BRANCH NON CORRETTO
echo ============================================================
echo Branch attuale: !CURRENT_BRANCH!
echo Questo comando pubblica soltanto il branch main.
echo Non faccio alcuna modifica.
goto :FINE

:NOTOOL
echo.
echo ERRORE: manca %TRANSFER_PS1%
echo Non faccio alcuna modifica.
goto :FINE

:NOTGIT
echo.
echo ERRORE: questo CMD deve essere eseguito dalla radice del clone GitHub.
goto :FINE

:ERRORE_PRIMA_EXPORT
echo.
echo STOP: errore prima della copia del Service locale.
echo Nulla e' stato pubblicato.
echo Manda questa schermata a ChatGPT.
goto :FINE

:ERRORE_DOPO_EXPORT
echo.
echo STOP: errore dopo la copia ma prima del commit.
echo Nulla e' stato pubblicato.
echo La copia nel clone verra' ripulita; i sorgenti locali restano intatti.
echo Manda questa schermata a ChatGPT.
goto :PULISCI_E_FINE

:CONFLITTO
echo.
echo ============================================================
echo   STOP - CONFLITTO GIT
echo ============================================================
echo Il commit locale e' salvo ma NON forzo nulla su GitHub.
echo NON rilanciare questo CMD.
echo Manda questa schermata a ChatGPT.
goto :FINE

:ERRORE_DOPO_COMMIT
echo.
echo ============================================================
echo   STOP - COMMIT LOCALE CREATO, PUSH NON COMPLETATO
echo ============================================================
echo Il lavoro e' salvo nel clone locale ma non e' stato forzato sul remoto.
echo NON rilanciare questo CMD.
echo Manda questa schermata a ChatGPT.
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

:FINE
echo.
echo Premi un tasto per chiudere questa finestra...
pause >nul
endlocal
