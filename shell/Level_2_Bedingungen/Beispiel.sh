#!/usr/bin/env bash
# Level 2: Bedingungen und Exit-Codes.

# Ein Befehl, der klappt, und einer, der nicht klappt:
grep -q root /etc/passwd
printf 'grep root:      Exit-Code %d\n' "$?"
grep -q gibtesnicht /etc/passwd
printf 'grep Unsinn:    Exit-Code %d\n' "$?"

# if prüft einen Befehl, keinen Wert:
if [[ -f /etc/hostname ]]; then
  printf '/etc/hostname ist eine Datei.\n'
fi

zahl=7
if (( zahl > 5 )); then
  printf '%d ist größer als 5.\n' "$zahl"
else
  printf '%d ist nicht größer als 5.\n' "$zahl"
fi

text=""
if [[ -z "$text" ]]; then
  printf 'Die Variable ist leer.\n'
fi

# Verketten statt if, wo es kurz bleibt:
[[ -d /tmp ]] && printf '/tmp gibt es.\n'
[[ -d /gibtesnicht ]] || printf '/gibtesnicht gibt es nicht.\n'

# case
for wort in start stop tanzen; do
  case "$wort" in
    start) printf '%s: fahre hoch\n' "$wort" ;;
    stop)  printf '%s: fahre herunter\n' "$wort" ;;
    *)     printf '%s: kenne ich nicht\n' "$wort" ;;
  esac
done
