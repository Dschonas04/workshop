#!/bin/sh
# Ein winziger Dienst: er schreibt seinen Zustand in eine Datei im
# Volume und antwortet auf Port 8000 mit einer Zeile.
echo "api gestartet, GRUSS=${GRUSS:-nichts}" > /gemeinsam/api.log
while true; do
  printf 'HTTP/1.1 200 OK\r\nContent-Length: %d\r\n\r\n%s' \
    "$(printf '%s' "${GRUSS:-nichts}" | wc -c)" "${GRUSS:-nichts}" |
    nc -l -p 8000 -q 1 >/dev/null 2>&1
done
