$fragen = 'Neuen Schüler hinzufügen', 'Name:', 'Alter:', 'Note:'
function Ruf([string]$Ausdruck) { Zeile (Starte $Ziel -Eingabe 'n' -Fragen $fragen -Danach $Ausdruck) 1 }

# Teil 1: die Funktionen für sich
Pruefe '1.1 New-Schüler' (Ruf '$s = New-Schüler -Name Ida -Alter 15 -Note 2; "$($s.Name) $($s.Alter) $($s.Note)"') 'Ida 15 2'
Pruefe '1.1 Note 3 als Standard' (Ruf '(New-Schüler -Name Ida -Alter 15).Note') '3'
Pruefe '1.2 Get-Notentext' (Ruf '(1..6 | ForEach-Object { Get-Notentext -Note $_ }) -join ","') 'Sehr gut,Gut,Befriedigend,Ausreichend,Mangelhaft,Ungenügend'
Pruefe '1.3 Get-Durchschnitt' (Ruf 'Get-Durchschnitt -Liste @((New-Schüler -Name A -Alter 1 -Note 1), (New-Schüler -Name B -Alter 1 -Note 2))') '1.5'

# Teil 2 bis 6: ein Lauf mit einem sechsten Schüler
$aus = Starte $Ziel -Eingabe 'j', 'Finn', '16', '6' -Fragen $fragen
$kopf = '==============================', '  Schülerverwaltung', '=============================='
Pruefe '3.1 Überschrift' (Zeilen $aus 1 3) $kopf
Pruefe '3.2 Schülerliste' (Zeilen $aus 4 8) @(
    'Anna (16 Jahre) - Note: 2 (Gut)',
    'Ben (17 Jahre) - Note: 4 (Ausreichend)',
    'Clara (16 Jahre) - Note: 1 (Sehr gut)',
    'David (18 Jahre) - Note: 5 (Mangelhaft)',
    'Eva (17 Jahre) - Note: 3 (Befriedigend)')
Pruefe '4.1 Durchschnitt' (Zeile $aus 9) 'Durchschnitt: 3'
Pruefe '4.2 bestanden und durchgefallen' (Zeile $aus 10) 'Bestanden: 4, Durchgefallen: 1'
Pruefe '4.3 Bester und Schlechtester' (Zeile $aus 11) 'Bester: Clara, Schlechtester: David'
Pruefe '5.1 Finn hinzugefügt' (Zeile $aus 12) 'Finn wurde hinzugefügt.'

$csv = Join-Path $script:Arbeit 'Ergebnisse/schueler.csv'
$bericht = Join-Path $script:Arbeit 'Ergebnisse/bericht.txt'
Pruefe '6.1 CSV mit sechs Schülern' $(if (Test-Path $csv) { @(Import-Csv $csv).Count } else { 'keine Datei' }) 6
Pruefe '6.1 Spalten der CSV' $(if (Test-Path $csv) { (Get-Content $csv -TotalCount 1) } else { 'keine Datei' }) '"Name","Alter","Note"'
$sollBericht = 'Anzahl Schüler: 6', 'Notendurchschnitt: 3.5', 'Bestanden: 4', 'Durchgefallen: 2', 'Bester: Clara', 'Schlechtester: Finn'
Pruefe '6.2 Bericht' $(if (Test-Path $bericht) { @(Get-Content $bericht -Encoding utf8) } else { 'keine Datei' }) $sollBericht
Pruefe '6.3 Bericht auf der Konsole' (Zeilen $aus ($aus.Count - 5) $aus.Count) $sollBericht

$aus = Starte $Ziel -Eingabe 'n' -Fragen $fragen
Pruefe '5.1 mit n bleibt es bei fünf' (Zeile $aus 12) 'Kein neuer Schüler.'
