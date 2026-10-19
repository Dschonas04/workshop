# ================================================================
#  Level 7: Funktionen – BEISPIELE
#  Führe diese Datei aus (F5) oder markiere Teile (F8).
# ================================================================

# --- Einfache Funktion mit Standardwert ---
function Get-Begrüßung {
    param (
        [string]$Name = "Welt",
        [string]$Tageszeit = "Tag"
    )
    return "Guten $Tageszeit, $Name! Willkommen zum PowerShell Kurs!"
}

Write-Host (Get-Begrüßung)
Write-Host (Get-Begrüßung -Name "Max" -Tageszeit "Morgen")

# --- Funktion mit Berechnung ---
function Get-Summe {
    param (
        [int]$a,
        [int]$b
    )
    return $a + $b
}

$ergebnis = Get-Summe -a 15 -b 27
Write-Host "`nGet-Summe: 15 + 27 = $ergebnis"

# --- Funktion mit mehreren Ausgaben ---
function Get-Rechteck {
    param (
        [double]$Länge,
        [double]$Breite
    )
    $fläche = $Länge * $Breite
    $umfang = 2 * ($Länge + $Breite)
    Write-Host "  Rechteck: ${Länge}cm x ${Breite}cm"
    Write-Host "  Fläche:  $fläche cm²"
    Write-Host "  Umfang:   $umfang cm"
}

Write-Host "`nGet-Rechteck:"
Get-Rechteck -Länge 5 -Breite 3

# --- Funktion mit Boolean-Rückgabe ---
function Test-GeradeZahl {
    param ([int]$Zahl)
    return ($Zahl % 2 -eq 0)
}

Write-Host "`nTest-GeradeZahl:"
Write-Host "  4 ist gerade: $(Test-GeradeZahl -Zahl 4)"
Write-Host "  7 ist gerade: $(Test-GeradeZahl -Zahl 7)"

# --- Temperatur-Umrechner ---
function Convert-Temperatur {
    param (
        [double]$Wert,
        [string]$Von = "Celsius"
    )
    if ($Von -eq "Celsius") {
        $ergebnis = $Wert * 9/5 + 32
        Write-Host "  ${Wert}°C = ${ergebnis}°F"
    } else {
        $ergebnis = ($Wert - 32) * 5/9
        Write-Host "  ${Wert}°F = $([math]::Round($ergebnis, 1))°C"
    }
}

Write-Host "`nConvert-Temperatur:"
Convert-Temperatur -Wert 100 -Von "Celsius"
Convert-Temperatur -Wert 72 -Von "Fahrenheit"
