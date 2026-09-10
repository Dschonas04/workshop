#!/usr/bin/env bash
set -u
quelle="$1"; hier="$(cd Level_4_Module && pwd)"
arbeit="$(mktemp -d)"; cp "$quelle" "$arbeit/main.tf"
mkdir -p "$arbeit/modul"
if [[ "$quelle" == Loesungen/* ]]; then
  cp -r Loesungen/Level_4_Module_modul/dienst "$arbeit/modul/"
else
  cp -r "$hier/modul/dienst" "$arbeit/modul/"
fi
(cd "$arbeit" && tofu init -input=false >/dev/null 2>&1 && tofu apply -auto-approve -input=false >/tmp/tf4.log 2>&1)
pruefe "4.0 apply läuft durch" "$(grep -c 'Apply complete' /tmp/tf4.log)" "1"
pruefe "4.1/4.3 web.conf aus dem Modul" \
  "$(cat "$arbeit/ausgabe/web.conf" 2>/dev/null | tr '\n' '|')" "name = web|port = 80|"
pruefe "4.3 api.conf mit eigenem Port" \
  "$(sed -n 's/^port = //p' "$arbeit/ausgabe/api.conf" 2>/dev/null)" "8080"
pruefe "4.2/4.4 Pfade aus den Modulausgaben" \
  "$(sed 's|.*/||' "$arbeit/ausgabe/pfade.txt" 2>/dev/null | tr '\n' ' ')" "web.conf api.conf "
pruefe "4.3 zwei getrennte Modulinstanzen im Zustand" \
  "$(cd "$arbeit" && tofu state list 2>/dev/null | grep -c '^module\.')" "2"
rm -rf "$arbeit"
