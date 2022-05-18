terraform {
  backend "s3" {}
}

resource "aws_cognito_user_pool" "auth" {
  name                     = "${var.customer_prefix}-${var.name}-pool-${var.environment_suffix}"
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
  admin_create_user_config {
    invite_message_template {
      email_message = "Su nueva cuenta {username} ha sido creada. Para iniciar sesión su contraseña temporal es: {####}."
      email_subject = "Nueva cuenta de usuario"
      sms_message   = "Su nueva cuenta {username} ha sido creada. Para iniciar sesión su contraseña temporal es: {####}."
    }
    allow_admin_create_user_only = false
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
      developer_only_attribute = lookup(schema.value, "developer_only_attribute")
      mutable                  = lookup(schema.value, "mutable")
      name                     = lookup(schema.value, "name")
      required                 = lookup(schema.value, "required")
    }
  }

  dynamic "password_policy" {
    for_each = var.password_policy
    content {
      minimum_length                   = lookup(password_policy.value, "minimum_length")
      require_lowercase                = lookup(password_policy.value, "require_lowercase")
      require_numbers                  = lookup(password_policy.value, "require_numbers")
      require_symbols                  = lookup(password_policy.value, "require_symbols")
      require_uppercase                = lookup(password_policy.value, "require_uppercase")
      temporary_password_validity_days = lookup(password_policy.value, "temporary_password_validity_days")
    }
  }

  tags = var.common_tags
}

resource "aws_cognito_user_pool_client" "auth" {
  name         = "${var.customer_prefix}-${var.name}-client-${var.environment_suffix}"
  user_pool_id = aws_cognito_user_pool.auth.id
}
