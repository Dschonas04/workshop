terraform {
  required_providers {
    local = { source = "hashicorp/local", version = "~> 2.5" }
  }
}

variable "umgebung" {
  type    = string
  default = "kurs"
}

variable "dienste" {
  type = map(object({
    port  = number
    aktiv = bool
  }))
  default = {
    web = { port = 80, aktiv = true }
    api = { port = 8080, aktiv = true }
    alt = { port = 8081, aktiv = false }
  }
}

locals {
  aktive = { for name, d in var.dienste : name => d if d.aktiv }
}

resource "local_file" "dienst" {
  for_each = local.aktive
  filename = "${path.module}/ausgabe/${each.key}.conf"
  content  = <<-EOT
    umgebung = ${var.umgebung}
    name = ${each.key}
    port = ${each.value.port}
  EOT
}

resource "local_file" "uebersicht" {
  filename = "${path.module}/ausgabe/uebersicht.txt"
  content  = "${join(", ", sort(keys(local.aktive)))}\n"
}

output "anzahl" {
  value = length(local.aktive)
}

output "pfade" {
  value = sort([for d in local_file.dienst : d.filename])
}
