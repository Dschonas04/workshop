# Musterlösung Level 4
param(
    [int]$Zahl = 7,
    [int]$Alter = 20,
    [string]$Fuehrerschein = 'ja',
    [string]$Tag = 'Montag',
    [int]$Punkte = 78
)

# 4.1
if ($Zahl -gt 0) {
    Write-Host "$Zahl ist positiv."
} elseif ($Zahl -lt 0) {
    Write-Host "$Zahl ist negativ."
} else {
    Write-Host "Die Zahl ist null."
}

# 4.2
if ($Alter -ge 18 -and $Fuehrerschein -eq 'ja') {
    Write-Host "Du darfst Auto fahren!"
} else {
    Write-Host "Du darfst leider nicht fahren."
}

# 4.3
switch ($Tag) {
    "Montag"  { Write-Host "Wochenstart..." }
    "Freitag" { Write-Host "Fast Wochenende!" }
    "Samstag" { Write-Host "Wochenende!" }
    "Sonntag" { Write-Host "Wochenende!" }
    default   { Write-Host "Ein ganz normaler Tag." }
}

# 4.4
if ($Punkte -ge 90) {
    $note = 1
} elseif ($Punkte -ge 75) {
    $note = 2
} elseif ($Punkte -ge 60) {
    $note = 3
} elseif ($Punkte -ge 45) {
    $note = 4
} elseif ($Punkte -ge 30) {
    $note = 5
} else {
    $note = 6
}
Write-Host "$Punkte Punkte = Note $note"

# 4.5
if ($Alter -le 12) {
    $gruppe = "Kind"
} elseif ($Alter -ge 13 -and $Alter -le 17) {
    $gruppe = "Jugendlich"
} elseif ($Alter -ge 18 -and $Alter -le 64) {
    $gruppe = "Erwachsen"
} else {
    $gruppe = "Senior"
}
Write-Host "Altersgruppe: $gruppe"
