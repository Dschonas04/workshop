# Musterlösung Level 6

# 6.1
for ($i = 1; $i -le 10; $i++) {
    if ($i % 2 -eq 0) {
        Write-Host "[g] $i (gerade)"
    } else {
        Write-Host "[u] $i (ungerade)"
    }
}

# 6.2
$tiere = @("Hund", "Katze", "Maus", "Pferd", "Igel")
$zähler = 1
foreach ($tier in $tiere) {
    Write-Host "$zähler. $tier"
    $zähler++
}

# 6.3
$countdown = 10
while ($countdown -ge 1) {
    Write-Host $countdown
    $countdown--
}
Write-Host "Start!"

# 6.4
$geheimzahl = 7
do {
    [int]$tipp = Read-Host "Rate die Zahl (1-10)"
    if ($tipp -lt $geheimzahl) {
        Write-Host "Zu niedrig!"
    } elseif ($tipp -gt $geheimzahl) {
        Write-Host "Zu hoch!"
    }
} while ($tipp -ne $geheimzahl)
Write-Host "Richtig! Die Zahl war $geheimzahl!"

# 6.5
$basis = 6
for ($i = 1; $i -le 10; $i++) {
    Write-Host "$basis x $i = $($basis * $i)"
}

# 6.6
foreach ($i in 1..15) {
    if ($i % 15 -eq 0) {
        Write-Host "FizzBuzz"
    } elseif ($i % 3 -eq 0) {
        Write-Host "Fizz"
    } elseif ($i % 5 -eq 0) {
        Write-Host "Buzz"
    } else {
        Write-Host $i
    }
}
