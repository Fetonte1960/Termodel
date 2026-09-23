param(
  [Parameter(Mandatory = $true)]
  [string]$OutputDirectory
)

$ErrorActionPreference = "Stop"
$utf8 = [System.Text.UTF8Encoding]::new($false)
$base = "http://127.0.0.1:5082"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..")).Path
$fixturePath = Join-Path $repoRoot "SorgentiTermodel\Library\projects\ProgettoVuoto\ProgettoVuoto.termodel.txt"
$expectedGeometrySha = "bda76910a15d4206f018d733d621f427ffb269c3fa4526f89bc0e3a23f17dd06"
$originalProjectId = "5f3bb304-0c72-45e2-85eb-faf3be0fb8ab"
$originalGeneratedAtUtc = "2026-09-23T18:41:15.372Z"

New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
$requestDir = Join-Path $OutputDirectory "request"
$responseDir = Join-Path $OutputDirectory "response"
$workspaceCopy = Join-Path $OutputDirectory "workspace"
New-Item -ItemType Directory -Path $requestDir,$responseDir,$workspaceCopy -Force | Out-Null

$serviceOut = Join-Path $OutputDirectory "service.stdout.log"
$serviceErr = Join-Path $OutputDirectory "service.stderr.log"
$summaryPath = Join-Path $OutputDirectory "debug-summary.txt"
$env:ASPNETCORE_URLS = $base
$env:TERMODEL_PROJECT_LOCK_LEASE_SECONDS = "120"
$env:TERMODEL_SAVED_PROJECTS_DIR = Join-Path $env:RUNNER_TEMP ("TermodelAiDebug-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $env:TERMODEL_SAVED_PROJECTS_DIR -Force | Out-Null

function Normalize-Lf([string]$text) {
  return $text.Replace(([string][char]13)+([string][char]10),[string][char]10).Replace([string][char]13,[string][char]10)
}

function Replace-Section([string]$projectText,[string]$sectionName,[string]$content) {
  $normalized = Normalize-Lf $projectText
  $begin = "---BEGIN:$sectionName---"
  $end = "---END:$sectionName---"
  $bi = $normalized.IndexOf($begin,[System.StringComparison]::Ordinal)
  if ($bi -lt 0) { throw "Sezione $sectionName non trovata." }
  $cs = $bi + $begin.Length
  if ($cs -lt $normalized.Length -and $normalized[$cs] -eq [char]10) { $cs++ }
  $ei = $normalized.IndexOf($end,$cs,[System.StringComparison]::Ordinal)
  if ($ei -lt 0) { throw "Sezione $sectionName non chiusa." }
  return $normalized.Substring(0,$cs) + (Normalize-Lf $content).TrimEnd([char]10) + [char]10 + $normalized.Substring($ei)
}

function Get-Section([string]$projectText,[string]$sectionName) {
  $normalized = Normalize-Lf $projectText
  $begin = "---BEGIN:$sectionName---"
  $end = "---END:$sectionName---"
  $bi = $normalized.IndexOf($begin,[System.StringComparison]::Ordinal)
  if ($bi -lt 0) { throw "Sezione $sectionName non trovata." }
  $cs = $bi + $begin.Length
  if ($cs -lt $normalized.Length -and $normalized[$cs] -eq [char]10) { $cs++ }
  $ei = $normalized.IndexOf($end,$cs,[System.StringComparison]::Ordinal)
  if ($ei -lt 0) { throw "Sezione $sectionName non chiusa." }
  return $normalized.Substring($cs,$ei-$cs).TrimEnd([char]10)
}

function Sha256-Utf8([string]$text) {
  $bytes = $utf8.GetBytes((Normalize-Lf $text))
  $hash = [System.Security.Cryptography.SHA256]::HashData($bytes)
  return ([Convert]::ToHexString($hash)).ToLowerInvariant()
}

function Set-Manifest([string]$projectText,[string]$projectId,[string]$generatedAtUtc,[string]$geometrySha) {
  $manifest = (Get-Section $projectText "manifest.json") | ConvertFrom-Json
  $manifest | Add-Member -NotePropertyName projectId -NotePropertyValue $projectId -Force
  $manifest.generatedAtUtc = $generatedAtUtc
  $geometryItem = @($manifest.sections | Where-Object { $_.name -eq "geometry/project.svg" })[0]
  if (-not $geometryItem) { throw "Voce geometry/project.svg non trovata nel manifest." }
  $geometryItem.sha256 = $geometrySha
  $json = $manifest | ConvertTo-Json -Depth 100
  return Replace-Section $projectText "manifest.json" $json
}


function Build-CanonicalServerGeometry([string]$projectText,[string]$localGeometry) {
  $manifest = (Get-Section $projectText "manifest.json") | ConvertFrom-Json
  $floor = @($manifest.floors)[0]
  if (-not $floor) { throw "Nessun piano nel manifest per canonicalizzazione Service." }

  $source = [System.Xml.XmlDocument]::new()
  $source.PreserveWhitespace = $false
  $source.LoadXml($localGeometry)

  $sourceGroup = $source.SelectSingleNode("/*[local-name()='svg']/*[local-name()='g' and @id='calpestabile']")
  if (-not $sourceGroup) { throw "Gruppo locale calpestabile non trovato." }

  $out = [System.Xml.XmlDocument]::new()
  $root = $out.CreateElement("svg","http://www.w3.org/2000/svg")
  $root.SetAttribute("version","1.1")
  $root.SetAttribute("data-termodel-format","TERMODEL-PROJECT-SVG-V1")
  $root.SetAttribute("data-termodel-units","cm")
  [void]$out.AppendChild($root)

  $group = $out.CreateElement("g","http://www.w3.org/2000/svg")
  $floorId = [string]$floor.id
  $floorName = [string]$floor.name
  $floorRole = ([string]$floor.type).ToLowerInvariant()
  $floorFile = [string]$floor.fileName
  $floorLayer = [string]$floor.cadLayer
  $floorOrder = [string]$floor.order

  $group.SetAttribute("id","floor-" + ($floorId -replace '[^A-Za-z0-9_-]+','_'))
  $group.SetAttribute("data-termodel-floor-id",$floorId)
  $group.SetAttribute("data-termodel-name",$floorName)
  $group.SetAttribute("data-termodel-role",$floorRole)
  $group.SetAttribute("data-termodel-file",$floorFile)
  $group.SetAttribute("data-termodel-layer",$floorLayer)
  $group.SetAttribute("data-termodel-order",$floorOrder)

  foreach ($node in @($sourceGroup.ChildNodes)) {
    if ($node.NodeType -ne [System.Xml.XmlNodeType]::Element) { continue }
    $include = $node.LocalName -eq "line"
    if ($node.LocalName -eq "text") {
      $first = $node.SelectSingleNode("*[local-name()='tspan'][1]")
      $include = $first -and ([string]$first.InnerText -match '^\s*BLOCCO\s*,')
    }
    if (-not $include) { continue }

    $clone = $out.ImportNode($node,$true)
    if ([string]::IsNullOrWhiteSpace($clone.GetAttribute("data-termodel-layer"))) {
      $clone.SetAttribute("data-termodel-layer",$floorLayer)
    }

    if ($clone.LocalName -eq "line") {
      if ([string]::IsNullOrWhiteSpace($clone.GetAttribute("data-termodel-linetype"))) {
        $localType = $clone.GetAttribute("data-termodel-tipo-linea")
        if (-not [string]::IsNullOrWhiteSpace($localType)) {
          $clone.SetAttribute("data-termodel-linetype",$localType)
        }
      }
      if ([string]::IsNullOrWhiteSpace($clone.GetAttribute("data-termodel-color"))) {
        $localColor = $clone.GetAttribute("data-termodel-colore")
        if ($localColor -match '^\s*(\d+)') {
          $clone.SetAttribute("data-termodel-color",$Matches[1])
        }
      }
    }
    [void]$group.AppendChild($clone)
  }

  [void]$root.AppendChild($group)
  return $out.OuterXml
}

function Start-ServiceProcess {
  $p = Start-Process dotnet -ArgumentList @(
    "run","--project","src/Termodel.WebService/Termodel.WebService.csproj",
    "--configuration","Release","--no-build","--no-launch-profile"
  ) -RedirectStandardOutput $serviceOut -RedirectStandardError $serviceErr -PassThru
  for ($attempt = 0; $attempt -lt 60; $attempt++) {
    try {
      $health = Invoke-RestMethod -Uri "$base/health" -Method Get
      if ($health.status -eq "ok") { return $p }
    } catch {
      Start-Sleep -Milliseconds 500
    }
  }
  if ($p -and -not $p.HasExited) { & taskkill.exe /PID $p.Id /T /F 2>$null | Out-Null }
  throw "Termodel.WebService non ha risposto a /health."
}

function Stop-ServiceProcess($p) {
  if ($p -and -not $p.HasExited) {
    & taskkill.exe /PID $p.Id /T /F 2>$null | Out-Null
    try { $p.WaitForExit(5000) | Out-Null } catch {}
  }
}

function Save-WebResponse([string]$name,$response) {
  [System.IO.File]::WriteAllText((Join-Path $responseDir "$name.status.txt"),[string]$response.StatusCode,$utf8)
  $body = if ($response.Content -is [byte[]]) {
    [System.Text.Encoding]::UTF8.GetString($response.Content)
  } else {
    [string]$response.Content
  }
  [System.IO.File]::WriteAllText((Join-Path $responseDir "$name.body.txt"),$body,$utf8)
  $headers = @()
  foreach ($key in $response.Headers.Keys) {
    $headers += "$key=$($response.Headers[$key] -join ',')"
  }
  [System.IO.File]::WriteAllLines((Join-Path $responseDir "$name.headers.txt"),$headers,$utf8)
}

if (-not (Test-Path $fixturePath)) { throw "Fixture ProgettoVuoto non trovata: $fixturePath" }
$project = [System.IO.File]::ReadAllText($fixturePath,$utf8)

$geometry = @'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800" width="1200" height="800">
  <g id="calpestabile"><line id="W001" x1="195.760" y1="172.438" x2="652.768" y2="172.438" data-termodel-piano="Unico" data-termodel-layer="Unico" data-termodel-tipo-parete="Parete esterna isolata" data-termodel-confine-parete="Automatico" data-termodel-colore="1 - Rosso" data-termodel-tipo-linea="Continuous" stroke="#ff0000"/><line id="W002" x1="652.768" y1="172.438" x2="652.768" y2="524.853" data-termodel-piano="Unico" data-termodel-layer="Unico" data-termodel-tipo-parete="Parete esterna isolata" data-termodel-confine-parete="Automatico" data-termodel-colore="1 - Rosso" data-termodel-tipo-linea="Continuous" stroke="#ff0000"/><line id="W003" x1="652.768" y1="524.853" x2="195.760" y2="524.853" data-termodel-piano="Unico" data-termodel-layer="Unico" data-termodel-tipo-parete="Parete esterna isolata" data-termodel-confine-parete="Automatico" data-termodel-colore="1 - Rosso" data-termodel-tipo-linea="Continuous" stroke="#ff0000"/><line id="W004" x1="195.760" y1="524.853" x2="195.760" y2="172.438" data-termodel-piano="Unico" data-termodel-layer="Unico" data-termodel-tipo-parete="Parete esterna isolata" data-termodel-confine-parete="Automatico" data-termodel-colore="1 - Rosso" data-termodel-tipo-linea="Continuous" stroke="#ff0000"/><text id="R001" x="437.927" y="350.530" font-size="1" data-termodel-piano="Unico" data-termodel-layer="Unico"><tspan x="437.927" dy="0">BLOCCO,LOC</tspan><tspan x="437.927" dy="1.2em">DESCR.,Appartamento</tspan><tspan x="437.927" dy="1.2em">ZONA,Zona climatizzata</tspan><tspan x="437.927" dy="1.2em">CPAV,Automatico</tspan><tspan x="437.927" dy="1.2em">CSOF,Automatico</tspan><tspan x="437.927" dy="1.2em">CCOPERTURA,Solaio piano</tspan><tspan x="437.927" dy="1.2em">TPAV,Solaio interpiano</tspan><tspan x="437.927" dy="1.2em">TSOF,Solaio interpiano</tspan><tspan x="437.927" dy="1.2em">ALTEZZALORDA,Da piano</tspan><tspan x="437.927" dy="1.2em">ALTEZZANETTA,Da piano</tspan><tspan x="437.927" dy="1.2em">QUOTAPAVIMENTO,Da piano</tspan></text></g>
  <g id="copertura"/>
<g id="termodel-north" data-termodel-accessorio="NORD" data-termodel-orientamento="71" pointer-events="none" transform="translate(1170.56 29.439999999999998)"><circle cx="0" cy="0" r="25.6" fill="#ffffff" fill-opacity="0.88" stroke="#333333" stroke-width="1.5"/><g transform="rotate(71)"><line x1="0" y1="6.4" x2="0" y2="-17.919999999999998" stroke="#c62828" stroke-width="2" stroke-linecap="round"/><polygon points="0,-20.992 -3.3280000000000003,-14.080000000000002 3.3280000000000003,-14.080000000000002" fill="#c62828"/></g><text x="0" y="12.288" text-anchor="middle" font-family="Segoe UI, Arial, sans-serif" font-size="8.704" font-weight="700" fill="#111111">N</text></g></svg>
'@

$geometrySha = Sha256-Utf8 $geometry
if ($geometrySha -ne $expectedGeometrySha) {
  throw "SHA geometria non coincide col progetto utente. expected=$expectedGeometrySha actual=$geometrySha"
}

$project = Replace-Section $project "geometry/project.svg" $geometry
$project = Set-Manifest $project $originalProjectId $originalGeneratedAtUtc $geometrySha
$originalInputPath = Join-Path $requestDir "project-user-equivalent.tmdl"
[System.IO.File]::WriteAllText($originalInputPath,$project,$utf8)

$manifest = (Get-Section $project "manifest.json") | ConvertFrom-Json
$serverGeometry = Build-CanonicalServerGeometry $project $geometry
$serverGeometrySha = Sha256-Utf8 $serverGeometry
$serverProject = Replace-Section $project "geometry/project.svg" $serverGeometry
$serverProject = Set-Manifest $serverProject $originalProjectId $originalGeneratedAtUtc $serverGeometrySha
[System.IO.File]::WriteAllText((Join-Path $requestDir "project-server-payload.tmdl"),$serverProject,$utf8)
[System.IO.File]::WriteAllText((Join-Path $requestDir "geometry-server-canonical.svg"),$serverGeometry,$utf8)

$checks = @(
  "sourceFixture=SorgentiTermodel/Library/projects/ProgettoVuoto/ProgettoVuoto.termodel.txt",
  "geometrySha256=$geometrySha",
  "expectedGeometrySha256=$expectedGeometrySha",
  "serverGeometrySha256=$serverGeometrySha",
  "serverGeometryHasUnits=$($serverGeometry.Contains('data-termodel-units=\"cm\"'))",
  "serverGeometryHasFormat=$($serverGeometry.Contains('data-termodel-format=\"TERMODEL-PROJECT-SVG-V1\"'))",
  "projectId=$($manifest.projectId)",
  "generatedAtUtc=$($manifest.generatedAtUtc)",
  "sectionCount=$(@($manifest.sections).Count)"
)
[System.IO.File]::WriteAllLines((Join-Path $requestDir "input-checks.txt"),$checks,$utf8)

$service = $null
try {
  $service = Start-ServiceProcess

  # Conserva il primo risultato: il progetto copiato dagli appunti non è il payload
  # tecnico Service. Il frontend normale passa prima da buildTermodelServerPayload().
  $rawDirect = Invoke-WebRequest -Uri "$base/api/model/3d" -Method Post -ContentType "text/plain; charset=utf-8" -Body $project -SkipHttpErrorCheck
  Save-WebResponse "model3d-raw-copied-project" $rawDirect

  # Questo è il percorso equivalente al frontend: payload canonico Service.
  $direct = Invoke-WebRequest -Uri "$base/api/model/3d" -Method Post -ContentType "text/plain; charset=utf-8" -Body $serverProject -SkipHttpErrorCheck
  Save-WebResponse "model3d-server-payload" $direct

  $allocation = Invoke-RestMethod -Uri "$base/api/projects/allocate-id" -Method Post
  $allocation | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath (Join-Path $responseDir "allocation.json") -Encoding utf8NoBOM
  $projectId = [string]$allocation.projectId
  $lockToken = [string]$allocation.projectLockToken
  if ([string]::IsNullOrWhiteSpace($projectId) -or [string]::IsNullOrWhiteSpace($lockToken)) {
    throw "allocate-id non ha restituito projectId/lock token."
  }

  $calculationProject = Set-Manifest $serverProject $projectId $originalGeneratedAtUtc $serverGeometrySha
  [System.IO.File]::WriteAllText((Join-Path $requestDir "project-calculation.tmdl"),$calculationProject,$utf8)
  $headers = @{ "X-Termodel-Project-Lock" = $lockToken }

  $calc = Invoke-WebRequest -Uri "$base/api/calculations?logCategories=all" -Method Post -Headers $headers -ContentType "text/plain; charset=utf-8" -Body $calculationProject -SkipHttpErrorCheck
  Save-WebResponse "calculation" $calc

  $generated = Invoke-WebRequest -Uri "$base/api/projects/$projectId/generated-files" -Method Get -SkipHttpErrorCheck
  Save-WebResponse "generated-files" $generated

  $workspace = Join-Path $env:TERMODEL_SAVED_PROJECTS_DIR $projectId
  if (Test-Path $workspace) {
    Copy-Item -LiteralPath $workspace -Destination (Join-Path $workspaceCopy $projectId) -Recurse -Force
  }

  $lines = @(
    "TERMODEL_AI_REAL_PROJECT_DEBUG_V2",
    "projectId=$projectId",
    "sourceFixture=$fixturePath",
    "rawGeometrySha256=$geometrySha",
    "serverGeometrySha256=$serverGeometrySha",
    "rawCopiedModel3dStatus=$($rawDirect.StatusCode)",
    "model3dServerPayloadStatus=$($direct.StatusCode)",
    "calculationStatus=$($calc.StatusCode)",
    "generatedFilesStatus=$($generated.StatusCode)",
    "workspace=$workspace"
  )
  [System.IO.File]::WriteAllLines($summaryPath,$lines,$utf8)
  Write-Host "TERMODEL_AI_REAL_PROJECT_DEBUG_COMPLETED"
  Write-Host ($lines -join [Environment]::NewLine)
}
finally {
  Stop-ServiceProcess $service
}
