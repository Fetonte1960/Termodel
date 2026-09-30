param(
  [string]$Configuration = "Release",
  [string]$OutputRoot = ""
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($OutputRoot)) {
  $OutputRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("VittorioRevisionatoBase-" + [guid]::NewGuid().ToString("N"))
}

$OutputRoot = [System.IO.Path]::GetFullPath($OutputRoot)
New-Item -ItemType Directory -Force -Path $OutputRoot | Out-Null

$project = "tools/Termodel.RadiantPanels.Harness/Termodel.RadiantPanels.Harness.csproj"

$cases = @(
  [pscustomobject]@{ Id = "square-4x4"; Input = "tests/fixtures/StrategiaDiegoSquare4x4.locale.xml" },
  [pscustomobject]@{ Id = "concave-l"; Input = "tests/fixtures/StrategiaDiegoConcaveL.locale.xml" },
  [pscustomobject]@{ Id = "oblique-trapezoid"; Input = "tests/fixtures/StrategiaDiegoObliqueTrapezoid.locale.xml" },
  [pscustomobject]@{ Id = "connection-terminal"; Input = "tests/fixtures/StrategiaDiegoConnectionTerminal.locale.xml" },
  [pscustomobject]@{ Id = "current-apartment"; Input = "tests/radiant-harness/prepared/StrategiaDiegoCurrentApartment.pannelli.xml" },
  [pscustomobject]@{ Id = "public-radiant-panels"; Input = "tests/radiant-harness/prepared/PannelliRadiantiPublic.pannelli.xml" }
)

function Get-BlueReturnPoints([string]$SvgPath) {
  [xml]$svg = Get-Content -LiteralPath $SvgPath -Raw
  $nodes = $svg.SelectNodes("//*[local-name()='polyline' and @stroke='blue']")
  return @($nodes | ForEach-Object { [string]$_.points })
}

$results = @()

foreach ($case in $cases) {
  $caseRoot = Join-Path $OutputRoot $case.Id
  $vOut = Join-Path $caseRoot "vittorio"
  $rOut = Join-Path $caseRoot "revisionato-base"
  New-Item -ItemType Directory -Force -Path $vOut | Out-Null
  New-Item -ItemType Directory -Force -Path $rOut | Out-Null

  $vId = "VR-BASE-$($case.Id)-VITTORIO"
  $rId = "VR-BASE-$($case.Id)-REVISIONATO"

  $vArgs = @("run","--input",$case.Input,"--engine","Vittorio","--id",$vId,"--out",$vOut)
  & dotnet run --project $project -c $Configuration --no-build -- @vArgs
  if ($LASTEXITCODE -ne 0) { throw "Vittorio fallito sul caso $($case.Id)." }

  $rArgs = @("run","--input",$case.Input,"--engine","Vittorio_revisionato","--revisionato-vittorio-base","--id",$rId,"--out",$rOut)
  & dotnet run --project $project -c $Configuration --no-build -- @rArgs
  if ($LASTEXITCODE -ne 0) { throw "Vittorio_revisionato base fallito sul caso $($case.Id)." }

  $vSvg = Join-Path $vOut "$vId.svg"
  $rSvg = Join-Path $rOut "$rId.svg"
  $vXml = Join-Path $vOut "$vId.result.locale.xml"
  $rXml = Join-Path $rOut "$rId.result.locale.xml"

  foreach ($p in @($vSvg,$rSvg,$vXml,$rXml)) {
    if (-not (Test-Path -LiteralPath $p)) { throw "Artifact base mancante: $p" }
  }

  $vXmlHash = (Get-FileHash -LiteralPath $vXml -Algorithm SHA256).Hash
  $rXmlHash = (Get-FileHash -LiteralPath $rXml -Algorithm SHA256).Hash
  if ($vXmlHash -ne $rXmlHash) {
    throw "BASE VITTORIO: Mandata/XML divergente per $($case.Id): Vittorio=$vXmlHash Revisionato=$rXmlHash"
  }

  $vReturns = @(Get-BlueReturnPoints $vSvg)
  $rReturns = @(Get-BlueReturnPoints $rSvg)

  if ($vReturns.Count -ne $rReturns.Count) {
    throw "BASE VITTORIO: numero Return divergente per $($case.Id): Vittorio=$($vReturns.Count) Revisionato=$($rReturns.Count)"
  }

  for ($i = 0; $i -lt $vReturns.Count; $i++) {
    if ($vReturns[$i] -ne $rReturns[$i]) {
      throw "BASE VITTORIO: Return $i divergente per $($case.Id)."
    }
  }

  $results += [pscustomobject]@{
    id = $case.Id
    input = $case.Input
    supplyXmlEqual = $true
    returnPolylineEqual = $true
    returnCount = $vReturns.Count
    xmlSha256 = $vXmlHash
  }

  Write-Host "VITTORIO_REVISIONATO_BASE_OK case=$($case.Id) returns=$($vReturns.Count) XML=$vXmlHash"
}

$reportPath = Join-Path $OutputRoot "vittorio-base-report.json"
$report = [ordered]@{
  format = "TERMODEL-VITTORIO-REVISIONATO-BASE-V1"
  invariant = "Vittorio_revisionato before closure/fillet improvements == Vittorio Supply + Return"
  caseCount = @($results).Count
  allEquivalent = $true
  cases = $results
}
[System.IO.File]::WriteAllText(
  $reportPath,
  ($report | ConvertTo-Json -Depth 6),
  [System.Text.UTF8Encoding]::new($false))

Write-Host "VITTORIO_REVISIONATO_BASE_MATRIX_OK cases=$(@($results).Count)"
Write-Host "report=$reportPath"
