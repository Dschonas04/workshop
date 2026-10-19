#!/usr/bin/env bash
# ================================================================
#  Prüfer für den React-Kurs. Ruft vitest auf.
#
#    ./pruefen.sh             alle Level
#    ./pruefen.sh 3           nur Level 3
#    ./pruefen.sh abschluss   die Abschlussaufgabe
#    ./pruefen.sh --loesung   prüft die Musterlösungen
# ================================================================
set -uo pipefail
cd "$(dirname "$0")"

[ -d node_modules ] || { printf 'Erst einmal: npm install\n'; exit 1; }

welche="${1:-alle}"
case "$welche" in
  alle)       ziel=(level1_komponenten level2_zustand level3_listen_formulare level4_effekte_hooks abschluss) ;;
  --loesung)  ziel=(Loesungen) ;;
  abschluss)  ziel=(abschluss) ;;
  [0-9]*)     ziel=("$(ls -d level"$welche"_* 2>/dev/null)") ;;
  *)          printf 'Unbekannt: %s\n' "$welche"; exit 1 ;;
esac
[ -n "${ziel[0]:-}" ] || { printf 'Kein Level %s.\n' "$welche"; exit 1; }

npx vitest run "${ziel[@]}"
