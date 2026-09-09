#!/usr/bin/env bash
set -u
quelle="$1"; ordner="$(cd "$(dirname "$quelle")" && pwd)"
arbeit="$(mktemp -d)"
cp "$quelle" "$arbeit/main.tf"
(
  cd "$arbeit"
  tofu init -input=false >/dev/null 2>&1
  tofu apply -auto-approve -input=false >/tmp/tf-anwenden.log 2>&1
)
pruefe "1.0 apply läuft durch" \
  "$(grep -c 'Apply complete' /tmp/tf-anwenden.log)" "1"
pruefe "1.1 Datei mit richtigem Inhalt" \
  "$(cat "$arbeit/ausgabe/hallo.txt" 2>/dev/null)" "Hallo Terraform"
pruefe "1.2 Bezug auf die andere Ressource" \
  "$(basename "$(cat "$arbeit/ausgabe/verweis.txt" 2>/dev/null)")" "hallo.txt"
pruefe "1.3 Ausgabewert gruss" \
  "$(cd "$arbeit" && tofu output -raw gruss 2>/dev/null)" "Hallo Terraform"
# Ein zweiter plan darf nichts mehr vorhaben.
(cd "$arbeit" && tofu plan -detailed-exitcode -input=false >/dev/null 2>&1); code=$?
pruefe "1.4 zweiter plan hat nichts zu tun" "$code" "0"
rm -rf "$arbeit"
