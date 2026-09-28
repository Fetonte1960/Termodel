param(
    [ValidateSet("run", "snapshot", "restore", "serve", "status")]
    [string]$Action = "run",
    [string]$SnapshotId = "",
    [string]$SnapshotLabel = "manuale",
    [int]$Port = 5081,
    [switch]$Rebuild,
    [switch]$NoBuild,
    [switch]$UseMirror,
    [string]$PreparedInput = "",
    [string]$RunId = "",
    [switch]$Fillets,
    [switch]$Closure,
    [ValidateSet("left", "right")]
    [string]$ReturnSide = "left",
    [ValidateRange(0.001, 10.0)]
    [double]$StepMeters = 0.30,
    [switch]$LegacyReturn,
    [switch]$OpenBrowser,
    [switch]$ConfirmRestore
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$ServiceRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot "..\.."))
$StateRoot = Join-Path ([Environment]::GetFolderPath("LocalApplicationData")) "Termodel\RadiantHarness"
$SnapshotRoot = Join-Path $StateRoot "Snapshots"
$MirrorRoot = Join-Path $StateRoot "SourceMirror"
$LatestRoot = Join-Path $StateRoot "Latest"
$LogRoot = Join-Path $StateRoot "Logs"
$FingerprintPath = Join-Path $StateRoot "source-fingerprint.txt"
$SourceStampPath = Join-Path $StateRoot "source-stamp.txt"
$HarnessProjectRelative = "tools\Termodel.RadiantPanels.Harness\Termodel.RadiantPanels.Harness.csproj"
$CaseRelative = "tests\radiant-harness\cases\LG041-SQUARE4X4-T1-P030-DIEGO-VITTORIO.json"
$DefaultCaseId = "LG041-SQUARE4X4-T1-P030-DIEGO-VITTORIO"
$CaseId = if (-not [string]::IsNullOrWhiteSpace($RunId)) {
    $RunId
} elseif (-not [string]::IsNullOrWhiteSpace($PreparedInput)) {
    [IO.Path]::GetFileNameWithoutExtension($PreparedInput)
} else {
    $DefaultCaseId
}

function Write-Utf8Text([string]$Path, [string]$Text) {
    [IO.File]::WriteAllText($Path, $Text, $Utf8NoBom)
}

function Assert-ChildPath([string]$Candidate, [string]$Root, [string]$Purpose) {
    $rootFull = [IO.Path]::GetFullPath($Root).TrimEnd('\') + '\'
    $candidateFull = [IO.Path]::GetFullPath($Candidate)
    if (-not $candidateFull.StartsWith($rootFull, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Percorso non valido per ${Purpose}: $candidateFull non e' sotto $rootFull"
    }
    return $candidateFull
}

function Get-RelativePath([string]$BasePath, [string]$TargetPath) {
    $baseFull = [IO.Path]::GetFullPath($BasePath).TrimEnd('\') + '\'
    $targetFull = [IO.Path]::GetFullPath($TargetPath)
    $baseUri = New-Object Uri($baseFull)
    $targetUri = New-Object Uri($targetFull)
    return [Uri]::UnescapeDataString($baseUri.MakeRelativeUri($targetUri).ToString()).Replace('/', '\')
}

function Get-SourceFiles {
    $roots = @(
        (Join-Path $ServiceRoot "src\Termodel.Core"),
        (Join-Path $ServiceRoot "tools\Termodel.RadiantPanels.Harness")
    )
    $files = New-Object System.Collections.Generic.List[System.IO.FileInfo]
    foreach ($root in $roots) {
        if (-not (Test-Path -LiteralPath $root)) { continue }
        Get-ChildItem -LiteralPath $root -Recurse -File | Where-Object {
            $_.FullName -notmatch '[\\/](bin|obj)[\\/]'
        } | ForEach-Object { $files.Add($_) }
    }
    $props = Join-Path $ServiceRoot "Directory.Build.props"
    if (Test-Path -LiteralPath $props) { $files.Add((Get-Item -LiteralPath $props)) }
    return $files | Sort-Object FullName
}

function Get-SourceFingerprint {
    $rows = foreach ($file in Get-SourceFiles) {
        $relative = Get-RelativePath $ServiceRoot $file.FullName
        $hash = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash
        "$relative|$hash"
    }
    $bytes = [Text.Encoding]::UTF8.GetBytes(($rows -join "`n"))
    $sha = [Security.Cryptography.SHA256]::Create()
    try {
        return ([BitConverter]::ToString($sha.ComputeHash($bytes))).Replace('-', '')
    }
    finally {
        $sha.Dispose()
    }
}

function Get-SourceStamp {
    # Il ciclo rapido usa solo metadati filesystem, non rilegge/hash-a il
    # contenuto di tutto Termodel.Core ad ogni prova. MSBuild resta
    # responsabile della build incrementale quando lo stamp cambia.
    $rows = foreach ($file in Get-SourceFiles) {
        $relative = Get-RelativePath $ServiceRoot $file.FullName
        "$relative|$($file.Length)|$($file.LastWriteTimeUtc.Ticks)"
    }
    return ($rows -join "`n")
}

function Ensure-DirectBuild {
    New-Item -ItemType Directory -Path $StateRoot, $LogRoot -Force | Out-Null
    $project = Join-Path $ServiceRoot $HarnessProjectRelative
    $dll = Join-Path $ServiceRoot "tools\Termodel.RadiantPanels.Harness\bin\Release\net8.0\Termodel.RadiantPanels.Harness.dll"
    $assets = Join-Path $ServiceRoot "tools\Termodel.RadiantPanels.Harness\obj\project.assets.json"

    if ($NoBuild) {
        if (-not (Test-Path -LiteralPath $dll)) {
            throw "-NoBuild richiesto ma il binario Harness non esiste: $dll"
        }
        Write-Host "BUILD FAST: salto build su richiesta (-NoBuild)." -ForegroundColor Green
        return $dll
    }

    $stamp = Get-SourceStamp
    $knownStamp = if (Test-Path -LiteralPath $SourceStampPath) {
        Get-Content -LiteralPath $SourceStampPath -Raw
    } else { "" }

    if (-not $Rebuild -and
        $stamp -eq $knownStamp -and
        (Test-Path -LiteralPath $dll)) {
        Write-Host "BUILD FAST: riuso binario working tree; metadati sorgenti invariati." -ForegroundColor Green
        return $dll
    }

    if ($Rebuild -or -not (Test-Path -LiteralPath $assets)) {
        Write-Host "BUILD FAST: restore Harness/Core necessario." -ForegroundColor Yellow
        $restoreLog = Join-Path $LogRoot "restore-latest.log"
        $restoreOutput = & dotnet restore $project --nologo --verbosity:quiet 2>&1
        $restoreExit = $LASTEXITCODE
        Write-Utf8Text $restoreLog (($restoreOutput | Out-String).TrimEnd() + "`n")
        if ($restoreExit -ne 0) {
            Write-Host ($restoreOutput | Select-Object -Last 30 | Out-String)
            throw "Restore Harness locale non riuscito. Log: $restoreLog"
        }
    }

    Write-Host "BUILD FAST: build incrementale diretto sul working tree." -ForegroundColor Yellow
    $buildLog = Join-Path $LogRoot "build-latest.log"
    $sw = [Diagnostics.Stopwatch]::StartNew()
    $buildArguments = @(
        "build", $project,
        "-c", "Release",
        "--no-restore",
        "--nologo",
        "--verbosity:quiet",
        "-p:BuildInParallel=true"
    )
    if ($Rebuild) { $buildArguments += "--no-incremental" }
    $output = & dotnet @buildArguments 2>&1
    $exitCode = $LASTEXITCODE
    $sw.Stop()
    Write-Utf8Text $buildLog (($output | Out-String).TrimEnd() + "`n")
    if ($exitCode -ne 0 -or -not (Test-Path -LiteralPath $dll)) {
        Write-Host ($output | Select-Object -Last 30 | Out-String)
        throw "Build Harness locale non riuscita. Log: $buildLog"
    }

    # Lo stamp viene scritto soltanto dopo una build riuscita.
    Write-Utf8Text $SourceStampPath $stamp
    Write-Host ("BUILD FAST OK: {0} ms" -f $sw.ElapsedMilliseconds) -ForegroundColor Green
    return $dll
}

function Sync-SourceMirror([string]$Fingerprint) {
    New-Item -ItemType Directory -Path $MirrorRoot -Force | Out-Null
    $mirrorManifestPath = Join-Path $StateRoot "mirror-files.txt"
    $sourceFiles = @(Get-SourceFiles)
    $currentRelativePaths = @($sourceFiles | ForEach-Object {
        Get-RelativePath $ServiceRoot $_.FullName
    })
    $previousRelativePaths = if (Test-Path -LiteralPath $mirrorManifestPath) {
        @(Get-Content -LiteralPath $mirrorManifestPath | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
    } else { @() }

    # Il mirror mantiene bin/obj per permettere a MSBuild di ricompilare soltanto
    # ciò che cambia; vengono rimossi esclusivamente eventuali sorgenti non più presenti.
    foreach ($relative in $previousRelativePaths | Where-Object { $_ -notin $currentRelativePaths }) {
        $stalePath = Join-Path $MirrorRoot $relative
        Assert-ChildPath $stalePath $MirrorRoot "rimozione sorgente obsoleto dal mirror" | Out-Null
        if ($stalePath -notmatch '[\\/](bin|obj)[\\/]' -and (Test-Path -LiteralPath $stalePath -PathType Leaf)) {
            Remove-Item -LiteralPath $stalePath -Force
        }
    }

    foreach ($file in $sourceFiles) {
        $relative = Get-RelativePath $ServiceRoot $file.FullName
        $destination = Join-Path $MirrorRoot $relative
        Assert-ChildPath $destination $MirrorRoot "copia mirror locale" | Out-Null
        New-Item -ItemType Directory -Path (Split-Path $destination -Parent) -Force | Out-Null
        Copy-Item -LiteralPath $file.FullName -Destination $destination -Force
    }
    Write-Utf8Text $mirrorManifestPath (($currentRelativePaths | Sort-Object) -join "`n")
    Write-Utf8Text $FingerprintPath ($Fingerprint + "`n")
}

function Ensure-MirrorBuild {
    New-Item -ItemType Directory -Path $StateRoot, $LogRoot -Force | Out-Null
    $fingerprint = Get-SourceFingerprint
    $knownFingerprint = if (Test-Path -LiteralPath $FingerprintPath) {
        (Get-Content -LiteralPath $FingerprintPath -Raw).Trim()
    } else { "" }
    $dll = Join-Path $MirrorRoot "tools\Termodel.RadiantPanels.Harness\bin\Release\net8.0\Termodel.RadiantPanels.Harness.dll"
    $needsBuild = $Rebuild -or $fingerprint -ne $knownFingerprint -or -not (Test-Path -LiteralPath $dll)

    if (-not $needsBuild) {
        Write-Host "BUILD CACHE: riuso del binario locale (sorgenti invariati)." -ForegroundColor Green
        return $dll
    }

    Write-Host "BUILD CACHE: sorgenti cambiati; aggiorno il mirror locale e compilo." -ForegroundColor Yellow
    Sync-SourceMirror $fingerprint
    $project = Join-Path $MirrorRoot $HarnessProjectRelative
    $buildLog = Join-Path $LogRoot "build-latest.log"
    $buildArguments = @("build", $project, "-c", "Release", "--nologo", "--verbosity:minimal")
    if ($Rebuild) { $buildArguments += "--no-incremental" }
    $output = & dotnet @buildArguments 2>&1
    $exitCode = $LASTEXITCODE
    Write-Utf8Text $buildLog (($output | Out-String).TrimEnd() + "`n")
    if ($exitCode -ne 0 -or -not (Test-Path -LiteralPath $dll)) {
        Write-Host ($output | Select-Object -Last 30 | Out-String)
        throw "Build Harness locale non riuscita. Log: $buildLog"
    }
    Write-Host "BUILD OK: $dll" -ForegroundColor Green
    Write-Host "Log completo: $buildLog"
    return $dll
}

function Ensure-LocalBuild {
    if ($UseMirror) {
        Write-Host "BUILD MODE: mirror legacy in LOCALAPPDATA." -ForegroundColor Cyan
        return Ensure-MirrorBuild
    }

    Write-Host "BUILD MODE: working tree diretto + cache metadati." -ForegroundColor Cyan
    return Ensure-DirectBuild
}

function Get-SnapshotSourceFiles {
    $relativeItems = @(
        "src\Termodel.Core\CopiedFromTermodel\SpiraliDiegoVittorio",
        "src\Termodel.Core\RadiantPanels\RadiantExecutiveGenerator.cs",
        "src\Termodel.Core\RadiantPanels\StrategiaDiegoVittorioBenchmark.cs",
        "src\Termodel.Core\RadiantPanels\StrategiaVittorioBenchmark.cs",
        "src\Termodel.Core\RadiantPanels\StrategiaDiegoBenchmark.cs",
        "src\Termodel.Core\RadiantPanels\StrategiaDiegoEngine.cs",
        "tools\Termodel.RadiantPanels.Harness",
        "tests\radiant-harness\cases\LG041-SQUARE4X4-T1-P030-DIEGO-VITTORIO.json",
        "tests\fixtures\StrategiaDiegoSquare4x4.locale.xml"
    )
    $seen = @{}
    foreach ($relative in $relativeItems) {
        $path = Join-Path $ServiceRoot $relative
        if (-not (Test-Path -LiteralPath $path)) { continue }
        $item = Get-Item -LiteralPath $path
        $candidates = if ($item.PSIsContainer) {
            Get-ChildItem -LiteralPath $path -Recurse -File | Where-Object {
                $_.FullName -notmatch '[\\/](bin|obj)[\\/]'
            }
        } else { @($item) }
        foreach ($candidate in $candidates) {
            if (-not $seen.ContainsKey($candidate.FullName)) {
                $seen[$candidate.FullName] = $true
                $candidate
            }
        }
    }
}

function New-LocalSnapshot([string]$Label) {
    New-Item -ItemType Directory -Path $SnapshotRoot -Force | Out-Null
    $safeLabel = ($Label -replace '[^A-Za-z0-9_-]', '-')
    $id = (Get-Date).ToString("yyyyMMdd-HHmmss-fff") + "-" + $safeLabel
    $snapshotPath = Join-Path $SnapshotRoot $id
    Assert-ChildPath $snapshotPath $SnapshotRoot "creazione snapshot" | Out-Null
    New-Item -ItemType Directory -Path $snapshotPath -Force | Out-Null

    $manifestFiles = New-Object System.Collections.Generic.List[object]
    foreach ($file in Get-SnapshotSourceFiles) {
        $relative = Get-RelativePath $ServiceRoot $file.FullName
        $destination = Join-Path $snapshotPath $relative
        Assert-ChildPath $destination $snapshotPath "contenuto snapshot" | Out-Null
        New-Item -ItemType Directory -Path (Split-Path $destination -Parent) -Force | Out-Null
        Copy-Item -LiteralPath $file.FullName -Destination $destination -Force
        $manifestFiles.Add([ordered]@{
            path = $relative.Replace('\', '/')
            sha256 = (Get-FileHash -LiteralPath $destination -Algorithm SHA256).Hash
            bytes = (Get-Item -LiteralPath $destination).Length
        })
    }

    $gitHead = "unknown"
    try {
        $gitHead = (& git -C (Split-Path $ServiceRoot -Parent) rev-parse HEAD 2>$null | Select-Object -First 1).Trim()
    } catch { }
    $manifest = [ordered]@{
        schemaVersion = 1
        snapshotId = $id
        label = $Label
        createdAtUtc = [DateTime]::UtcNow.ToString("o")
        sourceRoot = $ServiceRoot
        gitHead = $gitHead
        restorePolicy = "Copia soltanto i file elencati; non cancella file aggiuntivi; crea prima uno snapshot pre-restore."
        files = $manifestFiles
    }
    Write-Utf8Text (Join-Path $snapshotPath "manifest.json") (($manifest | ConvertTo-Json -Depth 6) + "`n")
    Write-Host "SNAPSHOT OK: $id" -ForegroundColor Green
    Write-Host "Percorso: $snapshotPath"
    return $id
}

function Restore-LocalSnapshot([string]$Id) {
    if ([string]::IsNullOrWhiteSpace($Id)) {
        throw "Specificare -SnapshotId. Usare -Action status per vedere gli snapshot disponibili."
    }
    if (-not $ConfirmRestore) {
        throw "Ripristino non eseguito: aggiungere -ConfirmRestore dopo avere verificato lo SnapshotId."
    }
    $snapshotPath = Join-Path $SnapshotRoot $Id
    Assert-ChildPath $snapshotPath $SnapshotRoot "ripristino snapshot" | Out-Null
    $manifestPath = Join-Path $snapshotPath "manifest.json"
    if (-not (Test-Path -LiteralPath $manifestPath)) {
        throw "Manifest snapshot non trovato: $manifestPath"
    }
    $manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
    New-LocalSnapshot ("pre-restore-" + $Id) | Out-Null
    foreach ($entry in $manifest.files) {
        $relative = ([string]$entry.path).Replace('/', '\')
        $source = Join-Path $snapshotPath $relative
        $destination = Join-Path $ServiceRoot $relative
        Assert-ChildPath $source $snapshotPath "sorgente ripristino" | Out-Null
        Assert-ChildPath $destination $ServiceRoot "destinazione ripristino" | Out-Null
        if (-not (Test-Path -LiteralPath $source)) { throw "File snapshot mancante: $source" }
        $actualHash = (Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash
        if ($actualHash -ne [string]$entry.sha256) { throw "Hash snapshot non valido: $relative" }
        New-Item -ItemType Directory -Path (Split-Path $destination -Parent) -Force | Out-Null
        Copy-Item -LiteralPath $source -Destination $destination -Force
        $restoredHash = (Get-FileHash -LiteralPath $destination -Algorithm SHA256).Hash
        if ($restoredHash -ne [string]$entry.sha256) { throw "Verifica ripristino fallita: $relative" }
    }
    Write-Host "RIPRISTINO OK: $Id" -ForegroundColor Green
    Write-Host "Lo stato precedente e' stato salvato automaticamente in Snapshots."
}

function Write-PreviewFiles([string]$OutputRoot, [string]$RunOutput) {
    $sourceSvg = Join-Path $OutputRoot ($CaseId + ".svg")
    $sourceXml = Join-Path $OutputRoot ($CaseId + ".result.locale.xml")
    $sourceLog = Join-Path $OutputRoot ($CaseId + ".log.txt")
    $sourceMetrics = Join-Path $OutputRoot ($CaseId + ".metrics.json")
    foreach ($required in @($sourceSvg, $sourceXml, $sourceLog, $sourceMetrics)) {
        if (-not (Test-Path -LiteralPath $required)) { throw "Artifact Harness mancante: $required" }
    }
    Copy-Item -LiteralPath $sourceSvg -Destination (Join-Path $OutputRoot "latest.svg") -Force
    Copy-Item -LiteralPath $sourceXml -Destination (Join-Path $OutputRoot "result.locale.xml") -Force
    Copy-Item -LiteralPath $sourceLog -Destination (Join-Path $OutputRoot "harness.log.txt") -Force
    Copy-Item -LiteralPath $sourceMetrics -Destination (Join-Path $OutputRoot "metrics.json") -Force
    Write-Utf8Text (Join-Path $OutputRoot "console.log.txt") ($RunOutput.TrimEnd() + "`n")

    $state = [ordered]@{
        generatedAtUtc = [DateTime]::UtcNow.ToString("o")
        caseId = $CaseId
        engine = "Diego_Vittorio"
        fittings = if ($Fillets) { "enabled" } else { "disabled" }
        closure = if ($Closure) { "enabled" } else { "disabled" }
        autonomousReturn = if ($LegacyReturn) { "disabled" } else { "enabled" }
        returnSide = $ReturnSide
        stepMeters = $StepMeters
        svgSha256 = (Get-FileHash -LiteralPath $sourceSvg -Algorithm SHA256).Hash
    }
    Write-Utf8Text (Join-Path $OutputRoot "state.json") (($state | ConvertTo-Json) + "`n")

    $html = @'
<!doctype html>
<html lang="it">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>Termodel Harness locale — Diego_Vittorio</title>
  <style>
    html,body{height:100%;margin:0;background:#17191d;color:#eef1f5;font:14px system-ui,sans-serif}body{display:grid;grid-template-rows:auto 1fr}.bar{display:flex;gap:18px;align-items:center;padding:10px 14px;background:#252932}.bar a{color:#83c7ff}.bar .state{margin-left:auto;color:#aab4c0}.view{min-height:0;padding:10px}.view object{width:100%;height:100%;border:0;background:#fff;border-radius:4px}
  </style>
</head>
<body>
  <div class="bar"><strong>Diego_Vittorio — Harness locale</strong><a href="/latest.svg" target="_blank">SVG</a><a href="/metrics.json" target="_blank">metriche</a><a href="/harness.log.txt" target="_blank">log</a><a href="/result.locale.xml" target="_blank">XML</a><span class="state" id="state">controllo aggiornamenti…</span></div>
  <div class="view"><object id="svg" type="image/svg+xml" data="/latest.svg"></object></div>
  <script>
  let stamp=""; async function refresh(){try{const r=await fetch('/state.json?'+Date.now(),{cache:'no-store'});const s=await r.json();const next=s.generatedAtUtc+'|'+s.svgSha256;if(stamp&&next!==stamp)document.getElementById('svg').data='/latest.svg?'+Date.now();stamp=next;document.getElementById('state').textContent=new Date(s.generatedAtUtc).toLocaleString()+' · raccordi '+s.fittings+' · chiusura '+s.closure+' · ritorno '+s.autonomousReturn+'/'+s.returnSide;}catch(e){document.getElementById('state').textContent='server non disponibile';}}refresh();setInterval(refresh,800);
  </script>
</body>
</html>
'@
    Write-Utf8Text (Join-Path $OutputRoot "index.html") $html
}

function Invoke-HarnessRun {
    New-Item -ItemType Directory -Path $StateRoot, $SnapshotRoot, $LogRoot -Force | Out-Null
    if (-not (Get-ChildItem -LiteralPath $SnapshotRoot -Directory -ErrorAction SilentlyContinue | Select-Object -First 1)) {
        New-LocalSnapshot "baseline-automatica" | Out-Null
    }
    $dll = Ensure-LocalBuild
    $casePath = Join-Path $ServiceRoot $CaseRelative
    $tempOutput = Join-Path $StateRoot ("Latest.next." + [Guid]::NewGuid().ToString("N"))
    Assert-ChildPath $tempOutput $StateRoot "output temporaneo Harness" | Out-Null
    New-Item -ItemType Directory -Path $tempOutput -Force | Out-Null
    $oldFlag = [Environment]::GetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_DRAW_FILLETS", "Process")
    $oldClosureFlag = [Environment]::GetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_DRAW_CLOSURE", "Process")
    $oldAutonomousReturnFlag = [Environment]::GetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_AUTONOMOUS_RETURN", "Process")
    $oldReturnSideFlag = [Environment]::GetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_RETURN_SIDE", "Process")
    try {
        [Environment]::SetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_DRAW_FILLETS", $(if ($Fillets) { "true" } else { "false" }), "Process")
        [Environment]::SetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_DRAW_CLOSURE", $(if ($Closure) { "true" } else { "false" }), "Process")
        [Environment]::SetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_AUTONOMOUS_RETURN", $(if ($LegacyReturn) { "false" } else { "true" }), "Process")
        [Environment]::SetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_RETURN_SIDE", $ReturnSide, "Process")
        # Modificato da Codex per realizzare: sovrascrivere il passo del caso
        # standard senza duplicare fixture JSON per ogni prova.
        $stepInvariant = $StepMeters.ToString("0.############", [Globalization.CultureInfo]::InvariantCulture)
        $runArgs = @($dll, "run")
        if (-not [string]::IsNullOrWhiteSpace($PreparedInput)) {
            $preparedFull = [IO.Path]::GetFullPath($PreparedInput)
            if (-not (Test-Path -LiteralPath $preparedFull -PathType Leaf)) {
                throw "Prepared input non trovato: $preparedFull"
            }
            $runArgs += @("--input", $preparedFull, "--engine", "Diego_Vittorio", "--id", $CaseId)
            Write-Host "INPUT: XML preparato reale $preparedFull" -ForegroundColor Cyan
        }
        else {
            $runArgs += @("--case", $casePath)
            Write-Host "INPUT: case Git $CaseRelative" -ForegroundColor Cyan
        }
        $runArgs += @("--p", $stepInvariant, "--out", $tempOutput)
        $runOutput = & dotnet @runArgs 2>&1
        $exitCode = $LASTEXITCODE
        $runText = ($runOutput | Out-String)
        Write-Utf8Text (Join-Path $LogRoot "run-latest.log") $runText
        if ($exitCode -ne 0) {
            Write-Host ($runOutput | Select-Object -Last 30 | Out-String)
            throw "Esecuzione Harness fallita. Log: $(Join-Path $LogRoot 'run-latest.log')"
        }
        Write-PreviewFiles $tempOutput $runText
        if (Test-Path -LiteralPath $LatestRoot) {
            $validatedLatest = Assert-ChildPath $LatestRoot $StateRoot "sostituzione Latest"
            Remove-Item -LiteralPath $validatedLatest -Recurse -Force
        }
        Move-Item -LiteralPath $tempOutput -Destination $LatestRoot
    }
    finally {
        [Environment]::SetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_DRAW_FILLETS", $oldFlag, "Process")
        [Environment]::SetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_DRAW_CLOSURE", $oldClosureFlag, "Process")
        [Environment]::SetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_AUTONOMOUS_RETURN", $oldAutonomousReturnFlag, "Process")
        [Environment]::SetEnvironmentVariable("TERMODEL_DIEGO_VITTORIO_RETURN_SIDE", $oldReturnSideFlag, "Process")
        if (Test-Path -LiteralPath $tempOutput) {
            $validatedTemp = Assert-ChildPath $tempOutput $StateRoot "pulizia output temporaneo"
            Remove-Item -LiteralPath $validatedTemp -Recurse -Force
        }
    }
    $metrics = Get-Content -LiteralPath (Join-Path $LatestRoot "metrics.json") -Raw | ConvertFrom-Json
    Write-Host "HARNESS OK: $($metrics.spiralPointCount) punti in $($metrics.elapsedMilliseconds) ms" -ForegroundColor Green
    Write-Host "Raccordi: $(if ($Fillets) { 'ON' } else { 'OFF (debug rapido)' })"
    Write-Host "Chiusura: $(if ($Closure) { 'ON' } else { 'OFF (circuiti separati)' })"
    Write-Host "Ritorno: $(if ($LegacyReturn) { 'LEGACY derivato' } else { "AUTONOMO lato $ReturnSide" })"
    Write-Host "Passo: $($StepMeters.ToString('0.###', [Globalization.CultureInfo]::InvariantCulture)) m"
    Write-Host "Artifact: $LatestRoot"
    Write-Host "Anteprima: http://127.0.0.1:$Port/ (avviare il comando server preview)"
}

function Start-PreviewServer {
    if (-not (Test-Path -LiteralPath (Join-Path $LatestRoot "index.html"))) {
        Write-Host "Nessun risultato Latest: eseguo prima l'Harness." -ForegroundColor Yellow
        Invoke-HarnessRun
    }
    $routes = @{
        "/" = @{ File = "index.html"; Type = "text/html; charset=utf-8" }
        "/index.html" = @{ File = "index.html"; Type = "text/html; charset=utf-8" }
        "/latest.svg" = @{ File = "latest.svg"; Type = "image/svg+xml" }
        "/metrics.json" = @{ File = "metrics.json"; Type = "application/json; charset=utf-8" }
        "/state.json" = @{ File = "state.json"; Type = "application/json; charset=utf-8" }
        "/harness.log.txt" = @{ File = "harness.log.txt"; Type = "text/plain; charset=utf-8" }
        "/console.log.txt" = @{ File = "console.log.txt"; Type = "text/plain; charset=utf-8" }
        "/result.locale.xml" = @{ File = "result.locale.xml"; Type = "application/xml; charset=utf-8" }
    }
    $listener = New-Object Net.Sockets.TcpListener([Net.IPAddress]::Loopback, $Port)
    $listener.Start()
    Write-Host "SERVER PREVIEW ATTIVO: http://127.0.0.1:$Port/" -ForegroundColor Green
    Write-Host "Solo loopback locale; WebService invariato su http://localhost:5080/."
    Write-Host "Premere CTRL+C per arrestare il server."
    if ($OpenBrowser) { Start-Process "http://127.0.0.1:$Port/" }
    try {
        while ($true) {
            $client = $listener.AcceptTcpClient()
            try {
                $stream = $client.GetStream()
                $reader = New-Object IO.StreamReader($stream, [Text.Encoding]::ASCII, $false, 4096, $true)
                $requestLine = $reader.ReadLine()
                while ($null -ne ($line = $reader.ReadLine()) -and $line -ne "") { }
                $path = "/"
                if ($requestLine -match '^GET\s+([^\s]+)') { $path = ([Uri]("http://localhost" + $Matches[1])).AbsolutePath }
                if ($path -eq "/health") {
                    $body = [Text.Encoding]::UTF8.GetBytes('{"status":"ok","service":"Termodel Radiant Harness Preview"}')
                    $status = "200 OK"; $contentType = "application/json; charset=utf-8"
                } elseif ($routes.ContainsKey($path)) {
                    $route = $routes[$path]
                    $filePath = Join-Path $LatestRoot $route.File
                    Assert-ChildPath $filePath $LatestRoot "file server preview" | Out-Null
                    if (Test-Path -LiteralPath $filePath) {
                        $body = [IO.File]::ReadAllBytes($filePath); $status = "200 OK"; $contentType = $route.Type
                    } else {
                        $body = [Text.Encoding]::UTF8.GetBytes("File non disponibile"); $status = "404 Not Found"; $contentType = "text/plain; charset=utf-8"
                    }
                } else {
                    $body = [Text.Encoding]::UTF8.GetBytes("Not found"); $status = "404 Not Found"; $contentType = "text/plain; charset=utf-8"
                }
                $header = "HTTP/1.1 $status`r`nContent-Type: $contentType`r`nContent-Length: $($body.Length)`r`nCache-Control: no-store`r`nConnection: close`r`n`r`n"
                $headerBytes = [Text.Encoding]::ASCII.GetBytes($header)
                $stream.Write($headerBytes, 0, $headerBytes.Length)
                $stream.Write($body, 0, $body.Length)
                $stream.Flush()
            }
            finally {
                $client.Close()
            }
        }
    }
    finally {
        $listener.Stop()
    }
}

function Show-Status {
    Write-Host "Service root : $ServiceRoot"
    Write-Host "Stato locale : $StateRoot"
    Write-Host "Build default : working tree diretto (mirror solo con -UseMirror)"
    Write-Host "Mirror legacy : $MirrorRoot"
    Write-Host "Ultimo output : $LatestRoot"
    Write-Host "Preview       : http://127.0.0.1:$Port/"
    Write-Host "WebService    : http://localhost:5080/ (separato)"
    Write-Host "`nSnapshot disponibili:"
    $snapshots = Get-ChildItem -LiteralPath $SnapshotRoot -Directory -ErrorAction SilentlyContinue | Sort-Object Name -Descending
    if (-not $snapshots) { Write-Host "  nessuno"; return }
    foreach ($snapshot in $snapshots) { Write-Host ("  " + $snapshot.Name) }
}

switch ($Action) {
    "run" { Invoke-HarnessRun }
    "snapshot" { New-LocalSnapshot $SnapshotLabel | Out-Null }
    "restore" { Restore-LocalSnapshot $SnapshotId }
    "serve" { Start-PreviewServer }
    "status" { Show-Status }
}
