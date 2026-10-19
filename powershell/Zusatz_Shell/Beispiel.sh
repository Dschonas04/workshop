#!/bin/bash
# ================================================================
#  Zusatz: Shell-Scripting (Bash) – BEISPIELE
#  Ausführen: chmod +x Beispiel.sh && ./Beispiel.sh
#  Oder:      bash Beispiel.sh
# ================================================================

echo "========================================"
echo "  Willkommen zum Shell-Kurs!"
echo "========================================"
echo ""

# --- Variablen ---
name="Shell-Schüler"
alter=25
naechstes_jahr=$((alter + 1))
echo "Hallo $name!"
echo "Du bist $alter Jahre alt."
echo "Nächstes Jahr bist du $naechstes_jahr."
echo ""

# --- Benutzereingabe ---
read -p "Wie heißt du? " benutzername
echo "Hallo $benutzername, schöner Name!"
echo ""

# --- Rechnen ---
a=15
b=4
echo "Rechnen:"
echo "  $a + $b = $((a + b))"
echo "  $a - $b = $((a - b))"
echo "  $a * $b = $((a * b))"
echo "  $a / $b = $((a / b)) (Integer!)"
echo "  $a % $b = $((a % b)) (Modulo)"
echo ""

# --- Bedingungen ---
zahl=42
echo "Bedingungen:"
if [ $zahl -ge 40 ]; then
    echo "  $zahl ist größer oder gleich 40."
else
    echo "  $zahl ist kleiner als 40."
fi

if [ -f "Beispiel.sh" ]; then
    echo "  Diese Datei (Beispiel.sh) existiert!"
fi
echo ""

# --- Schleifen ---
echo "For-Schleife (Liste):"
for frucht in Apfel Birne Kirsche Mango; do
    echo "  - $frucht"
done
echo ""

echo "For-Schleife (Zählen 1-5):"
for i in $(seq 1 5); do
    echo "  Nummer: $i"
done
echo ""

echo "While-Schleife (Countdown):"
count=5
while [ $count -gt 0 ]; do
    echo "  $count..."
    count=$((count - 1))
done
echo "  Start!"
echo ""

# --- Dateiverwaltung ---
echo "Dateiverwaltung:"
testordner="TestOrdner"
mkdir -p "$testordner"

echo "Zeile 1: Hallo Welt" > "$testordner/test.txt"
echo "Zeile 2: Shell ist mächtig" >> "$testordner/test.txt"
echo "Zeile 3: Fertig!" >> "$testordner/test.txt"

echo "  Inhalt von test.txt:"
while IFS= read -r zeile; do
    echo "    > $zeile"
done < "$testordner/test.txt"
echo ""

echo "  Anzahl Zeilen: $(wc -l < "$testordner/test.txt")"
echo ""

# Weitere Dateien erstellen
echo "Server-Info" > "$testordner/server.txt"
echo "User-Info" > "$testordner/user.txt"

echo "  Dateien im Ordner:"
for datei in "$testordner"/*; do
    groesse=$(wc -c < "$datei")
    echo "    $(basename "$datei") ($groesse Bytes)"
done
echo ""

# Aufräumen
rm -rf "$testordner"
echo "  Ordner aufgeräumt."
echo ""

# --- Funktionen ---
echo "Funktionen:"

begrüßung() {
    echo "  Hallo, $1!"
}

addiere() {
    echo $(($1 + $2))
}

begrüßung "Welt"
begrüßung "Shell"

ergebnis=$(addiere 10 20)
echo "  10 + 20 = $ergebnis"
echo ""

# --- Pipeline ---
echo "Pipeline-Beispiele:"

# Dateien im aktuellen Ordner (Top 5 nach Größe)
echo "  Top 5 Dateien (nach Größe):"
ls -lS *.sh *.txt 2>/dev/null | head -5 | while read -r zeile; do
    echo "    $zeile"
done
echo ""

# Systeminformationen
echo "System-Info:"
echo "  Benutzer: $(whoami)"
echo "  Computer: $(hostname)"
echo "  Datum:    $(date)"
echo "  Ordner:   $(pwd)"
echo "  Shell:    $SHELL"
echo ""

echo "========================================"
echo "  Alle Beispiele abgeschlossen!"
echo "========================================"
