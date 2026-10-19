#!/usr/bin/env bash
# Musterlösung zu Level 1.

werkzeug="Shell"
echo "Ich lerne $werkzeug."

datei="alter bericht.txt"
printf '%s\n' "$datei"

printf '%s\n' "${datei%.txt}"

printf '%d\n' "$(( 7 * 6 ))"

ort=""
printf '%s\n' "${ort:-unbekannt}"

anzahl="$(wc -l < /etc/hostname)"
printf 'Zeilen: %s\n' "$anzahl"
