param(
    [ValidateSet('status','export')]
    [string]$Action = 'status',
    [string]$Source = 'C:\DOCUMENTI\sd\Termodel-Library-Appendice-Sorgenti-Pascal'
)

$ErrorActionPreference = 'Stop'
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$Destination = Join-Path $RepoRoot 'SorgentiTermodel\Library\SorgentiPascal'

# Funzione realizzata da Codex in autonomia
function Assert-SafePaths {
    if (-not (Test-Path -LiteralPath $Source -PathType Container)) {
        throw "Raccolta locale non trovata: $Source"
    }
    $expected = Join-Path $RepoRoot 'SorgentiTermodel\Library\SorgentiPascal'
    if (-not $Destination.Equals($expected, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Destinazione inattesa: $Destination"
    }
}

# Funzione realizzata da Codex in autonomia
function Get-FileSha256([string]$Path) {
    $longPath = if ($Path.StartsWith('\\?\')) { $Path } else { '\\?\' + $Path }
    $stream = [IO.File]::OpenRead($longPath)
    try {
        $algorithm = [Security.Cryptography.SHA256]::Create()
        try {
            return ([BitConverter]::ToString($algorithm.ComputeHash($stream))).Replace('-','')
        }
        finally { $algorithm.Dispose() }
    }
    finally { $stream.Dispose() }
}

# Funzione realizzata da Codex in autonomia
function Get-HashIndex([string]$Root) {
    $result = @{}
    if (-not (Test-Path -LiteralPath $Root)) { return $result }
    $resolved = (Resolve-Path -LiteralPath $Root).Path
    Get-ChildItem -LiteralPath $resolved -Recurse -File | ForEach-Object {
        $relative = $_.FullName.Substring($resolved.Length).TrimStart('\','/')
        # Modificato da Codex per realizzare: verificare anche i percorsi storici
        # che superano il limite gestito da Get-FileHash in Windows PowerShell.
        $result[$relative] = Get-FileSha256 $_.FullName
    }
    return $result
}

# Funzione realizzata da Codex in autonomia
function Show-Status {
    $local = Get-HashIndex $Source
    $git = Get-HashIndex $Destination
    $all = @($local.Keys + $git.Keys | Sort-Object -Unique)
    $differences = 0
    foreach ($relative in $all) {
        if (-not $local.ContainsKey($relative)) {
            Write-Host "SOLO LIBRARY GIT  $relative" -ForegroundColor Magenta
            $differences++
        }
        elseif (-not $git.ContainsKey($relative)) {
            Write-Host "SOLO LOCALE       $relative" -ForegroundColor Blue
            $differences++
        }
        elseif ($local[$relative] -ne $git[$relative]) {
            Write-Host "CONTENUTO DIVERSO $relative" -ForegroundColor Red
            $differences++
        }
    }
    Write-Host ''
    Write-Host "File locali: $($local.Count)"
    Write-Host "File Library Git: $($git.Count)"
    if ($differences -eq 0) {
        Write-Host 'OK - raccolta locale e Library Git sono allineate.' -ForegroundColor Green
    }
    else {
        Write-Host "Differenze: $differences" -ForegroundColor Yellow
    }
    return $differences
}

# Funzione realizzata da Codex in autonomia
function Export-ToGitLibrary {
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    & robocopy $Source $Destination /MIR /R:1 /W:1 /COPY:DAT /DCOPY:T /NFL /NDL /NJH /NJS /NP
    $code = $LASTEXITCODE
    if ($code -ge 8) { throw "Robocopy terminato con errore $code" }
    $differences = Show-Status
    if ($differences -ne 0) { throw 'La verifica successiva alla copia ha rilevato differenze.' }
}

Assert-SafePaths
Write-Host "Raccolta locale : $Source"
Write-Host "Library Git      : $Destination"
Write-Host ''

if ($Action -eq 'export') { Export-ToGitLibrary } else { [void](Show-Status) }
