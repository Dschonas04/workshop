#!/usr/bin/env bash
set -u
. "$(dirname "$0")/../werkzeug.sh"
W="$(werkzeug_finden)"
ARBEIT="$(mktemp -d)"
trap 'rm -rf "$ARBEIT"' EXIT

$W run --rm -v "$ARBEIT":/daten alpine:3.20 sh -c 'echo "aus dem Container" > /daten/notiz.txt'
cat "$ARBEIT/notiz.txt"

$W run --rm -v "$ARBEIT":/daten:ro alpine:3.20 sh -c 'echo x > /daten/verboten.txt' 2>/dev/null \
  || echo "schreibgeschuetzt"

$W volume create workshop-daten >/dev/null
$W run --rm -v workshop-daten:/v alpine:3.20 sh -c 'echo "bleibt erhalten" > /v/dauer.txt'
$W run --rm -v workshop-daten:/v alpine:3.20 cat /v/dauer.txt

$W network create workshopnetz >/dev/null 2>&1
$W run -d --name ziel --network workshopnetz alpine:3.20 sleep 60 >/dev/null
$W run --rm --network workshopnetz alpine:3.20 sh -c 'getent hosts ziel >/dev/null && echo "ziel erreichbar"'

$W rm -f ziel >/dev/null 2>&1
$W network rm workshopnetz >/dev/null 2>&1
$W volume rm workshop-daten >/dev/null 2>&1
