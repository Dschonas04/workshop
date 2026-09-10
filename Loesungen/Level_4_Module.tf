terraform {
  required_providers {
    local = { source = "hashicorp/local", version = "~> 2.5" }
  }
}

module "web" {
  source = "./modul/dienst"
  name   = "web"
  port   = 80
  ziel   = "${path.module}/ausgabe"
}

module "api" {
  source = "./modul/dienst"
  name   = "api"
  port   = 8080
  ziel   = "${path.module}/ausgabe"
}

resource "local_file" "pfade" {
  filename = "${path.module}/ausgabe/pfade.txt"
  content  = "${module.web.pfad}\n${module.api.pfad}\n"
}
