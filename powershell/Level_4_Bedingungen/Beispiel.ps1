# ================================================================
#  Level 4: Bedingungen – BEISPIELE
#  Führe diese Datei aus (F5) oder markiere Teile (F8).
# ================================================================

# --- if / elseif / else ---
$temperatur = 22

Write-Host "Temperatur: $temperatur°C"
if ($temperatur -gt 30) {
    Write-Host "  Es ist heiß!"
} elseif ($temperatur -ge 15) {
    Write-Host "  Angenehme Temperatur!"
} elseif ($temperatur -ge 0) {
    Write-Host "  Zieh eine Jacke an!"
} else {
    Write-Host "  Es friert!"
}

# --- Logische Operatoren ---
$personAlter = 20
$hatFührerschein = $true

Write-Host "`nAutofahren-Check (Alter: $personAlter, Führerschein: $hatFührerschein):"
if ($personAlter -ge 18 -and $hatFührerschein) {
    Write-Host "  Du darfst fahren!"
} else {
    Write-Host "  Du darfst nicht fahren."
}

# --- switch-Anweisung ---
$tag = "Freitag"

Write-Host "`nWochentag: $tag"
switch ($tag) {
    "Montag"     { Write-Host "  Wochenstart..." }
    "Dienstag"   { Write-Host "  Noch lang bis Freitag..." }
    "Mittwoch"   { Write-Host "  Halbzeit!" }
    "Donnerstag" { Write-Host "  Fast geschafft!" }
    "Freitag"    { Write-Host "  FREITAG! Fast Wochenende!" }
    "Samstag"    { Write-Host "  Wochenende!" }
    "Sonntag"    { Write-Host "  Noch ein Tag frei..." }
    default      { Write-Host "  Unbekannter Tag" }
}

# --- String-Vergleiche ---
Write-Host "`nString-Vergleiche:"
Write-Host "  'Hallo' -like 'H*'     = $("Hallo" -like "H*")"
Write-Host "  'abc123' -match '\d+'  = $("abc123" -match "\d+")"
Write-Host "  @(1,2,3) -contains 2   = $(@(1,2,3) -contains 2)"
