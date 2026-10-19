# ================================================================
#  Level 2: Variablen & Datentypen – BEISPIELE
#  Führe diese Datei aus (F5) oder markiere Teile (F8).
# ================================================================

# Verschiedene Datentypen
$name = "PowerShell"          # String
$version = 7.4                # Double
$alter = 25                   # Int32
$istToll = $true              # Boolean
$nix = $null                  # Null

# Ausgabe mit String-Interpolation
Write-Host "Sprache: $name (Version $version)"
Write-Host "Alter: $alter, Toll: $istToll"

# Datentypen prüfen
Write-Host "`nDatentypen:"
Write-Host "  name:    $($name.GetType().Name)"       # String
Write-Host "  version: $($version.GetType().Name)"    # Double
Write-Host "  alter:   $($alter.GetType().Name)"      # Int32
Write-Host "  istToll: $($istToll.GetType().Name)"    # Boolean

# Einfache vs. doppelte Anführungszeichen
Write-Host "`nAnführungszeichen:"
Write-Host "  Doppelt: Sprache ist $name"     # → Sprache ist PowerShell
Write-Host '  Einfach: Sprache ist $name'     # → Sprache ist $name

# Casting (Typ erzwingen)
[string]$zahlAlsText = 42
Write-Host "`nCasting: 42 als String = '$zahlAlsText' (Typ: $($zahlAlsText.GetType().Name))"

# Vorsicht beim Rechnen mit Strings!
$a = "10"    # String
$b = 20      # Int
Write-Host "`nString + Zahl Falle:"
Write-Host "  '10' + 20 = $($a + $b)"     # → "1020" (String-Verkettung!)
Write-Host "  20 + '10' = $($b + $a)"     # → 30     (Addition!)
Write-Host "  → PowerShell richtet sich nach dem LINKEN Operanden!"
