#!/usr/bin/env bash
set -u
ausgabe="$(bash "$1" apfel "birne kiwi" zwetschge 2>/dev/null)"
pruefe "3.1 Anzahl der Argumente" "$(sed -n 1p <<<"$ausgabe")" "3"
pruefe "3.2 Argumente einzeln, zusammengehalten" \
  "$(sed -n '2,4p' <<<"$ausgabe" | tr '\n' ' ')" "[apfel] [birne kiwi] [zwetschge] "
pruefe "3.3 Summe 1 bis 10" "$(sed -n 5p <<<"$ausgabe")" "55"
pruefe "3.4 Zeilen nummeriert, Rand erhalten" \
  "$(sed -n '6,8p' <<<"$ausgabe" | tr '\n' '|')" "1: erste|2:   zweite  |3: dritte|"
pruefe "3.5 nur gerade Zahlen" \
  "$(sed -n '9,13p' <<<"$ausgabe" | tr '\n' ' ')" "2 4 6 8 10 "
