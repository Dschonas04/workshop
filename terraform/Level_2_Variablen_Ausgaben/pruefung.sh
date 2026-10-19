#!/usr/bin/env bash
set -u
quelle="$1"
arbeit="$(mktemp -d)"; cp "$quelle" "$arbeit/main.tf"
(
  cd "$arbeit"
  tofu init -input=false >/dev/null 2>&1
  tofu apply -auto-approve -input=false -var="umgebung=test" >/tmp/tf2.log 2>&1
)
pruefe "2.0 apply mit -var läuft" "$(grep -c 'Apply complete' /tmp/tf2.log)" "1"
pruefe "2.4 Präfix aus Umgebung und Dienst" \
  "$(sed -n 's/^praefix = //p' "$arbeit/ausgabe/bericht.txt" 2>/dev/null)" "test-web"
pruefe "2.2 Port aus dem object" \
  "$(sed -n 's/^port = //p' "$arbeit/ausgabe/bericht.txt" 2>/dev/null)" "8080"
pruefe "2.3/2.5 Knoten groß und verbunden" \
  "$(sed -n 's/^knoten = //p' "$arbeit/ausgabe/bericht.txt" 2>/dev/null)" "ALPHA, BETA, GAMMA"
pruefe "2.6 Ausgabewert praefix" \
  "$(cd "$arbeit" && tofu output -raw praefix 2>/dev/null)" "test-web"
# Vorgabe greift, wenn nichts übergeben wird.
(cd "$arbeit" && tofu apply -auto-approve -input=false >/dev/null 2>&1)
pruefe "2.1 Vorgabe workshop greift ohne -var" \
  "$(sed -n 's/^praefix = //p' "$arbeit/ausgabe/bericht.txt" 2>/dev/null)" "workshop-web"
rm -rf "$arbeit"
