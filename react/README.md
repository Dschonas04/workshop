# React-Kurs

[![Prüfung](https://github.com/Dschonas04/React-Kurs/actions/workflows/pruefen.yml/badge.svg)](https://github.com/Dschonas04/React-Kurs/actions/workflows/pruefen.yml)
[![Lizenz: CC BY-SA 4.0](https://img.shields.io/badge/Lizenz-CC%20BY--SA%204.0-lightgrey.svg)](LICENSE)
[![Code: MIT](https://img.shields.io/badge/Code-MIT-blue.svg)](LICENSE-CODE)

React in vier Leveln, geprüft von Vitest und der Testing Library --
also mit den Werkzeugen, mit denen in React wirklich getestet wird.

## Einrichten

```bash
npm install
```

## Aufbau

| Datei                  | Zweck                                            |
| ---------------------- | ------------------------------------------------ |
| `theorie.txt`          | Konzepte lesen und verstehen                     |
| `Aufgabenstellung.txt` | was zu tun ist, in Worten                        |
| `uebung.jsx`           | deine Komponenten -- die Exporte stehen schon da  |
| `uebung.test.jsx`      | die Tests. **Nicht ändern**, sie sind die Aufgabe |

Die Musterlösungen liegen gesammelt in [`Loesungen/`](Loesungen/) und
laufen gegen dieselben Tests.

Die Exporte bleiben stehen, weil die Tests sie so importieren. Eine ganz
leere Datei würde am Import scheitern, und die Fehlermeldung hätte nichts
mit der Aufgabe zu tun.

## Los geht es

```bash
./pruefen.sh             # alle Level
./pruefen.sh 2           # nur Level 2
./pruefen.sh abschluss   # die Abschlussaufgabe
./pruefen.sh --loesung   # prüft die Musterlösungen, muss grün sein

npm run test:beobachten  # läuft mit und prüft bei jedem Speichern
```

## Level

| Level                                       | Thema                                        |
| -------------------------------------------- | -------------------------------------------- |
| [Level 1](level1_komponenten/)                | Komponenten, JSX, Props, children, Listen    |
| [Level 2](level2_zustand/)                    | useState, Ereignisse, kontrollierte Felder   |
| [Level 3](level3_listen_formulare/)           | Listen ändern, Formulare, Meldung nach oben  |
| [Level 4](level4_effekte_hooks/)              | useEffect, Aufräumen, eigene Hooks           |
| [Abschluss](abschluss/)                       | eine kleine Notizverwaltung                  |

## Wie hier getestet wird

Die Tests suchen nichts über CSS-Klassen oder `querySelector`, sondern
so, wie ein Mensch die Oberfläche benutzt:

```js
screen.getByRole('button', { name: 'hinzufügen' })
screen.getByLabelText('Aufgabe')
await nutzer.click(...)
```

Das hat einen Nebeneffekt, der zum Lernen gehört: eine Lösung, die keine
`<label>` mit `htmlFor` hat, ist für den Test unsichtbar -- und für einen
Screenreader auch. Zugänglichkeit ist hier keine Zusatzaufgabe, sondern
die Bedingung, unter der die Prüfung überhaupt findet, was du gebaut hast.

In Level 4 prüft ein Test nach dem Aushängen `vi.getTimerCount()`. Wer das
`clearInterval` vergisst, wird rot -- der klassische Fehler, der sich
sonst erst als langsam wachsender Speicherverbrauch zeigt.

## Voraussetzungen

Node 18 oder neuer. Prüfen mit `node -v`.

## Mitmachen

Fehler gefunden oder eine Idee für eine Aufgabe? Siehe
[CONTRIBUTING.md](CONTRIBUTING.md).

## Lizenz

Die Kurstexte (Theorie, Aufgabenstellungen, README) stehen unter
[CC BY-SA 4.0](LICENSE): frei nutzbar und veränderbar, mit Namensnennung
und unter gleichen Bedingungen. Der Code (Beispiele, Musterlösungen,
Prüfer) steht unter der [MIT-Lizenz](LICENSE-CODE).
