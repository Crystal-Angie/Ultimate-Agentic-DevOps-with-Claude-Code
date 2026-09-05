variable "aws_region" {
  description = "AWS region for deploying the portfolio website"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project, used for naming AWS resources"
  type        = string
  default     = "portfolio-dmi"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "Project name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Environment name (e.g., production, staging, development)"
  type        = string
  default     = "production"

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of: development, staging, production."
  }
}

variable "domain_name" {
  description = "Custom domain name for the CloudFront distribution (optional)"
  type        = string
  default     = ""
}
