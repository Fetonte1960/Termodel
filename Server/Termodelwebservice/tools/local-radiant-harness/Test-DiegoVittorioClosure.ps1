param(
    [Parameter(Mandatory = $true)]
    [string]$SvgPath,
    [double]$StepMeters = 0.30,
    [double]$ToleranceMeters = 0.000002,
    [switch]$ExpectFillets
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Read-Points([string]$Value) {
    $result = New-Object System.Collections.Generic.List[object]
    foreach ($token in ($Value.Trim() -split '\s+')) {
        if ([string]::IsNullOrWhiteSpace($token)) { continue }
        $xy = $token.Split(',')
        $result.Add([pscustomobject]@{
            X = [double]::Parse($xy[0], [Globalization.CultureInfo]::InvariantCulture)
            Y = [double]::Parse($xy[1], [Globalization.CultureInfo]::InvariantCulture)
        })
    }
    return $result
}

function Point-Distance($a, $b) {
    return [Math]::Sqrt(
        ($a.X - $b.X) * ($a.X - $b.X) +
        ($a.Y - $b.Y) * ($a.Y - $b.Y))
}

function Orientation($a, $b, $c) {
    return ($b.X - $a.X) * ($c.Y - $a.Y) -
        ($b.Y - $a.Y) * ($c.X - $a.X)
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
    if ($lengthSquared -le 0.000000000001) { return Point-Distance $p $a }
    $t = (($p.X - $a.X) * $dx + ($p.Y - $a.Y) * $dy) / $lengthSquared
    $t = [Math]::Max(0.0, [Math]::Min(1.0, $t))
    return Point-Distance $p ([pscustomobject]@{
        X = $a.X + $t * $dx
        Y = $a.Y + $t * $dy
    })
}

function Segment-Distance($a0, $a1, $b0, $b1) {
    if (Segments-Intersect $a0 $a1 $b0 $b1) { return 0.0 }
    return [Math]::Min(
        [Math]::Min((Point-Segment-Distance $a0 $b0 $b1), (Point-Segment-Distance $a1 $b0 $b1)),
        [Math]::Min((Point-Segment-Distance $b0 $a0 $a1), (Point-Segment-Distance $b1 $a0 $a1)))
}

function Direction-Cosine($a0, $a1, $b0, $b1) {
    $adx = $a1.X - $a0.X
    $ady = $a1.Y - $a0.Y
    $bdx = $b1.X - $b0.X
    $bdy = $b1.Y - $b0.Y
    $alen = [Math]::Sqrt($adx * $adx + $ady * $ady)
    $blen = [Math]::Sqrt($bdx * $bdx + $bdy * $bdy)
    if ($alen -le 0.0000001 -or $blen -le 0.0000001) { return -1.0 }
    return ($adx * $bdx + $ady * $bdy) / ($alen * $blen)
}

if (-not (Test-Path -LiteralPath $SvgPath -PathType Leaf)) {
    throw "SVG non trovato: $SvgPath"
}

[xml]$svg = Get-Content -LiteralPath $SvgPath -Raw
$polylines = @($svg.SelectNodes("//*[local-name()='polyline']"))
$red = @($polylines | Where-Object { $_.stroke -eq "red" })
$blue = @($polylines | Where-Object { $_.stroke -eq "blue" })
$polygonNode = $svg.SelectSingleNode("//*[local-name()='polygon' and @class='architectural-contour']")
if ($red.Count -lt 2 -or $blue.Count -lt 1 -or $null -eq $polygonNode) {
    throw "SVG privo di mandata, chiusura, ritorno o perimetro architettonico."
}

$supply = @(Read-Points ([string]$red[0].points))
$closure = @(Read-Points ([string]$red[1].points))
$return = @(Read-Points ([string]$blue[0].points))
$perimeter = @(Read-Points ([string]$polygonNode.points))
if ($supply.Count -lt 2 -or $return.Count -lt 2 -or $closure.Count -lt 2) {
    throw "Geometria della chiusura non conforme al contratto a polilinea unica."
}
if ($closure.Count -gt 9) {
    throw "Frammentazione eccessiva della chiusura: $($closure.Count) punti."
}
if ($ExpectFillets -and $svg.svg.'data-termodel-fittings' -ne 'enabled') {
    throw "L'SVG non dichiara i raccordi attivi."
}

$c0 = $closure[0]
$c1 = $closure[-1]
if ((Point-Distance $supply[-1] $c0) -gt $ToleranceMeters -or
    (Point-Distance $return[-1] $c1) -gt $ToleranceMeters) {
    throw "La chiusura non coincide con i terminali mandata/ritorno."
}

$chordLength = Point-Distance $c0 $c1
if ($chordLength -lt 2.0 * $StepMeters - $ToleranceMeters) {
    throw "Corda della chiusura troppo corta: $chordLength m; minimo $(2.0 * $StepMeters) m."
}
$curveLength = 0.0
for ($i = 0; $i -lt $closure.Count - 1; $i++) {
    $curveLength += Point-Distance $closure[$i] $closure[$i + 1]
}
$orthogonal = [Math]::Abs($c0.X - $c1.X) -le $ToleranceMeters -or
    [Math]::Abs($c0.Y - $c1.Y) -le $ToleranceMeters
# L'ortogonalità è un criterio preferenziale della selezione, non un vincolo
# assoluto: resta esposta nel report per rendere verificabile la scelta.

$supplyCos = Direction-Cosine $supply[-2] $supply[-1] $closure[0] $closure[1]
$returnCos = Direction-Cosine $closure[-2] $closure[-1] $return[-1] $return[-2]
if ($supplyCos -lt -$ToleranceMeters -or $returnCos -lt -$ToleranceMeters) {
    throw "La chiusura forma un angolo acuto/inversione: coseni $supplyCos / $returnCos."
}
if ($ExpectFillets -and ($supplyCos -lt 0.95 -or $returnCos -lt 0.95)) {
    throw "Tangenza discretizzata insufficiente: coseni $supplyCos / $returnCos."
}

$minPipe = [double]::PositiveInfinity
$crossesPipe = $false
for ($i = 0; $i -lt $supply.Count - 2; $i++) {
    for ($j = 0; $j -lt $closure.Count - 1; $j++) {
        if (Segments-Intersect $closure[$j] $closure[$j + 1] $supply[$i] $supply[$i + 1]) {
            $crossesPipe = $true
        }
        $minPipe = [Math]::Min($minPipe, (Segment-Distance $closure[$j] $closure[$j + 1] $supply[$i] $supply[$i + 1]))
    }
}
for ($i = 0; $i -lt $return.Count - 2; $i++) {
    for ($j = 0; $j -lt $closure.Count - 1; $j++) {
        if (Segments-Intersect $closure[$j] $closure[$j + 1] $return[$i] $return[$i + 1]) {
            $crossesPipe = $true
        }
        $minPipe = [Math]::Min($minPipe, (Segment-Distance $closure[$j] $closure[$j + 1] $return[$i] $return[$i + 1]))
    }
}
if ($crossesPipe) {
    throw "La chiusura interseca un tratto non adiacente."
}
# La distanza positiva resta nel report diagnostico ma non è un criterio di
# arresto: è vietata soltanto l'intersezione effettiva.

$minWall = [double]::PositiveInfinity
for ($i = 0; $i -lt $perimeter.Count; $i++) {
    $j = ($i + 1) % $perimeter.Count
    for ($k = 0; $k -lt $closure.Count - 1; $k++) {
        $minWall = [Math]::Min($minWall, (Segment-Distance $closure[$k] $closure[$k + 1] $perimeter[$i] $perimeter[$j]))
    }
}

[ordered]@{
    status = "ok"
    svg = [IO.Path]::GetFullPath($SvgPath)
    stepMeters = $StepMeters
    closureChordMeters = [Math]::Round($chordLength, 6)
    closureCurveMeters = [Math]::Round($curveLength, 6)
    closurePoints = $closure.Count
    orthogonal = $orthogonal
    supplyJointCosine = [Math]::Round($supplyCos, 6)
    returnJointCosine = [Math]::Round($returnCos, 6)
    crossesPipe = $crossesPipe
    pipeClearanceMeters = [Math]::Round($minPipe, 6)
    wallClearanceMeters = [Math]::Round($minWall, 6)
    supplyPoints = $supply.Count
    returnPoints = $return.Count
    svgSha256 = (Get-FileHash -LiteralPath $SvgPath -Algorithm SHA256).Hash
} | ConvertTo-Json
