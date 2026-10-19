#!/usr/bin/env bash
# ================================================================
#  Prüfer für den Go-Kurs.
#
#    ./pruefen.sh            alle Level
#    ./pruefen.sh 3          nur Level 3
#    ./pruefen.sh --loesung  prüft die Musterlösungen
#
#  Geprüft wird mit go test -race: ein Wettlauf zwischen Goroutinen
#  fällt damit hier auf und nicht erst im Betrieb.
# ================================================================
set -uo pipefail
cd "$(dirname "$0")"

GRUEN=$'\e[32m'; ROT=$'\e[31m'; FETT=$'\e[1m'; AUS=$'\e[0m'
[ -t 1 ] || { GRUEN=""; ROT=""; FETT=""; AUS=""; }

welche="${1:-alle}"
pfade=(./level1_grundlagen ./level2_sammlungen ./level3_schnittstellen ./level4_nebenlaeufigkeit ./abschluss)
if [ "$welche" = "--loesung" ]; then
  pfade=(./Loesungen/...)
  welche="alle"
elif [ "$welche" != "alle" ]; then
  treffer=()
  for p in "${pfade[@]}"; do
    case "$p" in *level"$welche"_*) treffer+=("$p");; esac
  done
  [ "$welche" = "abschluss" ] && treffer=(./abschluss)
  pfade=("${treffer[@]}")
fi

[ "${#pfade[@]}" -gt 0 ] || { printf 'Kein Level %s.\n' "$welche"; exit 1; }

printf '%sgo test -race %s%s\n\n' "$FETT" "${pfade[*]}" "$AUS"
if go test -race "${pfade[@]}"; then
  printf '\n%s%sAlles grün.%s\n' "$FETT" "$GRUEN" "$AUS"
else
  printf '\n%s%sNoch nicht. Die Meldungen oben sagen, welcher Test was erwartet hat.%s\n' \
    "$FETT" "$ROT" "$AUS"
  exit 1
fi
