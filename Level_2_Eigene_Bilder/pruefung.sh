#!/usr/bin/env bash
set -u
ordner="$1"; modus="$2"
datei="$ordner/${modus}.Dockerfile"
marke="kurs-level2:pruefung"

bau="$($W build -f "$datei" -t "$marke" "$ordner/bau" 2>&1)"
gebaut=$?
pruefe "2.0 Bild lässt sich bauen" "$gebaut" "0"

ausgabe="$($W run --rm "$marke" 2>/dev/null)"
pruefe "2.4/2.6 Startbefehl läuft"  "$(grep -c 'Ich bin' <<<"$ausgabe")" "1"
pruefe "2.5 Umgebungsvariable im Bild" \
  "$(sed -n 's/Ich bin \(.*\) und laufe.*/\1/p' <<<"$ausgabe")" "kursbild"
pruefe "2.3 läuft nicht als root" \
  "$(sed -n 's/.*laufe als \(.*\)\./\1/p' <<<"$ausgabe")" "dienst"
pruefe "2.2 Arbeitsverzeichnis" "$($W run --rm "$marke" pwd 2>/dev/null)" "/app"
$W rmi -f "$marke" >/dev/null 2>&1
