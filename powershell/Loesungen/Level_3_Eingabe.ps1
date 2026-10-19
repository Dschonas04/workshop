# Musterlösung Level 3

# 3.1
$eingabeName = Read-Host "Wie heißt du"
Write-Host "Hallo $eingabeName! Willkommen!" -ForegroundColor Green

# 3.2 -- Read-Host liefert Text, [int] macht eine Zahl daraus
[int]$zahl1 = Read-Host "Erste Zahl"
[int]$zahl2 = Read-Host "Zweite Zahl"
$summe = $zahl1 + $zahl2
Write-Host "$zahl1 + $zahl2 = $summe"

# 3.3
Write-Host "Differenz: $($zahl1 - $zahl2)"
Write-Host "Produkt: $($zahl1 * $zahl2)"
Write-Host "Quotient: $([math]::Round($zahl1 / $zahl2, 2))"

# 3.4
[double]$a = Read-Host "Zahl 1"
[double]$b = Read-Host "Zahl 2"
$op = Read-Host "Operator (+, -, *, /)"
switch ($op) {
    "+" { $ergebnis = $a + $b }
    "-" { $ergebnis = $a - $b }
    "*" { $ergebnis = $a * $b }
    "/" { $ergebnis = $a / $b }
    default { $ergebnis = "unbekannter Operator" }
}
Write-Host "$a $op $b = $ergebnis"

# 3.5 -- -as gibt $null statt eines Fehlers
$zahl = (Read-Host "Eine ganze Zahl") -as [int]
if ($null -eq $zahl) {
    Write-Host "Das ist keine Zahl."
} else {
    Write-Host "Doppelt: $($zahl * 2)"
}
