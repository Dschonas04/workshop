#!/usr/bin/env bash
set -u
ordner="$1"; modus="$2"; grund="$3"
$W rm -f kurs-5 >/dev/null 2>&1
ausgabe="$(bash "${grund}.sh" 2>/dev/null)"

pruefe "5.1 Werkzeug erkannt"        "$(sed -n 1p <<<"$ausgabe")" "$W"
pruefe "5.2 innen läuft root"        "$(sed -n 2p <<<"$ausgabe")" "root"
# Bei Docker gehört die Datei root, bei rootless Podman dem Nutzer.
erwartet_eigner="root"; [ "$W" = podman ] && erwartet_eigner="$(id -un)"
pruefe "5.3 Eigentümer auf dem Wirt" "$(sed -n 3p <<<"$ausgabe")" "$erwartet_eigner"
pruefe "5.4 Zustand des Containers"  "$(sed -n 4p <<<"$ausgabe")" "running"
pruefe "5.5 in einem Befehl entfernt" "$(sed -n 5p <<<"$ausgabe")" "entfernt"
pruefe "5.5 wirklich weg" "$($W ps -a --format '{{.Names}}' 2>/dev/null | grep -c '^kurs-5$')" "0"
$W rm -f kurs-5 >/dev/null 2>&1
