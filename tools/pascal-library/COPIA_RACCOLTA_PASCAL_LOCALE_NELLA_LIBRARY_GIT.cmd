@echo off
setlocal
cd /d "%~dp0\..\.."
echo ================================================================
echo ALLINEAMENTO: RACCOLTA PASCAL LOCALE --^> LIBRARY GIT
echo ================================================================
echo Origine     : C:\DOCUMENTI\sd\Termodel-Library-Appendice-Sorgenti-Pascal
echo Destinazione: SorgentiTermodel\Library\SorgentiPascal
echo.
echo ATTENZIONE: la destinazione viene resa speculare all'origine.
choice /C SN /N /M "Procedere? [S/N] "
if errorlevel 2 goto :annullato
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Sync-PascalLibrary.ps1" -Action export
set "RC=%ERRORLEVEL%"
goto :fine
:annullato
echo Operazione annullata. Nessun file copiato.
set "RC=0"
:fine
echo.
echo Premi un tasto per chiudere questa finestra...
pause >nul
exit /b %RC%
