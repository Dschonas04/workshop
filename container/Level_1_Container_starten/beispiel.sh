#!/usr/bin/env bash
# Level 1: zum Mitlesen und Ausprobieren.
set -u
. "$(dirname "$0")/../werkzeug.sh"
W="$(werkzeug_finden)"
[ -n "$W" ] || { echo "Weder Docker noch Podman gefunden."; exit 1; }
echo "Benutzt wird: $W"

echo "--- Ein Container, ein Befehl, dann weg ---"
$W run --rm alpine:3.20 echo "Hallo aus dem Container"

echo "--- Der Container hat sein eigenes Dateisystem ---"
$W run --rm alpine:3.20 sh -c 'echo eigen > /tmp/x; cat /tmp/x'
echo "Auf dem Wirt gibt es /tmp/x aus dem Container nicht:"
[ -e /tmp/x ] && echo "doch?" || echo "richtig, nicht vorhanden"

echo "--- Umgebungsvariablen ---"
$W run --rm -e GRUSS=Moin alpine:3.20 sh -c 'echo "$GRUSS"'

echo "--- Im Hintergrund, dann nachsehen ---"
$W run -d --name workshop-beispiel alpine:3.20 sleep 20 >/dev/null
$W ps --filter name=workshop-beispiel --format '{{.Names}} läuft mit {{.Command}}'
$W exec workshop-beispiel sh -c 'echo "von innen: $(hostname)"'
$W stop workshop-beispiel >/dev/null
$W rm workshop-beispiel >/dev/null
echo "wieder aufgeräumt"
