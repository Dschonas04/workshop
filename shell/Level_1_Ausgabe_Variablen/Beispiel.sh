#!/usr/bin/env bash
# Level 1: Ausgabe und Variablen -- zum Anschauen und Ausprobieren.
# Starten mit:  bash Beispiel.sh

name="Max"
alter=25

echo "Hallo, $name!"
printf 'Du bist %s Jahre alt.\n' "$alter"

# Geschweifte Klammern, wo der Name sonst weiterläuft:
printf '%s\n' "${name}s Fahrrad"

# Kommandoersetzung
heute="$(date +%F)"
printf 'Heute ist der %s.\n' "$heute"

# Rechnen
printf 'In fünf Jahren bist du %d.\n' "$(( alter + 5 ))"

# Warum Anführungszeichen zählen:
datei="mein bericht.txt"
printf 'Ohne Anführungszeichen sieht die Shell hier %d Wörter:\n' "$(set -- $datei; echo $#)"
printf 'Mit Anführungszeichen genau %d:\n' "$(set -- "$datei"; echo $#)"

# Vorgabewerte und Textzuschnitt
unbekannt=""
printf 'Name oder Vorgabe: %s\n' "${unbekannt:-Gast}"
printf 'Länge von "%s": %d\n' "$name" "${#name}"
printf 'Ohne Endung: %s\n' "${datei%.txt}"
