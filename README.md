# Container-Kurs

Docker, Compose und Podman in fünf Leveln, mit einem Prüfer, der nach
jeder Aufgabe sagt, ob sie stimmt.

Der Kurs läuft **mit Docker und mit Podman**. Der Prüfer nimmt, was da
ist. Dass beides fast gleich zu bedienen ist, gehört zum Lernstoff.

## Aufbau

| Datei                    | Zweck                                     |
| ------------------------ | ----------------------------------------- |
| `theorie.txt`            | Konzepte lesen und verstehen              |
| `beispiel.sh`            | Lauffähiges Beispiel (Level 1)            |
| `Aufgabenstellung.txt`   | was zu tun ist, in Worten                 |
| `uebung.*`               | deine Lösung -- eine leere Datei zum Anfangen |

Die Musterlösungen liegen gesammelt in [`Loesungen/`](Loesungen/), nicht
neben der Aufgabe.

Je nach Level ist die Aufgabe ein Shell-Skript, ein Dockerfile oder eine
compose.yaml -- so, wie die Sache es verlangt.

## Los geht es

```bash
./pruefen.sh             # alles prüfen
./pruefen.sh 3           # nur Level 3
./pruefen.sh --loesung   # prüft die Musterlösungen, muss grün sein
```

Der erste Lauf holt `alpine:3.20` aus dem Netz, danach geht es offline.

## Level

| Level                                     | Thema                                        |
| ------------------------------------------ | -------------------------------------------- |
| [Level 1](Level_1_Container_starten/)       | Bild und Container, run, exec, logs, Marken  |
| [Level 2](Level_2_Eigene_Bilder/)           | Dockerfile, Schichten, CMD, nicht als root   |
| [Level 3](Level_3_Daten_Netz/)              | Volumes, Bind Mounts, Netze, Umgebung        |
| [Level 4](Level_4_Compose/)                 | compose.yaml, mehrere Dienste, depends_on    |
| [Level 5](Level_5_Podman/)                  | rootless, kein Daemon, Pods, systemd         |
| [Abschluss](Abschluss_Aufgabe/)             | Bild bauen, Volume, Aufbau, zweimal starten  |

## Was der Prüfer zusätzlich prüft

* In Level 2, dass der Container **nicht als root** läuft. Zwei Zeilen
  im Dockerfile, die fast immer fehlen.
* In Level 3, dass ein `:ro`-Mount das Schreiben wirklich verhindert --
  nicht die Absicht zählt, sondern der Fehlschlag.
* In Level 3, dass sich zwei Container **über ihren Namen** erreichen.
  Im Vorgabenetz geht das nicht, im eigenen schon.
* Im Abschluss läuft der Aufbau **zweimal**. Beim zweiten Mal muss der
  Zähler auf 2 stehen: nur dann hat das Volume überlebt, und genau das
  ist der Unterschied zwischen einem Container und einer Datenbank, die
  ihre Daten behält.

## Voraussetzungen

Docker oder Podman.

```bash
podman --version    # Debian/Ubuntu: apt install podman -- kein Daemon, kein root
docker --version
```

Für Level 4 und den Abschluss zusätzlich `docker compose`,
`podman compose` oder `podman-compose`. Fehlt das, melden diese beiden
Level es und der Rest läuft weiter.
