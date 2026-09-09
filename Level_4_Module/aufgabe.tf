# ================================================================
#  Level 4: Module -- AUFGABEN (Teil zwei; Teil eins liegt in
#  modul/dienst/main.tf und outputs.tf)
# ================================================================

terraform {
  required_providers {
    local = { source = "hashicorp/local", version = "~> 2.5" }
  }
}

# ── AUFGABE 4.3 ────────────────────────────────────────────────
# Rufe das Modul zweimal auf, einmal als "web" mit Port 80 und
# einmal als "api" mit Port 8080. Beide schreiben nach
# ${path.module}/ausgabe.
module "web" {
  source = "___"
  name   = "web"
  port   = ___
  ziel   = "${path.module}/ausgabe"
}

module "api" {
  ___
}

# ── AUFGABE 4.4 ────────────────────────────────────────────────
# Schreibe ausgabe/pfade.txt mit den beiden Pfaden aus den Modulen,
# je einer pro Zeile, web zuerst. Nutze die Ausgaben der Module.
resource "local_file" "pfade" {
  filename = "${path.module}/ausgabe/pfade.txt"
  content  = "${___}\n${___}\n"
}
