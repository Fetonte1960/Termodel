@echo off
setlocal
cd /d "%~dp0\..\.."
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0TermodelTransfer.ps1" -Action status -Name TermodelWebService
echo.
choice /M "Copiare Server\Termodelwebservice nel Service locale con backup"
if errorlevel 2 exit /b 0
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0TermodelTransfer.ps1" -Action import -Name TermodelWebService
pause
