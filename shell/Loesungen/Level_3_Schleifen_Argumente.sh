#!/usr/bin/env bash
# Musterlösung zu Level 3.

echo $#

for arg in "$@"; do
  printf '[%s]\n' "$arg"
done

summe=0
for ((i = 1; i <= 10; i++)); do
  summe=$(( summe + i ))
done
echo "$summe"

datei="$(mktemp)"
printf 'erste\n  zweite  \ndritte\n' > "$datei"

nummer=0
while IFS= read -r zeile; do
  nummer=$(( nummer + 1 ))
  printf '%d: %s\n' "$nummer" "$zeile"
done < "$datei"
rm -f "$datei"

for i in {1..10}; do
  if (( i % 2 != 0 )); then
    continue
  fi
  echo "$i"
done
