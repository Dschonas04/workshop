#!/bin/sh
# Zählt bei jedem Start um eins hoch -- der Stand liegt im Volume.
datei=/daten/stand
stand=$(cat "$datei" 2>/dev/null || echo 0)
stand=$((stand + 1))
echo "$stand" > "$datei"
echo "Lauf $stand fuer ${DIENST:-namenlos}"
