@echo off
setlocal
cd /d "%~dp0"
echo ATTENZIONE: questo comando sovrascrive i soli file elencati nello snapshot.
echo Prima del ripristino verra' creato automaticamente uno snapshot dello stato corrente.
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\local-radiant-harness\LocalRadiantHarness.ps1" -Action status
echo.
set /p "SNAPSHOT_ID=Scrivi lo SnapshotId esatto da ripristinare, oppure lascia vuoto per annullare:"
if "%SNAPSHOT_ID%"=="" goto annulla
set /p "CONFERMA=Scrivi RIPRISTINA per confermare:"
if /I not "%CONFERMA%"=="RIPRISTINA" goto annulla
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\local-radiant-harness\LocalRadiantHarness.ps1" -Action restore -SnapshotId "%SNAPSHOT_ID%" -ConfirmRestore
goto fine
:annulla
echo Ripristino annullato: nessun file modificato.
:fine
echo.
echo Operazione terminata. La finestra resta aperta per leggere il risultato.
pause
endlocal
