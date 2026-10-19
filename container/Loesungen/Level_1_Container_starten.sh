#!/usr/bin/env bash
set -u
. "$(dirname "$0")/../werkzeug.sh"
W="$(werkzeug_finden)"

$W run --rm alpine:3.20 echo "hallo workshop"

$W run --rm -e WORKSHOP=container alpine:3.20 sh -c 'echo "$WORKSHOP"'

$W run -d --name workshop-1 alpine:3.20 sleep 30 >/dev/null

$W exec workshop-1 sh -c 'echo "von innen"'

$W ps --filter name=workshop-1 --format '{{.Names}}'

$W stop workshop-1 >/dev/null 2>&1
$W rm workshop-1 >/dev/null 2>&1
