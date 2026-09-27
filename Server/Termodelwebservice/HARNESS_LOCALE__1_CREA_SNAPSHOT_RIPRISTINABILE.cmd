@echo off
setlocal
cd /d "%~dp0"
echo Creo una copia locale ripristinabile dei sorgenti Harness e Diego_Vittorio.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\local-radiant-harness\LocalRadiantHarness.ps1" -Action snapshot -SnapshotLabel manuale
echo.
echo Operazione terminata. La finestra resta aperta per leggere il risultato.
pause
endlocal
