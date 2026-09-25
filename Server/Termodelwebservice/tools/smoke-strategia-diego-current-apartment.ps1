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

function Get-ProjectSection([string]$projectText,[string]$sectionName) {
  $begin = "---BEGIN:$sectionName---"
  $end = "---END:$sectionName---"
  $bi = $projectText.IndexOf($begin,[System.StringComparison]::Ordinal)
  if ($bi -lt 0) { throw "Sezione $sectionName non trovata." }
  $cs = $bi + $begin.Length
  while ($cs -lt $projectText.Length -and ($projectText[$cs] -in @([char]13,[char]10))) { $cs++ }
  $ei = $projectText.IndexOf($end,$cs,[System.StringComparison]::Ordinal)
  if ($ei -lt 0) { throw "Sezione $sectionName non chiusa." }
  return $projectText.Substring($cs,$ei-$cs).TrimEnd([char]13,[char]10)
}

function Set-ProjectSection([string]$projectText,[string]$sectionName,[string]$content) {
  $begin = "---BEGIN:$sectionName---"
  $end = "---END:$sectionName---"
  $bi = $projectText.IndexOf($begin,[System.StringComparison]::Ordinal)
  if ($bi -lt 0) { throw "Sezione $sectionName non trovata." }
  $cs = $bi + $begin.Length
  while ($cs -lt $projectText.Length -and ($projectText[$cs] -in @([char]13,[char]10))) { $cs++ }
  $ei = $projectText.IndexOf($end,$cs,[System.StringComparison]::Ordinal)
  if ($ei -lt 0) { throw "Sezione $sectionName non chiusa." }
  return $projectText.Substring(0,$cs) + $content + "`n" + $projectText.Substring($ei)
}

function Remove-ProjectSection([string]$projectText,[string]$sectionName) {
  $begin = "---BEGIN:$sectionName---"
  $end = "---END:$sectionName---"
  $bi = $projectText.IndexOf($begin,[System.StringComparison]::Ordinal)
  if ($bi -lt 0) { return $projectText }
  $ei = $projectText.IndexOf($end,$bi,[System.StringComparison]::Ordinal)
  if ($ei -lt 0) { throw "Sezione $sectionName non chiusa." }
  $after = $ei + $end.Length
  while ($after -lt $projectText.Length -and ($projectText[$after] -in @([char]13,[char]10))) { $after++ }
  return $projectText.Substring(0,$bi) + $projectText.Substring($after)
}

function Get-Sha256Text([string]$value) {
  $sha = [System.Security.Cryptography.SHA256]::Create()
  try {
    $bytes = [System.Text.UTF8Encoding]::new($false).GetBytes($value)
    return ([System.BitConverter]::ToString($sha.ComputeHash($bytes))).Replace("-","").ToLowerInvariant()
  } finally {
    $sha.Dispose()
  }
}

function Refresh-Manifest([string]$projectText) {
  $manifest = Get-ProjectSection $projectText "manifest.json" | ConvertFrom-Json
  $kept = @()
  $definitionHash = ""
  foreach ($section in @($manifest.sections)) {
    $name = [string]$section.name
    if ($name.StartsWith("assets/backgrounds/",[System.StringComparison]::OrdinalIgnoreCase)) { continue }
    $body = Get-ProjectSection $projectText $name
    $section.sha256 = Get-Sha256Text $body
    if ($name -eq [string]$manifest.databaseDefinition.path) { $definitionHash = [string]$section.sha256 }
    $kept += $section
  }
  $manifest.sections = @($kept)
  if ($definitionHash -and $manifest.databaseDefinition) {
    $manifest.databaseDefinition.sha256 = $definitionHash
  }
  $json = $manifest | ConvertTo-Json -Depth 100
  return Set-ProjectSection $projectText "manifest.json" $json
}

function Build-CanonicalServerProject([string]$projectText) {
  $manifest = Get-ProjectSection $projectText "manifest.json" | ConvertFrom-Json
  [xml]$source = Get-ProjectSection $projectText "geometry/project.svg"

  $out = New-Object System.Xml.XmlDocument
  $root = $out.CreateElement("svg","http://www.w3.org/2000/svg")
  $root.SetAttribute("version","1.1")
  $root.SetAttribute("data-termodel-format","TERMODEL-PROJECT-SVG-V1")
  $root.SetAttribute("data-termodel-units","cm")
  $out.AppendChild($root) | Out-Null

  $sourceRoot = $source.DocumentElement
  $legacyGroups = @($sourceRoot.ChildNodes | Where-Object {
    $_.NodeType -eq [System.Xml.XmlNodeType]::Element -and
    ($_.GetAttribute("id") -eq "calpestabile" -or $_.GetAttribute("id") -eq "copertura")
  })

  foreach ($floor in @($manifest.floors | Sort-Object order)) {
    $group = $out.CreateElement("g","http://www.w3.org/2000/svg")
    $safeId = ([string]$floor.id) -replace "[^A-Za-z0-9_-]+","_"
    $group.SetAttribute("id","floor-" + $safeId)
    $group.SetAttribute("data-termodel-floor-id",[string]$floor.id)
    $group.SetAttribute("data-termodel-name",[string]$floor.name)
    $role = if ([string]$floor.type -eq "Copertura") { "copertura" } else { "calpestabile" }
    $group.SetAttribute("data-termodel-role",$role)
    $group.SetAttribute("data-termodel-file",[string]$floor.fileName)
    $group.SetAttribute("data-termodel-layer",[string]$floor.cadLayer)
    $group.SetAttribute("data-termodel-order",[string]$floor.order)

    foreach ($legacyGroup in $legacyGroups) {
      foreach ($node in @($legacyGroup.ChildNodes)) {
        if ($node.NodeType -ne [System.Xml.XmlNodeType]::Element) { continue }
        if ($node.LocalName -notin @("line","text")) { continue }

        $plane = [string]$node.GetAttribute("data-termodel-piano")
        if ($plane -and $plane -ne [string]$floor.name -and $plane -ne [string]$floor.id) { continue }

        if ($node.LocalName -eq "text") {
          $firstTspan = @($node.ChildNodes | Where-Object {
            $_.NodeType -eq [System.Xml.XmlNodeType]::Element -and $_.LocalName -eq "tspan"
          } | Select-Object -First 1)
          if (-not $firstTspan -or [string]$firstTspan.InnerText -notmatch "^\s*BLOCCO\s*,") { continue }
        }

        $clone = $out.ImportNode($node,$true)
        if ($clone.LocalName -eq "line") {
          if ([string]::IsNullOrWhiteSpace($clone.GetAttribute("data-termodel-layer"))) {
            $clone.SetAttribute("data-termodel-layer",[string]$floor.cadLayer)
          }
          if ([string]::IsNullOrWhiteSpace($clone.GetAttribute("data-termodel-linetype"))) {
            $localType = $clone.GetAttribute("data-termodel-tipo-linea")
            if ($localType) { $clone.SetAttribute("data-termodel-linetype",$localType) }
          }
          if ([string]::IsNullOrWhiteSpace($clone.GetAttribute("data-termodel-color"))) {
            $localColor = $clone.GetAttribute("data-termodel-colore")
            if ($localColor -match "^\s*(\d+)") { $clone.SetAttribute("data-termodel-color",$Matches[1]) }
          }
        } elseif ([string]::IsNullOrWhiteSpace($clone.GetAttribute("data-termodel-layer"))) {
          $clone.SetAttribute("data-termodel-layer",[string]$floor.cadLayer)
        }

        $group.AppendChild($clone) | Out-Null
      }
    }
    $root.AppendChild($group) | Out-Null
  }

  $projectText = Set-ProjectSection $projectText "geometry/project.svg" $out.OuterXml
  foreach ($section in @($manifest.sections)) {
    $name = [string]$section.name
    if ($name.StartsWith("assets/backgrounds/",[System.StringComparison]::OrdinalIgnoreCase)) {
      $projectText = Remove-ProjectSection $projectText $name
    }
  }
  return Refresh-Manifest $projectText
}

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

  $serverProject = Build-CanonicalServerProject $projectText
  if ($serverProject -notmatch 'data-termodel-format="TERMODEL-PROJECT-SVG-V1"' -or
      $serverProject -notmatch 'data-termodel-units="cm"') {
    throw "Banco prova appartamento: canonicalizzazione frontend non riuscita."
  }

  [System.IO.File]::WriteAllText(
    (Join-Path $artifactDir "server-payload.tmdl"),
    $serverProject,
    [System.Text.UTF8Encoding]::new($false))

  $service = Start-ServiceProcess

  $svgPath = Join-Path $artifactDir "pannelli-esecutivo.svg"
  $response = Invoke-WebRequest `
    -Uri "$base/api/calculations?responseArtifact=pannelli-esecutivo-svg" `
    -Method Post `
    -ContentType "text/plain; charset=utf-8" `
    -Body $serverProject `
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
  if ($svgText -notmatch 'data-layer="Unico_PiantaPulita_Output"') {
    throw "Banco prova appartamento: esecutivo privo della pianta pulita incorporata."
  }
  if ($svgText -match 'data-layer="Unico_Edificio_Output"') {
    throw "Banco prova appartamento: usato il vecchio fallback edificio a linee invece della pianta pulita."
  }

  [xml]$svgDocument = $svgText
  $cleanFloorGroup = @($svgDocument.DocumentElement.ChildNodes | Where-Object {
    $_.NodeType -eq [System.Xml.XmlNodeType]::Element -and
    $_.GetAttribute("data-layer") -eq "Unico_PiantaPulita_Output"
  } | Select-Object -First 1)
  if (-not $cleanFloorGroup) {
    throw "Banco prova appartamento: gruppo pianta pulita non trovato nell'SVG."
  }
  $cleanBoundaries = @($cleanFloorGroup.ChildNodes | Where-Object {
    $_.NodeType -eq [System.Xml.XmlNodeType]::Element -and
    $_.LocalName -in @("polyline","polygon")
  })
  if ($cleanBoundaries.Count -lt 2) {
    throw "Banco prova appartamento: la pianta pulita deve mostrare almeno due contorni per rendere visibile lo spessore delle pareti."
  }

  # Regression definitiva primo tratto mandata (rettifica utente 25/09/2026):
  # la distanza minima tubo-parete e' p/2. Con p=0,30 m il primo tratto
  # dentro il locale deve quindi fermarsi a 0,15 m dalla parete di ingresso.
  # Anche alla prima svolta verso la parete destra resta valida la distanza
  # architettonica minima p/2; non va forzato l'offset errato di 0,45 m.
  $supplyGroup = @($svgDocument.DocumentElement.ChildNodes | Where-Object {
    $_.NodeType -eq [System.Xml.XmlNodeType]::Element -and
    $_.GetAttribute("data-layer") -eq "Unico_PannelliMandata_Output"
  } | Select-Object -First 1)
  if (-not $supplyGroup) {
    throw "Banco prova appartamento: gruppo mandata non trovato nell'SVG."
  }
  $supplyPolyline = @($supplyGroup.ChildNodes | Where-Object {
    $_.NodeType -eq [System.Xml.XmlNodeType]::Element -and
    $_.LocalName -eq "polyline"
  } | Select-Object -First 1)
  if (-not $supplyPolyline) {
    throw "Banco prova appartamento: polilinea mandata non trovata."
  }

  $supplyPoints = @($supplyPolyline.GetAttribute("points") -split "\s+" |
    Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
  if ($supplyPoints.Count -lt 3) {
    throw "Banco prova appartamento: mandata priva del primo cambio direzione."
  }

  function Parse-SvgPoint([string]$token) {
    $parts = $token.Split(",")
    if ($parts.Count -ne 2) { throw "Punto SVG non valido: $token" }
    return @(
      [double]::Parse($parts[0],[Globalization.CultureInfo]::InvariantCulture),
      [double]::Parse($parts[1],[Globalization.CultureInfo]::InvariantCulture)
    )
  }

  $p0 = Parse-SvgPoint $supplyPoints[0]
  $p1 = Parse-SvgPoint $supplyPoints[1]
  $p2 = Parse-SvgPoint $supplyPoints[2]

  $firstEntryLength = [Math]::Sqrt(
    [Math]::Pow($p1[0]-$p0[0],2) +
    [Math]::Pow($p1[1]-$p0[1],2))
  if ([Math]::Abs($firstEntryLength - 0.15) -gt 0.02) {
    throw "Banco prova appartamento: ingresso mandata inatteso ($firstEntryLength m), atteso circa 0,15 m = p/2."
  }
  if ([Math]::Abs($p2[0] - 7.98148) -gt 0.02) {
    throw "Banco prova appartamento: primo tratto dopo la svolta termina a x=$($p2[0]) m; atteso circa 7,98148 m, cioe' 0,15 m dalla parete destra."
  }


  $generated = Invoke-RestMethod -Uri "$base/api/projects/$projectId/generated-files" -Method Get
  $generated | ConvertTo-Json -Depth 100 |
    Set-Content -LiteralPath (Join-Path $artifactDir "generated-files.json") -Encoding utf8

  $projectDir = Join-Path $env:TERMODEL_SAVED_PROJECTS_DIR $projectId
  if (-not (Test-Path -LiteralPath $projectDir)) { throw "Banco prova appartamento: workspace projectId non trovato." }

  foreach ($relative in @(
    "artifacts/pannelli.json",
    "artifacts/pannelli-esecutivo.dxf",
    "artifacts/pianta-pulita/Unico.svg",
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
