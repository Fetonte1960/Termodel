@echo off
setlocal
cd /d "%~dp0"

echo ======================================
echo   TERMODEL - AGGIORNA CARTELLA GITHUB
echo ======================================
echo.

git pull --ff-only

if errorlevel 1 (
    echo.
    echo ATTENZIONE: aggiornamento non eseguito.
    echo Controlla eventuali modifiche locali o divergenze Git.
) else (
    echo.
    echo Aggiornamento completato.
)

echo.
pause
endlocal
