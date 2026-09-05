output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.portfolio.id
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.portfolio.domain_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.portfolio.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.portfolio.arn
}

output "website_url" {
  description = "URL to access the portfolio website"
  value       = "https://${aws_cloudfront_distribution.portfolio.domain_name}"
}
