#!/usr/bin/env bash
set -u
ordner="$1"; modus="$2"; grund="$3"
COMPOSE="$(compose_finden "$W")"
if [ -z "$COMPOSE" ]; then
  pruefe "Abschluss: Compose vorhanden" "fehlt" "docker compose oder podman-compose"
  return 0 2>/dev/null || exit 0
fi

# Teil 1: das Bild allein.
marke="kurs-abschluss:pruefung"
$W build -f "${grund}.Dockerfile" -t "$marke" "$ordner/zaehler" >/dev/null 2>&1
gebaut=$?
pruefe "Abschluss: Bild lässt sich bauen" "$gebaut" "0"
lauf="$($W run --rm "$marke" 2>/dev/null)"
pruefe "Abschluss: Startbefehl und DIENST" "$lauf" "Lauf 1 fuer zaehler"

# Teil 2: der Aufbau, zweimal gestartet -- der Stand muss steigen.
datei="${grund}.compose.yaml"
projekt="kursabschluss"
$COMPOSE -f "$datei" -p "$projekt" down -v >/dev/null 2>&1
erst="$($COMPOSE -f "$datei" -p "$projekt" up --build --abort-on-container-exit --exit-code-from leser 2>&1)"
pruefe "Abschluss: erster Lauf zählt auf 1" "$(grep -c 'Lauf 1 fuer zaehler' <<<"$erst")" "1"
zweit="$($COMPOSE -f "$datei" -p "$projekt" up --abort-on-container-exit --exit-code-from leser 2>&1)"
pruefe "Abschluss: Volume überlebt, zweiter Lauf zählt auf 2" \
  "$(grep -c 'Lauf 2 fuer zaehler' <<<"$zweit")" "1"

$COMPOSE -f "$datei" -p "$projekt" down -v >/dev/null 2>&1
$W rmi -f "$marke" >/dev/null 2>&1
