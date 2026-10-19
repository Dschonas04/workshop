#!/usr/bin/env bash
set -u
quelle="$1"; arbeit="$(mktemp -d)"; cp "$quelle" "$arbeit/main.tf"
(cd "$arbeit" && tofu init -input=false >/dev/null 2>&1 && tofu apply -auto-approve -input=false >/tmp/tf3.log 2>&1)
pruefe "3.0 apply läuft durch" "$(grep -c 'Apply complete' /tmp/tf3.log)" "1"
pruefe "3.2 web.conf aus for_each" "$(cat "$arbeit/ausgabe/web.conf" 2>/dev/null)" "port = 80"
pruefe "3.2 api.conf aus for_each" "$(cat "$arbeit/ausgabe/api.conf" 2>/dev/null)" "port = 8080"
pruefe "3.1 inaktiver Dienst bleibt aus" \
  "$([ -e "$arbeit/ausgabe/alt.conf" ] && echo da || echo weg)" "weg"
pruefe "3.3 drei nummerierte Dateien" \
  "$(cat "$arbeit"/ausgabe/knoten-*.txt 2>/dev/null | tr '\n' ' ')" "Knoten 0 Knoten 1 Knoten 2 "
pruefe "3.4 Namen sortiert" "$(cat "$arbeit/ausgabe/namen.txt" 2>/dev/null)" "api, web"
pruefe "3.5 Ausgabewert anzahl" "$(cd "$arbeit" && tofu output -raw anzahl 2>/dev/null)" "2"
# Adressen prüfen: for_each benennt nach Schlüssel, nicht nach Position.
pruefe "3.2 Adresse ist der Name, nicht die Position" \
  "$(cd "$arbeit" && tofu state list 2>/dev/null | grep -c 'local_file.dienst\["web"\]')" "1"
rm -rf "$arbeit"
