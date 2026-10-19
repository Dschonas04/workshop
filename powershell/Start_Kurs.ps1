#Requires -Version 7
$ErrorActionPreference = 'Stop'

$kursElemente = @(
    [pscustomobject]@{ Key = '0'; Name = 'Level 0 - Einstieg'; Folder = 'Level_0_Einstieg'; TheoryFile = 'Anleitung.txt'; ExampleFile = $null; TaskFile = $null; Check = $null }
    [pscustomobject]@{ Key = '1'; Name = 'Level 1 - Ausgabe'; Folder = 'Level_1_Ausgabe'; TheoryFile = 'Theorie.txt'; ExampleFile = 'Beispiel.ps1'; TaskFile = 'Aufgabenstellung.txt'; Check = '1' }
    [pscustomobject]@{ Key = '2'; Name = 'Level 2 - Variablen'; Folder = 'Level_2_Variablen'; TheoryFile = 'Theorie.txt'; ExampleFile = 'Beispiel.ps1'; TaskFile = 'Aufgabenstellung.txt'; Check = '2' }
    [pscustomobject]@{ Key = '3'; Name = 'Level 3 - Eingabe'; Folder = 'Level_3_Eingabe'; TheoryFile = 'Theorie.txt'; ExampleFile = 'Beispiel.ps1'; TaskFile = 'Aufgabenstellung.txt'; Check = '3' }
    [pscustomobject]@{ Key = '4'; Name = 'Level 4 - Bedingungen'; Folder = 'Level_4_Bedingungen'; TheoryFile = 'Theorie.txt'; ExampleFile = 'Beispiel.ps1'; TaskFile = 'Aufgabenstellung.txt'; Check = '4' }
    [pscustomobject]@{ Key = '5'; Name = 'Level 5 - Arrays'; Folder = 'Level_5_Arrays'; TheoryFile = 'Theorie.txt'; ExampleFile = 'Beispiel.ps1'; TaskFile = 'Aufgabenstellung.txt'; Check = '5' }
    [pscustomobject]@{ Key = '6'; Name = 'Level 6 - Schleifen'; Folder = 'Level_6_Schleifen'; TheoryFile = 'Theorie.txt'; ExampleFile = 'Beispiel.ps1'; TaskFile = 'Aufgabenstellung.txt'; Check = '6' }
    [pscustomobject]@{ Key = '7'; Name = 'Level 7 - Funktionen'; Folder = 'Level_7_Funktionen'; TheoryFile = 'Theorie.txt'; ExampleFile = 'Beispiel.ps1'; TaskFile = 'Aufgabenstellung.txt'; Check = '7' }
    [pscustomobject]@{ Key = '8'; Name = 'Level 8 - Dateien & Pipeline'; Folder = 'Level_8_Dateien_Pipeline'; TheoryFile = 'Theorie.txt'; ExampleFile = 'Beispiel.ps1'; TaskFile = 'Aufgabenstellung.txt'; Check = '8' }
    [pscustomobject]@{ Key = 'A'; Name = 'Abschlussaufgabe'; Folder = 'Abschluss_Aufgabe'; TheoryFile = 'Aufgabenstellung.txt'; ExampleFile = $null; TaskFile = $null; Check = 'abschluss' }
    [pscustomobject]@{ Key = 'B'; Name = 'Zusatz - Batch'; Folder = 'Zusatz_Batch'; TheoryFile = 'Theorie.txt'; ExampleFile = 'Beispiel.bat'; TaskFile = 'Aufgabe.bat'; Check = $null }
    [pscustomobject]@{ Key = 'S'; Name = 'Zusatz - Shell'; Folder = 'Zusatz_Shell'; TheoryFile = 'Theorie.txt'; ExampleFile = 'Beispiel.sh'; TaskFile = 'Aufgabe.sh'; Check = $null }
)

function Show-Header {
    param([string]$Title)

    Clear-Host
    Write-Host ''
    Write-Host '============================================' -ForegroundColor DarkCyan
    Write-Host " $Title" -ForegroundColor Cyan
    Write-Host '============================================' -ForegroundColor DarkCyan
    Write-Host ''
}

function Pause-Kurs {
    Read-Host 'Weiter mit Enter'
}

function Get-ElementPath {
    param(
        [pscustomobject]$Item,
        [string]$FileName
    )

    if ([string]::IsNullOrWhiteSpace($FileName)) {
        return $null
    }

    return Join-Path -Path (Join-Path -Path $PSScriptRoot -ChildPath $Item.Folder) -ChildPath $FileName
}

function Show-FileContent {
    param(
        [string]$Path,
        [string]$Label
    )

    Show-Header $Label

    if (-not (Test-Path -Path $Path)) {
        Write-Host "Datei nicht gefunden: $Path" -ForegroundColor Red
        Pause-Kurs
        return
    }

    Write-Host "Datei: $Path" -ForegroundColor DarkGray
    Write-Host ''
    Get-Content -Path $Path | ForEach-Object { Write-Host $_ }
    Write-Host ''
    Pause-Kurs
}

function Start-LevelQuiz {
    param([pscustomobject]$Item)

    Show-Header "Mini-Check: $($Item.Name)"

    switch ($Item.Key) {
        '0' {
            $antwort = Read-Host 'Welche Dateiendung hat ein PowerShell-Skript?'
            if ($antwort.Trim().ToLower() -eq '.ps1' -or $antwort.Trim().ToLower() -eq 'ps1') {
                Write-Host 'Richtig! PowerShell-Skripte enden auf .ps1.' -ForegroundColor Green
            } else {
                Write-Host 'Fast. Die richtige Endung ist .ps1.' -ForegroundColor Yellow
            }
        }
        '1' {
            $antwort = Read-Host 'Welcher Befehl schreibt Daten in die Pipeline: Write-Host oder Write-Output?'
            if ($antwort.Trim().ToLower() -eq 'write-output') {
                Write-Host 'Genau: Write-Output geht in die Pipeline.' -ForegroundColor Green
            } else {
                Write-Host 'Nicht ganz. Write-Output geht in die Pipeline.' -ForegroundColor Yellow
            }
        }
        '2' {
            $antwort = Read-Host 'Wie startet in PowerShell eine Variable?'
            if ($antwort.Trim() -eq '$') {
                Write-Host 'Richtig: Variablen beginnen mit $.' -ForegroundColor Green
            } else {
                Write-Host 'Die richtige Antwort ist: mit $.' -ForegroundColor Yellow
            }
        }
        '3' {
            $antwort = Read-Host 'Mit welchem Befehl fragst du eine Eingabe ab?'
            if ($antwort.Trim().ToLower() -eq 'read-host') {
                Write-Host 'Perfekt: Read-Host liest Benutzereingaben.' -ForegroundColor Green
            } else {
                Write-Host 'Hier ist die Lösung: Read-Host.' -ForegroundColor Yellow
            }
        }
        '4' {
            $antwort = Read-Host 'Welche Abfrage verwendet man für Bedingungen in PowerShell?'
            if ($antwort.Trim().ToLower() -eq 'if') {
                Write-Host 'Genau: if ist die Standard-Bedingung.' -ForegroundColor Green
            } else {
                Write-Host 'Die einfachste Antwort wäre: if.' -ForegroundColor Yellow
            }
        }
        '5' {
            $antwort = Read-Host 'Trenne drei Array-Werte mit Komma oder Semikolon?'
            if ($antwort.Trim().ToLower() -eq 'komma' -or $antwort.Trim() -eq ',') {
                Write-Host 'Richtig: Arrays werden typischerweise mit Kommas getrennt.' -ForegroundColor Green
            } else {
                Write-Host 'Gemeint war: mit Kommas.' -ForegroundColor Yellow
            }
        }
        '6' {
            $antwort = Read-Host 'Welche Schleife läuft über alle Elemente einer Liste: foreach, if oder switch?'
            if ($antwort.Trim().ToLower() -eq 'foreach') {
                Write-Host 'Richtig: foreach verarbeitet Elemente nacheinander.' -ForegroundColor Green
            } else {
                Write-Host 'Die richtige Antwort ist: foreach.' -ForegroundColor Yellow
            }
        }
        '7' {
            $antwort = Read-Host 'Mit welchem Schlüsselwort definierst du eine Funktion?'
            if ($antwort.Trim().ToLower() -eq 'function') {
                Write-Host 'Genau: function startet eine Funktionsdefinition.' -ForegroundColor Green
            } else {
                Write-Host 'Die richtige Antwort ist: function.' -ForegroundColor Yellow
            }
        }
        '8' {
            $antwort = Read-Host 'Welches Zeichen leitet die Pipeline ein?'
            if ($antwort.Trim() -eq '|') {
                Write-Host 'Exakt: | verbindet Befehle über die Pipeline.' -ForegroundColor Green
            } else {
                Write-Host 'Gemeint war das Pipe-Zeichen: |' -ForegroundColor Yellow
            }
        }
        'B' {
            $antwort = Read-Host 'Welche Batch-Zeile unterdrückt die Echo-Ausgabe häufig am Anfang?'
            if ($antwort.Trim().ToLower() -eq '@echo off') {
                Write-Host 'Richtig: @echo off ist der Klassiker.' -ForegroundColor Green
            } else {
                Write-Host 'Typisch wäre: @echo off.' -ForegroundColor Yellow
            }
        }
        'S' {
            $antwort = Read-Host 'Wie heißt die erste Zeile vieler Bash-Skripte?'
            if ($antwort.Trim().ToLower() -eq '#!/bin/bash') {
                Write-Host 'Genau: das ist der Shebang.' -ForegroundColor Green
            } else {
                Write-Host 'Gesucht war: #!/bin/bash' -ForegroundColor Yellow
            }
        }
        default {
            Write-Host 'Für dieses Element gibt es noch keinen Mini-Check.' -ForegroundColor Yellow
        }
    }

    Write-Host ''
    Pause-Kurs
}

function Start-LevelMenu {
    param([pscustomobject]$Item)

    while ($true) {
        Show-Header $Item.Name
        Write-Host '1 - Theorie / Anleitung lesen'
        if ($Item.ExampleFile) {
            Write-Host '2 - Beispiel anzeigen'
        }
        if ($Item.TaskFile) {
            Write-Host '3 - Aufgabenstellung anzeigen'
        }
        Write-Host '4 - Mini-Check starten'
        if ($Item.Check) {
            Write-Host '5 - Meine Lösung prüfen (uebung.ps1)'
        }
        Write-Host 'M - Zurück zum Hauptmenü'
        Write-Host ''

        $auswahl = (Read-Host 'Deine Auswahl').Trim().ToUpper()

        switch ($auswahl) {
            '1' {
                $path = Get-ElementPath -Item $Item -FileName $Item.TheoryFile
                Show-FileContent -Path $path -Label "$($Item.Name) - Theorie"
            }
            '2' {
                if ($Item.ExampleFile) {
                    $path = Get-ElementPath -Item $Item -FileName $Item.ExampleFile
                    Show-FileContent -Path $path -Label "$($Item.Name) - Beispiel"
                }
            }
            '3' {
                if ($Item.TaskFile) {
                    $path = Get-ElementPath -Item $Item -FileName $Item.TaskFile
                    Show-FileContent -Path $path -Label "$($Item.Name) - Aufgabenstellung"
                }
            }
            '4' {
                Start-LevelQuiz -Item $Item
            }
            '5' {
                if ($Item.Check) {
                    Show-Header "$($Item.Name) - Prüfung"
                    # eigene PowerShell: der Prüfer beendet sich mit exit, das Menü soll bleiben
                    & (Get-Process -Id $PID).Path -NoProfile -File (Join-Path $PSScriptRoot 'pruefen.ps1') $Item.Check
                    Write-Host ''
                    Pause-Kurs
                }
            }
            'M' {
                return
            }
            default {
                Write-Host "Unbekannte Auswahl: $auswahl" -ForegroundColor Yellow
                Start-Sleep -Seconds 1
            }
        }
    }
}

while ($true) {
    Show-Header 'PowerShell-Kurs'
    Write-Host 'Wähle ein Level oder einen Zusatzbereich:'
    Write-Host ''

    foreach ($element in $kursElemente) {
        Write-Host "$($element.Key) - $($element.Name)"
    }

    Write-Host 'Q - Beenden'
    Write-Host ''

    $auswahl = (Read-Host 'Deine Auswahl').Trim().ToUpper()

    if ($auswahl -eq 'Q') {
        Show-Header 'Bis bald!'
        Write-Host 'Viel Erfolg beim Üben.' -ForegroundColor Green
        break
    }

    $gewählt = $kursElemente | Where-Object { $_.Key -eq $auswahl } | Select-Object -First 1

    if ($null -eq $gewählt) {
        Write-Host "Ungültige Eingabe: $auswahl" -ForegroundColor Yellow
        Start-Sleep -Seconds 1
        continue
    }

    Start-LevelMenu -Item $gewählt
}