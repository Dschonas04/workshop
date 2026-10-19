#!/usr/bin/env bash
# Level 3: Schleifen und Argumente.
# Probier auch:  bash Beispiel.sh eins "zwei drei"

printf 'Skript: %s\n' "$0"
printf 'Argumente: %d\n' "$#"
for arg in "$@"; do
  printf '  [%s]\n' "$arg"
done

printf -- '--- for über eine Liste ---\n'
for name in Anna Bert Carl; do
  printf '%s\n' "$name"
done

printf -- '--- Zählschleife ---\n'
summe=0
for ((i = 1; i <= 5; i++)); do
  summe=$(( summe + i ))
done
printf '1 bis 5 ergibt %d\n' "$summe"

printf -- '--- while über Zeilen ---\n'
verzeichnis="$(mktemp -d)"
printf 'erste Zeile\n  zweite mit Rand  \ndritte\n' > "$verzeichnis/text.txt"
while IFS= read -r zeile; do
  printf '[%s]\n' "$zeile"
done < "$verzeichnis/text.txt"

printf -- '--- Dateien mit Leerzeichen ---\n'
touch "$verzeichnis/mein bericht.txt" "$verzeichnis/notiz.txt"
for datei in "$verzeichnis"/*.txt; do
  [[ -e "$datei" ]] || continue
  printf '%s\n' "${datei##*/}"
done
rm -rf "$verzeichnis"
