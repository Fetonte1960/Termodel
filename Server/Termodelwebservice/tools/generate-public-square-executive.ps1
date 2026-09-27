$ErrorActionPreference = "Stop"

$base = "http://127.0.0.1:5084"
$env:ASPNETCORE_URLS = $base
$env:TERMODEL_SPIRAL_ENGINE = "GPT"
$env:TERMODEL_SAVED_PROJECTS_DIR = Join-Path $env:RUNNER_TEMP ("TermodelPublicSquareExecutive-" + [guid]::NewGuid().ToString("N"))
$artifactDir = Join-Path $env:RUNNER_TEMP "PublicSquareExecutiveArtifacts"
New-Item -ItemType Directory -Path $env:TERMODEL_SAVED_PROJECTS_DIR -Force | Out-Null
if (Test-Path -LiteralPath $artifactDir) { Remove-Item -LiteralPath $artifactDir -Recurse -Force }
New-Item -ItemType Directory -Path $artifactDir -Force | Out-Null

function Start-ServiceProcess {
  $p = Start-Process dotnet -ArgumentList @(
    "run",
    "--project","src/Termodel.WebService/Termodel.WebService.csproj",
    "--configuration","Release",
    "--no-build",
    "--no-launch-profile") -PassThru
  for ($attempt = 0; $attempt -lt 40; $attempt++) {
    try {
      $health = Invoke-RestMethod -Uri "$base/health" -Method Get
      if ($health.status -eq "ok") { return $p }
    } catch { Start-Sleep -Milliseconds 500 }
  }
  throw "Termodel.WebService non ha risposto a /health."
}

function Stop-ServiceProcess($p) {
  if (-not $p) { return }
  if (-not $p.HasExited) {
    if ($IsWindows) { & taskkill.exe /PID $p.Id /T /F 2>$null | Out-Null }
    else { Stop-Process -Id $p.Id -Force }
    try { $p.WaitForExit(5000) | Out-Null } catch {}
  }
}

function Read-ProjectJsonSection([string]$projectText,[string]$sectionName) {
  $begin = "---BEGIN:$sectionName---"
  $end = "---END:$sectionName---"
  $bi = $projectText.IndexOf($begin,[System.StringComparison]::Ordinal)
  if ($bi -lt 0) { throw "Sezione $sectionName non trovata." }
  $cs = $bi + $begin.Length
  while ($cs -lt $projectText.Length -and ($projectText[$cs] -in @([char]13,[char]10))) { $cs++ }
  $ei = $projectText.IndexOf($end,$cs,[System.StringComparison]::Ordinal)
  if ($ei -lt 0) { throw "Sezione $sectionName non chiusa." }
  return $projectText.Substring($cs,$ei-$cs).Trim() | ConvertFrom-Json
}

function Set-ProjectManifest([string]$projectText,[string]$projectId,[string]$projectName) {
  $begin = "---BEGIN:manifest.json---"
  $end = "---END:manifest.json---"
  $bi = $projectText.IndexOf($begin,[System.StringComparison]::Ordinal)
  $cs = $bi + $begin.Length
  while ($cs -lt $projectText.Length -and ($projectText[$cs] -in @([char]13,[char]10))) { $cs++ }
  $ei = $projectText.IndexOf($end,$cs,[System.StringComparison]::Ordinal)
  $manifest = $projectText.Substring($cs,$ei-$cs).Trim() | ConvertFrom-Json
  $manifest | Add-Member -NotePropertyName projectId -NotePropertyValue $projectId -Force
  $manifest.projectName = $projectName
  $json = $manifest | ConvertTo-Json -Depth 100
  return $projectText.Substring(0,$cs) + $json + [Environment]::NewLine + $projectText.Substring($ei)
}

function Add-SquareFixture([string]$projectText,[string]$floorName) {
  $sectionName = "geometry/project.svg"
  $begin = "---BEGIN:$sectionName---"
  $end = "---END:$sectionName---"
  $bi = $projectText.IndexOf($begin,[System.StringComparison]::Ordinal)
  if ($bi -lt 0) { throw "geometry/project.svg non disponibile." }
  $cs = $bi + $begin.Length
  while ($cs -lt $projectText.Length -and ($projectText[$cs] -in @([char]13,[char]10))) { $cs++ }
  $ei = $projectText.IndexOf($end,$cs,[System.StringComparison]::Ordinal)
  if ($ei -lt 0) { throw "geometry/project.svg non chiuso." }

  $geometry = $projectText.Substring($cs,$ei-$cs)
  $groupStart = $geometry.IndexOf("<g ",[System.StringComparison]::OrdinalIgnoreCase)
  if ($groupStart -lt 0) { throw "Gruppo piano non trovato." }

  $pipeLayer = $floorName + "_tubipannelli"
  $fixture = @(
    ('<line id="E001" x1="0" y1="0" x2="400" y2="0" data-termodel-piano="' + $floorName + '" data-termodel-layer="' + $floorName + '" data-termodel-tipo-parete="Parete esterna isolata" data-termodel-confine-parete="Automatico" data-termodel-color="1" data-termodel-linetype="Continuous" />'),
    ('<line id="E002" x1="400" y1="0" x2="400" y2="400" data-termodel-piano="' + $floorName + '" data-termodel-layer="' + $floorName + '" data-termodel-tipo-parete="Parete esterna isolata" data-termodel-confine-parete="Automatico" data-termodel-color="1" data-termodel-linetype="Continuous" />'),
    ('<line id="E003" x1="400" y1="400" x2="0" y2="400" data-termodel-piano="' + $floorName + '" data-termodel-layer="' + $floorName + '" data-termodel-tipo-parete="Parete esterna isolata" data-termodel-confine-parete="Automatico" data-termodel-color="1" data-termodel-linetype="Continuous" />'),
    ('<line id="E004" x1="0" y1="400" x2="0" y2="0" data-termodel-piano="' + $floorName + '" data-termodel-layer="' + $floorName + '" data-termodel-tipo-parete="Parete esterna isolata" data-termodel-confine-parete="Automatico" data-termodel-color="1" data-termodel-linetype="Continuous" />'),
    ('<line id="T001" x1="-50" y1="200" x2="50" y2="200" data-termodel-piano="' + $floorName + '" data-termodel-layer="' + $pipeLayer + '" data-termodel-entity="Tubo" data-termodel-rete="RAD-DEFAULT" data-termodel-linetype="Continuous" data-termodel-color="1" />'),
    ('<text id="R001" x="200" y="200" font-size="1" data-termodel-piano="' + $floorName + '" data-termodel-layer="' + $floorName + '">'),
    '  <tspan x="200" dy="0">BLOCCO,LOC</tspan>',
    '  <tspan x="200" dy="1.2em">DESCR.,Quadrato con pannelli</tspan>',
    '  <tspan x="200" dy="1.2em">ZONA,Zona climatizzata</tspan>',
    '  <tspan x="200" dy="1.2em">CPAV,Automatico</tspan>',
    '  <tspan x="200" dy="1.2em">CSOF,Automatico</tspan>',
    '  <tspan x="200" dy="1.2em">CCOPERTURA,Solaio piano</tspan>',
    '  <tspan x="200" dy="1.2em">TPAV,Pavimento su terreno</tspan>',
    '  <tspan x="200" dy="1.2em">TSOF,Solaio Esterno in laterocemento</tspan>',
    '  <tspan x="200" dy="1.2em">ALTEZZALORDA,Da piano</tspan>',
    '  <tspan x="200" dy="1.2em">ALTEZZANETTA,Da piano</tspan>',
    '  <tspan x="200" dy="1.2em">QUOTAPAVIMENTO,Da piano</tspan>',
    '</text>'
  ) -join [Environment]::NewLine

  $closeGroup = $geometry.IndexOf("</g>",$groupStart,[System.StringComparison]::OrdinalIgnoreCase)
  if ($closeGroup -lt 0) { throw "Gruppo piano SVG non chiuso." }
  $geometry = $geometry.Insert($closeGroup,$fixture + [Environment]::NewLine)
  return $projectText.Substring(0,$cs) + $geometry + $projectText.Substring($ei)
}

$service = $null
try {
  $service = Start-ServiceProcess

  $project = Invoke-RestMethod -Uri "$base/api/projects/new" -Method Post -ContentType "application/json" -Body "{}"
  $piani = @(Read-ProjectJsonSection $project "archives/json/Piani.json")
  if ($piani.Count -lt 1) { throw "Nessun piano nel progetto nuovo." }
  $floorName = [string]$piani[0].Nome

  $allocation = Invoke-RestMethod -Uri "$base/api/projects/allocate-id" -Method Post
  $project = Set-ProjectManifest $project ([string]$allocation.projectId) "Quadrato con pannelli"
  $project = Add-SquareFixture $project $floorName
  $headers = @{ "X-Termodel-Project-Lock" = [string]$allocation.projectLockToken }

  $responsePath = Join-Path $artifactDir "quadrato-con-pannelli-esecutivo.svg"
  $response = Invoke-WebRequest -Uri "$base/api/calculations?responseArtifact=pannelli-esecutivo-svg" -Method Post -Headers $headers -ContentType "text/plain; charset=utf-8" -Body $project -OutFile $responsePath -PassThru
  if ($response.StatusCode -ne 200) { throw "Calcolo quadrato: HTTP $($response.StatusCode)." }

  $svg = [System.IO.File]::ReadAllText($responsePath,[System.Text.UTF8Encoding]::new($false))
  if ($svg -notmatch "TERMODEL-PANNELLI-ESECUTIVO-SVG-V1" -or
      $svg -notmatch 'data-coordinate-unit="m"' -or
      $svg -notmatch 'data-termodel-max-y=') {
    throw "SVG quadrato non è un esecutivo pannelli canonico."
  }
  foreach ($layer in @("_PiantaPulita_Output","_PannelliMandata_Output","_PannelliRitorno_Output")) {
    if ($svg -notmatch [regex]::Escape($floorName + $layer)) {
      throw "SVG quadrato privo del layer $($floorName + $layer)."
    }
  }

  Write-Host "PUBLIC_SQUARE_EXECUTIVE_OK"
  Write-Host "engine=GPT"
  Write-Host "file=$responsePath"
}
finally {
  Stop-ServiceProcess $service
  if (Test-Path $env:TERMODEL_SAVED_PROJECTS_DIR) {
    Remove-Item -LiteralPath $env:TERMODEL_SAVED_PROJECTS_DIR -Recurse -Force -ErrorAction SilentlyContinue
  }
}
