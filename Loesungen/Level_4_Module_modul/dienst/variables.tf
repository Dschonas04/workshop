variable "name" {
  description = "Name des Dienstes"
  type        = string
}

variable "port" {
  description = "Port, auf dem er lauscht"
  type        = number
  default     = 8080

  validation {
    condition     = var.port > 0 && var.port < 65536
    error_message = "Port muss zwischen 1 und 65535 liegen."
  }
}

variable "ziel" {
  description = "Verzeichnis, in das geschrieben wird"
  type        = string
}
