#!/usr/bin/env bash
# ================================================================
#  Level 5: Podman -- AUFGABEN
#
#  Diese Aufgaben laufen mit BEIDEN Werkzeugen. Wo Podman etwas
#  anders macht, steht es dabei.
#  Prüfen mit:  ./pruefen.sh 5
# ================================================================
set -u
. "$(dirname "$0")/../werkzeug.sh"
W="$(werkzeug_finden)"
ARBEIT="$(mktemp -d)"
trap 'rm -rf "$ARBEIT"' EXIT

# ── AUFGABE 5.1 ──────────────────────────────────────────────
# Gib aus, welches Werkzeug läuft -- nur "docker" oder "podman".
echo "___"

# ── AUFGABE 5.2 ──────────────────────────────────────────────
# Zeige, unter welcher Kennung ein Container INNEN läuft.
# Erwartet: root (auch bei rootless Podman -- innen ist er root,
# auf dem Wirt bist es du).
$W run --rm alpine:3.20 ___

# ── AUFGABE 5.3 ──────────────────────────────────────────────
# Schreibe aus dem Container eine Datei in $ARBEIT und gib aus,
# WEM sie auf dem Wirt gehört.
# Bei Docker: root. Bei rootless Podman: deine Kennung.
$W run --rm -v "$ARBEIT":/daten alpine:3.20 sh -c 'echo x > /daten/wem.txt'
stat -c '%U' "$ARBEIT/wem.txt"

# ── AUFGABE 5.4 ──────────────────────────────────────────────
# Starte einen Container mit einem festen Namen im Hintergrund und
# gib danach seinen Zustand aus (erwartet: running).
$W run -d --name kurs-5 alpine:3.20 sleep 30 >/dev/null
$W inspect --format '___' kurs-5

# ── AUFGABE 5.5 ──────────────────────────────────────────────
# Halte ihn an und entferne ihn in EINEM Befehl.
$W ___ kurs-5 >/dev/null
echo "entfernt"
