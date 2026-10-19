# ================================================================
#  Level 6: Schleifen – BEISPIELE
#  Führe diese Datei aus (F5) oder markiere Teile (F8).
# ================================================================

# --- for-Schleife ---
Write-Host "for-Schleife (1x1 der 7):"
for ($i = 1; $i -le 5; $i++) {
    $ergebnis = 7 * $i
    Write-Host "  7 x $i = $ergebnis"
}

# --- foreach ---
Write-Host "`nforeach-Schleife:"
$tiere = @("Hund", "Katze", "Hamster", "Fisch")
foreach ($tier in $tiere) {
    Write-Host "  Ich mag: $tier"
}

# --- foreach mit Zähler ---
Write-Host "`nforeach mit Nummerierung:"
$nr = 1
foreach ($tier in $tiere) {
    Write-Host "  $nr. $tier"
    $nr++
}

# --- while-Schleife ---
Write-Host "`nwhile-Countdown:"
$countdown = 5
while ($countdown -ge 1) {
    Write-Host "  $countdown..."
    $countdown--
}
Write-Host "  Start!"

# --- Gerade/Ungerade mit Modulo ---
Write-Host "`nGerade/Ungerade (1-10):"
for ($i = 1; $i -le 10; $i++) {
    if ($i % 2 -eq 0) {
        Write-Host "  $i (gerade)" -ForegroundColor Green
    } else {
        Write-Host "  $i (ungerade)" -ForegroundColor Gray
    }
}

# --- break und continue ---
Write-Host "`nbreak & continue (1-10, 5 überspringen, bei 8 stoppen):"
foreach ($zahl in 1..10) {
    if ($zahl -eq 5) { continue }    # 5 wird übersprungen
    if ($zahl -eq 8) { break }       # Schleife endet bei 8
    Write-Host "  $zahl" -NoNewline
}
Write-Host ""  # Neue Zeile
