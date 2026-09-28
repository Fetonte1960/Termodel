param(
    [Parameter(Mandatory = $true)]
    [string]$SvgPath,
    [double]$StepMeters = 0.30,
    [double]$ToleranceMeters = 0.002,
    [ValidateSet("left", "right")]
    [string]$ReturnSide = "left"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Read-Points([string]$Value) {
    $points = New-Object System.Collections.Generic.List[object]
    foreach ($token in ($Value.Trim() -split '\s+')) {
        if ([string]::IsNullOrWhiteSpace($token)) { continue }
        $xy = $token.Split(',')
        $points.Add([pscustomobject]@{
            X = [double]::Parse($xy[0], [Globalization.CultureInfo]::InvariantCulture)
            Y = [double]::Parse($xy[1], [Globalization.CultureInfo]::InvariantCulture)
        })
    }
    return $points
}

function Orientation($a, $b, $c) {
    return ($b.X - $a.X) * ($c.Y - $a.Y) - ($b.Y - $a.Y) * ($c.X - $a.X)
}

function Point-On-Segment($p, $a, $b) {
    $eps = 0.0000001
    return $p.X -ge [Math]::Min($a.X, $b.X) - $eps -and
        $p.X -le [Math]::Max($a.X, $b.X) + $eps -and
        $p.Y -ge [Math]::Min($a.Y, $b.Y) - $eps -and
        $p.Y -le [Math]::Max($a.Y, $b.Y) + $eps
}

function Segments-Intersect($a0, $a1, $b0, $b1) {
    $eps = 0.0000001
    $o1 = Orientation $a0 $a1 $b0
    $o2 = Orientation $a0 $a1 $b1
    $o3 = Orientation $b0 $b1 $a0
    $o4 = Orientation $b0 $b1 $a1
    if ((($o1 -gt $eps -and $o2 -lt -$eps) -or ($o1 -lt -$eps -and $o2 -gt $eps)) -and
        (($o3 -gt $eps -and $o4 -lt -$eps) -or ($o3 -lt -$eps -and $o4 -gt $eps))) {
        return $true
    }
    return ([Math]::Abs($o1) -le $eps -and (Point-On-Segment $b0 $a0 $a1)) -or
        ([Math]::Abs($o2) -le $eps -and (Point-On-Segment $b1 $a0 $a1)) -or
        ([Math]::Abs($o3) -le $eps -and (Point-On-Segment $a0 $b0 $b1)) -or
        ([Math]::Abs($o4) -le $eps -and (Point-On-Segment $a1 $b0 $b1))
}

function Point-Segment-Distance($p, $a, $b) {
    $dx = $b.X - $a.X
    $dy = $b.Y - $a.Y
    $lengthSquared = $dx * $dx + $dy * $dy
    if ($lengthSquared -le 0.000000000001) {
        return [Math]::Sqrt(($p.X - $a.X) * ($p.X - $a.X) + ($p.Y - $a.Y) * ($p.Y - $a.Y))
    }
    $t = (($p.X - $a.X) * $dx + ($p.Y - $a.Y) * $dy) / $lengthSquared
    $t = [Math]::Max(0.0, [Math]::Min(1.0, $t))
    $x = $a.X + $t * $dx
    $y = $a.Y + $t * $dy
    return [Math]::Sqrt(($p.X - $x) * ($p.X - $x) + ($p.Y - $y) * ($p.Y - $y))
}

function Segment-Distance($a0, $a1, $b0, $b1) {
    if (Segments-Intersect $a0 $a1 $b0 $b1) { return 0.0 }
    return [Math]::Min(
        [Math]::Min((Point-Segment-Distance $a0 $b0 $b1), (Point-Segment-Distance $a1 $b0 $b1)),
        [Math]::Min((Point-Segment-Distance $b0 $a0 $a1), (Point-Segment-Distance $b1 $a0 $a1)))
}

if (-not (Test-Path -LiteralPath $SvgPath -PathType Leaf)) {
    throw "SVG non trovato: $SvgPath"
}

[xml]$svg = Get-Content -LiteralPath $SvgPath -Raw
$namespace = New-Object Xml.XmlNamespaceManager($svg.NameTable)
$namespace.AddNamespace("s", "http://www.w3.org/2000/svg")
$supplyNode = $svg.SelectSingleNode('//s:polyline[@stroke="red"]', $namespace)
$returnNode = $svg.SelectSingleNode('//s:polyline[@stroke="blue"]', $namespace)
if ($null -eq $supplyNode -or $null -eq $returnNode) {
    throw "Polilinee mandata/ritorno non trovate in $SvgPath"
}

$supply = Read-Points $supplyNode.points
$return = Read-Points $returnNode.points
if ($supply.Count -lt 2 -or $return.Count -lt 2) {
    throw "Mandata o ritorno non contengono il raccordo iniziale completo."
}

# Modificato da Codex per realizzare: verificare esplicitamente che il ritorno
# inizi dal parallelo gemello del tubo d'ingresso della mandata.
$entryDx = $supply[1].X - $supply[0].X
$entryDy = $supply[1].Y - $supply[0].Y
$entryLength = [Math]::Sqrt($entryDx * $entryDx + $entryDy * $entryDy)
if ($entryLength -le 0.0000001) {
    throw "Il primo tratto della mandata non definisce una direzione valida."
}
$entryUx = $entryDx / $entryLength
$entryUy = $entryDy / $entryLength
if ($ReturnSide -eq "left") {
    $normalX = -$entryUy
    $normalY = $entryUx
}
else {
    $normalX = $entryUy
    $normalY = -$entryUx
}
$expectedRootX = $supply[0].X + $normalX * $StepMeters
$expectedRootY = $supply[0].Y + $normalY * $StepMeters
$expectedInnerX = $expectedRootX + $entryUx * ($entryLength + $StepMeters)
$expectedInnerY = $expectedRootY + $entryUy * ($entryLength + $StepMeters)
$rootError = [Math]::Sqrt(
    ($return[0].X - $expectedRootX) * ($return[0].X - $expectedRootX) +
    ($return[0].Y - $expectedRootY) * ($return[0].Y - $expectedRootY))
$innerError = [Math]::Sqrt(
    ($return[1].X - $expectedInnerX) * ($return[1].X - $expectedInnerX) +
    ($return[1].Y - $expectedInnerY) * ($return[1].Y - $expectedInnerY))
if ($rootError -gt $ToleranceMeters -or $innerError -gt $ToleranceMeters) {
    throw "Raccordo ritorno non gemello dell'ingresso mandata: errori radice=$rootError m, interno=$innerError m."
}

$minSupplyReturn = [double]::PositiveInfinity
$minSupplyReturnPair = ""
for ($i = 0; $i -lt $supply.Count - 1; $i++) {
    for ($j = 0; $j -lt $return.Count - 1; $j++) {
        $distance = Segment-Distance $supply[$i] $supply[$i + 1] $return[$j] $return[$j + 1]
        if ($distance -lt $minSupplyReturn) {
            $minSupplyReturn = $distance
            $minSupplyReturnPair = "$i/$j"
        }
    }
}

$minReturnReturn = [double]::PositiveInfinity
$minReturnReturnPair = ""
for ($i = 0; $i -lt $return.Count - 1; $i++) {
    for ($j = $i + 2; $j -lt $return.Count - 1; $j++) {
        $distance = Segment-Distance $return[$i] $return[$i + 1] $return[$j] $return[$j + 1]
        if ($distance -lt $minReturnReturn) {
            $minReturnReturn = $distance
            $minReturnReturnPair = "$i/$j"
        }
    }
}

if ($minSupplyReturn -lt $StepMeters - $ToleranceMeters) {
    throw "Distanza mandata-ritorno insufficiente: $minSupplyReturn m, minimo $StepMeters m, segmenti $minSupplyReturnPair."
}
if ($minReturnReturn -lt $StepMeters - $ToleranceMeters) {
    throw "Distanza ritorno-ritorno insufficiente: $minReturnReturn m, minimo $StepMeters m, segmenti $minReturnReturnPair."
}

[ordered]@{
    status = "ok"
    svg = [IO.Path]::GetFullPath($SvgPath)
    supplyPoints = $supply.Count
    returnPoints = $return.Count
    supplyReturnMinimumMeters = [Math]::Round($minSupplyReturn, 6)
    supplyReturnPair = $minSupplyReturnPair
    returnReturnMinimumMeters = [Math]::Round($minReturnReturn, 6)
    returnReturnPair = $minReturnReturnPair
    requestedStepMeters = $StepMeters
    returnSide = $ReturnSide
    twinEntryRootErrorMeters = [Math]::Round($rootError, 6)
    twinEntryInnerErrorMeters = [Math]::Round($innerError, 6)
    svgSha256 = (Get-FileHash -LiteralPath $SvgPath -Algorithm SHA256).Hash
} | ConvertTo-Json
