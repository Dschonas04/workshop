$fragen = 'Wie heißt du', 'Erste Zahl', 'Zweite Zahl', 'Zahl 1', 'Zahl 2', 'Operator', 'Eine ganze Zahl'
$aus = Starte $Ziel -Eingabe 'Max', '7', '3', '12', '4', '*', 'abc' -Fragen $fragen
Pruefe '3.1 Begrüßung' (Zeile $aus 1) 'Hallo Max! Willkommen!'
Pruefe '3.2 Summe' (Zeile $aus 2) '7 + 3 = 10'
Pruefe '3.3 Differenz' (Zeile $aus 3) 'Differenz: 4'
Pruefe '3.3 Produkt' (Zeile $aus 4) 'Produkt: 21'
Pruefe '3.3 Quotient' (Zeile $aus 5) 'Quotient: 2.33'
Pruefe '3.4 Taschenrechner mit *' (Zeile $aus 6) '12 * 4 = 48'
Pruefe '3.5 keine Zahl erkannt' (Zeile $aus 7) 'Das ist keine Zahl.'

$aus = Starte $Ziel -Eingabe 'Ida', '9', '3', '9', '2', '-', '41' -Fragen $fragen
Pruefe '3.4 Taschenrechner mit -' (Zeile $aus 6) '9 - 2 = 7'
Pruefe '3.5 Zahl erkannt' (Zeile $aus 7) 'Doppelt: 82'
