---
name: patterns_s3_cloudfront
description: Recurring security anti-patterns and their fixes for S3 static-site + CloudFront Terraform stacks
type: reference
---

## S3 Bucket Policy — OAC Condition Missing aws:SourceArn

A policy that allows `cloudfront.amazonaws.com` without scoping `aws:SourceArn` to the specific distribution permits ANY CloudFront distribution in any account to read the bucket.

Fix: add a `Condition` block:
```hcl
Condition = {
  StringEquals = {
    "AWS:SourceArn" = aws_cloudfront_distribution.portfolio.arn
  }
}
```

## CloudFront TLS — Default Certificate Forces TLSv1

Using `cloudfront_default_certificate = true` locks the minimum TLS version to TLSv1 and prevents setting `minimum_protocol_version`. To enforce TLSv1.2_2021, a custom ACM certificate must be attached.

## CloudFront — No Response Headers Policy

Without `response_headers_policy_id` there are no security headers (CSP, X-Frame-Options, HSTS, X-Content-Type-Options, Referrer-Policy). Use the AWS managed policy `67f7725c-6f97-4210-82d7-5512b31e9d03` (SecurityHeadersPolicy) or define a custom one.

## CloudFront — Logging Disabled

`logging_config` block absent means no access logs. Add an S3 destination for audit trails.

## S3 — No Server-Side Encryption Resource

Default AES256 is applied automatically by AWS since 2023 but is not expressed in Terraform. Add `aws_s3_bucket_server_side_encryption_configuration` for explicit IaC control.

## S3 — No Lifecycle Policy on Versioned Bucket

Versioning without a lifecycle rule causes indefinite accumulation of noncurrent versions. Add `aws_s3_bucket_lifecycle_configuration` with a noncurrent version expiration rule.

## Terraform State — Must Not Be Committed to Git

`terraform.tfstate` and `terraform.tfstate.backup` expose account IDs, IAM ARNs, resource IDs, and user IDs. They must be in `.gitignore` and stored in a remote backend (S3 + DynamoDB).

## Custom Error Response — 200 for 404 Is Wrong for Multi-Page Sites

Returning HTTP 200 with index.html for a 404 is a SPA pattern. For a static multi-page site (portfolio with privacy.html, terms.html) this masks real missing-page errors. Use `response_code = 404` or create a dedicated 404 page.
