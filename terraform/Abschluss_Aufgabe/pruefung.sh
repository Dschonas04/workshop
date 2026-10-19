#!/usr/bin/env bash
set -u
quelle="$1"; arbeit="$(mktemp -d)"; cp "$quelle" "$arbeit/main.tf"
(cd "$arbeit" && tofu init -input=false >/dev/null 2>&1 && tofu apply -auto-approve -input=false >/tmp/tfa.log 2>&1)
pruefe "Abschluss: apply läuft durch" "$(grep -c 'Apply complete' /tmp/tfa.log)" "1"
pruefe "Abschluss: web.conf vollständig" \
  "$(cat "$arbeit/ausgabe/web.conf" 2>/dev/null | tr '\n' '|')" "umgebung = workshop|name = web|port = 80|"
pruefe "Abschluss: api.conf mit Port" \
  "$(sed -n 's/^port = //p' "$arbeit/ausgabe/api.conf" 2>/dev/null)" "8080"
pruefe "Abschluss: inaktiver Dienst fehlt" \
  "$([ -e "$arbeit/ausgabe/alt.conf" ] && echo da || echo weg)" "weg"
pruefe "Abschluss: Übersicht sortiert" "$(cat "$arbeit/ausgabe/uebersicht.txt" 2>/dev/null)" "api, web"
pruefe "Abschluss: Ausgabewert anzahl" "$(cd "$arbeit" && tofu output -raw anzahl 2>/dev/null)" "2"
pruefe "Abschluss: Ausgabewert pfade" \
  "$(cd "$arbeit" && tofu output -json pfade 2>/dev/null | tr -d '\n' | sed 's|[^,]*/||g; s/[]["]//g')" "api.conf,web.conf"
pruefe "Abschluss: for_each statt count" \
  "$(cd "$arbeit" && tofu state list 2>/dev/null | grep -c 'local_file.dienst\["web"\]')" "1"
(cd "$arbeit" && tofu plan -detailed-exitcode -input=false >/dev/null 2>&1); code=$?
pruefe "Abschluss: zweiter plan hat nichts zu tun" "$code" "0"
rm -rf "$arbeit"
