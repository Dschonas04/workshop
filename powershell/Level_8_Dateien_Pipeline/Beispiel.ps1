# ================================================================
#  Level 8: Dateien, Pipeline & Cmdlets – BEISPIELE
#  Führe diese Datei aus (F5) oder markiere Teile (F8).
# ================================================================

# --- Dateien & Ordner ---
Write-Host "Dateiverwaltung:"

# Ordner erstellen
$testPfad = ".\BeispielOrdner"
New-Item -Path $testPfad -ItemType Directory -Force | Out-Null

# Dateien erstellen
"Zeile 1: Hallo Welt" | Out-File "$testPfad\log.txt"
"Zeile 2: PowerShell ist toll" | Add-Content "$testPfad\log.txt"
"Zeile 3: Fertig!" | Add-Content "$testPfad\log.txt"

"Server: SRV-DC01`nIP: 192.168.1.10" | Out-File "$testPfad\server.txt"
"User: Admin`nRolle: Domänenadmin" | Out-File "$testPfad\user.txt"

# Datei lesen
$inhalt = Get-Content "$testPfad\log.txt"
Write-Host "  log.txt hat $($inhalt.Count) Zeilen:"
$inhalt | ForEach-Object { Write-Host "    > $_" }

# Prüfen ob Pfad existiert
Write-Host "  Existiert? $(Test-Path $testPfad)"

# Dateien auflisten
Write-Host "`n  Dateien im Ordner:"
Get-ChildItem $testPfad | ForEach-Object {
    Write-Host "    $($_.Name) ($($_.Length) Bytes)"
}

# Aufräumen
Remove-Item -Path $testPfad -Recurse -Force
Write-Host "  Ordner aufgeräumt."

# --- Pipeline-Beispiele ---
Write-Host "`nPipeline-Beispiele:"

# Top 5 Prozesse nach RAM
Write-Host "`n  Top 5 Prozesse (RAM):"
Get-Process |
    Sort-Object WorkingSet -Descending |
    Select-Object -First 5 |
    ForEach-Object {
        $mb = [math]::Round($_.WorkingSet / 1MB, 1)
        Write-Host "    $($_.Name): $mb MB"
    }

# Anzahl laufende Prozesse
$anzahl = (Get-Process | Measure-Object).Count
Write-Host "`n  Laufende Prozesse: $anzahl"

# Pipeline mit Where-Object (filtern)
Write-Host "`n  Prozesse > 100 MB RAM:"
Get-Process |
    Where-Object { $_.WorkingSet -gt 100MB } |
    Sort-Object WorkingSet -Descending |
    Select-Object Name, @{N="MB"; E={[math]::Round($_.WorkingSet/1MB)}} |
    ForEach-Object { Write-Host "    $($_.Name): $($_.MB) MB" }

# Pipeline: Dateien im aktuellen Ordner
Write-Host "`n  Dateien hier (nach Größe):"
Get-ChildItem -Path "." -File |
    Sort-Object Length -Descending |
    Select-Object Name, @{N="KB"; E={[math]::Round($_.Length/1KB, 1)}} -First 5 |
    ForEach-Object { Write-Host "    $($_.Name) - $($_.KB) KB" }
