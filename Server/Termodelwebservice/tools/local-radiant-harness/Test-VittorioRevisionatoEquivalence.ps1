param(
  [string]$Configuration = "Release",
  [string]$OutputRoot = ""
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($OutputRoot)) {
  $OutputRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("VittorioRevisionatoMultiProject-" + [guid]::NewGuid().ToString("N"))
}

$OutputRoot = [System.IO.Path]::GetFullPath($OutputRoot)
New-Item -ItemType Directory -Force -Path $OutputRoot | Out-Null

$project = "tools/Termodel.RadiantPanels.Harness/Termodel.RadiantPanels.Harness.csproj"

$cases = @(
  [pscustomobject]@{
    Id = "square-4x4"
    Input = "tests/fixtures/StrategiaDiegoSquare4x4.locale.xml"
  },
  [pscustomobject]@{
    Id = "concave-l"
    Input = "tests/fixtures/StrategiaDiegoConcaveL.locale.xml"
  },
  [pscustomobject]@{
    Id = "oblique-trapezoid"
    Input = "tests/fixtures/StrategiaDiegoObliqueTrapezoid.locale.xml"
  },
  [pscustomobject]@{
    Id = "connection-terminal"
    Input = "tests/fixtures/StrategiaDiegoConnectionTerminal.locale.xml"
  },
  [pscustomobject]@{
    Id = "current-apartment"
    Input = "tests/radiant-harness/prepared/StrategiaDiegoCurrentApartment.pannelli.xml"
  },
  [pscustomobject]@{
    Id = "public-radiant-panels"
    Input = "tests/radiant-harness/prepared/PannelliRadiantiPublic.pannelli.xml"
  }
)

$results = @()

foreach ($case in $cases) {
  $caseRoot = Join-Path $OutputRoot $case.Id
  $vittorioOut = Join-Path $caseRoot "vittorio"
  $revisionatoOut = Join-Path $caseRoot "revisionato"
  New-Item -ItemType Directory -Force -Path $vittorioOut | Out-Null
  New-Item -ItemType Directory -Force -Path $revisionatoOut | Out-Null

  $vId = "VR-EQ-$($case.Id)-VITTORIO"
  $rId = "VR-EQ-$($case.Id)-REVISIONATO"

  Write-Host "=== $($case.Id): Vittorio ==="
  $vArgs = @("run","--input",$case.Input,"--engine","Vittorio","--id",$vId,"--out",$vittorioOut)
  & dotnet run --project $project -c $Configuration --no-build -- @vArgs
  if ($LASTEXITCODE -ne 0) {
    throw "Vittorio fallito sul caso $($case.Id)."
  }

  Write-Host "=== $($case.Id): Vittorio_revisionato ==="
  $rArgs = @("run","--input",$case.Input,"--engine","Vittorio_revisionato","--id",$rId,"--out",$revisionatoOut)
  & dotnet run --project $project -c $Configuration --no-build -- @rArgs
  if ($LASTEXITCODE -ne 0) {
    throw "Vittorio_revisionato fallito sul caso $($case.Id)."
  }

  $vSvg = Join-Path $vittorioOut "$vId.svg"
  $rSvg = Join-Path $revisionatoOut "$rId.svg"
  $vXml = Join-Path $vittorioOut "$vId.result.locale.xml"
  $rXml = Join-Path $revisionatoOut "$rId.result.locale.xml"

  foreach ($path in @($vSvg,$rSvg,$vXml,$rXml)) {
    if (-not (Test-Path -LiteralPath $path)) {
      throw "Artifact equivalenza mancante per $($case.Id): $path"
    }
  }

  $vSvgHash = (Get-FileHash -LiteralPath $vSvg -Algorithm SHA256).Hash
  $rSvgHash = (Get-FileHash -LiteralPath $rSvg -Algorithm SHA256).Hash
  $vXmlHash = (Get-FileHash -LiteralPath $vXml -Algorithm SHA256).Hash
  $rXmlHash = (Get-FileHash -LiteralPath $rXml -Algorithm SHA256).Hash

  $svgEqual = $vSvgHash -eq $rSvgHash
  $xmlEqual = $vXmlHash -eq $rXmlHash

  $results += [pscustomobject]@{
    id = $case.Id
    input = $case.Input
    svgEqual = $svgEqual
    xmlEqual = $xmlEqual
    svgSha256 = $vSvgHash
    xmlSha256 = $vXmlHash
  }

  if (-not $svgEqual) {
    throw "Equivalenza SVG fallita per $($case.Id): Vittorio=$vSvgHash Revisionato=$rSvgHash"
  }
  if (-not $xmlEqual) {
    throw "Equivalenza XML fallita per $($case.Id): Vittorio=$vXmlHash Revisionato=$rXmlHash"
  }

  Write-Host "VITTORIO_REVISIONATO_EQUIVALENCE_OK case=$($case.Id) SVG=$vSvgHash XML=$vXmlHash"
}

$reportPath = Join-Path $OutputRoot "equivalence-report.json"
$report = [ordered]@{
  format = "TERMODEL-VITTORIO-REVISIONATO-EQUIVALENCE-V1"
  comparedEngine = "Vittorio_revisionato"
  referenceEngine = "Vittorio"
  caseCount = @($results).Count
  allEquivalent = (@($results | Where-Object { -not $_.svgEqual -or -not $_.xmlEqual }).Count -eq 0)
  cases = $results
}
[System.IO.File]::WriteAllText(
  $reportPath,
  ($report | ConvertTo-Json -Depth 6),
  [System.Text.UTF8Encoding]::new($false))

Write-Host "VITTORIO_REVISIONATO_MULTI_PROJECT_EQUIVALENCE_OK cases=$(@($results).Count)"
Write-Host "report=$reportPath"
