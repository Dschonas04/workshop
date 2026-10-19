#!/bin/bash
# ================================================================
#  Zusatz: Shell-Scripting (Bash) – AUFGABEN
#  Ersetze ___ durch den richtigen Code.
#  Entferne das # vor den Zeilen, um sie zu aktivieren.
# ================================================================

# ── AUFGABE S.1: Ausgabe & Variablen ────────────────────────
# Erstelle Variablen für deinen Namen und dein Alter.
# Berechne dein Geburtsjahr (aktuelles Jahr - Alter).
# Gib alles formatiert aus.

# name="___"
# alter=___
# geburtsjahr=$((2026 - ___))
# echo "Ich bin $___. Alter: $___. Geburtsjahr: $___."


# ── AUFGABE S.2: Benutzereingabe & Bedingung ───────────────
# Frage den Benutzer nach einer Zahl.
# Wenn positiv → "Positiv", wenn negativ → "Negativ", sonst → "Null".

# read -p "Gib eine Zahl ein: " zahl
# if [ $zahl ___ 0 ]; then
#     echo "___"
# elif [ $zahl ___ 0 ]; then
#     echo "___"
# else
#     echo "___"
# fi


# ── AUFGABE S.3: Schleifen ─────────────────────────────────
# a) Gib das Einmaleins der 7 aus (7x1 bis 7x10)
# Tipp: for + $(( )) zum Rechnen

# for i in $(seq 1 ___); do
#     ergebnis=$((___ * ___))
#     echo "7 x $i = $___"
# done


# ── AUFGABE S.4: Dateien erstellen & lesen ──────────────────
# Erstelle einen Ordner "ShellTest".
# Schreibe 5 Zeilen in eine Datei "log.txt" (mit >> anhängen).
# Zähle die Zeilen mit wc und gib den Inhalt aus.

# mkdir -p "___"
# echo "Log Eintrag 1" > "ShellTest/log.txt"
# echo "Log Eintrag 2" >> "___"
# echo "___" >> "ShellTest/log.txt"
# echo "___" >> "ShellTest/log.txt"
# echo "___" >> "ShellTest/log.txt"
#
# echo "Anzahl Zeilen: $(wc -l < "___")"
# echo "Inhalt:"
# cat "___"


# ── AUFGABE S.5: Funktionen ────────────────────────────────
# Schreibe eine Funktion "max" die zwei Zahlen vergleicht
# und die größere zurückgibt.
# Teste mit: ergebnis=$(max 15 23)

# ___() {
#     if [ $1 ___ $2 ]; then
#         echo ___
#     else
#         echo ___
#     fi
# }
#
# ergebnis=$(___ 15 23)
# echo "Die größere Zahl ist: $ergebnis"


# ── AUFGABE S.6: Pipeline ──────────────────────────────────
# Liste alle .sh Dateien im aktuellen Ordner auf,
# sortiere nach Größe (absteigend) und zeige nur die
# Top 3 mit Dateiname und Größe.

# ls -lS ___ | head -___ | while read -r zeile; do
#     echo "$zeile"
# done


# ── BONUS ──────────────────────────────────────────────────
# Schreibe ein Skript, das:
# 1. Einen Ordner "Backup" erstellt
# 2. Alle .sh Dateien dorthin kopiert
# 3. Jede kopierte Datei mit Datum im Namen versieht
#    z.B. Beispiel_2026-03-16.sh
# 4. Die Anzahl der kopierten Dateien ausgibt
# Tipp: date +%Y-%m-%d, cp, for-Schleife, basename

echo ""
echo "Alle Aufgaben befinden sich oben im Code!"
echo "Entferne # und ersetze ___ um sie zu lösen."
