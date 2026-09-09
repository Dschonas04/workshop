#!/usr/bin/env bash
# Findet die vorhandene Container-Werkzeugkette. Der Kurs läuft mit
# Docker und mit Podman -- die Befehle sind zu 95 Prozent dieselben,
# und genau das ist eine der Lektionen.
werkzeug_finden() {
  if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
    echo docker
  elif command -v podman >/dev/null 2>&1; then
    echo podman
  else
    echo ""
  fi
}

compose_finden() {
  local w="$1"
  if [ "$w" = docker ] && docker compose version >/dev/null 2>&1; then
    echo "docker compose"
  elif command -v podman-compose >/dev/null 2>&1; then
    echo "podman-compose"
  elif [ "$w" = podman ] && podman compose version >/dev/null 2>&1; then
    echo "podman compose"
  elif command -v docker-compose >/dev/null 2>&1; then
    echo "docker-compose"
  else
    echo ""
  fi
}
