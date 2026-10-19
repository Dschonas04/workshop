# Die Funktionen werden direkt aufgerufen, mit anderen Werten als in
# der Aufgabenstellung. Was dein Skript selbst ausgibt, zählt hier nicht.
function Ruf([string]$Ausdruck) { Zeile (Starte $Ziel -Danach $Ausdruck) 1 }

Pruefe '7.1 Get-Summe 15 + 27' (Ruf 'Get-Summe -a 15 -b 27') '42'
Pruefe '7.1 Get-Summe -3 + 3' (Ruf 'Get-Summe -a -3 -b 3') '0'
Pruefe '7.1 gibt eine Zahl zurück' (Ruf '(Get-Summe -a 1 -b 2).GetType().Name') 'Int32'
Pruefe '7.2 Rechteck 5 x 3' (Ruf '$r = Get-Rechteck -Länge 5 -Breite 3; "$($r.Fläche) $($r.Umfang)"') '15 16'
Pruefe '7.2 Rechteck 2.5 x 4' (Ruf '$r = Get-Rechteck -Länge 2.5 -Breite 4; "$($r.Fläche) $($r.Umfang)"') '10 13'
Pruefe '7.3 Test-GeradeZahl 4' (Ruf 'Test-GeradeZahl -Zahl 4') 'True'
Pruefe '7.3 Test-GeradeZahl 7' (Ruf 'Test-GeradeZahl -Zahl 7') 'False'
Pruefe '7.3 Test-GeradeZahl 0' (Ruf 'Test-GeradeZahl -Zahl 0') 'True'
Pruefe '7.4 Begrüßung ohne Namen' (Ruf 'Get-Begrüßung') 'Hallo, Welt!'
Pruefe '7.4 Begrüßung mit Namen' (Ruf 'Get-Begrüßung -Name Max') 'Hallo, Max!'
Pruefe '7.5 100 °C in Fahrenheit' (Ruf 'Convert-Temperatur -Wert 100') '212'
Pruefe '7.5 212 °F in Celsius' (Ruf 'Convert-Temperatur -Wert 212 -Von Fahrenheit') '100'
Pruefe '7.5 -40 bleibt -40' (Ruf 'Convert-Temperatur -Wert -40') '-40'
