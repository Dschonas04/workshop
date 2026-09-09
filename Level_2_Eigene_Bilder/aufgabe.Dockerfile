# ================================================================
#  Level 2: Eigene Bilder -- AUFGABE
#  Ersetze jedes ___. Gebaut wird aus dem Ordner bau/.
#  Prüfen mit:  ./pruefen.sh 2
# ================================================================

# AUFGABE 2.1: Grundlage ist alpine:3.20 -- mit fester Fassung,
# nicht latest.
___ alpine:3.20

# AUFGABE 2.2: Arbeitsverzeichnis /app.
___ /app

# AUFGABE 2.3: Lege einen Nutzer "dienst" an und wechsle zu ihm,
# damit im Container nicht root läuft.
RUN adduser -D ___
# (der Wechsel kommt weiter unten, nach dem Kopieren)

# AUFGABE 2.4: Kopiere start.sh aus dem Kontext nach /app.
___ start.sh .

RUN chmod +x start.sh

# AUFGABE 2.5: Setze die Umgebungsvariable NAME auf "kursbild".
___ NAME=kursbild

# Jetzt der Wechsel zum Nutzer (siehe 2.3).
___ dienst

# AUFGABE 2.6: Startbefehl in Klammerform, damit keine Shell
# dazwischensteht.
___ ["./start.sh"]
