$aus = Starte $Ziel -Eingabe '3', '9', '7' -Fragen 'Rate die Zahl'
$soll61 = 1..10 | ForEach-Object { if ($_ % 2 -eq 0) { "[g] $_ (gerade)" } else { "[u] $_ (ungerade)" } }
Pruefe '6.1 gerade und ungerade' (Zeilen $aus 1 10) $soll61
Pruefe '6.2 nummerierte Tiere' (Zeilen $aus 11 15) @('1. Hund', '2. Katze', '3. Maus', '4. Pferd', '5. Igel')
Pruefe '6.3 Countdown' (Zeilen $aus 16 26) @((10..1 | ForEach-Object { "$_" }) + 'Start!')
Pruefe '6.4 Ratespiel' (Zeilen $aus 27 29) @('Zu niedrig!', 'Zu hoch!', 'Richtig! Die Zahl war 7!')
Pruefe '6.5 Einmaleins der 6' (Zeilen $aus 30 39) (1..10 | ForEach-Object { "6 x $_ = $(6 * $_)" })
$fizz = 1..15 | ForEach-Object {
    if ($_ % 15 -eq 0) { 'FizzBuzz' } elseif ($_ % 3 -eq 0) { 'Fizz' } elseif ($_ % 5 -eq 0) { 'Buzz' } else { "$_" }
}
Pruefe '6.6 FizzBuzz' (Zeilen $aus 40 54) $fizz
