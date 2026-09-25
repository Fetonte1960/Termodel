$ErrorActionPreference = "Stop"

$base = "http://127.0.0.1:5084"
$env:ASPNETCORE_URLS = $base
$env:TERMODEL_SPIRAL_ENGINE = "Diego"
$env:TERMODEL_SAVED_PROJECTS_DIR = Join-Path $env:RUNNER_TEMP ("TermodelStrategiaDiegoCurrentApartment-" + [guid]::NewGuid().ToString("N"))
$artifactDir = Join-Path $env:RUNNER_TEMP "StrategiaDiegoCurrentApartmentArtifacts"

New-Item -ItemType Directory -Path $env:TERMODEL_SAVED_PROJECTS_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $artifactDir -Force | Out-Null

$fixturePath = Join-Path $PSScriptRoot "../tests/fixtures/StrategiaDiegoCurrentApartment.project.tmdl"
$expectedFixtureSha256 = "1a5855490adcbac25e5585f9ba89c624eb2381874eb2de8bdc74821a40d2a9a5"

function Start-ServiceProcess {
  $outLog = Join-Path $artifactDir "service.stdout.log"
  $errLog = Join-Path $artifactDir "service.stderr.log"

  $p = Start-Process dotnet -ArgumentList @(
    "run",
    "--project","src/Termodel.WebService/Termodel.WebService.csproj",
    "--configuration","Release",
    "--no-build",
    "--no-launch-profile"
  ) -RedirectStandardOutput $outLog -RedirectStandardError $errLog -PassThru

  for ($attempt = 0; $attempt -lt 60; $attempt++) {
    try {
      if ((Invoke-RestMethod -Uri "$base/health" -Method Get).status -eq "ok") { return $p }
    } catch {
      Start-Sleep -Milliseconds 500
    }
  }
  throw "Termodel.WebService non ha risposto a /health."
}

function Stop-ServiceProcess($p) {
  if (-not $p) { return }
  if (-not $p.HasExited) {
    if ($IsWindows) {
      & taskkill.exe /PID $p.Id /T /F 2>$null | Out-Null
    } else {
      Stop-Process -Id $p.Id -Force
    }
    try { $p.WaitForExit(5000) | Out-Null } catch {}
  }
}

$service = $null
try {
  if (-not (Test-Path -LiteralPath $fixturePath)) {
    throw "Fixture banco prova corrente mancante: $fixturePath"
  }

  $fixtureHash = (Get-FileHash -LiteralPath $fixturePath -Algorithm SHA256).Hash.ToLowerInvariant()
  if ($fixtureHash -ne $expectedFixtureSha256) {
    throw "Fixture banco prova corrente modificata: SHA-256 $fixtureHash."
  }

  $projectText = [System.IO.File]::ReadAllText((Resolve-Path $fixturePath), [System.Text.UTF8Encoding]::new($false))
  if (-not $projectText.StartsWith("[TERMODEL-PROJECT-TEXT-V1]") -or
      -not $projectText.EndsWith("[END-TERMODEL-PROJECT-TEXT-V1]")) {
    throw "Fixture banco prova corrente: sentinelle TERMODEL-PROJECT-TEXT-V1 non valide."
  }

  if ($projectText -notmatch '"projectId"\s*:\s*"([0-9a-fA-F-]{36})"') {
    throw "Fixture banco prova corrente: projectId non trovato."
  }
  $projectId = $Matches[1]
  if ($projectId -ne "07bf8dca-dc86-41ea-8844-1aaca58888f0") {
    throw "Fixture banco prova corrente: projectId inatteso $projectId."
  }

  $service = Start-ServiceProcess

  $svgPath = Join-Path $artifactDir "pannelli-esecutivo.svg"
  $response = Invoke-WebRequest `
    -Uri "$base/api/calculations?responseArtifact=pannelli-esecutivo-svg" `
    -Method Post `
    -ContentType "text/plain; charset=utf-8" `
    -Body $projectText `
    -OutFile $svgPath `
    -PassThru

  if ($response.StatusCode -ne 200) { throw "Banco prova appartamento: HTTP inatteso $($response.StatusCode)." }
  if ([string]$response.Headers["Content-Type"] -notmatch "^image/svg\+xml") {
    throw "Banco prova appartamento: Content-Type non SVG."
  }
  if ([string]$response.Headers["X-Termodel-Response-Artifact"] -ne "pannelli-esecutivo-svg") {
    throw "Banco prova appartamento: X-Termodel-Response-Artifact inatteso."
  }
  if ([string]$response.Headers["X-Termodel-Project-Id"] -ne $projectId) {
    throw "Banco prova appartamento: projectId di risposta inatteso."
  }

  $svgText = Get-Content -LiteralPath $svgPath -Raw
  if ($svgText -notmatch "<svg") { throw "Banco prova appartamento: risposta priva di SVG." }

  $generated = Invoke-RestMethod -Uri "$base/api/projects/$projectId/generated-files" -Method Get
  $generated | ConvertTo-Json -Depth 100 |
    Set-Content -LiteralPath (Join-Path $artifactDir "generated-files.json") -Encoding utf8

  $projectDir = Join-Path $env:TERMODEL_SAVED_PROJECTS_DIR $projectId
  if (-not (Test-Path -LiteralPath $projectDir)) { throw "Banco prova appartamento: workspace projectId non trovato." }

  foreach ($relative in @(
    "artifacts/pannelli.json",
    "artifacts/pannelli-esecutivo.dxf",
    "logs/TermodelLog.md",
    "logs/diagnostics.txt",
    "logs/calculation.log"
  )) {
    $source = Join-Path $projectDir $relative
    if (Test-Path -LiteralPath $source) { Copy-Item -LiteralPath $source -Destination $artifactDir -Force }
  }

  $svgHash = (Get-FileHash -LiteralPath $svgPath -Algorithm SHA256).Hash.ToLowerInvariant()

  [ordered]@{
    fixture = "tests/fixtures/StrategiaDiegoCurrentApartment.project.tmdl"
    fixtureSha256 = $fixtureHash
    projectId = $projectId
    requestedArtifact = "pannelli-esecutivo-svg"
    spiralEngine = $env:TERMODEL_SPIRAL_ENGINE
    responseStatus = $response.StatusCode
    svgSha256 = $svgHash
    generatedFileCount = @($generated.files).Count
    executedAtUtc = [DateTime]::UtcNow.ToString("o")
  } | ConvertTo-Json -Depth 20 |
    Set-Content -LiteralPath (Join-Path $artifactDir "test-metadata.json") -Encoding utf8

  Write-Host "STRATEGIA_DIEGO_CURRENT_APARTMENT_OK"
  Write-Host "projectId=$projectId"
  Write-Host "fixtureSha256=$fixtureHash"
  Write-Host "svgSha256=$svgHash"
  Write-Host "generatedFileCount=$(@($generated.files).Count)"
}
finally {
  Stop-ServiceProcess $service
  if (Test-Path $env:TERMODEL_SAVED_PROJECTS_DIR) {
    Remove-Item -LiteralPath $env:TERMODEL_SAVED_PROJECTS_DIR -Recurse -Force -ErrorAction SilentlyContinue
  }
}
