variable "customer_prefix" {
  type = string
}

variable "environment_suffix" {
  type = string
}

variable "name" {
  type = string
}

variable "user_attributes" {
  type    = list(any)
  default = []
}

variable "password_policy" {
  type    = list(any)
  default = []
}

variable "common_tags" {
  type = map(any)
}
