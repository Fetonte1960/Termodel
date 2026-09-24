# AI debug Appartamento FIN orientation
param(
  [Parameter(Mandatory = $true)]
  [string]$OutputDirectory
)

$ErrorActionPreference = "Stop"
$utf8 = [System.Text.UTF8Encoding]::new($false)
$base = "http://127.0.0.1:5082"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..")).Path
$fixturePath = Join-Path $repoRoot "SorgentiTermodel\Library\projects\ProgettoVuoto\ProgettoVuoto.termodel.txt"
$exampleGeometryPath = Join-Path $repoRoot "docs\termodel-ui-demo\examples\appartamento.svg"
$originalProjectId = [guid]::NewGuid().ToString("D")
$originalGeneratedAtUtc = [DateTimeOffset]::UtcNow.ToString("O")

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
if (-not (Test-Path $exampleGeometryPath)) { throw "Geometria Appartamento non trovata: $exampleGeometryPath" }
$project = [System.IO.File]::ReadAllText($fixturePath,$utf8)

$geometry = [System.IO.File]::ReadAllText($exampleGeometryPath,$utf8)
$geometrySha = Sha256-Utf8 $geometry

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
  "serverGeometrySha256=$serverGeometrySha",
  "serverGeometryHasUnits=$($serverGeometry.Contains('data-termodel-units=\"cm\"'))",
  "serverGeometryHasFormat=$($serverGeometry.Contains('data-termodel-format=\"TERMODEL-PROJECT-SVG-V1\"'))",
  "sourceLineCount=$(([regex]::Matches($geometry, '<line\\b')).Count)",
  "sourceBlockCount=$(([regex]::Matches($geometry, 'BLOCCO,')).Count)",
  "serverGeometryHasNorthTechnical=$($serverGeometry.Contains('BLOCCO,NORD'))",
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

  $modelArtifactPath = Join-Path $workspace "artifacts\model3d.json"
  $modelPrimitiveCount = -1
  $modelArrayCount = -1
  $modelTypeCounts = ""
  $modelBBox = ""
  if (Test-Path $modelArtifactPath) {
    $model = [System.IO.File]::ReadAllText($modelArtifactPath,$utf8) | ConvertFrom-Json
    $primitives = @($model.primitives)
    $modelPrimitiveCount = [int]$model.primitiveCount
    $modelArrayCount = $primitives.Count
    $modelTypeCounts = (($primitives | Group-Object tipo | Sort-Object Name | ForEach-Object { "$($_.Name)=$($_.Count)" }) -join ";")

    $xs = [System.Collections.Generic.List[double]]::new()
    $ys = [System.Collections.Generic.List[double]]::new()
    $zs = [System.Collections.Generic.List[double]]::new()
    foreach ($primitive in $primitives) {
      foreach ($vertex in @($primitive.vertices)) {
        if ($null -ne $vertex -and @($vertex).Count -ge 3) {
          $xs.Add([double]$vertex[0]); $ys.Add([double]$vertex[1]); $zs.Add([double]$vertex[2])
        }
      }
    }
    if ($xs.Count -gt 0) {
      $modelBBox = "X=$([Linq.Enumerable]::Min([double[]]$xs.ToArray()))..$([Linq.Enumerable]::Max([double[]]$xs.ToArray()));Y=$([Linq.Enumerable]::Min([double[]]$ys.ToArray()))..$([Linq.Enumerable]::Max([double[]]$ys.ToArray()));Z=$([Linq.Enumerable]::Min([double[]]$zs.ToArray()))..$([Linq.Enumerable]::Max([double[]]$zs.ToArray()))"
    }
  }

  $orientationDetails = [System.Collections.Generic.List[string]]::new()
  $orientationFailures = 0
  $orientationChecked = 0

  if (Test-Path $modelArtifactPath) {
    $sourceXml = [System.Xml.XmlDocument]::new()
    $sourceXml.LoadXml($serverGeometry)
    $svgNs = [System.Xml.XmlNamespaceManager]::new($sourceXml.NameTable)
    $svgNs.AddNamespace("svg","http://www.w3.org/2000/svg")

    $wallLines = @($sourceXml.SelectNodes("//svg:line",$svgNs))
    $finNodes = @($sourceXml.SelectNodes("//svg:text[svg:tspan[1][starts-with(normalize-space(.),'BLOCCO,FIN')]]",$svgNs))
    $windowSides = @($primitives | Where-Object { $_.tipo -eq "Finestra" -and $_.parte -eq "lati" })

    function Segment-DistanceAndDirection([double]$px,[double]$py,$line) {
      $x1 = [double]::Parse($line.GetAttribute("x1"),[Globalization.CultureInfo]::InvariantCulture) * 0.01
      $y1 = [double]::Parse($line.GetAttribute("y1"),[Globalization.CultureInfo]::InvariantCulture) * 0.01
      $x2 = [double]::Parse($line.GetAttribute("x2"),[Globalization.CultureInfo]::InvariantCulture) * 0.01
      $y2 = [double]::Parse($line.GetAttribute("y2"),[Globalization.CultureInfo]::InvariantCulture) * 0.01
      $dx = $x2 - $x1; $dy = $y2 - $y1
      $len2 = $dx*$dx + $dy*$dy
      if ($len2 -le 1e-18) { return [pscustomobject]@{ Distance = [double]::PositiveInfinity; Dx=0.0; Dy=0.0; Id=$line.GetAttribute("id") } }
      $t = (($px-$x1)*$dx + ($py-$y1)*$dy) / $len2
      $t = [Math]::Max(0.0,[Math]::Min(1.0,$t))
      $qx = $x1 + $t*$dx; $qy = $y1 + $t*$dy
      $len = [Math]::Sqrt($len2)
      return [pscustomobject]@{
        Distance = [Math]::Sqrt(($px-$qx)*($px-$qx)+($py-$qy)*($py-$qy))
        Dx = $dx/$len
        Dy = $dy/$len
        Id = $line.GetAttribute("id")
      }
    }

    foreach ($fin in $finNodes) {
      $finId = $fin.GetAttribute("id")
      $fx = [double]::Parse($fin.GetAttribute("x"),[Globalization.CultureInfo]::InvariantCulture) * 0.01
      $fy = [double]::Parse($fin.GetAttribute("y"),[Globalization.CultureInfo]::InvariantCulture) * 0.01

      $nearestWall = $null
      foreach ($wall in $wallLines) {
        $candidate = Segment-DistanceAndDirection $fx $fy $wall
        if ($null -eq $nearestWall -or $candidate.Distance -lt $nearestWall.Distance) { $nearestWall = $candidate }
      }

      $nearestWindow = $null
      foreach ($window in $windowSides) {
        $wv = @($window.vertices)
        if ($wv.Count -lt 2) { continue }
        $cx = ($wv | ForEach-Object { [double]$_[0] } | Measure-Object -Average).Average
        $cy = ($wv | ForEach-Object { [double]$_[1] } | Measure-Object -Average).Average
        $dist = [Math]::Sqrt(($cx-$fx)*($cx-$fx)+($cy-$fy)*($cy-$fy))
        if ($null -eq $nearestWindow -or $dist -lt $nearestWindow.Distance) {
          $nearestWindow = [pscustomobject]@{ Distance=$dist; Primitive=$window }
        }
      }

      if ($null -eq $nearestWall -or $null -eq $nearestWindow) {
        $orientationFailures++
        $orientationDetails.Add("$finId ERROR association missing")
        continue
      }

      $v = @($nearestWindow.Primitive.vertices)
      $adx = [double]$v[1][0] - [double]$v[0][0]
      $ady = [double]$v[1][1] - [double]$v[0][1]
      $alen = [Math]::Sqrt($adx*$adx+$ady*$ady)
      if ($alen -le 1e-12) {
        $orientationFailures++
        $orientationDetails.Add("$finId ERROR zero width edge")
        continue
      }
      $adx /= $alen; $ady /= $alen
      $alignment = [Math]::Abs($adx*$nearestWall.Dx + $ady*$nearestWall.Dy)
      $orientationChecked++
      if ($alignment -lt 0.999) { $orientationFailures++ }
      $orientationDetails.Add(
        "$finId wall=$($nearestWall.Id) alignment=$($alignment.ToString('0.000000',[Globalization.CultureInfo]::InvariantCulture)) " +
        "windowCenterDistance=$($nearestWindow.Distance.ToString('0.000000',[Globalization.CultureInfo]::InvariantCulture))"
      )
    }
  }

  $lines = @(
    "TERMODEL_AI_APPARTAMENTO_FIN_ORIENTATION_DEBUG_V1",
    "projectId=$projectId",
    "sourceFixture=$fixturePath",
    "exampleGeometry=$exampleGeometryPath",
    "rawGeometrySha256=$geometrySha",
    "sourceLineCount=$(([regex]::Matches($geometry, '<line\\b')).Count)",
    "sourceBlockCount=$(([regex]::Matches($geometry, 'BLOCCO,')).Count)",
    "serverGeometrySha256=$serverGeometrySha",
    "rawCopiedModel3dStatus=$($rawDirect.StatusCode)",
    "model3dServerPayloadStatus=$($direct.StatusCode)",
    "calculationStatus=$($calc.StatusCode)",
    "generatedFilesStatus=$($generated.StatusCode)",
    "modelPrimitiveCount=$modelPrimitiveCount",
    "modelArrayCount=$modelArrayCount",
    "modelTypeCounts=$modelTypeCounts",
    "modelBBox=$modelBBox",
    "orientationChecked=$orientationChecked",
    "orientationFailures=$orientationFailures",
    $orientationDetails,
    "workspace=$workspace"
  )
  [System.IO.File]::WriteAllLines($summaryPath,$lines,$utf8)
  Write-Host "TERMODEL_AI_APPARTAMENTO_FIN_ORIENTATION_DEBUG_COMPLETED"
  Write-Host ($lines -join [Environment]::NewLine)
  if ($orientationChecked -ne 9 -or $orientationFailures -ne 0) {
    throw "FIN orientation regression: checked=$orientationChecked failures=$orientationFailures"
  }
}
finally {
  Stop-ServiceProcess $service
}
