# ================================================================
#  Level 4: Modul -- AUFGABE
#  Ersetze jedes ___. Prüfen mit:  ./pruefen.sh 4
# ================================================================

terraform {
  required_providers {
    local = { source = "hashicorp/local", version = "~> 2.5" }
  }
}

# ── AUFGABE 4.1 ────────────────────────────────────────────────
# Schreibe <ziel>/<name>.conf mit zwei Zeilen:
#   name = <name>
#   port = <port>
resource "local_file" "konfiguration" {
  filename = "${___}/${___}.conf"
  content  = <<-EOT
    name = ${___}
    port = ${___}
  EOT
}
