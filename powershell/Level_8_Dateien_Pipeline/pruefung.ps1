# Dein Skript läuft in einem leeren Ordner. Was es anlegt, sieht der
# Prüfer danach nach -- und zwar zweimal, denn ein Skript, das beim
# zweiten Lauf stolpert, ist noch nicht fertig.
$aus = Starte $Ziel
Pruefe '8.1 drei Dateien angelegt' (Zeile $aus 1) 'Angelegt: 3 Dateien'
Pruefe '8.2 Name und Inhalt' @((Zeile $aus 2), (Zeile $aus 3), (Zeile $aus 4)) @('datei1.txt : Inhalt 1', 'datei2.txt : Inhalt 2', 'datei3.txt : Inhalt 3')
Pruefe '8.3 nur Dateien mit 3 im Inhalt' (Zeile $aus 5) 'Gefunden: datei3.txt'
Pruefe '8.4 CSV wieder eingelesen' (Zeile $aus 6) 'CSV: 3 Zeilen, zusammen 24 Zeichen'
$angelegt = (Zeile $aus 1) -eq 'Angelegt: 3 Dateien'
Pruefe '8.5 MeinTest aufgeräumt' ($angelegt -and -not (Test-Path (Join-Path $script:Arbeit 'MeinTest'))) $true
Pruefe '8.5 CSV aufgeräumt' ($angelegt -and -not (Test-Path (Join-Path $script:Arbeit 'dateien.csv'))) $true
$zweiter = Starte $Ziel
Pruefe '8.5 zweiter Lauf geht genauso' ($angelegt -and ($zweiter -join '|') -eq ($aus -join '|')) $true
