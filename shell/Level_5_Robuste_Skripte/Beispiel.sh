#!/usr/bin/env bash
# Level 5: Robuste Skripte.
set -euo pipefail

arbeit="$(mktemp -d)"
trap 'rm -rf "$arbeit"; printf "aufgeräumt: %s\n" "$arbeit"' EXIT

melde() { printf '%s\n' "$*" >&2; }

anlegen() {
  local ordner="$1" anzahl="$2" i
  for ((i = 1; i <= anzahl; i++)); do
    printf 'Zeile %d\n' "$i" > "$ordner/datei $i.txt"
  done
}

zaehle_zeilen() {
  local gesamt=0 datei
  while IFS= read -r -d '' datei; do
    gesamt=$(( gesamt + $(wc -l < "$datei") ))
  done < <(find "$1" -type f -name '*.txt' -print0)
  printf '%d\n' "$gesamt"
}

anlegen "$arbeit" 3
melde "drei Dateien angelegt in $arbeit"
printf 'Zeilen insgesamt: %s\n' "$(zaehle_zeilen "$arbeit")"

# pipefail zeigen, ohne das Skript zu beenden:
if grep -q "gibtesnicht" /etc/hostname | cat; then :; fi
printf 'Mit pipefail meldet die Pipe den Fehler: %d\n' "${PIPESTATUS[0]}"

# Warum local: ohne es überschriebe die Funktion das i des Aufrufers.
i="wichtig"
anlegen "$arbeit" 1
printf 'i ist nach dem Funktionsaufruf noch: %s\n' "$i"
