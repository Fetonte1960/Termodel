@echo off
setlocal
cd /d "%~dp0"

set "SRC=%~dp0SorgentiTermodel\Work"
set "DST=%~dp0Locale"

echo ======================================
echo   TERMODEL - COPIA DA GIT
 eecho   Work  ^>  Locale
 echo ======================================
echo.

if not exist "%SRC%" (
    echo ERRORE: cartella sorgente non trovata:
    echo %SRC%
    echo.
    pause
    exit /b 1
)

if not exist "%DST%" mkdir "%DST%"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$src = '%SRC%'; $dst = '%DST%';" ^
  "Get-ChildItem -LiteralPath $src -Force | Where-Object { $_.Name -ne 'README.md' } | ForEach-Object {" ^
  "  $target = Join-Path $dst $_.Name;" ^
  "  if ($_.PSIsContainer) { Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse -Force }" ^
  "  else { Copy-Item -LiteralPath $_.FullName -Destination $target -Force }" ^
  "}"

if errorlevel 1 (
    echo.
    echo ATTENZIONE: copia non completata.
) else (
    echo.
    echo Copia completata.
    echo Destinazione: %DST%
)

echo.
pause
endlocal
