param(
    [ValidateSet('status','export','import','pull','push','receive','publish')]
    [string]$Action = 'status',
    [string]$Message = '',
    [string]$Name = ''
)

$ErrorActionPreference = 'Stop'

$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
$ConfigPath = Join-Path $RepoRoot 'transfer-map.json'

if (-not (Test-Path $ConfigPath)) {
    throw "Configurazione non trovata: $ConfigPath"
}

$config = Get-Content $ConfigPath -Raw | ConvertFrom-Json
$ProjectRoot = (Resolve-Path (Join-Path $RepoRoot $config.projectRoot)).Path
$WorkspaceRoot = Join-Path $RepoRoot $config.workspaceRoot
$BackupRoot = Join-Path $RepoRoot '_backups'
$ExcludedDirectories = @($config.excludeDirectories)
$ExcludedFiles = @($config.excludeFiles)
$Mappings = @($config.mappings | Where-Object { $_.enabled -eq $true })

if (-not [string]::IsNullOrWhiteSpace($Name)) {
    $Mappings = @($Mappings | Where-Object { $_.name -eq $Name })
}

if ($Mappings.Count -eq 0) {
    throw 'Nessun mapping abilitato in transfer-map.json'
}

function Write-Title([string]$text) {
    Write-Host ''
    Write-Host ('=' * 72) -ForegroundColor DarkGray
    Write-Host $text -ForegroundColor Cyan
    Write-Host ('=' * 72) -ForegroundColor DarkGray
}

function Ensure-Directory([string]$path) {
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path -Force | Out-Null
    }
}

function Get-MappingTarget($mapping) {
    # Modificato da Codex per realizzare: consentire moduli versionati direttamente
    # nel repository, mantenendo compatibilità con il precedente workspace.
    $base = if ($mapping.targetBase -eq 'repository') { $RepoRoot } else { $WorkspaceRoot }
    return Join-Path $base $mapping.target
}

function Invoke-RobocopySafe {
    param(
        [string]$Source,
        [string]$Destination,
        [switch]$Mirror
    )

    Ensure-Directory $Destination

    $args = @(
        $Source,
        $Destination,
        '/E',
        '/R:1',
        '/W:1',
        '/COPY:DAT',
        '/DCOPY:T',
        '/NFL',
        '/NDL',
        '/NJH',
        '/NJS',
        '/NP'
    )

    if ($Mirror) { $args += '/MIR' }

    if ($ExcludedDirectories.Count -gt 0) {
        $args += '/XD'
        $args += $ExcludedDirectories
    }

    if ($ExcludedFiles.Count -gt 0) {
        $args += '/XF'
        $args += $ExcludedFiles
    }

    & robocopy @args | Out-Null
    $code = $LASTEXITCODE
    if ($code -ge 8) {
        # Modificato da Codex per realizzare: delimitare la variabile prima dei due punti.
        throw "Robocopy terminato con errore ${code}: $Source -> $Destination"
    }
}

function Copy-MappingExport($mapping) {
    $source = Join-Path $ProjectRoot $mapping.source
    $target = Get-MappingTarget $mapping

    if (-not (Test-Path $source)) {
        throw "Sorgente non trovata per '$($mapping.name)': $source"
    }

    Write-Host "[$($mapping.name)]" -ForegroundColor Yellow
    Write-Host "  Termodel : $source"
    Write-Host "  Git      : $target"

    if (Test-Path $source -PathType Container) {
        Invoke-RobocopySafe -Source $source -Destination $target -Mirror
    }
    else {
        Ensure-Directory (Split-Path $target -Parent)
        Copy-Item $source $target -Force
    }
}

function Backup-Destination($mapping, [string]$destination) {
    if (-not (Test-Path $destination)) { return }

    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $backup = Join-Path $BackupRoot (Join-Path $stamp $mapping.name)

    Write-Host "  Backup   : $backup" -ForegroundColor DarkGray

    if (Test-Path $destination -PathType Container) {
        Invoke-RobocopySafe -Source $destination -Destination $backup
    }
    else {
        Ensure-Directory (Split-Path $backup -Parent)
        Copy-Item $destination $backup -Force
    }
}

function Copy-MappingImport($mapping) {
    $source = Get-MappingTarget $mapping
    $target = Join-Path $ProjectRoot $mapping.source

    if (-not (Test-Path $source)) {
        throw "Workspace non trovato per '$($mapping.name)': $source"
    }

    Write-Host "[$($mapping.name)]" -ForegroundColor Yellow
    Write-Host "  Git      : $source"
    Write-Host "  Termodel : $target"

    Backup-Destination $mapping $target

    if (Test-Path $source -PathType Container) {
        # Import volutamente NON distruttivo: copia/aggiorna, ma non cancella
        # dal progetto reale file assenti nel workspace.
        Invoke-RobocopySafe -Source $source -Destination $target
    }
    else {
        Ensure-Directory (Split-Path $target -Parent)
        Copy-Item $source $target -Force
    }
}

function Test-Excluded([string]$relativePath) {
    $parts = $relativePath -split '[\\/]'
    foreach ($p in $parts) {
        if ($ExcludedDirectories -contains $p) { return $true }
    }
    foreach ($pattern in $ExcludedFiles) {
        if ((Split-Path $relativePath -Leaf) -like $pattern) { return $true }
    }
    return $false
}

function Get-HashTable([string]$path) {
    $table = @{}

    if (-not (Test-Path $path)) { return $table }

    if (-not (Test-Path $path -PathType Container)) {
        $table['.'] = (Get-FileHash $path -Algorithm SHA256).Hash
        return $table
    }

    $base = (Resolve-Path $path).Path
    Get-ChildItem $base -Recurse -File | ForEach-Object {
        # Modificato da Codex per realizzare: passare caratteri singoli a TrimStart.
        $rel = $_.FullName.Substring($base.Length).TrimStart('\','/')
        if (-not (Test-Excluded $rel)) {
            $table[$rel] = (Get-FileHash $_.FullName -Algorithm SHA256).Hash
        }
    }

    return $table
}

function Show-Status {
    Write-Title 'STATO TRANSFER TERMODEL <-> GITHUB'

    foreach ($mapping in $Mappings) {
        $local = Join-Path $ProjectRoot $mapping.source
        $git = Get-MappingTarget $mapping

        Write-Host "[$($mapping.name)]" -ForegroundColor Yellow
        $a = Get-HashTable $local
        $b = Get-HashTable $git

        $all = @($a.Keys + $b.Keys | Sort-Object -Unique)
        $different = 0

        foreach ($key in $all) {
            if (-not $a.ContainsKey($key)) {
                Write-Host "  SOLO GIT     $key" -ForegroundColor Magenta
                $different++
            }
            elseif (-not $b.ContainsKey($key)) {
                Write-Host "  SOLO TERMODEL $key" -ForegroundColor Blue
                $different++
            }
            elseif ($a[$key] -ne $b[$key]) {
                Write-Host "  DIVERSO      $key" -ForegroundColor Red
                $different++
            }
        }

        if ($different -eq 0) {
            Write-Host '  OK - contenuti allineati' -ForegroundColor Green
        }
    }
}

function Export-All {
    Write-Title 'ESPORTAZIONE TERMODEL -> WORKSPACE GITHUB'
    Ensure-Directory $WorkspaceRoot
    foreach ($mapping in $Mappings) { Copy-MappingExport $mapping }
    Write-Host ''
    Write-Host 'Esportazione completata.' -ForegroundColor Green
}

function Import-All {
    Write-Title 'IMPORTAZIONE WORKSPACE GITHUB -> TERMODEL'
    foreach ($mapping in $Mappings) { Copy-MappingImport $mapping }
    Write-Host ''
    Write-Host 'Importazione completata. Backup salvato in _backups.' -ForegroundColor Green
}

function Assert-Git {
    $cmd = Get-Command git -ErrorAction SilentlyContinue
    if (-not $cmd) { throw 'Git non e installato o non e nel PATH.' }

    & git -C $RepoRoot rev-parse --is-inside-work-tree *> $null
    if ($LASTEXITCODE -ne 0) {
        throw "La cartella non e un repository Git locale: $RepoRoot"
    }
}

function Git-Pull {
    Write-Title 'GIT PULL'
    Assert-Git
    & git -C $RepoRoot pull --ff-only
    if ($LASTEXITCODE -ne 0) { throw 'git pull fallito.' }
}

function Git-Push {
    Write-Title 'GIT COMMIT + PUSH'
    Assert-Git

    & git -C $RepoRoot add -- 'workspace' 'Server' 'transfer-map.json' 'tools/transfer' '.gitignore'
    if ($LASTEXITCODE -ne 0) { throw 'git add fallito.' }

    & git -C $RepoRoot diff --cached --quiet
    if ($LASTEXITCODE -eq 0) {
        Write-Host 'Nessuna modifica da pubblicare.' -ForegroundColor Yellow
        return
    }

    if ([string]::IsNullOrWhiteSpace($Message)) {
        $Message = 'Update Termodel workspace ' + (Get-Date -Format 'yyyy-MM-dd HH:mm')
    }

    & git -C $RepoRoot commit -m $Message
    if ($LASTEXITCODE -ne 0) { throw 'git commit fallito.' }

    & git -C $RepoRoot push
    if ($LASTEXITCODE -ne 0) { throw 'git push fallito.' }

    Write-Host 'Pubblicazione completata.' -ForegroundColor Green
}

switch ($Action) {
    'status'  { Show-Status }
    'export'  { Export-All }
    'import'  { Import-All }
    'pull'    { Git-Pull }
    'push'    { Git-Push }
    'receive' { Git-Pull; Import-All; Show-Status }
    'publish' { Export-All; Git-Push; Show-Status }
}
