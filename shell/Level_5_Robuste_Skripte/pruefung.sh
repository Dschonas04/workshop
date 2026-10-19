#!/usr/bin/env bash
set -u
datei="$1"
stdout="$(bash "$datei" 2>/dev/null)"; code=$?
stderr="$(bash "$datei" 2>&1 >/dev/null)"

quelle="$(cat "$datei")"
pruefe "5.1 strenger Kopf" \
  "$(grep -qE 'set -[a-z]*e[a-z]*u[a-z]*' <<<"$quelle" && grep -q 'pipefail' <<<"$quelle" && echo ja)" "ja"
pruefe "5.2 trap räumt auf" \
  "$(grep -q 'trap' <<<"$quelle" && grep -qE 'mktemp -d' <<<"$quelle" && echo ja)" "ja"
pruefe "5.3 Meldung nach stderr" "$(sed -n 1p <<<"$stderr")" "Start"
pruefe "5.3 stdout bleibt sauber" "$(grep -c '^Start$' <<<"$stdout")" "0"
pruefe "5.4 Funktion verdoppelt" "$(sed -n 1p <<<"$stdout")" "42"
pruefe "5.5 Dateien mit Leerzeichen gezählt" "$(sed -n 2p <<<"$stdout")" "3"
pruefe "5.6 Exit-Code" "$code" "3"
