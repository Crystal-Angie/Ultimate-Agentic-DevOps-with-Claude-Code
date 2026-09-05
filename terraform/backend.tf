# Terraform Backend Configuration
#
# IMPORTANT: Remote backend setup instructions
#
# This backend configuration is commented out by default. Follow these steps to enable it:
#
# Step 1: Initialize Terraform WITHOUT backend
#   $ terraform init
#
# Step 2: Create the S3 bucket and DynamoDB table for state management
#   - S3 bucket for state storage (enable versioning, encryption, and block public access)
#   - DynamoDB table named "terraform-locks" with LockID as primary key (for state locking)
#
# Step 3: Uncomment the backend block below
#
# Step 4: Migrate state to the remote backend
#   $ terraform init -migrate-state
#   When prompted, confirm that you want to copy existing state to the new backend
#
# Once enabled, Terraform will:
# - Store state files in S3 (encrypted and versioned)
# - Use DynamoDB for state locking during apply/plan
# - Prevent concurrent modifications to infrastructure

# terraform {
#   backend "s3" {
#     bucket         = "portfolio-dmi-terraform-state"
#     key            = "prod/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
