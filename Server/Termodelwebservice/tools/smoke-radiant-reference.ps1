$ErrorActionPreference = "Stop"

$base = "http://127.0.0.1:5082"
$env:ASPNETCORE_URLS = $base
$env:TERMODEL_SAVED_PROJECTS_DIR = Join-Path $env:RUNNER_TEMP ("TermodelRadiantReference-" + [guid]::NewGuid().ToString("N"))
$artifactDir = Join-Path $env:RUNNER_TEMP "RadiantPanelsReferenceArtifacts"
New-Item -ItemType Directory -Path $env:TERMODEL_SAVED_PROJECTS_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $artifactDir -Force | Out-Null

function Read-Fixture {
  $parts = 1..4 | ForEach-Object {
    Join-Path $PSScriptRoot ("..\tests\fixtures\RadiantPanelsReference.original.part0" + $_ + ".txt")
  }
  foreach ($path in $parts) {
    if (-not (Test-Path -LiteralPath $path)) { throw "Fixture mancante: $path" }
  }
  return (($parts | ForEach-Object {
    [System.IO.File]::ReadAllText((Resolve-Path $_),[System.Text.UTF8Encoding]::new($false))
  }) -join "`n")
}

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

function Refresh-Manifest([string]$projectText,[string]$projectId = "") {
  $manifest = Get-ProjectSection $projectText "manifest.json" | ConvertFrom-Json
  if ($projectId) {
    $manifest | Add-Member -NotePropertyName projectId -NotePropertyValue $projectId -Force
  }
  $manifest.projectName = "Riferimento pannelli radianti"
  $manifest.generatedAtUtc = [DateTime]::UtcNow.ToString("o")

  $kept = @()
  $definitionHash = ""
  foreach ($section in @($manifest.sections)) {
    $name = [string]$section.name
    if ($name.StartsWith("assets/backgrounds/",[System.StringComparison]::OrdinalIgnoreCase)) { continue }
    $body = Get-ProjectSection $projectText $name
    $section.sha256 = Get-Sha256Text $body
    if ($name -eq [string]$manifest.databaseDefinition.path) {
      $definitionHash = [string]$section.sha256
    }
    $kept += $section
  }
  $manifest.sections = @($kept)
  if ($definitionHash -and $manifest.databaseDefinition) {
    $manifest.databaseDefinition.sha256 = $definitionHash
  }
  $json = $manifest | ConvertTo-Json -Depth 100
  return Set-ProjectSection $projectText "manifest.json" $json
}

function Apply-CircuitMetadata([string]$projectText) {
  $mapPath = Join-Path $PSScriptRoot "..\tests\fixtures\RadiantPanelsReference.circuit-map.json"
  $map = Get-Content -LiteralPath $mapPath -Raw | ConvertFrom-Json
  $geometry = Get-ProjectSection $projectText "geometry/project.svg"

  foreach ($circuit in @($map.circuits)) {
    foreach ($segment in @($circuit.segments)) {
      $id = [regex]::Escape([string]$segment)
      $pattern = '(<line\s+id="' + $id + '"[^>]*?data-termodel-rete="[^"]+")'
      $replacement = '$1 data-termodel-circuito="' + [string]$circuit.circuitCode + '"'
      $updated = [regex]::Replace(
        $geometry,
        $pattern,
        $replacement,
        [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
      if ($updated -eq $geometry) {
        throw "Impossibile assegnare circuito $($circuit.circuitCode) al segmento $segment."
      }
      $geometry = $updated
    }
  }

  return Set-ProjectSection $projectText "geometry/project.svg" $geometry
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
    $safeId = ([string]$floor.id) -replace '[^A-Za-z0-9_-]+','_'
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
          if (-not $firstTspan -or [string]$firstTspan.InnerText -notmatch '^\s*BLOCCO\s*,') { continue }
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
            if ($localColor -match '^\s*(\d+)') { $clone.SetAttribute("data-termodel-color",$Matches[1]) }
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

function Set-ProjectId([string]$projectText,[string]$projectId) {
  return Refresh-Manifest $projectText $projectId
}

function Start-ServiceProcess {
  $outLog = Join-Path $artifactDir "service.stdout.log"
  $errLog = Join-Path $artifactDir "service.stderr.log"
  $p = Start-Process dotnet -ArgumentList @(
    "run",
    "--project","src/Termodel.WebService/Termodel.WebService.csproj",
    "--configuration","Release",
    "--no-build",
    "--no-launch-profile") -RedirectStandardOutput $outLog -RedirectStandardError $errLog -PassThru

  for ($attempt = 0; $attempt -lt 50; $attempt++) {
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
  $original = Read-Fixture
  if ($original -notmatch '\[TERMODEL-PROJECT-TEXT-V1\]' -or
      $original -notmatch 'data-termodel-rete="RAD-DEFAULT"') {
    throw "Fixture reale pannelli non ricomposta correttamente."
  }

  $correctedLocal = Apply-CircuitMetadata $original
  [System.IO.File]::WriteAllText(
    (Join-Path $artifactDir "RadiantPanelsReference.corrected-local.tmdl.txt"),
    $correctedLocal,
    [System.Text.UTF8Encoding]::new($false))

  $serverProject = Build-CanonicalServerProject $correctedLocal
  if ($serverProject -notmatch 'data-termodel-format="TERMODEL-PROJECT-SVG-V1"' -or
      $serverProject -notmatch 'data-termodel-units="cm"') {
    throw "Canonicalizzazione fixture non ha prodotto TERMODEL-PROJECT-SVG-V1."
  }
  if ($serverProject -match 'assets/backgrounds/') {
    throw "Il payload Service regression contiene ancora gli sfondi locali."
  }

  $appJs = Get-Content -LiteralPath (Join-Path $PSScriptRoot "..\..\..\docs\termodel-ui-demo\app.js") -Raw
  if ($appJs -notmatch "data-termodel-circuito" -or
      $appJs -notmatch "cadNextPipeCircuitId") {
    throw "Frontend corrente non assegna l'identità circuito alle sequenze Tubo."
  }

  $service = Start-ServiceProcess

  $allocation = Invoke-RestMethod -Uri "$base/api/projects/allocate-id" -Method Post
  $serverProject = Set-ProjectId $serverProject ([string]$allocation.projectId)
  [System.IO.File]::WriteAllText(
    (Join-Path $artifactDir "RadiantPanelsReference.server-payload.tmdl.txt"),
    $serverProject,
    [System.Text.UTF8Encoding]::new($false))

  $headers = @{ "X-Termodel-Project-Lock" = [string]$allocation.projectLockToken }
  $calc = Invoke-RestMethod -Uri "$base/api/calculations" -Method Post -Headers $headers -ContentType "text/plain; charset=utf-8" -Body $serverProject

  if (@($calc.artifacts.name) -notcontains "pannelli") {
    throw "Calcolo reale privo di pannelli.json."
  }

  $projectDir = Join-Path $env:TERMODEL_SAVED_PROJECTS_DIR ([string]$allocation.projectId)
  $panelsPath = Join-Path $projectDir "artifacts\pannelli.json"
  if (-not (Test-Path -LiteralPath $panelsPath)) { throw "pannelli.json non persistito." }

  $panels = Get-Content -LiteralPath $panelsPath -Raw | ConvertFrom-Json
  if ($panels.format -ne "TermodelRadiantPanels" -or
      $panels.version -ne 1 -or
      $panels.status -ne "completed") {
    throw "Artifact pannelli reale non valido."
  }
  if ($panels.networkCount -ne 1 -or $panels.circuitCount -ne 6) {
    throw "Fixture reale: attesi 1 rete e 6 circuiti, ottenuti $($panels.networkCount) rete/i e $($panels.circuitCount) circuito/i."
  }

  $mapPath = Join-Path $PSScriptRoot "..\tests\fixtures\RadiantPanelsReference.circuit-map.json"
  $map = Get-Content -LiteralPath $mapPath -Raw | ConvertFrom-Json
  $network = @($panels.networks)[0]
  if ($network.networkCode -ne "RAD-DEFAULT") { throw "Rete artifact inattesa." }

  $total = 0.0
  foreach ($expected in @($map.circuits)) {
    $wantedId = "RAD-DEFAULT/Unico/" + [string]$expected.circuitCode
    $actual = @($network.circuits | Where-Object { $_.circuitId -eq $wantedId })
    if ($actual.Count -ne 1) { throw "Circuito $wantedId non trovato una sola volta." }
    $circuit = $actual[0]
    $expectedSegments = @($expected.segments).Count
    if ($circuit.segmentCount -ne $expectedSegments) {
      throw "${wantedId}: segmentCount atteso $expectedSegments, ottenuto $($circuit.segmentCount)."
    }
    if ([bool]$circuit.branched) { throw "$wantedId risulta ancora ramificato." }
    if ([Math]::Abs([double]$circuit.geometricLengthM - [double]$expected.expectedLengthM) -gt 0.00001) {
      throw "${wantedId}: lunghezza inattesa $($circuit.geometricLengthM) m."
    }
    if ([double]$circuit.flowLitersHour -le 0 -or [double]$circuit.pressureLossPa -le 0) {
      throw "${wantedId}: kernel idraulico non ha prodotto valori positivi."
    }
    $total += [double]$circuit.geometricLengthM
  }

  if ([Math]::Abs($total - [double]$map.expectedTotalLengthM) -gt 0.00002) {
    throw "Lunghezza totale circuiti inattesa: $total m."
  }

  if (@($network.diagnostics | Where-Object { $_ -match "Topologia ramificata" }).Count -gt 0) {
    throw "La fixture corretta conserva diagnostica di topologia ramificata."
  }

  $expectedGenerated = @("pannelli-esecutivo-svg","pannelli-esecutivo-dxf")
  foreach ($artifactName in $expectedGenerated) {
    if (@($calc.artifacts.name) -notcontains $artifactName) {
      throw "Fixture reale: artifact $artifactName non generato."
    }
  }

  foreach ($name in @(
    "pannelli.json",
    "pannelli-esecutivo.svg",
    "pannelli-esecutivo.dxf"
  )) {
    $source = Join-Path $projectDir ("artifacts\" + $name)
    if (Test-Path -LiteralPath $source) {
      Copy-Item -LiteralPath $source -Destination (Join-Path $artifactDir $name) -Force
    }
  }
  foreach ($name in @("TermodelLog.md","diagnostics.txt","calculation.log")) {
    $source = Join-Path $projectDir ("logs\" + $name)
    if (Test-Path -LiteralPath $source) {
      Copy-Item -LiteralPath $source -Destination (Join-Path $artifactDir $name) -Force
    }
  }

  $logPath = Join-Path $projectDir "logs\TermodelLog.md"
  if (Test-Path -LiteralPath $logPath) {
    $log = Get-Content -LiteralPath $logPath -Raw
    if ($log -notmatch "Letti 12 tubi dal layer Unico_tubipannelli") {
      throw "Log Core non conferma i 12 tubi della fixture reale."
    }
  }

  Write-Host "RADIANT_REFERENCE_PROJECT_OK"
  Write-Host "networkCount=$($panels.networkCount)"
  Write-Host "circuitCount=$($panels.circuitCount)"
  Write-Host ("totalLengthM=" + $total.ToString("0.############",[Globalization.CultureInfo]::InvariantCulture))
}
finally {
  Stop-ServiceProcess $service
  if (Test-Path $env:TERMODEL_SAVED_PROJECTS_DIR) {
    Remove-Item -LiteralPath $env:TERMODEL_SAVED_PROJECTS_DIR -Recurse -Force -ErrorAction SilentlyContinue
  }
}
