# Musterlösung Abschlussaufgabe: Schülerverwaltung

# ── Teil 1: Funktionen ──────────────────────────────────────────

function New-Schüler {
    param (
        [string]$Name,
        [int]$Alter,
        [int]$Note = 3
    )
    return @{ Name = $Name; Alter = $Alter; Note = $Note }
}

function Get-Notentext {
    param ([int]$Note)
    switch ($Note) {
        1 { return "Sehr gut" }
        2 { return "Gut" }
        3 { return "Befriedigend" }
        4 { return "Ausreichend" }
        5 { return "Mangelhaft" }
        6 { return "Ungenügend" }
        default { return "unbekannt" }
    }
}

function Get-Durchschnitt {
    param ([array]$Liste)
    $summe = 0
    foreach ($s in $Liste) {
        $summe += $s.Note
    }
    return $summe / $Liste.Count
}

# ── Teil 2: Schüler anlegen ─────────────────────────────────────

$schüler = @()
$schüler += New-Schüler -Name "Anna" -Alter 16 -Note 2
$schüler += New-Schüler -Name "Ben" -Alter 17 -Note 4
$schüler += New-Schüler -Name "Clara" -Alter 16 -Note 1
$schüler += New-Schüler -Name "David" -Alter 18 -Note 5
$schüler += New-Schüler -Name "Eva" -Alter 17 -Note 3

# ── Teil 3: Ausgabe ─────────────────────────────────────────────

Write-Host "=============================="
Write-Host "  Schülerverwaltung"
Write-Host "=============================="
foreach ($s in $schüler) {
    Write-Host "$($s.Name) ($($s.Alter) Jahre) - Note: $($s.Note) ($(Get-Notentext -Note $s.Note))"
}
Write-Host ""

# ── Teil 4: Auswertung ──────────────────────────────────────────

function Get-Auswertung {
    param ([array]$Liste)
    $bestanden = 0
    $durchgefallen = 0
    $bester = $Liste[0]
    $schlechtester = $Liste[0]
    foreach ($s in $Liste) {
        if ($s.Note -le 4) { $bestanden++ } else { $durchgefallen++ }
        if ($s.Note -lt $bester.Note) { $bester = $s }
        if ($s.Note -gt $schlechtester.Note) { $schlechtester = $s }
    }
    return @{
        Durchschnitt  = [math]::Round((Get-Durchschnitt -Liste $Liste), 2)
        Bestanden     = $bestanden
        Durchgefallen = $durchgefallen
        Bester        = $bester.Name
        Schlechtester = $schlechtester.Name
    }
}

$a = Get-Auswertung -Liste $schüler
Write-Host "Durchschnitt: $($a.Durchschnitt)"
Write-Host "Bestanden: $($a.Bestanden), Durchgefallen: $($a.Durchgefallen)"
Write-Host "Bester: $($a.Bester), Schlechtester: $($a.Schlechtester)"

# ── Teil 5: Benutzereingabe ─────────────────────────────────────

$antwort = Read-Host "Neuen Schüler hinzufügen? (j/n)"
if ($antwort -eq "j") {
    $name = Read-Host "Name"
    [int]$alter = Read-Host "Alter"
    [int]$note = Read-Host "Note"
    $schüler += New-Schüler -Name $name -Alter $alter -Note $note
    Write-Host "$name wurde hinzugefügt."
} else {
    Write-Host "Kein neuer Schüler."
}

# ── Teil 6: Dateien ─────────────────────────────────────────────

New-Item -Path "Ergebnisse" -ItemType Directory -Force | Out-Null

$schüler | ForEach-Object {
    [pscustomobject]@{ Name = $_.Name; Alter = $_.Alter; Note = $_.Note }
} | Export-Csv -Path "Ergebnisse/schueler.csv" -NoTypeInformation -Encoding utf8

$a = Get-Auswertung -Liste $schüler
@(
    "Anzahl Schüler: $($schüler.Count)"
    "Notendurchschnitt: $($a.Durchschnitt)"
    "Bestanden: $($a.Bestanden)"
    "Durchgefallen: $($a.Durchgefallen)"
    "Bester: $($a.Bester)"
    "Schlechtester: $($a.Schlechtester)"
) | Set-Content -Path "Ergebnisse/bericht.txt" -Encoding utf8

Get-Content -Path "Ergebnisse/bericht.txt" -Encoding utf8 | ForEach-Object { Write-Host $_ }
