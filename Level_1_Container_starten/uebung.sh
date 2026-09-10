#!/usr/bin/env bash
# Deine Lösung. Die Aufgabenstellung steht in Aufgabenstellung.txt.
set -u
. "$(dirname "$0")/../werkzeug.sh"
W="$(werkzeug_finden)"
ARBEIT="$(mktemp -d)"
trap 'rm -rf "$ARBEIT"' EXIT

# Ab hier deins.
