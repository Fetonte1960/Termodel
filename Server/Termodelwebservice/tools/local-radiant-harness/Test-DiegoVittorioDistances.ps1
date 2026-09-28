param(
    [Parameter(Mandatory = $true)]
    [string]$SvgPath,
    [double]$StepMeters = 0.30,
    [double]$Tolerance = 0.002
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $SvgPath -PathType Leaf)) {
    throw "SVG non trovato: $SvgPath"
}

[xml]$document = Get-Content -LiteralPath $SvgPath -Raw
$polylines = @($document.SelectNodes("//*[local-name()='polyline']"))
$supplyNode = $polylines | Where-Object { $_.stroke -eq "red" } | Select-Object -First 1
$returnNode = $polylines | Where-Object { $_.stroke -eq "blue" } | Select-Object -First 1
if ($null -eq $supplyNode -or $null -eq $returnNode) {
    throw "SVG privo delle polilinee Supply/Return attese."
}

function Convert-Points([string]$Text) {
    $culture = [Globalization.CultureInfo]::InvariantCulture
    $result = @()
    foreach ($pair in ($Text.Trim() -split '\s+')) {
        $parts = $pair -split ','
        if ($parts.Count -ne 2) { continue }
        $result += [pscustomobject]@{
            X = [double]::Parse($parts[0], $culture)
            Y = [double]::Parse($parts[1], $culture)
        }
    }
    return $result
}

function Assert-Coordinate(
    [object[]]$Points,
    [ValidateSet("X", "Y")][string]$Axis,
    [double]$Expected,
    [string]$Rule) {
    $found = $Points | Where-Object {
        [Math]::Abs(([double]($_.$Axis)) - $Expected) -le $Tolerance
    } | Select-Object -First 1
    if ($null -eq $found) {
        throw "${Rule}: coordinata $Axis=$Expected non trovata entro tolleranza $Tolerance."
    }
}

$supply = @(Convert-Points ([string]$supplyNode.points))
$return = @(Convert-Points ([string]$returnNode.points))

if ([double]::IsNaN($StepMeters) -or [double]::IsInfinity($StepMeters) -or $StepMeters -le 0) {
    throw "StepMeters deve essere finito e positivo."
}

$halfStep = $StepMeters / 2.0
$doubleStep = $StepMeters * 2.0
$wallReturn = $halfStep + $StepMeters

# Funzione realizzata da Codex in autonomia: regression geometrica specifica
# del quadrato Git 4x4/T1 a passo variabile, usato come riferimento prestazionale.
foreach ($value in @($halfStep, (4.0 - $halfStep))) {
    Assert-Coordinate $supply "X" $value "parete-Supply=p/2"
    Assert-Coordinate $supply "Y" $value "parete-Supply=p/2"
}
foreach ($value in @(($halfStep + $doubleStep), (4.0 - $halfStep - $doubleStep))) {
    Assert-Coordinate $supply "X" $value "Supply-Supply=2p"
    Assert-Coordinate $supply "Y" $value "Supply-Supply=2p"
}
foreach ($value in @($wallReturn, (4.0 - $wallReturn))) {
    Assert-Coordinate $return "X" $value "Supply-Return=p"
    Assert-Coordinate $return "Y" $value "Supply-Return=p"
}
foreach ($value in @(($wallReturn + $doubleStep), (4.0 - $wallReturn - $doubleStep))) {
    Assert-Coordinate $return "X" $value "Return successivo conforme"
    Assert-Coordinate $return "Y" $value "Return successivo conforme"
}

$report = [ordered]@{
    status = "ok"
    fixture = "StrategiaDiegoSquare4x4.locale.xml"
    stepMeters = $StepMeters
    wallSupplyMeters = $halfStep
    supplySupplyMeters = $doubleStep
    supplyReturnMeters = $StepMeters
    wallReturnMeters = $wallReturn
    returnReturnObservedMeters = $doubleStep
    returnReturnMinimumMeters = $StepMeters
    supplyPoints = $supply.Count
    returnPoints = $return.Count
    svgSha256 = (Get-FileHash -LiteralPath $SvgPath -Algorithm SHA256).Hash
}

$report | ConvertTo-Json
