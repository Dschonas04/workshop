#!/usr/bin/env bash
# ================================================================
#  Prüfer für den Container-Kurs.
#
#    ./pruefen.sh            alle Level
#    ./pruefen.sh 3          nur Level 3
#    ./pruefen.sh --loesung  prüft die Musterlösungen
#
#  Er benutzt, was da ist: Docker oder Podman. Die Befehle sind zu
#  fast allem dasselbe -- genau das ist eine der Lektionen.
# ================================================================
set -uo pipefail
cd "$(dirname "$0")"
. ./werkzeug.sh

GRUEN=$'\e[32m'; ROT=$'\e[31m'; GRAU=$'\e[90m'; FETT=$'\e[1m'; AUS=$'\e[0m'
[ -t 1 ] || { GRUEN=""; ROT=""; GRAU=""; FETT=""; AUS=""; }

W="$(werkzeug_finden)"
if [ -z "$W" ]; then
  printf '%sWeder Docker noch Podman gefunden.%s\n\n' "$ROT" "$AUS"
  printf 'Der Kurs braucht eines von beiden:\n'
  printf '  Debian/Ubuntu:  apt install podman   (kein Daemon, kein root)\n'
  printf '  oder Docker:    https://docs.docker.com/engine/install/\n'
  exit 1
fi
printf '%sWerkzeug: %s%s\n' "$GRAU" "$W" "$AUS"

gesamt=0; gut=0
pruefe() {
  local name="$1" ist="$2" soll="$3"
  gesamt=$((gesamt + 1))
  if [ "$ist" = "$soll" ]; then
    gut=$((gut + 1)); printf '  %s✓%s %s\n' "$GRUEN" "$AUS" "$name"
  else
    printf '  %s✗%s %s\n' "$ROT" "$AUS" "$name"
    printf '     %serwartet:%s %s\n' "$GRAU" "$AUS" "$(printf '%q' "$soll")"
    printf '     %sbekommen:%s %s\n' "$GRAU" "$AUS" "$(printf '%q' "$ist")"
  fi
}

welche="${1:-alle}"
modus="aufgabe"
[ "$welche" = "--loesung" ] && { modus="loesung"; welche="alle"; }

for ordner in Level_*/ Abschluss_Aufgabe/; do
  [ -f "$ordner/pruefung.sh" ] || continue
  nummer="$(sed -n 's/^Level_\([0-9]*\).*/\1/p' <<<"$ordner")"
  [ "$welche" != "alle" ] && [ "$welche" != "$nummer" ] && continue
  printf '\n%s%s%s\n' "$FETT" "${ordner%/}" "$AUS"
  # Das Prüfskript bekommt den Ordner und den Modus und sucht sich
  # seine Dateien selbst -- die heißen je nach Level anders.
  if [ "$modus" = loesung ]; then
    grund="Loesungen/${ordner%/}"
  else
    grund="${ordner}uebung"
  fi
  source "$ordner/pruefung.sh" "${ordner%/}" "$modus" "$grund"
done

printf '\n%s%d von %d Aufgaben stimmen.%s\n' "$FETT" "$gut" "$gesamt" "$AUS"
[ "$gut" -eq "$gesamt" ] || exit 1
