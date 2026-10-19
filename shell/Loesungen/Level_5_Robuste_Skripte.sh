#!/usr/bin/env bash
# Musterlösung zu Level 5.

set -euo pipefail

arbeit="$(mktemp -d)"
trap 'rm -rf "$arbeit"' EXIT

melde() {
  printf '%s\n' "$*" >&2
}
melde "Start"

verdopple() {
  local zahl="$1"
  printf '%d\n' "$(( zahl * 2 ))"
}
verdopple 21

for n in 1 2 3; do : > "$arbeit/datei $n.txt"; done

anzahl=0
while IFS= read -r -d '' datei; do
  anzahl=$(( anzahl + 1 ))
done < <(find "$arbeit" -type f -name '*.txt' -print0)
echo "$anzahl"

exit 3
