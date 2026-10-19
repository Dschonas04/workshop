#!/usr/bin/env bash
set -u
ordner="$1"; modus="$2"; grund="$3"
skript="${grund}.sh"
$W rm -f workshop-1 >/dev/null 2>&1
ausgabe="$(bash "$skript" 2>/dev/null)"

pruefe "1.1 Container gibt etwas aus"       "$(sed -n 1p <<<"$ausgabe")" "hallo workshop"
pruefe "1.2 Umgebungsvariable gesetzt"      "$(sed -n 2p <<<"$ausgabe")" "container"
pruefe "1.4 Befehl im laufenden Container"  "$(sed -n 3p <<<"$ausgabe")" "von innen"
pruefe "1.3/1.5 Container hieß workshop-1"      "$(sed -n 4p <<<"$ausgabe")" "workshop-1"
pruefe "1.1 --rm hat aufgeräumt" \
  "$($W ps -a --format '{{.Image}}' 2>/dev/null | grep -c '^alpine:3.20$')" "0"
$W rm -f workshop-1 >/dev/null 2>&1
