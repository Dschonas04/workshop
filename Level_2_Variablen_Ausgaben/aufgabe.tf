# ================================================================
#  Level 2: Variablen, Typen, Ausgaben -- AUFGABEN
#  Der Prüfer ruft dich mit -var="umgebung=test" auf.
#  Prüfen mit:  ./pruefen.sh 2
# ================================================================

terraform {
  required_providers {
    local = { source = "hashicorp/local", version = "~> 2.5" }
  }
}

# ── AUFGABE 2.1 ────────────────────────────────────────────────
# Eine Zeichenketten-Variable "umgebung" mit der Vorgabe "kurs".
variable "umgebung" {
  ___ = string
  ___ = "kurs"
}

# ── AUFGABE 2.2 ────────────────────────────────────────────────
# Eine Variable "dienst" vom Typ object mit den Feldern
# name (string) und port (number). Vorgabe: web / 8080.
variable "dienst" {
  type = ___({
    name = ___
    port = ___
  })
  default = {
    name = "web"
    port = 8080
  }
}

# ── AUFGABE 2.3 ────────────────────────────────────────────────
# Eine Liste "knoten" mit den Vorgabewerten alpha, beta, gamma.
variable "knoten" {
  type    = ___(string)
  default = ___
}

# ── AUFGABE 2.4 ────────────────────────────────────────────────
# Ein local "praefix" aus Umgebung und Dienstname, verbunden mit
# einem Bindestrich: "test-web".
locals {
  praefix = "___"
}

# ── AUFGABE 2.5 ────────────────────────────────────────────────
# Schreibe ausgabe/bericht.txt mit genau diesen drei Zeilen:
#   praefix = test-web
#   port = 8080
#   knoten = ALPHA, BETA, GAMMA
# Die Knoten also in Großbuchstaben, mit Komma und Leerzeichen.
resource "local_file" "bericht" {
  filename = "${path.module}/ausgabe/bericht.txt"
  content  = <<-EOT
    praefix = ${local.praefix}
    port = ${___}
    knoten = ${___(", ", [for k in var.knoten : ___(k)])}
  EOT
}

# ── AUFGABE 2.6 ────────────────────────────────────────────────
# Gib den Präfix als Ausgabewert "praefix" heraus.
output "praefix" {
  value = ___
}
