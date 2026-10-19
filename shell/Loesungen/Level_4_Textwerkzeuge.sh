#!/usr/bin/env bash
# Musterlösung zu Level 4.
# Die Daten liegen beim Level, diese Datei in Loesungen/.
cd "$(dirname "$0")/../Level_4_Textwerkzeuge"

grep -c " 404 " daten/zugriffe.log

awk '{print $1}' daten/zugriffe.log | sort -u

awk '{print $1}' daten/zugriffe.log | sort | uniq -c | sort -rn

awk '{summe += $NF} END {print summe}' daten/zugriffe.log

awk -F';' '$2 == "Technik" {print $1}' daten/mitarbeiter.csv

sed 's/;/,/g' daten/mitarbeiter.csv | sed -n '2p'
