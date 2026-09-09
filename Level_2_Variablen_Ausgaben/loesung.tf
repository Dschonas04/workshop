terraform {
  required_providers {
    local = { source = "hashicorp/local", version = "~> 2.5" }
  }
}

variable "umgebung" {
  type    = string
  default = "kurs"
}

variable "dienst" {
  type = object({
    name = string
    port = number
  })
  default = {
    name = "web"
    port = 8080
  }
}

variable "knoten" {
  type    = list(string)
  default = ["alpha", "beta", "gamma"]
}

locals {
  praefix = "${var.umgebung}-${var.dienst.name}"
}

resource "local_file" "bericht" {
  filename = "${path.module}/ausgabe/bericht.txt"
  content  = <<-EOT
    praefix = ${local.praefix}
    port = ${var.dienst.port}
    knoten = ${join(", ", [for k in var.knoten : upper(k)])}
  EOT
}

output "praefix" {
  value = local.praefix
}
