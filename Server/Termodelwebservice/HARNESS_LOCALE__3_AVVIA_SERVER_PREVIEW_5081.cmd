@echo off
setlocal
cd /d "%~dp0"
echo Avvio la sola preview Harness su http://127.0.0.1:5081/ .
echo Il WebService Termodel sulla porta 5080 non viene modificato.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\local-radiant-harness\LocalRadiantHarness.ps1" -Action serve -Port 5081 -OpenBrowser
echo.
echo Server arrestato. La finestra resta aperta per leggere il risultato.
pause
endlocal
