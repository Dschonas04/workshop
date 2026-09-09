#!/usr/bin/env bash
set -u
ordner="$1"; modus="$2"
COMPOSE="$(compose_finden "$W")"
if [ -z "$COMPOSE" ]; then
  pruefe "4.0 Compose vorhanden" "fehlt" "docker compose oder podman-compose"
  return 0 2>/dev/null || exit 0
fi

datei="$ordner/${modus}.compose.yaml"
projekt="kurs4"
$COMPOSE -f "$datei" -p "$projekt" down -v >/dev/null 2>&1

hoch="$($COMPOSE -f "$datei" -p "$projekt" up --build --abort-on-container-exit --exit-code-from pruefer 2>&1)"
pruefe "4.1 Aufbau startet" "$(grep -cE 'api gestartet' <<<"$hoch")" "1"
pruefe "4.2 Umgebungsvariable kommt an" "$(grep -c 'GRUSS=moin' <<<"$hoch")" "1"
pruefe "4.3/4.5 Volume wird von beiden gesehen" \
  "$(grep -c 'api gestartet, GRUSS=moin' <<<"$hoch")" "1"

dienste="$($COMPOSE -f "$datei" -p "$projekt" config --services 2>/dev/null | sort | tr '\n' ' ')"
pruefe "4.4 zwei Dienste erklärt" "$dienste" "api pruefer "

$COMPOSE -f "$datei" -p "$projekt" down -v >/dev/null 2>&1
