#!/usr/bin/env bash
# Prüft die Lösung zu Level 1. Aufgerufen von ../pruefen.sh mit der zu
# prüfenden Datei als erstem Argument.
set -u
datei="$1"
ausgabe="$(bash "$datei" 2>/dev/null)"
erwartet_zeilen="$(wc -l < /etc/hostname)"

pruefe "1.1 Satz mit Variable" \
  "$(sed -n 1p <<<"$ausgabe")" "Ich lerne Shell."
pruefe "1.2 Dateiname als eine Zeile" \
  "$(sed -n 2p <<<"$ausgabe")" "alter bericht.txt"
pruefe "1.3 Endung abgeschnitten" \
  "$(sed -n 3p <<<"$ausgabe")" "alter bericht"
pruefe "1.4 Multiplikation" \
  "$(sed -n 4p <<<"$ausgabe")" "42"
pruefe "1.5 Vorgabewert" \
  "$(sed -n 5p <<<"$ausgabe")" "unbekannt"
pruefe "1.6 Zeilen gezählt" \
  "$(sed -n 6p <<<"$ausgabe")" "Zeilen: $erwartet_zeilen"
