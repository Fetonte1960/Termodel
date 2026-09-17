@echo off
setlocal
cd /d "%~dp0\..\.."

:menu
cls
echo ================================================================
echo  TERMODEL ^<^-> GITHUB TRANSFER
echo ================================================================
echo.
echo  1  Stato differenze

echo  2  Esporta Termodel ^> workspace GitHub

echo  3  Importa workspace GitHub ^> Termodel  (con backup)

echo  4  Git pull

echo  5  Git commit + push

echo  6  RICEVI COMPLETO  = pull + import

echo  7  PUBBLICA COMPLETO = export + commit + push

echo  0  Esci

echo.
set /p scelta=Scelta: 

if "%scelta%"=="1" powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0TermodelTransfer.ps1" -Action status
if "%scelta%"=="2" powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0TermodelTransfer.ps1" -Action export
if "%scelta%"=="3" powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0TermodelTransfer.ps1" -Action import
if "%scelta%"=="4" powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0TermodelTransfer.ps1" -Action pull
if "%scelta%"=="5" powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0TermodelTransfer.ps1" -Action push
if "%scelta%"=="6" powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0TermodelTransfer.ps1" -Action receive
if "%scelta%"=="7" powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0TermodelTransfer.ps1" -Action publish
if "%scelta%"=="0" goto :eof

echo.
pause
goto menu
