output "ecr_repository_url" {
  description = "ECR repo URL"
  value       = aws_ecr_repository.lambda_repo.repository_url
}

output "lambda_function_name" {
  description = "Lambda name"
  value       = aws_lambda_function.docker_lambda.function_name
}

output "image_uri" {
  description = "Full image URI"
  value       = local.image_uri
}
