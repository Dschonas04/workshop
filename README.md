# Terraform-Kurs

Terraform beziehungsweise OpenTofu in vier Leveln, mit einem Prüfer, der
nach jeder Aufgabe sagt, ob sie stimmt.

Der Kurs benutzt **nur die Anbieter `local` und `random`**. Es entsteht
nichts in einer Cloud, es kostet nichts, und alles landet in einem
Wegwerf-Verzeichnis.

## Aufbau

| Datei                  | Zweck                                    |
| ---------------------- | ---------------------------------------- |
| `theorie.txt`          | Konzepte lesen und verstehen             |
| `beispiel.tf.txt`      | Beispiel zum Anschauen und Kopieren      |
| `Aufgabenstellung.txt` | was zu tun ist, in Worten                |
| `uebung.tf`            | dein Aufbau -- ein leeres Gerüst zum Anfangen |

Die Musterlösungen liegen gesammelt in [`Loesungen/`](Loesungen/), nicht
neben der Aufgabe.

Der Prüfer kopiert deine `aufgabe.tf` in ein frisches Verzeichnis, ruft
`init` und `apply` auf und sieht sich an, was dabei herauskam. Dein
Kursverzeichnis bleibt sauber, und ein misslungener Versuch hinterlässt
keinen kaputten Zustand.

## Los geht es

```bash
./pruefen.sh             # alles prüfen
./pruefen.sh 3           # nur Level 3
./pruefen.sh --loesung   # prüft die Musterlösungen, muss grün sein
```

Von Hand ausprobieren:

```bash
mkdir -p /tmp/tf && cp Level_1_Erste_Ressource/uebung.tf /tmp/tf/main.tf
cd /tmp/tf && tofu init && tofu apply
```

## Level

| Level                                      | Thema                                     |
| ------------------------------------------- | ----------------------------------------- |
| [Level 1](Level_1_Erste_Ressource/)          | init, plan, apply, Zustand, Bezüge        |
| [Level 2](Level_2_Variablen_Ausgaben/)       | Variablen, Typen, locals, outputs         |
| [Level 3](Level_3_Mehrfach_Ausdruecke/)      | count, for_each, for-Ausdrücke            |
| [Level 4](Level_4_Module/)                   | Module, Ein- und Ausgaben, Wiederverwendung |
| [Abschluss](Abschluss_Aufgabe/)              | eine kleine Auslieferung, alles zusammen  |

## Was der Prüfer zusätzlich prüft

An mehreren Stellen läuft nach dem `apply` noch ein
`plan -detailed-exitcode`. Der muss 0 ergeben, also "nichts zu tun".

Damit fällt der häufigste Anfängerfehler auf: ein Aufbau, der bei jedem
Lauf etwas ändern will. Und im Level über `for_each` schaut der Prüfer in
`tofu state list`, ob die Ressource unter ihrem Namen steht
(`local_file.dienst["web"]`) und nicht unter einer Position. Genau daran
hängt, ob dir das Entfernen eines Listeneintrags später alles andere
mitreißt.

## Voraussetzungen

OpenTofu oder Terraform. Prüfen mit `tofu version` beziehungsweise
`terraform version`. Die Prüfskripte rufen `tofu` auf; für Terraform
genügt ein Alias oder ein Suchen-und-Ersetzen in `*/pruefung.sh`.

Beim ersten Lauf lädt `init` die Anbieter aus dem Netz. Danach geht es
auch offline, solange der Zwischenspeicher steht.
