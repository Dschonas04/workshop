#!/usr/bin/env bash
# Musterlösung zu Level 2.

if [[ -f /etc/passwd ]]; then
  echo "Datei da"
else
  echo "Datei fehlt"
fi

grep -q "diesen-text-gibt-es-nicht" /etc/passwd
echo $?

a=12
b=30
if (( a < b )); then
  echo "kleiner"
elif (( a > b )); then
  echo "groesser"
else
  echo "gleich"
fi

name=""
if [[ -z "$name" ]]; then
  echo "leer"
fi

for farbe in gruen rot blau; do
  case "$farbe" in
    gruen) echo "fahren" ;;
    rot)   echo "halten" ;;
    *)     echo "unklar" ;;
  esac
done

[[ -d /tmp ]] && echo "erreichbar"
