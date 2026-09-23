@echo off
setlocal
cd /d "%~dp0\..\.."
echo ================================================================
echo CONFRONTO SOLA LETTURA: RACCOLTA PASCAL LOCALE vs LIBRARY GIT
echo ================================================================
echo.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Sync-PascalLibrary.ps1" -Action status
set "RC=%ERRORLEVEL%"
echo.
echo Premi un tasto per chiudere questa finestra...
pause >nul
exit /b %RC%
