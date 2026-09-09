# ================================================================
#  Level 1: Die erste Ressource -- AUFGABEN
#  Ersetze jedes ___. Prüfen mit:  ./pruefen.sh 1
# ================================================================

terraform {
  required_providers {
    local = {
      source  = "___"
      version = "~> 2.5"
    }
  }
}

# ── AUFGABE 1.1 ────────────────────────────────────────────────
# Lege die Datei ausgabe/hallo.txt an, Inhalt genau:
#   Hallo Terraform
# mit Zeilenumbruch am Ende.
resource "___" "hallo" {
  filename = "${path.module}/ausgabe/hallo.txt"
  ___      = "Hallo Terraform\n"
}

# ── AUFGABE 1.2 ────────────────────────────────────────────────
# Lege eine zweite Datei ausgabe/verweis.txt an, deren Inhalt der
# Dateiname der ersten Ressource ist, gefolgt von einem Umbruch.
# Nutze dafür den Bezug auf die erste Ressource, keinen festen Text.
resource "local_file" "verweis" {
  filename = "${path.module}/ausgabe/verweis.txt"
  content  = "${___}\n"
}

# ── AUFGABE 1.3 ────────────────────────────────────────────────
# Gib den Inhalt der ersten Datei als Ausgabewert "gruss" heraus.
output "___" {
  value = ___
}
