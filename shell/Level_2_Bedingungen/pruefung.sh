#!/usr/bin/env bash
set -u
ausgabe="$(bash "$1" 2>/dev/null)"
pruefe "2.1 Datei erkannt"        "$(sed -n 1p <<<"$ausgabe")" "Datei da"
pruefe "2.2 Exit-Code des Fehlers" "$(sed -n 2p <<<"$ausgabe")" "1"
pruefe "2.3 Zahlenvergleich"      "$(sed -n 3p <<<"$ausgabe")" "kleiner"
pruefe "2.4 Leere erkannt"        "$(sed -n 4p <<<"$ausgabe")" "leer"
pruefe "2.5 case über drei Farben" "$(sed -n '5,7p' <<<"$ausgabe" | tr '\n' ' ')" "fahren halten unklar "
pruefe "2.6 Verkettung mit &&"    "$(sed -n 8p <<<"$ausgabe")" "erreichbar"
