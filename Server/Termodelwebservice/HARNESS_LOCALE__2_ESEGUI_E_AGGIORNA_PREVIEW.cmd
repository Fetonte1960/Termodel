@echo off
setlocal
cd /d "%~dp0"
echo Eseguo Diego_Vittorio in locale e aggiorno SVG, XML, metriche e log della preview.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\local-radiant-harness\LocalRadiantHarness.ps1" -Action run
echo.
echo Operazione terminata. La finestra resta aperta per leggere il risultato.
pause
endlocal
