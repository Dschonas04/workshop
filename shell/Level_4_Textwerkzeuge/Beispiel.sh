#!/usr/bin/env bash
# Level 4: Textwerkzeuge. Alle Beispiele laufen gegen daten/.
cd "$(dirname "$0")"

printf -- '--- Wie viele Zeilen hat das Log? ---\n'
wc -l < daten/zugriffe.log

printf -- '--- Alle 404-Zeilen ---\n'
grep " 404 " daten/zugriffe.log

printf -- '--- Nur die Adressen daraus ---\n'
awk '$(NF-1) == 404 {print $1}' daten/zugriffe.log

printf -- '--- Rangliste der Adressen ---\n'
awk '{print $1}' daten/zugriffe.log | sort | uniq -c | sort -rn

printf -- '--- Summe der übertragenen Bytes ---\n'
awk '{summe += $NF} END {print summe}' daten/zugriffe.log

printf -- '--- Namen aus der CSV, ohne Kopfzeile ---\n'
sed '1d' daten/mitarbeiter.csv | cut -d';' -f1

printf -- '--- Stunden je Abteilung ---\n'
sed '1d' daten/mitarbeiter.csv |
  awk -F';' '{stunden[$2] += $3} END {for (a in stunden) print a, stunden[a]}' |
  sort
