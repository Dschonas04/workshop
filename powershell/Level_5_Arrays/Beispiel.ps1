# ================================================================
#  Level 5: Arrays & Hashtables – BEISPIELE
#  Führe diese Datei aus (F5) oder markiere Teile (F8).
# ================================================================

# --- Arrays ---
$sprachen = @("PowerShell", "Python", "JavaScript", "C#", "Go")

Write-Host "Array: $($sprachen -join ', ')"
Write-Host "  Anzahl:  $($sprachen.Count)"
Write-Host "  Erste:   $($sprachen[0])"
Write-Host "  Letzte:  $($sprachen[-1])"
Write-Host "  2. + 3.: $($sprachen[1..2] -join ', ')"

# Element hinzufügen
$sprachen += "Rust"
Write-Host "  Nach +=:  $($sprachen -join ', ')"

# --- Hashtable ---
$server = @{
    Name     = "SRV-DC01"
    IP       = "192.168.1.10"
    Rolle    = "Domain Controller"
    IsOnline = $true
    RAM_GB   = 16
}

Write-Host "`nHashtable:"
Write-Host "  Server: $($server.Name)"
Write-Host "  IP:     $($server['IP'])"
Write-Host "  Rolle:  $($server.Rolle)"
Write-Host "  Online: $($server.IsOnline)"
Write-Host "  Keys:   $($server.Keys -join ', ')"

# Neues Paar hinzufügen
$server["OS"] = "Windows Server 2022"
Write-Host "  Neues Paar - OS: $($server.OS)"

# --- Array von Hashtables (Mini-Datenbank) ---
Write-Host "`nSchüler-Datenbank:"
$schüler = @(
    @{ Name = "Anna";  Note = 2; Fach = "Mathe" },
    @{ Name = "Ben";   Note = 1; Fach = "Deutsch" },
    @{ Name = "Clara"; Note = 3; Fach = "Englisch" }
)

foreach ($s in $schüler) {
    Write-Host "  $($s.Name): Note $($s.Note) in $($s.Fach)"
}
