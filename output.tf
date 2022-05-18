output "cognito_pool_id" {
  value = aws_cognito_user_pool.auth.id
}

output "cognito_client_id" {
  value = aws_cognito_user_pool_client.auth.id
}
