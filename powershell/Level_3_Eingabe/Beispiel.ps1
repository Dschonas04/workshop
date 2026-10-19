# ================================================================
#  Level 3: Benutzereingabe & Berechnungen – BEISPIELE
#  HINWEIS: Read-Host Beispiele sind auskommentiert,
#  damit das Skript durchlaufen kann. Entkommentiere zum Testen!
# ================================================================

# --- Einfache Eingabe ---
# $stadt = Read-Host "In welcher Stadt wohnst du?"
# Write-Host "Cool, $stadt ist bestimmt schön!" -ForegroundColor Green

# --- Eingabe mit Typ-Umwandlung ---
# [int]$zahl1 = Read-Host "Erste Zahl"
# [int]$zahl2 = Read-Host "Zweite Zahl"
# Write-Host "$zahl1 + $zahl2 = $($zahl1 + $zahl2)"
# Write-Host "$zahl1 * $zahl2 = $($zahl1 * $zahl2)"

# --- Sichere Umwandlung mit -as ---
# $eingabe = Read-Host "Gib eine Zahl ein"
# $zahl = $eingabe -as [int]
# if ($null -eq $zahl) {
#     Write-Host "Das war keine gültige Zahl!" -ForegroundColor Red
# } else {
#     Write-Host "Doppelt: $($zahl * 2)"
# }

# --- Rechenbeispiel (ohne Eingabe) ---
Write-Host "Rechenbeispiele:"
$x = 15
$y = 4
Write-Host "  $x + $y = $($x + $y)"
Write-Host "  $x - $y = $($x - $y)"
Write-Host "  $x * $y = $($x * $y)"
Write-Host "  $x / $y = $($x / $y)"
Write-Host "  $x % $y = $($x % $y)  (Rest/Modulo)"
