terraform {
  required_providers {
    local = { source = "hashicorp/local", version = "~> 2.5" }
  }
}

resource "local_file" "konfiguration" {
  filename = "${var.ziel}/${var.name}.conf"
  content  = <<-EOT
    name = ${var.name}
    port = ${var.port}
  EOT
}
