# Musterlösung Level 7

# 7.1
function Get-Summe {
    param (
        [int]$a,
        [int]$b
    )
    return $a + $b
}
Write-Host "15 + 27 = $(Get-Summe -a 15 -b 27)"

# 7.2
function Get-Rechteck {
    param (
        [double]$Länge,
        [double]$Breite
    )
    return [pscustomobject]@{
        Fläche = $Länge * $Breite
        Umfang = 2 * ($Länge + $Breite)
    }
}
$r = Get-Rechteck -Länge 5 -Breite 3
Write-Host "Fläche: $($r.Fläche) cm², Umfang: $($r.Umfang) cm"

# 7.3
function Test-GeradeZahl {
    param ([int]$Zahl)
    return ($Zahl % 2 -eq 0)
}
Write-Host "4 gerade? $(Test-GeradeZahl -Zahl 4)"

# 7.4
function Get-Begrüßung {
    param (
        [string]$Name = "Welt"
    )
    return "Hallo, $Name!"
}
Write-Host (Get-Begrüßung)
Write-Host (Get-Begrüßung -Name "Max")

# 7.5
function Convert-Temperatur {
    param (
        [double]$Wert,
        [ValidateSet("Celsius", "Fahrenheit")]
        [string]$Von = "Celsius"
    )
    if ($Von -eq "Celsius") {
        return $Wert * 9 / 5 + 32
    }
    return ($Wert - 32) * 5 / 9
}
Write-Host "100 °C = $(Convert-Temperatur -Wert 100) °F"
