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

locals {
  aktive = { for d in var.dienste : d.name => d.port if d.aktiv }
}

resource "local_file" "dienst" {
  for_each = local.aktive
  filename = "${path.module}/ausgabe/${each.key}.conf"
  content  = "port = ${each.value}\n"
}

resource "local_file" "knoten" {
  count    = 3
  filename = "${path.module}/ausgabe/knoten-${count.index}.txt"
  content  = "Knoten ${count.index}\n"
}

resource "local_file" "namen" {
  filename = "${path.module}/ausgabe/namen.txt"
  content  = "${join(", ", sort(keys(local.aktive)))}\n"
}

output "anzahl" {
  value = length(local.aktive)
}
