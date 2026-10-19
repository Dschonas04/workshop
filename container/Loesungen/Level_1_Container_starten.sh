#!/usr/bin/env bash
set -u
. "$(dirname "$0")/../werkzeug.sh"
W="$(werkzeug_finden)"

$W run --rm alpine:3.20 echo "hallo kurs"

$W run --rm -e KURS=container alpine:3.20 sh -c 'echo "$KURS"'

$W run -d --name kurs-1 alpine:3.20 sleep 30 >/dev/null

$W exec kurs-1 sh -c 'echo "von innen"'

$W ps --filter name=kurs-1 --format '{{.Names}}'

$W stop kurs-1 >/dev/null 2>&1
$W rm kurs-1 >/dev/null 2>&1
