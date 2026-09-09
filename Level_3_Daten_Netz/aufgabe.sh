#!/usr/bin/env bash
# ================================================================
#  Level 3: Daten, Netz, Umgebung -- AUFGABEN
#  Prüfen mit:  ./pruefen.sh 3
# ================================================================
set -u
. "$(dirname "$0")/../werkzeug.sh"
W="$(werkzeug_finden)"
ARBEIT="$(mktemp -d)"
trap 'rm -rf "$ARBEIT"' EXIT

# ── AUFGABE 3.1 ──────────────────────────────────────────────
# Reiche das Verzeichnis $ARBEIT als /daten in den Container und
# schreibe darin die Datei notiz.txt mit dem Inhalt "aus dem Container".
$W run --rm ___ alpine:3.20 sh -c 'echo "aus dem Container" > /daten/notiz.txt'
cat "$ARBEIT/notiz.txt"

# ── AUFGABE 3.2 ──────────────────────────────────────────────
# Reiche dasselbe Verzeichnis NUR LESEND hinein und versuche zu
# schreiben. Der Befehl muss scheitern; gib dann "schreibgeschuetzt" aus.
$W run --rm ___ alpine:3.20 sh -c 'echo x > /daten/verboten.txt' 2>/dev/null \
  || echo "schreibgeschuetzt"

# ── AUFGABE 3.3 ──────────────────────────────────────────────
# Lege ein Volume namens kurs-daten an, schreibe hinein, entferne
# den Container und lies mit einem NEUEN Container wieder aus.
$W volume create kurs-daten >/dev/null
$W run --rm ___ alpine:3.20 sh -c 'echo "bleibt erhalten" > /v/dauer.txt'
$W run --rm -v kurs-daten:/v alpine:3.20 cat /v/dauer.txt

# ── AUFGABE 3.4 ──────────────────────────────────────────────
# Lege ein Netz kursnetz an, starte darin einen Container "ziel"
# im Hintergrund und erreiche ihn aus einem zweiten ÜBER SEINEN NAMEN.
$W network create kursnetz >/dev/null 2>&1
$W run -d --name ziel ___ kursnetz alpine:3.20 sleep 60 >/dev/null
$W run --rm ___ kursnetz alpine:3.20 sh -c 'getent hosts ziel >/dev/null && echo "ziel erreichbar"'

# Aufräumen (steht schon da).
$W rm -f ziel >/dev/null 2>&1
$W network rm kursnetz >/dev/null 2>&1
$W volume rm kurs-daten >/dev/null 2>&1
