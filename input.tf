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

variable "invite_message" {
  type = object({
    email_message = string
    email_subject = string
    sms_message   = string
  })
}

variable "verification_message" {
  type = object({
    email_message = string
    email_subject = string
    sms_message   = string
  })
}
