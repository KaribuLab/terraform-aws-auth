terraform {
  backend "s3" {}
}

resource "aws_cognito_user_pool" "auth" {
  name                = "${var.customer_prefix}-${var.name}-pool-${var.environment_suffix}"
  username_attributes = ["email"]
  admin_create_user_config {
    invite_message_template {
      email_message = var.invite_message.email_message
      email_subject = var.invite_message.email_subject
      sms_message   = var.invite_message.sms_message
    }
    allow_admin_create_user_only = true
  }

  verification_message_template {
    email_message = var.verification_message.email_message
    email_subject = var.verification_message.email_subject
    sms_message   = var.verification_message.sms_message
  }

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  dynamic "schema" {
    for_each = var.user_attributes
    content {
      attribute_data_type      = lookup(schema.value, "attribute_data_type")
      name                     = lookup(schema.value, "name")
      developer_only_attribute = lookup(schema.value, "developer_only_attribute", false)
      mutable                  = lookup(schema.value, "mutable", false)
      required                 = false
    }
  }

  dynamic "password_policy" {
    for_each = var.password_policy
    content {
      minimum_length                   = lookup(password_policy.value, "minimum_length")
      require_lowercase                = lookup(password_policy.value, "require_lowercase", false)
      require_numbers                  = lookup(password_policy.value, "require_numbers", false)
      require_symbols                  = lookup(password_policy.value, "require_symbols", false)
      require_uppercase                = lookup(password_policy.value, "require_uppercase", false)
      temporary_password_validity_days = lookup(password_policy.value, "temporary_password_validity_days", 1)
    }
  }

  tags = var.common_tags
}

resource "aws_cognito_user_pool_client" "auth" {
  name         = "${var.customer_prefix}-${var.name}-client-${var.environment_suffix}"
  user_pool_id = aws_cognito_user_pool.auth.id
}
