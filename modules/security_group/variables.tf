variable "project_name" {}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(number)
  default     = [22, 80, 443, 3306, 5432]
}

variable "allowed_protocols" {
  description = "List of allowed protocols"
  type        = list(string)
  default     = ["tcp"]
}

variable "allowed_cidr_blocks" {
  description = "List of allowed CIDR blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
