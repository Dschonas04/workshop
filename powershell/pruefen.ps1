<#
  Prüfer für den PowerShell-Kurs.

  Er sagt dir nach jeder Aufgabe, ob sie stimmt -- das ist der
  Unterschied zwischen "ich habe etwas hingeschrieben" und "ich
  habe es verstanden".

    pwsh ./pruefen.ps1              alle Level
    pwsh ./pruefen.ps1 3            nur Level 3
    pwsh ./pruefen.ps1 -Loesung     prüft die Musterlösungen (sollte alles
                                    grün sein; zeigt, dass der Prüfer stimmt)

  Dein Skript läuft dabei in einer eigenen PowerShell und in einem
  leeren Arbeitsordner. Was es dort anlegt, verschwindet danach wieder.
#>
#Requires -Version 7
param(
    [string]$Level = 'alle',
    [switch]$Loesung
)

Set-StrictMode -Version 3
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

$script:Gesamt = 0
$script:Gut = 0
$script:Pwsh = (Get-Process -Id $PID).Path

function Pruefe {
    param([string]$Name, $Ist, $Soll)
    $script:Gesamt++
    $istText = (@($Ist) | ForEach-Object { "$_" }) -join ' | '
    $sollText = (@($Soll) | ForEach-Object { "$_" }) -join ' | '
    if ($istText -ceq $sollText) {
        $script:Gut++
        Write-Host "  ✓ $Name" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $Name" -ForegroundColor Red
        Write-Host "     erwartet: $sollText" -ForegroundColor DarkGray
        Write-Host "     bekommen: $istText" -ForegroundColor DarkGray
    }
}

function Text {
    param([string]$Wert)
    "'" + ($Wert -replace "'", "''") + "'"
}

# Startet ein Skript in einer eigenen PowerShell und gibt seine
# Ausgabe als Zeilen zurück.
#   -Argumente  Parameter für das Skript, als Hashtable
#   -Eingabe    Zeilen, die Read-Host nacheinander bekommt
#   -Fragen     Anfänge von Read-Host-Fragen; diese Zeilen fallen weg
#   Leerzeilen fallen ebenfalls weg.
#   -Umleitung  z. B. '6>$null', um Write-Host auszublenden
#   -Danach     Befehl, der nach dem Skript in derselben Sitzung läuft;
#               das Skript wird dann mit . geladen und seine eigene
#               Ausgabe verschluckt
function Starte {
    param(
        [string]$Skript,
        [hashtable]$Argumente = @{},
        [string[]]$Eingabe = @(),
        [string[]]$Fragen = @(),
        [string]$Umleitung = '',
        [string]$Danach = '',
        [string]$Ordner = $script:Arbeit
    )
    $aufruf = (Text $Skript)
    foreach ($name in $Argumente.Keys) {
        $aufruf += " -$name " + (Text ([string]$Argumente[$name]))
    }
    $befehl = '[Console]::OutputEncoding = [Text.UTF8Encoding]::new($false); $ProgressPreference = ''SilentlyContinue''; '
    if ($Danach) {
        $befehl += ". $aufruf *> `$null; $Danach"
    } else {
        $befehl += "& $aufruf $Umleitung"
    }

    $start = [Diagnostics.ProcessStartInfo]::new($script:Pwsh)
    foreach ($a in '-NoProfile', '-NoLogo', '-Command', $befehl) { $start.ArgumentList.Add($a) }
    $start.WorkingDirectory = $Ordner
    $start.RedirectStandardInput = $true
    $start.RedirectStandardOutput = $true
    $start.RedirectStandardError = $true
    $start.StandardOutputEncoding = [Text.UTF8Encoding]::new($false)
    $start.UseShellExecute = $false
    $start.Environment['NO_COLOR'] = '1'

    $prozess = [Diagnostics.Process]::Start($start)
    foreach ($zeile in $Eingabe) { $prozess.StandardInput.WriteLine($zeile) }
    $prozess.StandardInput.Close()
    $aus = $prozess.StandardOutput.ReadToEndAsync()
    $null = $prozess.StandardError.ReadToEndAsync()
    if (-not $prozess.WaitForExit(30000)) {
        $prozess.Kill($true)
        return , @('(Zeitüberschreitung: wartet das Skript auf eine Eingabe?)')
    }

    $zeilen = [Collections.Generic.List[string]]::new()
    foreach ($zeile in ($aus.Result -split "`r?`n")) {
        $zeile = ($zeile -replace "`e\[[0-9;?]*[A-Za-z]", '').TrimEnd()
        $frage = $false
        foreach ($f in $Fragen) { if ($zeile.StartsWith($f)) { $frage = $true } }
        # Leerzeilen zählen nicht: sie machen eine Ausgabe lesbarer,
        # sollen aber keine Aufgabe verschieben.
        if (-not $frage -and $zeile -ne '') { $zeilen.Add($zeile) }
    }
    return , $zeilen.ToArray()
}

# Zeile $Nummer (ab 1) oder '' wenn es sie nicht gibt
function Zeile {
    param([string[]]$Zeilen, [int]$Nummer)
    if ($Nummer -ge 1 -and $Nummer -le $Zeilen.Count) { $Zeilen[$Nummer - 1] } else { '' }
}

# Zeilen $Von bis $Bis (ab 1); fehlende Zeilen werden zu ''
function Zeilen {
    param([string[]]$Zeilen, [int]$Von, [int]$Bis)
    , @(for ($i = $Von; $i -le $Bis; $i++) { Zeile $Zeilen $i })
}

$ordner = @(Get-ChildItem -Directory | Where-Object { $_.Name -match '^(Level_\d+_|Abschluss_Aufgabe)' } |
    Where-Object { Test-Path (Join-Path $_.FullName 'pruefung.ps1') } | Sort-Object Name)

foreach ($o in $ordner) {
    $nummer = if ($o.Name -match '^Level_(\d+)_') { $Matches[1] } else { 'abschluss' }
    if ($Level -ne 'alle' -and $Level -ne $nummer) { continue }

    Write-Host ''
    Write-Host $o.Name -ForegroundColor White
    $Ziel = if ($Loesung) { Join-Path $PSScriptRoot "Loesungen/$($o.Name).ps1" } else { Join-Path $o.FullName 'uebung.ps1' }
    if (-not (Test-Path $Ziel)) {
        Write-Host "  ✗ $Ziel fehlt" -ForegroundColor Red
        $script:Gesamt++
        continue
    }
    if (-not $Loesung -and -not ((Get-Content $Ziel -Raw) -match '(?m)^\s*[^#\s]')) {
        Write-Host "  · uebung.ps1 enthält noch nichts." -ForegroundColor DarkGray
    }

    $script:Arbeit = Join-Path ([IO.Path]::GetTempPath()) ("ps-kurs-" + [guid]::NewGuid())
    New-Item -ItemType Directory -Path $script:Arbeit | Out-Null
    try {
        . (Join-Path $o.FullName 'pruefung.ps1')
    } finally {
        Remove-Item -Recurse -Force $script:Arbeit -ErrorAction SilentlyContinue
    }
}

Write-Host ''
Write-Host "$script:Gut von $script:Gesamt Aufgaben stimmen." -ForegroundColor White
if ($script:Gut -ne $script:Gesamt) { exit 1 }
