$faelle = @(
    @{ Arg = @{}; Soll = '7 ist positiv.', 'Du darfst Auto fahren!', 'Wochenstart...', '78 Punkte = Note 2', 'Altersgruppe: Erwachsen' }
    @{ Arg = @{ Zahl = -5; Alter = 17; Fuehrerschein = 'ja'; Tag = 'Samstag'; Punkte = 30 }
       Soll = '-5 ist negativ.', 'Du darfst leider nicht fahren.', 'Wochenende!', '30 Punkte = Note 5', 'Altersgruppe: Jugendlich' }
    @{ Arg = @{ Zahl = 0; Alter = 70; Fuehrerschein = 'nein'; Tag = 'Dienstag'; Punkte = 90 }
       Soll = 'Die Zahl ist null.', 'Du darfst leider nicht fahren.', 'Ein ganz normaler Tag.', '90 Punkte = Note 1', 'Altersgruppe: Senior' }
    @{ Arg = @{ Alter = 12; Tag = 'Freitag'; Punkte = 29 }
       Soll = '7 ist positiv.', 'Du darfst leider nicht fahren.', 'Fast Wochenende!', '29 Punkte = Note 6', 'Altersgruppe: Kind' }
    @{ Arg = @{ Alter = 18; Tag = 'Sonntag'; Punkte = 60 }
       Soll = '7 ist positiv.', 'Du darfst Auto fahren!', 'Wochenende!', '60 Punkte = Note 3', 'Altersgruppe: Erwachsen' }
)
$namen = '4.1 positiv, negativ, null', '4.2 Auto fahren', '4.3 switch über Tage', '4.4 Notenrechner', '4.5 Altersgruppe'
$n = 0
foreach ($fall in $faelle) {
    $n++
    $aus = Starte $Ziel -Argumente $fall.Arg
    for ($i = 0; $i -lt 5; $i++) {
        Pruefe "$($namen[$i]) (Fall $n)" (Zeile $aus ($i + 1)) $fall.Soll[$i]
    }
}
