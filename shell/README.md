# Shell-Kurs

[![Prüfung](https://github.com/Dschonas04/Shell-Kurs/actions/workflows/pruefen.yml/badge.svg)](https://github.com/Dschonas04/Shell-Kurs/actions/workflows/pruefen.yml)
[![Lizenz: CC BY-SA 4.0](https://img.shields.io/badge/Lizenz-CC%20BY--SA%204.0-lightgrey.svg)](LICENSE)
[![Code: MIT](https://img.shields.io/badge/Code-MIT-blue.svg)](LICENSE-CODE)

Bash Schritt für Schritt in fünf Leveln, mit einem Prüfer, der dir sagt,
ob deine Lösung stimmt.

## Aufbau

Jedes Level hat vier Dateien:

| Datei                   | Zweck                                        |
| ----------------------- | -------------------------------------------- |
| `Theorie.txt`           | Konzepte lesen und verstehen                 |
| `Beispiel.sh`           | Lauffähige Beispiele anschauen und ausführen |
| `Aufgabenstellung.txt`  | was zu tun ist, in Worten                    |
| `uebung.sh`             | deine Lösung -- eine leere Datei zum Anfangen |

Dazu je Level ein `pruefung.sh`. Das ist der Unterschied zu einem Buch:
du bekommst nach jeder Aufgabe eine Antwort, ohne jemanden fragen zu müssen.

Die Musterlösungen liegen **nicht** neben der Aufgabe, sondern gesammelt
in [`Loesungen/`](Loesungen/). Wer sie sehen will, muss hingehen -- das ist
Absicht: mit der Lösung im selben Ordner schaut man hin, bevor man denkt.

## Los geht es

```bash
./Start_Kurs.sh          # Menü durch alle Level
./pruefen.sh             # alles prüfen
./pruefen.sh 3           # nur Level 3
./pruefen.sh --loesung   # prüft die Musterlösungen, muss grün sein
```

Ohne Menü genügt auch: Ordner öffnen, `Theorie.txt` lesen, `Beispiel.sh`
ausführen, `Aufgabenstellung.txt` lesen, `uebung.sh` schreiben,
`../pruefen.sh <nummer>` aufrufen.

## Level

| Level                                            | Thema                                        |
| ------------------------------------------------ | -------------------------------------------- |
| [Level 1](Level_1_Ausgabe_Variablen/)             | Ausgabe, Variablen, Anführungszeichen         |
| [Level 2](Level_2_Bedingungen/)                   | Bedingungen und Exit-Codes                    |
| [Level 3](Level_3_Schleifen_Argumente/)           | Schleifen und Argumente                       |
| [Level 4](Level_4_Textwerkzeuge/)                 | grep, cut, sort, uniq, awk, sed               |
| [Level 5](Level_5_Robuste_Skripte/)               | set -euo pipefail, trap, Funktionen           |
| [Abschluss](Abschluss_Aufgabe/)                   | ein Werkzeug, das jemand benutzen kann        |

## Voraussetzungen

Bash 4 oder neuer und die üblichen Werkzeuge (grep, sed, awk, sort, uniq,
find, mktemp). Auf einem Linux oder macOS ist alles da. Unter Windows über
WSL oder Git Bash.

## Warum du mit einer leeren Datei anfängst

Ein Lückentext prüft, ob du das fehlende Wort errätst. Eine leere Datei
prüft, ob du das Skript schreiben kannst -- und das ist die Fähigkeit,
um die es geht. Der Prüfer sagt dir nach jedem Versuch, was erwartet war
und was herauskam; mehr Hilfe braucht es nicht.

## Mitmachen

Fehler gefunden oder eine Idee für eine Aufgabe? Siehe
[CONTRIBUTING.md](CONTRIBUTING.md).

## Lizenz

Die Kurstexte (Theorie, Aufgabenstellungen, README) stehen unter
[CC BY-SA 4.0](LICENSE): frei nutzbar und veränderbar, mit Namensnennung
und unter gleichen Bedingungen. Der Code (Beispiele, Musterlösungen,
Prüfer) steht unter der [MIT-Lizenz](LICENSE-CODE).
