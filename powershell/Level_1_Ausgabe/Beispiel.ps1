# ================================================================
#  Level 1: Ausgabe auf der Konsole – BEISPIELE
#  Führe diese Datei aus (F5) oder markiere Teile (F8).
# ================================================================

# --- Write-Host: Direkt auf die Konsole, mit Farben ---
Write-Host "Ich bin grün!" -ForegroundColor Green
Write-Host "Ich bin rot auf weiß!" -ForegroundColor Red -BackgroundColor White
Write-Host "Ich bin cyan!" -ForegroundColor Cyan

# --- Write-Output: Geht in die Pipeline ---
Write-Output "Ich bin eine Pipeline-Nachricht."

# --- Write-Warning: Gelbe Warnung ---
Write-Warning "Achtung, das ist eine Warnung!"

# --- Der große Unterschied: Pipeline ---
Write-Host "`nPipeline-Test:"
Write-Output "Banane", "Apfel", "Cherry" | Sort-Object
# → Sortiert! Write-Output kann weitergeleitet werden.

# Write-Host kann NICHT weitergeleitet werden:
# Write-Host "Test" | Sort-Object  ← Gibt "Test" aus, Sort-Object bekommt nichts
