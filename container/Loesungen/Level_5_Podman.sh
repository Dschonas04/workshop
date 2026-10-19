#!/usr/bin/env bash
set -u
. "$(dirname "$0")/../werkzeug.sh"
W="$(werkzeug_finden)"
ARBEIT="$(mktemp -d)"
trap 'rm -rf "$ARBEIT"' EXIT

echo "$W"

$W run --rm alpine:3.20 id -un

$W run --rm -v "$ARBEIT":/daten alpine:3.20 sh -c 'echo x > /daten/wem.txt'
stat -c '%U' "$ARBEIT/wem.txt"

$W run -d --name workshop-5 alpine:3.20 sleep 30 >/dev/null
$W inspect --format '{{.State.Status}}' workshop-5

$W rm -f workshop-5 >/dev/null
echo "entfernt"
