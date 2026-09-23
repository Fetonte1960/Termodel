$ErrorActionPreference = "Stop"

$base = "http://127.0.0.1:5082"
$capture = Join-Path $env:RUNNER_TEMP "termodel-snapshot-capture.json"
$serviceOut = Join-Path $env:RUNNER_TEMP "termodel-snapshot-service.out.log"
$serviceErr = Join-Path $env:RUNNER_TEMP "termodel-snapshot-service.err.log"
$stubOut = Join-Path $env:RUNNER_TEMP "termodel-snapshot-stub.out.log"
$stubErr = Join-Path $env:RUNNER_TEMP "termodel-snapshot-stub.err.log"

$env:ASPNETCORE_URLS = $base
$env:TERMODEL_SAVED_PROJECTS_DIR = Join-Path $env:RUNNER_TEMP ("TermodelSnapshotProjects-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $env:TERMODEL_SAVED_PROJECTS_DIR -Force | Out-Null

function Start-ServiceProcess {
  $p = Start-Process dotnet -ArgumentList @("run","--project","src/Termodel.WebService/Termodel.WebService.csproj","--configuration","Release","--no-build","--no-launch-profile") -RedirectStandardOutput $serviceOut -RedirectStandardError $serviceErr -PassThru
  for ($attempt = 0; $attempt -lt 40; $attempt++) {
    try {
      if ((Invoke-RestMethod -Uri "$base/health" -Method Get).status -eq "ok") { return $p }
    } catch {
      Start-Sleep -Milliseconds 500
    }
  }
  if ($p -and -not $p.HasExited) {
    if ($IsWindows) { & taskkill.exe /PID $p.Id /T /F 2>$null | Out-Null } else { Stop-Process -Id $p.Id -Force }
  }
  throw "Termodel.WebService snapshot smoke non ha risposto a /health."
}

function Stop-ChildProcess($p) {
  if (-not $p) { return }
  if (-not $p.HasExited) {
    if ($IsWindows) { & taskkill.exe /PID $p.Id /T /F 2>$null | Out-Null } else { Stop-Process -Id $p.Id -Force }
    try { $p.WaitForExit(5000) | Out-Null } catch {}
  }
}

function Clear-SnapshotEnvironment {
  @(
    "TERMODEL_SNAPSHOT_GITHUB_TOKEN",
    "TERMODEL_SNAPSHOT_ADMIN_KEY",
    "TERMODEL_SNAPSHOT_REPOSITORY",
    "TERMODEL_SNAPSHOT_BRANCH",
    "TERMODEL_SNAPSHOT_BASE_BRANCH",
    "TERMODEL_SNAPSHOT_GITHUB_API_BASE_URL",
    "TERMODEL_SNAPSHOT_ROOT"
  ) | ForEach-Object { Remove-Item ("Env:" + $_) -ErrorAction SilentlyContinue }
}

$projectId = [guid]::NewGuid()
$projectDir = Join-Path $env:TERMODEL_SAVED_PROJECTS_DIR $projectId.ToString("D")
$artifactsDir = Join-Path $projectDir "artifacts"
$logsDir = Join-Path $projectDir "logs"
New-Item -ItemType Directory -Path $artifactsDir -Force | Out-Null
New-Item -ItemType Directory -Path $logsDir -Force | Out-Null

[System.IO.File]::WriteAllText((Join-Path $artifactsDir "model3d.json"),'{"format":"smoke","primitiveCount":1}',[System.Text.UTF8Encoding]::new($false))
[System.IO.File]::WriteAllText((Join-Path $artifactsDir "diagnostic.svg"),'<svg xmlns="http://www.w3.org/2000/svg"><line x1="0" y1="0" x2="10" y2="10"/></svg>',[System.Text.UTF8Encoding]::new($false))
[System.IO.File]::WriteAllText((Join-Path $artifactsDir "report.csv"),("name,value" + [Environment]::NewLine + "smoke,42" + [Environment]::NewLine),[System.Text.UTF8Encoding]::new($false))
[System.IO.File]::WriteAllText((Join-Path $logsDir "TermodelLog.md"),("# Snapshot smoke" + [Environment]::NewLine + [Environment]::NewLine + "OK" + [Environment]::NewLine),[System.Text.UTF8Encoding]::new($false))
[System.IO.File]::WriteAllText((Join-Path $projectDir "project.tmdl"),"MUST_NOT_BE_PUBLISHED",[System.Text.UTF8Encoding]::new($false))

$service = $null
$stub = $null

try {
  Clear-SnapshotEnvironment

  $service = Start-ServiceProcess
  $notConfigured = Invoke-WebRequest -Uri "$base/api/projects/$projectId/publish-session-snapshot" -Method Post -SkipHttpErrorCheck
  if ($notConfigured.StatusCode -ne 503) { throw "Snapshot non configurato: atteso 503, ricevuto $($notConfigured.StatusCode)." }

  Stop-ChildProcess $service
  $service = $null

  $env:TERMODEL_SNAPSHOT_GITHUB_TOKEN = "test-snapshot-token"
  $env:TERMODEL_SNAPSHOT_ADMIN_KEY = "test-admin-key-123456"
  $env:TERMODEL_SNAPSHOT_REPOSITORY = "Fetonte1960/Termodel"
  $env:TERMODEL_SNAPSHOT_BRANCH = "service-snapshots"
  $env:TERMODEL_SNAPSHOT_BASE_BRANCH = "main"
  $env:TERMODEL_SNAPSHOT_GITHUB_API_BASE_URL = "http://127.0.0.1:5100"
  $env:TERMODEL_SNAPSHOT_ROOT = "service-snapshots"

  Remove-Item -LiteralPath $capture -Force -ErrorAction SilentlyContinue
  $stub = Start-Process python -ArgumentList @("tests/github_snapshot_stub.py",$capture) -RedirectStandardOutput $stubOut -RedirectStandardError $stubErr -PassThru
  Start-Sleep -Milliseconds 350

  if ($stub.HasExited) {
    if (Test-Path $stubErr) { Get-Content $stubErr | Write-Host }
    throw "Stub GitHub snapshot non avviato."
  }

  $service = Start-ServiceProcess

  $forbidden = Invoke-WebRequest -Uri "$base/api/projects/$projectId/publish-session-snapshot" -Method Post -Headers @{ "X-Termodel-Snapshot-Key" = "wrong-key" } -SkipHttpErrorCheck
  if ($forbidden.StatusCode -ne 403) { throw "Snapshot con chiave errata: atteso 403, ricevuto $($forbidden.StatusCode)." }

  $createdResponse = Invoke-WebRequest -Uri "$base/api/projects/$projectId/publish-session-snapshot" -Method Post -Headers @{ "X-Termodel-Snapshot-Key" = "test-admin-key-123456" } -SkipHttpErrorCheck

  if ($createdResponse.StatusCode -ne 201) {
    Write-Host "Snapshot response: $($createdResponse.Content)"
    if (Test-Path $serviceOut) { Get-Content $serviceOut | Select-Object -Last 120 | Write-Host }
    if (Test-Path $serviceErr) { Get-Content $serviceErr | Select-Object -Last 120 | Write-Host }
    if (Test-Path $stubErr) { Get-Content $stubErr | Select-Object -Last 120 | Write-Host }
    throw "Pubblicazione snapshot: atteso 201, ricevuto $($createdResponse.StatusCode)."
  }

  $created = $createdResponse.Content | ConvertFrom-Json
  if ($created.status -ne "published" -or $created.branch -ne "service-snapshots" -or $created.commitSha -ne "newcommit00000000000000000000000000000000000" -or $created.fileCount -ne 4) {
    throw "Risposta snapshot pubblicato non valida."
  }

  if (-not (Test-Path -LiteralPath $capture)) { throw "Stub GitHub snapshot non ha prodotto il capture." }
  $captured = Get-Content -LiteralPath $capture -Raw | ConvertFrom-Json

  if (-not $captured.updated_ref -or $captured.updated_ref.sha -ne "newcommit00000000000000000000000000000000000" -or $captured.updated_ref.force -ne $false) {
    throw "Branch snapshot non aggiornato atomicamente."
  }

  $requests = @($captured.requests)
  if ($requests.Count -lt 8) { throw "Numero richieste GitHub snapshot troppo basso: $($requests.Count)." }

  foreach ($request in $requests) {
    if ($request.authorization -ne "Bearer test-snapshot-token") { throw "Authorization GitHub snapshot non corretta." }
    if ($request.userAgent -notmatch "Termodel-WebService-Snapshot") { throw "User-Agent GitHub snapshot non corretto." }
  }

  $treeEntries = @($captured.tree.tree)
  if ($treeEntries.Count -ne 5) { throw "Tree snapshot deve contenere 4 file generati + manifest." }

  $paths = @($treeEntries | ForEach-Object { [string]$_.path })
  if (@($paths | Where-Object { $_ -match "project\.tmdl$" }).Count -ne 0) { throw "project.tmdl non deve essere pubblicato nello snapshot." }

  foreach ($requiredSuffix in @("/artifacts/model3d.json","/artifacts/diagnostic.svg","/artifacts/report.csv","/logs/TermodelLog.md","/manifest.json")) {
    if (@($paths | Where-Object { $_.EndsWith($requiredSuffix) }).Count -ne 1) { throw "Tree snapshot privo di $requiredSuffix." }
  }

  if (@($paths | Where-Object { $_ -notmatch "^service-snapshots/" }).Count -ne 0) { throw "Tree snapshot contiene path fuori dalla radice service-snapshots." }

  $manifestEntry = @($treeEntries | Where-Object { $_.path -match "/manifest\.json$" })[0]
  $manifestBlobProperty = $captured.blobs.PSObject.Properties[$manifestEntry.sha]
  if (-not $manifestBlobProperty) { throw "Blob manifest non trovato nel capture." }

  $manifestBytes = [Convert]::FromBase64String([string]$manifestBlobProperty.Value.base64)
  $manifestText = [System.Text.Encoding]::UTF8.GetString($manifestBytes)
  $manifest = $manifestText | ConvertFrom-Json

  if ($manifest.format -ne "TERMODEL-SERVICE-SNAPSHOT-V1" -or [string]$manifest.projectId -ne $projectId.ToString("D") -or $manifest.fileCount -ne 4) {
    throw "Manifest snapshot non valido."
  }

  $manifestFiles = @($manifest.files)
  if (@($manifestFiles | Where-Object { $_.path -match "project\.tmdl$" }).Count -ne 0) { throw "Manifest snapshot espone project.tmdl." }

  foreach ($file in $manifestFiles) {
    if ([string]::IsNullOrWhiteSpace([string]$file.sha256) -or ([string]$file.sha256).Length -ne 64) { throw "SHA-256 manifest mancante/non valido per $($file.path)." }
    if ($file.path -notmatch "^(artifacts|logs)/") { throw "Manifest contiene path non autorizzato: $($file.path)." }
  }

  Write-Host "GITHUB_SESSION_SNAPSHOT_SMOKE_OK"
  Write-Host "snapshotId=$($created.snapshotId)"
  Write-Host "commitSha=$($created.commitSha)"
}
finally {
  Stop-ChildProcess $service
  Stop-ChildProcess $stub
  Clear-SnapshotEnvironment

  if ($env:TERMODEL_SAVED_PROJECTS_DIR -and (Test-Path $env:TERMODEL_SAVED_PROJECTS_DIR)) {
    Remove-Item $env:TERMODEL_SAVED_PROJECTS_DIR -Recurse -Force
  }

  foreach ($path in @($capture,$serviceOut,$serviceErr,$stubOut,$stubErr)) {
    if ($path -and (Test-Path -LiteralPath $path)) { Remove-Item -LiteralPath $path -Force }
  }
}
