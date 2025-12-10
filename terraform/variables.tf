variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
  default     = "lambda-docker-demo"
}

variable "ecr_repo_name" {
  description = "ECR repository name"
  type        = string
  default     = "lambda-docker-demo"
}

variable "image_tag" {
  description = "Image tag"
  type        = string
  default     = "latest"
}
