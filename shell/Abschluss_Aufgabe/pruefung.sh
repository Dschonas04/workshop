#!/usr/bin/env bash
set -u
skript="$1"
log="Level_4_Textwerkzeuge/daten/zugriffe.log"

# 1. ohne Argument
ohne_stderr="$(bash "$skript" 2>&1 >/dev/null)"; ohne_code=$?
bash "$skript" >/dev/null 2>&1; ohne_code=$?
pruefe "Abschluss: ohne Argument Exit 2" "$ohne_code" "2"
pruefe "Abschluss: Aufrufhinweis nach stderr" \
  "$(grep -c 'Aufruf:' <<<"$ohne_stderr")" "1"

# 2. nicht lesbare Datei
fehlt_stderr="$(bash "$skript" /gibtesnicht/log 2>&1 >/dev/null)"
bash "$skript" /gibtesnicht/log >/dev/null 2>&1; fehlt_code=$?
pruefe "Abschluss: fehlende Datei Exit 1" "$fehlt_code" "1"
pruefe "Abschluss: Meldung 'Nicht lesbar'" \
  "$(grep -c 'Nicht lesbar' <<<"$fehlt_stderr")" "1"

# 3. Bericht
bericht="$(bash "$skript" "$log" 2>/dev/null)"; code=$?
pruefe "Abschluss: Exit 0 im Normalfall" "$code" "0"
pruefe "Abschluss: Zeilen"   "$(sed -n 1p <<<"$bericht")" "Zeilen: 10"
pruefe "Abschluss: Fehler"   "$(sed -n 2p <<<"$bericht")" "Fehler: 4"
pruefe "Abschluss: Adresse"  "$(sed -n 3p <<<"$bericht")" "Haeufigste Adresse: 10.0.2.10 (4)"
pruefe "Abschluss: Bytes"    "$(sed -n 4p <<<"$bericht")" "Bytes: 17480"
