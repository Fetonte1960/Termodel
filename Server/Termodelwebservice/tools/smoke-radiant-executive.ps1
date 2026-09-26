$ErrorActionPreference = "Stop"

$base = "http://127.0.0.1:5081"
$env:ASPNETCORE_URLS = $base
$env:TERMODEL_SPIRAL_ENGINE = "Diego"
$env:TERMODEL_SAVED_PROJECTS_DIR = Join-Path $env:RUNNER_TEMP ("TermodelExecutiveSmoke-" + [guid]::NewGuid().ToString("N"))
$artifactDir = Join-Path $env:RUNNER_TEMP "StrategiaDiegoSquareExecutiveArtifacts"
New-Item -ItemType Directory -Path $env:TERMODEL_SAVED_PROJECTS_DIR -Force | Out-Null
if (Test-Path -LiteralPath $artifactDir) {
  Remove-Item -LiteralPath $artifactDir -Recurse -Force
}
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

  $calculation = Invoke-RestMethod -Uri "$base/api/calculations?logEnabled=true&logCategories=SpiraliDiego" -Method Post -Headers $headers -ContentType "text/plain; charset=utf-8" -Body $project
  if (@($calculation.artifacts.name) -notcontains "pannelli-esecutivo-svg" -or
      @($calculation.artifacts.name) -notcontains "pannelli-esecutivo-dxf") {
    throw "Manifest calcolo privo degli artifact esecutivi."
  }

  $svgResponse = Invoke-WebRequest -Uri "$base/api/projects/$($allocation.projectId)/artifacts/pannelli-esecutivo-svg" -Method Get
  $dxfResponse = Invoke-WebRequest -Uri "$base/api/projects/$($allocation.projectId)/artifacts/pannelli-esecutivo-dxf" -Method Get

  # Canale universale file generati: catalogo + GET sicuro, usato dal frontend
  # per disegni, report e altri output futuri.
  $generatedCatalog = Invoke-RestMethod -Uri "$base/api/projects/$($allocation.projectId)/generated-files" -Method Get
  if ($generatedCatalog.contractVersion -ne "TERMODEL-GENERATED-FILES-V1") {
    throw "Contratto catalogo file generati non riconosciuto."
  }

  $generatedPaths = @($generatedCatalog.files | ForEach-Object { [string]$_.path })
  foreach ($expectedPath in @(
    "artifacts/model3d.json",
    "artifacts/pannelli.json",
    "artifacts/pannelli-esecutivo.svg",
    "artifacts/pannelli-esecutivo.dxf",
    "logs/TermodelLog.md",
    "logs/calculation.log"
  )) {
    if ($generatedPaths -notcontains $expectedPath) {
      throw "Catalogo file generati privo di $expectedPath."
    }
  }
  if ($generatedPaths -contains "project.tmdl" -or
      @($generatedPaths | Where-Object { $_ -notmatch "^(artifacts|logs)/" }).Count -gt 0) {
    throw "Il catalogo universale espone file fuori da artifacts/logs."
  }

  $generatedSvgRecord = @($generatedCatalog.files | Where-Object {
    $_.path -eq "artifacts/pannelli-esecutivo.svg"
  })[0]
  $generatedDxfRecord = @($generatedCatalog.files | Where-Object {
    $_.path -eq "artifacts/pannelli-esecutivo.dxf"
  })[0]
  $generatedPanelsRecord = @($generatedCatalog.files | Where-Object {
    $_.path -eq "artifacts/pannelli.json"
  })[0]
  $generatedLogRecord = @($generatedCatalog.files | Where-Object {
    $_.path -eq "logs/TermodelLog.md"
  })[0]

  $genericSvgResponse = Invoke-WebRequest -Uri ($base + [string]$generatedSvgRecord.href) -Method Get
  $genericDxfResponse = Invoke-WebRequest -Uri ($base + [string]$generatedDxfRecord.href) -Method Get
  $genericPanelsResponse = Invoke-WebRequest -Uri ($base + [string]$generatedPanelsRecord.href) -Method Get
  $genericLogResponse = Invoke-WebRequest -Uri ($base + [string]$generatedLogRecord.href) -Method Get

  if ($genericSvgResponse.Headers["Content-Type"] -notmatch "^image/svg\+xml" -or
      $genericDxfResponse.Headers["Content-Type"] -notmatch "^application/dxf" -or
      $genericPanelsResponse.Headers["Content-Type"] -notmatch "^application/json" -or
      $genericLogResponse.Headers["Content-Type"] -notmatch "^text/markdown") {
    throw "Content-Type del canale universale non coerenti."
  }

  $diegoLogText = [string]$genericLogResponse.Content
  foreach ($marker in @(
    "[SpiraliDiego] START",
    "[SpiraliDiego] LOCALE",
    " ENTRY point=",
    "[SpiraliDiego] TREE Supply initial ACCEPT",
    "[SpiraliDiego] TREE Supply CHOICE",
    "TERMINAL-GOODNESS",
    " RETURN-CONNECTION accept ",
    " CLOSURE ",
    " BEST update ",
    " SELECT merit="
  )) {
    if (-not $diegoLogText.Contains($marker)) {
      throw "Log SpiraliDiego privo del marker strategico: $marker"
    }
  }
  [System.IO.File]::WriteAllText(
    (Join-Path $artifactDir "TermodelLog-SpiraliDiego.md"),
    $diegoLogText,
    [System.Text.UTF8Encoding]::new($false))

  # Regression nodo 8: dopo il primo giro la mandata deve poter riagganciare
  # una propria evoluzione usando la prima retta pertinente DAVANTI, senza
  # arrestarsi sul vecchio SequenceIndex+1.
  if ($diegoLogText -notmatch "SEQUENCE own-family geometric-continuation") {
    throw "StrategiaDiego: nessun inseguimento geometrico own-family registrato sul quadrato."
  }

  if ($diegoLogText -notmatch "EXTEND beyond-extended-front") {
    throw "StrategiaDiego LG-034: il quadrato non ha esercitato il passaggio oltre una linea estesa."
  }

  $goodnessMatches = [regex]::Matches(
    $diegoLogText,
    'SUPPLY-BEST-GOODNESS[^\r\n]*activeSegments=(?<segments>\d+)[^\r\n]*activeLength=(?<length>[0-9.]+)m[^\r\n]*coveredArea=(?<covered>[0-9.]+)m2[^\r\n]*localeArea=(?<area>[0-9.]+)m2[^\r\n]*factor=(?<factor>[0-9.]+)')
  if ($goodnessMatches.Count -lt 1) {
    throw "StrategiaDiego: metriche SUPPLY-BEST-GOODNESS mancanti sul quadrato."
  }

  $bestSupplyGoodness = $goodnessMatches |
    ForEach-Object {
      [pscustomobject]@{
        Segments = [int]$_.Groups["segments"].Value
        Length = [double]::Parse($_.Groups["length"].Value,[Globalization.CultureInfo]::InvariantCulture)
        Covered = [double]::Parse($_.Groups["covered"].Value,[Globalization.CultureInfo]::InvariantCulture)
        Area = [double]::Parse($_.Groups["area"].Value,[Globalization.CultureInfo]::InvariantCulture)
        Factor = [double]::Parse($_.Groups["factor"].Value,[Globalization.CultureInfo]::InvariantCulture)
      }
    } |
    Sort-Object Factor,Segments -Descending |
    Select-Object -First 1

  if ($bestSupplyGoodness.Segments -lt 15) {
    throw "StrategiaDiego LG-034 regression: miglior terminale mandata ha solo $($bestSupplyGoodness.Segments) tratti attivi; attesi almeno 15."
  }
  if ($bestSupplyGoodness.Factor -lt 1.00) {
    throw "StrategiaDiego LG-034 regression: fattore di bonta mandata $($bestSupplyGoodness.Factor) inferiore a 1,00."
  }

  Write-Host ("STRATEGIA_DIEGO_LG034_BEYOND_OK activeSegments={0} activeLength={1}m coveredArea={2}m2 localeArea={3}m2 factor={4}" -f
    $bestSupplyGoodness.Segments,
    $bestSupplyGoodness.Length.ToString("0.###",[Globalization.CultureInfo]::InvariantCulture),
    $bestSupplyGoodness.Covered.ToString("0.###",[Globalization.CultureInfo]::InvariantCulture),
    $bestSupplyGoodness.Area.ToString("0.###",[Globalization.CultureInfo]::InvariantCulture),
    $bestSupplyGoodness.Factor.ToString("0.###",[Globalization.CultureInfo]::InvariantCulture))

  Write-Host "STRATEGIA_DIEGO_LOG_SMOKE_OK"
  if ($genericSvgResponse.Headers["X-Termodel-Artifact-Stale"] -ne "false" -or
      $genericSvgResponse.Headers["X-Termodel-Generated-File"] -ne "artifacts/pannelli-esecutivo.svg") {
    throw "Header del GET universale SVG non coerenti."
  }

  $deniedProjectFile = Invoke-WebRequest -Uri "$base/api/projects/$($allocation.projectId)/generated-files/project.tmdl" -Method Get -SkipHttpErrorCheck
  if ($deniedProjectFile.StatusCode -ne 404) {
    throw "Il canale universale non deve esporre project.tmdl."
  }

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

  # Artifact diagnostico stabile del progetto quadrato 4x4 realmente
  # elaborato dal Service con StrategiaDiego. Serve alla verifica visuale
  # senza ricostruzioni esterne del disegno.
  [System.IO.File]::WriteAllText(
    (Join-Path $artifactDir "StrategiaDiegoSquare4x4.project.tmdl"),
    $project,
    [System.Text.UTF8Encoding]::new($false))
  Copy-Item -LiteralPath $svgPath -Destination (Join-Path $artifactDir "pannelli-esecutivo.svg") -Force
  Copy-Item -LiteralPath $dxfPath -Destination (Join-Path $artifactDir "pannelli-esecutivo.dxf") -Force
  if ($svgText -notmatch "TERMODEL-PANNELLI-ESECUTIVO-SVG-V1") {
    throw "Formato SVG esecutivo non riconosciuto."
  }

  [xml]$svgXml = $svgText
  $svgRoot = $svgXml.DocumentElement
  if ($svgRoot.GetAttribute("data-coordinate-unit") -ne "m" -or
      [string]::IsNullOrWhiteSpace($svgRoot.GetAttribute("data-termodel-max-y"))) {
    throw "SVG esecutivo privo dei metadata metrici richiesti dal CAD2D."
  }

  $ns = New-Object System.Xml.XmlNamespaceManager($svgXml.NameTable)
  $ns.AddNamespace("s","http://www.w3.org/2000/svg")
  $cleanFloorLayer = $floorName + "_PiantaPulita_Output"
  $mandataLayer = $floorName + "_PannelliMandata_Output"
  $ritornoLayer = $floorName + "_PannelliRitorno_Output"
  $debugLayer = $floorName + "_SpiraliDebug_Output"

  $cleanFloorGroup = $svgXml.SelectSingleNode("//s:g[@data-layer='$cleanFloorLayer']",$ns)
  $mandataGroup = $svgXml.SelectSingleNode("//s:g[@data-layer='$mandataLayer']",$ns)
  $ritornoGroup = $svgXml.SelectSingleNode("//s:g[@data-layer='$ritornoLayer']",$ns)
  $debugGroup = $svgXml.SelectSingleNode("//s:g[@data-layer='$debugLayer']",$ns)
  if (-not $cleanFloorGroup -or -not $mandataGroup -or -not $ritornoGroup) {
    throw "SVG esecutivo privo dei gruppi pianta-pulita/mandata/ritorno."
  }
  if ($mandataGroup.ChildNodes.Count -lt 1 -or $ritornoGroup.ChildNodes.Count -lt 1) {
    throw "SVG esecutivo non contiene geometria spirale mandata/ritorno."
  }

  if (-not $debugGroup) {
    throw "SVG esecutivo privo del layer diagnostico nodi con numerazioneSpirali default=true."
  }
  $debugNodeTexts = @($debugGroup.SelectNodes("./s:text",$ns))
  if ($debugNodeTexts.Count -lt 2) {
    throw "SVG esecutivo: numerazione nodi StrategiaDiego insufficiente."
  }
  foreach ($debugNodeText in $debugNodeTexts) {
    $nodeId = ([string]$debugNodeText.InnerText).Trim()
    if ($nodeId -notmatch "^\d+$") {
      throw "SVG esecutivo: identificativo nodo diagnostico non numerico '$nodeId'."
    }
    if ($diegoLogText -notmatch ("(?m)\bnode=" + [regex]::Escape($nodeId) + "\b|\bchildNode=" + [regex]::Escape($nodeId) + "\b")) {
      throw "SVG esecutivo: node-id $nodeId non rintracciato nel log SpiraliDiego."
    }
  }
  Write-Host "STRATEGIA_DIEGO_NODE_NUMBERING_OK count=$($debugNodeTexts.Count)"

  $cleanBoundaries = @($cleanFloorGroup.SelectNodes("./s:polyline | ./s:polygon",$ns))
  if ($cleanBoundaries.Count -lt 2) {
    throw "SVG esecutivo non contiene almeno due contorni della pianta pulita per rappresentare lo spessore pareti."
  }

  $distinctBoundaryPoints = @($cleanBoundaries | ForEach-Object {
    $_.GetAttribute("points")
  } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique)
  if ($distinctBoundaryPoints.Count -lt 2) {
    throw "SVG esecutivo contiene contorni pianta pulita coincidenti: spessore parete non verificabile."
  }

  if ($genericSvgResponse.Content -notmatch "TERMODEL-PANNELLI-ESECUTIVO-SVG-V1") {
    throw "GET universale non ha restituito l'SVG spirali."
  }
  Write-Host "GENERATED_FILES_CHANNEL_SMOKE_OK"
  Write-Host "RADIANT_EXECUTIVE_SVG_GEOMETRY_SMOKE_OK"

  foreach ($layer in @(
    ($floorName + "_PiantaPulita_Output"),
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
  $debugPrimitiveCount = $debugNodeTexts.Count
  $svgTechnicalPrimitiveCount = $svgPrimitiveCount - $debugPrimitiveCount

  $minimumExpectedPrimitives =
    $cleanBoundaries.Count +
    $mandataGroup.ChildNodes.Count +
    $ritornoGroup.ChildNodes.Count
  if ($svgTechnicalPrimitiveCount -lt $minimumExpectedPrimitives) {
    throw "Conteggio primitive tecniche SVG inferiore alla somma pianta pulita + mandata + ritorno."
  }
  if ($svgTechnicalPrimitiveCount -ne $dxfPrimitiveCount) {
    throw "Primitive tecniche SVG/DXF differenti: SVGtecnico=$svgTechnicalPrimitiveCount DXF=$dxfPrimitiveCount debugSVG=$debugPrimitiveCount."
  }
  if ($dxfText -match [regex]::Escape($debugLayer)) {
    throw "La numerazione diagnostica nodi non deve essere serializzata nel DXF."
  }

  $log = Get-Content -LiteralPath (Join-Path $projectDir "logs\calculation.log") -Raw
  if ($log -notmatch "radiantExecutivePrimitiveCount=$dxfPrimitiveCount" -or
      $log -notmatch "radiantExecutiveFloorCount=1") {
    throw "Conteggi esecutivo tecnico non coerenti nel calculation.log."
  }

  $metadata = [ordered]@{
    fixture = "square-4x4-service-project"
    spiralEngine = $env:TERMODEL_SPIRAL_ENGINE
    logCategory = "SpiraliDiego"
    projectId = [string]$allocation.projectId
    floorName = $floorName
    svgSha256 = (Get-FileHash -LiteralPath $svgPath -Algorithm SHA256).Hash.ToLowerInvariant()
    dxfSha256 = (Get-FileHash -LiteralPath $dxfPath -Algorithm SHA256).Hash.ToLowerInvariant()
    primitiveCount = $dxfPrimitiveCount
    svgDebugNodeCount = $debugPrimitiveCount
    executedAtUtc = [DateTime]::UtcNow.ToString("o")
  }
  $metadata | ConvertTo-Json -Depth 20 |
    Set-Content -LiteralPath (Join-Path $artifactDir "test-metadata.json") -Encoding utf8

  Write-Host "RADIANT_EXECUTIVE_SVG_DXF_SMOKE_OK"
  Write-Host "STRATEGIA_DIEGO_SQUARE_EXECUTIVE_OK"
  Write-Host "squareExecutiveSvgSha256=$($metadata.svgSha256)"
}
finally {
  Stop-ServiceProcess $service
  if (Test-Path $env:TERMODEL_SAVED_PROJECTS_DIR) {
    Remove-Item -LiteralPath $env:TERMODEL_SAVED_PROJECTS_DIR -Recurse -Force -ErrorAction SilentlyContinue
  }
}
