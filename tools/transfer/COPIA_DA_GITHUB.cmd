@echo off
setlocal
set SCRIPT_DIR=%~dp0
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%CopiaDaGitHub.ps1" %*
set RC=%ERRORLEVEL%
echo.
if not "%RC%"=="0" echo Operazione terminata con codice %RC%.
pause
exit /b %RC%
