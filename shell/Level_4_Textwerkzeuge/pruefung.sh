#!/usr/bin/env bash
set -u
ausgabe="$(bash "$1" 2>/dev/null)"
log="Level_4_Textwerkzeuge/daten/zugriffe.log"

pruefe "4.1 Anzahl der 404" "$(sed -n 1p <<<"$ausgabe")" "$(grep -c ' 404 ' "$log")"
pruefe "4.2 Adressen einmalig, sortiert" \
  "$(sed -n '2,5p' <<<"$ausgabe" | tr '\n' ' ')" "10.0.2.10 10.0.2.11 10.0.2.44 10.0.2.99 "
pruefe "4.3 Rangliste, häufigste zuerst" \
  "$(sed -n 6p <<<"$ausgabe" | awk '{print $1, $2}')" "4 10.0.2.10"
pruefe "4.4 Summe der Bytes" \
  "$(sed -n 10p <<<"$ausgabe")" "$(awk '{s += $NF} END {print s}' "$log")"
pruefe "4.5 Technik-Namen" \
  "$(sed -n '11,13p' <<<"$ausgabe" | tr '\n' ' ')" "Anna Krause Carla Meyer Eva Otto "
pruefe "4.6 Semikolon ersetzt, zweite Zeile" \
  "$(sed -n 14p <<<"$ausgabe")" "Anna Krause,Technik,38"
