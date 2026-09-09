# ================================================================
#  Level 3: Mehrfach und Ausdrücke -- AUFGABEN
#  Prüfen mit:  ./pruefen.sh 3
# ================================================================

terraform {
  required_providers {
    local = { source = "hashicorp/local", version = "~> 2.5" }
  }
}

variable "dienste" {
  type = list(object({
    name  = string
    port  = number
    aktiv = bool
  }))
  default = [
    { name = "web", port = 80, aktiv = true },
    { name = "api", port = 8080, aktiv = true },
    { name = "alt", port = 8081, aktiv = false },
  ]
}

# ── AUFGABE 3.1 ────────────────────────────────────────────────
# Baue aus der Liste eine Karte, die nur die AKTIVEN Dienste
# enthält: { "web" = 80, "api" = 8080 }
locals {
  aktive = { for d in var.dienste : ___ => ___ if ___ }
}

# ── AUFGABE 3.2 ────────────────────────────────────────────────
# Lege für jeden aktiven Dienst eine Datei ausgabe/<name>.conf an,
# Inhalt "port = <port>" mit Zeilenumbruch. Benutze for_each,
# nicht count.
resource "local_file" "dienst" {
  ___     = local.aktive
  filename = "${path.module}/ausgabe/${___}.conf"
  content  = "port = ${___}\n"
}

# ── AUFGABE 3.3 ────────────────────────────────────────────────
# Lege drei durchnummerierte Dateien ausgabe/knoten-0.txt bis
# knoten-2.txt an, Inhalt jeweils "Knoten <nummer>".
# Hier ist count richtig, denn es gibt keinen Namen, nur Anzahl.
resource "local_file" "knoten" {
  ___     = 3
  filename = "${path.module}/ausgabe/knoten-${___}.txt"
  content  = "Knoten ${count.index}\n"
}

# ── AUFGABE 3.4 ────────────────────────────────────────────────
# Schreibe ausgabe/namen.txt mit den Namen der aktiven Dienste,
# durch Komma und Leerzeichen getrennt, sortiert: "api, web"
resource "local_file" "namen" {
  filename = "${path.module}/ausgabe/namen.txt"
  content  = "${join(", ", ___(keys(local.aktive)))}\n"
}

# ── AUFGABE 3.5 ────────────────────────────────────────────────
# Gib die Anzahl der aktiven Dienste als Ausgabewert "anzahl" heraus.
output "anzahl" {
  value = ___(local.aktive)
}
