param(
    [Parameter(Position=0)]
    [string]$RelativePath
)

$ErrorActionPreference = 'Stop'

# Questo script vive in: GitHub\tools\transfer\
# RepoRoot = cartella GitHub locale
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$TermodelRoot = Split-Path $RepoRoot -Parent

if ([string]::IsNullOrWhiteSpace($RelativePath)) {
    Write-Host ''
    Write-Host 'COPIA DA GITHUB LOCALE A TERMODEL' -ForegroundColor Cyan
    Write-Host "GitHub locale : $RepoRoot"
    Write-Host "Termodel      : $TermodelRoot"
    Write-Host ''
    $RelativePath = Read-Host 'Percorso relativo da copiare (es. Impianti\Pannelli\SpiraliGPT)'
}

if ([string]::IsNullOrWhiteSpace($RelativePath)) {
    throw 'Percorso non specificato.'
}

# Sicurezza: accettiamo solo percorsi relativi interni alla cartella GitHub.
if ([System.IO.Path]::IsPathRooted($RelativePath) -or $RelativePath -match '(^|[\\/])\.\.([\\/]|$)') {
    throw 'Sono ammessi solo percorsi relativi interni alla cartella GitHub.'
}

$RelativePath = $RelativePath.TrimStart('\','/')
$Source = Join-Path $RepoRoot $RelativePath
$Destination = Join-Path $TermodelRoot $RelativePath

if (-not (Test-Path $Source)) {
    throw "Sorgente non trovata: $Source"
}

$Stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$BackupRoot = Join-Path $RepoRoot '_backup'
$Backup = Join-Path (Join-Path $BackupRoot $Stamp) $RelativePath

Write-Host ''
Write-Host 'Sorgente:' -ForegroundColor Yellow
Write-Host "  $Source"
Write-Host 'Destinazione:' -ForegroundColor Yellow
Write-Host "  $Destination"

if (Test-Path $Destination) {
    Write-Host 'Backup preventivo:' -ForegroundColor Yellow
    Write-Host "  $Backup"
    New-Item -ItemType Directory -Force -Path (Split-Path $Backup -Parent) | Out-Null

    if ((Get-Item $Destination).PSIsContainer) {
        Copy-Item $Destination $Backup -Recurse -Force
    }
    else {
        Copy-Item $Destination $Backup -Force
    }
}
else {
    Write-Host 'La destinazione non esiste ancora: verra creata.' -ForegroundColor DarkYellow
}

Write-Host ''
$answer = Read-Host 'Procedere con la copia? (S/N)'
if ($answer -notmatch '^[SsYy]$') {
    Write-Host 'Operazione annullata.'
    exit 0
}

if ((Get-Item $Source).PSIsContainer) {
    New-Item -ItemType Directory -Force -Path $Destination | Out-Null

    # /E copia sottocartelle; NON usiamo /MIR, quindi non cancelliamo file dal Termodel reale.
    & robocopy $Source $Destination /E /COPY:DAT /DCOPY:DAT /R:1 /W:1 /XD .git bin obj _backup
    $rc = $LASTEXITCODE
    if ($rc -ge 8) {
        throw "Robocopy ha restituito errore $rc"
    }
}
else {
    New-Item -ItemType Directory -Force -Path (Split-Path $Destination -Parent) | Out-Null
    Copy-Item $Source $Destination -Force
}

Write-Host ''
Write-Host 'COPIA COMPLETATA.' -ForegroundColor Green
Write-Host "Da : $Source"
Write-Host "A  : $Destination"
if (Test-Path $Backup) {
    Write-Host "Backup: $Backup"
}
