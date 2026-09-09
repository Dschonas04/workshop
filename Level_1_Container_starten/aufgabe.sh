#!/usr/bin/env bash
# ================================================================
#  Level 1: Container starten -- AUFGABEN
#  Ersetze jedes ___. In $W steht docker oder podman.
#  Prüfen mit:  ./pruefen.sh 1
# ================================================================
set -u
. "$(dirname "$0")/../werkzeug.sh"
W="$(werkzeug_finden)"

# ── AUFGABE 1.1 ──────────────────────────────────────────────
# Starte einen Container aus alpine:3.20, der "hallo kurs" ausgibt
# und danach gleich wieder aufgeräumt wird.
$W run ___ alpine:3.20 echo "hallo kurs"

# ── AUFGABE 1.2 ──────────────────────────────────────────────
# Gib den Wert der Umgebungsvariablen KURS aus, die du beim Start
# auf "container" setzt.
$W run --rm ___ alpine:3.20 sh -c 'echo "$KURS"'

# ── AUFGABE 1.3 ──────────────────────────────────────────────
# Starte einen Container im Hintergrund, benannt "kurs-1", der
# 30 Sekunden schläft.
$W run ___ ___ kurs-1 alpine:3.20 sleep 30 >/dev/null

# ── AUFGABE 1.4 ──────────────────────────────────────────────
# Führe in dem laufenden Container einen Befehl aus, der
# "von innen" ausgibt.
$W ___ kurs-1 sh -c 'echo "von innen"'

# ── AUFGABE 1.5 ──────────────────────────────────────────────
# Gib den Namen des laufenden Containers aus -- nur den Namen.
$W ps --filter name=kurs-1 --format '___'

# Aufräumen (steht schon da).
$W stop kurs-1 >/dev/null 2>&1
$W rm kurs-1 >/dev/null 2>&1
