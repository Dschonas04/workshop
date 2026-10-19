# Musterlösung Level 8

# 8.1
New-Item -Path "MeinTest" -ItemType Directory -Force | Out-Null
"Inhalt 1" | Out-File "MeinTest/datei1.txt"
"Inhalt 2" | Out-File "MeinTest/datei2.txt"
"Inhalt 3" | Out-File "MeinTest/datei3.txt"
$anzahl = (Get-ChildItem "MeinTest" -File).Count
Write-Host "Angelegt: $anzahl Dateien"

# 8.2
Get-ChildItem "MeinTest" -Filter "*.txt" | Sort-Object Name | ForEach-Object {
    $inhalt = Get-Content $_.FullName -Raw
    Write-Host "$($_.Name) : $($inhalt.Trim())"
}

# 8.3
$treffer = Get-ChildItem "MeinTest" -Filter "*.txt" |
    Where-Object { (Get-Content $_.FullName -Raw) -match "3" } |
    Select-Object -ExpandProperty Name
Write-Host "Gefunden: $($treffer -join ', ')"

# 8.4
Get-ChildItem "MeinTest" -Filter "*.txt" | Sort-Object Name |
    Select-Object Name, @{ Name = "Zeichen"; Expression = { (Get-Content $_.FullName -Raw).Trim().Length } } |
    Export-Csv -Path "dateien.csv" -NoTypeInformation
$zeilen = Import-Csv "dateien.csv"
$zeichen = ($zeilen | Measure-Object -Property Zeichen -Sum).Sum
Write-Host "CSV: $($zeilen.Count) Zeilen, zusammen $zeichen Zeichen"

# 8.5
if (Test-Path "MeinTest") { Remove-Item "MeinTest" -Recurse -Force }
if (Test-Path "dateien.csv") { Remove-Item "dateien.csv" -Force }
