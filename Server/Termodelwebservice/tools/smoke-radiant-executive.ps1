$ErrorActionPreference = "Stop"

$base = "http://127.0.0.1:5081"
$env:ASPNETCORE_URLS = $base
$env:TERMODEL_SAVED_PROJECTS_DIR = Join-Path $env:RUNNER_TEMP ("TermodelExecutiveSmoke-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $env:TERMODEL_SAVED_PROJECTS_DIR -Force | Out-Null

function Start-ServiceProcess {
  $p = Start-Process dotnet -ArgumentList @(
    "run",
    "--project","src/Termodel.WebService/Termodel.WebService.csproj",
    "--configuration","Release",
    "--no-build",
    "--no-launch-profile") -PassThru
  for ($attempt = 0; $attempt -lt 40; $attempt++) {
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

function Add-ExecutiveFixture([string]$projectText,[string]$floorName) {
  $sectionName = "geometry/project.svg"
  $begin = "---BEGIN:$sectionName---"
  $end = "---END:$sectionName---"
  $bi = $projectText.IndexOf($begin,[System.StringComparison]::Ordinal)
  $cs = $bi + $begin.Length
  while ($cs -lt $projectText.Length -and ($projectText[$cs] -in @([char]13,[char]10))) { $cs++ }
  $ei = $projectText.IndexOf($end,$cs,[System.StringComparison]::Ordinal)
  if ($bi -lt 0 -or $ei -lt 0) { throw "geometry/project.svg non disponibile." }

  $geometry = $projectText.Substring($cs,$ei-$cs)
  $groupStart = $geometry.IndexOf("<g ",[System.StringComparison]::OrdinalIgnoreCase)
  if ($groupStart -lt 0) { throw "Gruppo piano non trovato." }

  $pipeLayer = $floorName + "_tubipannelli"
  $fixtureLines = @(
    ('<line id="E001" x1="0" y1="0" x2="400" y2="0" data-termodel-piano="' + $floorName + '" data-termodel-color="1" data-termodel-linetype="Continuous" />'),
    ('<line id="E002" x1="400" y1="0" x2="400" y2="400" data-termodel-piano="' + $floorName + '" data-termodel-color="1" data-termodel-linetype="Continuous" />'),
    ('<line id="E003" x1="400" y1="400" x2="0" y2="400" data-termodel-piano="' + $floorName + '" data-termodel-color="1" data-termodel-linetype="Continuous" />'),
    ('<line id="E004" x1="0" y1="400" x2="0" y2="0" data-termodel-piano="' + $floorName + '" data-termodel-color="1" data-termodel-linetype="Continuous" />'),
    ('<line id="T001" x1="-50" y1="200" x2="50" y2="200" data-termodel-piano="' + $floorName + '" data-termodel-layer="' + $pipeLayer + '" data-termodel-entity="Tubo" data-termodel-rete="RAD-DEFAULT" data-termodel-linetype="Continuous" data-termodel-color="1" />'),
    ('<text id="R001" x="200" y="200" font-size="1" data-termodel-piano="' + $floorName + '">'),
    '  <tspan x="200" dy="0">BLOCCO,LOC</tspan>',
    '  <tspan x="200" dy="1.2em">DESCR.,Locale R001</tspan>',
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
  )
  $fixture = $fixtureLines -join [Environment]::NewLine

  $closeGroup = $geometry.IndexOf("</g>",$groupStart,[System.StringComparison]::OrdinalIgnoreCase)
  if ($closeGroup -ge 0) {
    $geometry = $geometry.Insert($closeGroup,$fixture + [Environment]::NewLine)
  } else {
    $selfClose = $geometry.IndexOf(" />",$groupStart,[System.StringComparison]::Ordinal)
    if ($selfClose -lt 0) { throw "Gruppo piano SVG non chiuso." }
    $replacement = ">" + [Environment]::NewLine + $fixture + [Environment]::NewLine + "</g>"
    $geometry = $geometry.Remove($selfClose,3).Insert($selfClose,$replacement)
  }

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
  $project = Set-ProjectManifest $project ([string]$allocation.projectId) "Executive Smoke"
  $project = Add-ExecutiveFixture $project $floorName
  $headers = @{ "X-Termodel-Project-Lock" = [string]$allocation.projectLockToken }

  $calculation = Invoke-RestMethod -Uri "$base/api/calculations" -Method Post -Headers $headers -ContentType "text/plain; charset=utf-8" -Body $project
  if (@($calculation.artifacts.name) -notcontains "pannelli-esecutivo-svg" -or
      @($calculation.artifacts.name) -notcontains "pannelli-esecutivo-dxf") {
    throw "Manifest calcolo privo degli artifact esecutivi."
  }

  $svgResponse = Invoke-WebRequest -Uri "$base/api/projects/$($allocation.projectId)/artifacts/pannelli-esecutivo-svg" -Method Get
  $dxfResponse = Invoke-WebRequest -Uri "$base/api/projects/$($allocation.projectId)/artifacts/pannelli-esecutivo-dxf" -Method Get

  if ($svgResponse.Headers["X-Termodel-Artifact-Stale"] -ne "false" -or
      $dxfResponse.Headers["X-Termodel-Artifact-Stale"] -ne "false") {
    throw "Artifact esecutivo appena calcolato marcato stale."
  }

  $projectDir = Join-Path $env:TERMODEL_SAVED_PROJECTS_DIR ([string]$allocation.projectId)
  $svgPath = Join-Path $projectDir "artifacts\pannelli-esecutivo.svg"
  $dxfPath = Join-Path $projectDir "artifacts\pannelli-esecutivo.dxf"
  if (-not (Test-Path $svgPath) -or -not (Test-Path $dxfPath)) {
    throw "Artifact esecutivo non persistiti nel workspace del progetto."
  }

  $svgText = [System.IO.File]::ReadAllText($svgPath,[System.Text.UTF8Encoding]::new($false))
  $dxfText = [System.IO.File]::ReadAllText($dxfPath,[System.Text.UTF8Encoding]::new($false))
  if ($svgText -notmatch "TERMODEL-PANNELLI-ESECUTIVO-SVG-V1") {
    throw "Formato SVG esecutivo non riconosciuto."
  }

  foreach ($layer in @(
    ($floorName + "_Edificio_Output"),
    ($floorName + "_PannelliMandata_Output"),
    ($floorName + "_PannelliRitorno_Output")
  )) {
    if ($svgText -notmatch [regex]::Escape($layer) -or
        $dxfText -notmatch [regex]::Escape($layer)) {
      throw "Layer esecutivo $layer mancante in SVG o DXF."
    }
  }

  $svgPrimitiveCount = ([regex]::Matches(
    $svgText,
    '<(?:line|polyline|polygon|text)\b',
    [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count
  $dxfPrimitiveCount = ([regex]::Matches(
    $dxfText,
    '(?m)^0\r?\n(?:LINE|LWPOLYLINE|TEXT)\r?$')).Count

  if ($svgPrimitiveCount -le 4) {
    throw "Esecutivo non contiene primitive pannelli oltre alla pianta base."
  }
  if ($svgPrimitiveCount -ne $dxfPrimitiveCount) {
    throw "Primitive SVG/DXF differenti: SVG=$svgPrimitiveCount DXF=$dxfPrimitiveCount."
  }

  $log = Get-Content -LiteralPath (Join-Path $projectDir "logs\calculation.log") -Raw
  if ($log -notmatch "radiantExecutivePrimitiveCount=$svgPrimitiveCount" -or
      $log -notmatch "radiantExecutiveFloorCount=1") {
    throw "Conteggi esecutivo non coerenti nel calculation.log."
  }

  Write-Host "RADIANT_EXECUTIVE_SVG_DXF_SMOKE_OK"
}
finally {
  Stop-ServiceProcess $service
  if (Test-Path $env:TERMODEL_SAVED_PROJECTS_DIR) {
    Remove-Item -LiteralPath $env:TERMODEL_SAVED_PROJECTS_DIR -Recurse -Force -ErrorAction SilentlyContinue
  }
}
