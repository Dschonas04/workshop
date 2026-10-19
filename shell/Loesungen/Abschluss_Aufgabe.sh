#!/usr/bin/env bash
# Musterlösung zur Abschlussaufgabe.
set -euo pipefail

melde() { printf '%s\n' "$*" >&2; }

if (( $# < 1 )); then
  melde "Aufruf: $0 <logdatei>"
  exit 2
fi

log="$1"
if [[ ! -r "$log" ]]; then
  melde "Nicht lesbar: $log"
  exit 1
fi

zeilen="$(wc -l < "$log")"
fehler="$(awk '$(NF-1) >= 400' "$log" | wc -l)"
bytes="$(awk '{summe += $NF} END {printf "%d", summe}' "$log")"

# Häufigste Adresse: zählen, absteigend ordnen, erste Zeile nehmen.
haeufig="$(awk '{print $1}' "$log" | sort | uniq -c | sort -rn | head -1)"
adresse="$(awk '{print $2}' <<<"$haeufig")"
anzahl="$(awk '{print $1}' <<<"$haeufig")"

printf 'Zeilen: %d\n' "$zeilen"
printf 'Fehler: %d\n' "$fehler"
printf 'Haeufigste Adresse: %s (%d)\n' "$adresse" "$anzahl"
printf 'Bytes: %d\n' "$bytes"
