terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

resource "local_file" "hallo" {
  filename = "${path.module}/ausgabe/hallo.txt"
  content  = "Hallo Terraform\n"
}

resource "local_file" "verweis" {
  filename = "${path.module}/ausgabe/verweis.txt"
  content  = "${local_file.hallo.filename}\n"
}

output "gruss" {
  value = local_file.hallo.content
}
