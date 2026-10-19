# PowerShell-Kurs

[![Prüfung](https://github.com/Dschonas04/Powershell-Kurs/actions/workflows/pruefen.yml/badge.svg)](https://github.com/Dschonas04/Powershell-Kurs/actions/workflows/pruefen.yml)
[![Lizenz: CC BY-SA 4.0](https://img.shields.io/badge/Lizenz-CC%20BY--SA%204.0-lightgrey.svg)](LICENSE)
[![Code: MIT](https://img.shields.io/badge/Code-MIT-blue.svg)](LICENSE-CODE)

PowerShell in acht Leveln und einer Abschlussaufgabe, mit einem Prüfer,
der nach jeder Aufgabe sagt, ob sie stimmt.

Gedacht für alle, die noch nie ein Skript geschrieben haben. Level 0
erklärt, wie man eine Skriptdatei anlegt und startet; danach geht es von
der ersten Ausgabe bis zu Funktionen, Dateien und der Pipeline.

## Aufbau

Jedes Level hat vier Dateien:

| Datei                  | Zweck                                          |
| ---------------------- | ---------------------------------------------- |
| `Theorie.txt`          | Konzepte lesen und verstehen                   |
| `Beispiel.ps1`         | Lauffähige Beispiele zum Ausprobieren          |
| `Aufgabenstellung.txt` | was zu tun ist, in Worten                      |
| `uebung.ps1`           | deine Lösung -- du fängst mit einer leeren Datei an |

Die Musterlösungen liegen **nicht** neben der Aufgabe, sondern gesammelt
in [`Loesungen/`](Loesungen/). Wer sie sehen will, muss hingehen.

## Los geht es

```powershell
pwsh ./Start_Kurs.ps1            # Menü durch alle Level, mit Prüfen
pwsh ./pruefen.ps1               # alles prüfen
pwsh ./pruefen.ps1 3             # nur Level 3
pwsh ./pruefen.ps1 abschluss     # nur die Abschlussaufgabe
pwsh ./pruefen.ps1 -Loesung      # prüft die Musterlösungen, muss grün sein
```

Ein Beispiel ausprobieren:

```powershell
pwsh ./Level_1_Ausgabe/Beispiel.ps1
```

In VS Code genügt es, einen Block zu markieren und **F8** zu drücken, um
nur diesen Teil auszuführen.

## Level

| Level                                       | Thema                                      |
| ------------------------------------------- | ------------------------------------------ |
| [Level 0](Level_0_Einstieg/)                | Skriptdateien anlegen und ausführen        |
| [Level 1](Level_1_Ausgabe/)                 | Write-Host, Write-Output, Warnungen        |
| [Level 2](Level_2_Variablen/)               | Variablen, Datentypen, Interpolation       |
| [Level 3](Level_3_Eingabe/)                 | Read-Host, Umwandeln, Rechnen              |
| [Level 4](Level_4_Bedingungen/)             | if, elseif, switch, Parameter              |
| [Level 5](Level_5_Arrays/)                  | Arrays und Hashtables                      |
| [Level 6](Level_6_Schleifen/)               | for, foreach, while, do-while              |
| [Level 7](Level_7_Funktionen/)              | Funktionen, Parameter, Rückgabewerte       |
| [Level 8](Level_8_Dateien_Pipeline/)        | Dateien, Pipeline, CSV                     |
| [Abschluss](Abschluss_Aufgabe/)             | eine Schülerverwaltung, alles zusammen     |

## Was der Prüfer prüft

Der Prüfer startet dein Skript in einer eigenen PowerShell und in einem
leeren Arbeitsordner, also so, wie es auch jemand anderes starten würde.
Was es dort anlegt, räumt er danach weg.

Er schaut nicht nur auf den Text, sondern auch darauf, wie er
herauskommt. In Level 1 zählt, ob eine Zeile von `Write-Host` oder von
`Write-Output` stammt. Das ist der Unterschied, an dem später jede
Pipeline hängt.

Wo das Skript Eingaben braucht, tippt der Prüfer sie für dich. Wo es
Parameter hat, ruft er es mit anderen Werten auf als in der
Aufgabenstellung. Funktionen ruft er direkt auf. Eine Lösung, die nur
für das eine Beispiel stimmt, fällt dabei auf.

In Level 8 läuft das Skript zweimal. Ein Skript, das beim zweiten Mal
über seine eigenen Reste stolpert, ist noch nicht fertig.

## Warum du mit einer leeren Datei anfängst

Ein Lückentext prüft, ob du das fehlende Wort errätst. Eine leere Datei
prüft, ob du das Skript schreiben kannst -- und das ist die Fähigkeit,
um die es geht. Der Prüfer sagt dir nach jedem Versuch, was erwartet war
und was herauskam; mehr Hilfe braucht es nicht.

## Zusatz: andere Skriptsprachen

Zum Vergleichen, ohne Prüfer:

| Ordner                        | Sprache                    | Dateityp |
| ----------------------------- | -------------------------- | -------- |
| [Zusatz_Batch](Zusatz_Batch/) | Batch (Windows CMD)        | `.bat`   |
| [Zusatz_Shell](Zusatz_Shell/) | Bash / Shell (Linux/macOS) | `.sh`    |

Wer Bash richtig lernen will: dafür gibt es den
[Shell-Kurs](https://github.com/Dschonas04/Shell-Kurs), mit Prüfer.

[`Vortrag_Skripte.txt`](Vortrag_Skripte.txt) ist die Vorlage für einen
kurzen Vortrag, was Skripte sind und wofür man sie braucht.

## Voraussetzungen

PowerShell 7 (`pwsh`) auf Windows, Linux oder macOS. Prüfen mit
`$PSVersionTable.PSVersion`. Die Beispiele und Übungen laufen auch im
alten Windows PowerShell 5.1, der Prüfer und das Menü brauchen 7.
PowerShell 7 installieren:
[learn.microsoft.com/powershell](https://learn.microsoft.com/powershell/scripting/install/installing-powershell).

Lässt Windows das Skript nicht laufen, einmalig für den eigenen Benutzer
erlauben:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

## Mitmachen

Fehler gefunden oder eine Idee für eine Aufgabe? Siehe
[CONTRIBUTING.md](CONTRIBUTING.md).

## Lizenz

Die Kurstexte (Theorie, Aufgabenstellungen, README) stehen unter
[CC BY-SA 4.0](LICENSE): frei nutzbar und veränderbar, mit Namensnennung
und unter gleichen Bedingungen. Der Code (Beispiele, Musterlösungen,
Prüfer) steht unter der [MIT-Lizenz](LICENSE-CODE).
