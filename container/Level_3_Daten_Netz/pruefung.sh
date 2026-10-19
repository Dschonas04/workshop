#!/usr/bin/env bash
set -u
ordner="$1"; modus="$2"; grund="$3"
$W rm -f ziel >/dev/null 2>&1
$W volume rm -f kurs-daten >/dev/null 2>&1
ausgabe="$(bash "${grund}.sh" 2>/dev/null)"
pruefe "3.1 Bind Mount schreibt auf den Wirt" "$(sed -n 1p <<<"$ausgabe")" "aus dem Container"
pruefe "3.2 :ro verhindert das Schreiben"     "$(sed -n 2p <<<"$ausgabe")" "schreibgeschuetzt"
pruefe "3.3 Volume überlebt den Container"    "$(sed -n 3p <<<"$ausgabe")" "bleibt erhalten"
pruefe "3.4 Container erreicht Container über den Namen" \
  "$(sed -n 4p <<<"$ausgabe")" "ziel erreichbar"
$W rm -f ziel >/dev/null 2>&1
$W network rm kursnetz >/dev/null 2>&1
$W volume rm -f kurs-daten >/dev/null 2>&1
