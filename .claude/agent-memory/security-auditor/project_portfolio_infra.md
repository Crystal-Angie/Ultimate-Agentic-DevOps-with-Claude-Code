---
name: portfolio_infra_state
description: Current deployed state of the portfolio-dmi AWS infrastructure including live resource IDs and known security gaps
type: project
---

Static HTML/CSS portfolio site deployed to S3 + CloudFront in us-east-1.

Live resources (as of 2026-03-17 tfstate serial 13):
- AWS account ID: 703671902584
- IAM user used for deploy: arn:aws:iam::703671902584:user/terraform-01 (user_id AIDA2HVQ5EF4KCEUNZFN2)
- S3 bucket: portfolio-dmi-website-703671902584
- CloudFront distribution: E2ODAQNC794VIM (ds68rb5vg8kl2.cloudfront.net)
- OAC ID: EYZ2P0IMGPAK0

**Why:** Needed to cross-reference Terraform code against actual deployed state to find drift and sensitive data exposure.

**How to apply:** When reviewing future PRs or plan output for this project, the above IDs are the live production values. Flag any code change that references them as hardcoded literals.

Known open findings from first audit (2026-03-17):
- Terraform state files committed to git (CRITICAL) — exposes account ID, IAM user ARN, distribution IDs
- S3 bucket policy missing aws:SourceArn condition on CloudFront OAC (HIGH)
- TLS minimum protocol version is TLSv1 on the deployed distribution (HIGH) — code uses cloudfront_default_certificate so cannot set minimum_protocol_version
- No response headers policy — missing security headers (HIGH)
- CloudFront logging disabled (MEDIUM)
- S3 server access logging disabled (MEDIUM)
- S3 lifecycle policy absent — versioning accumulates cost/data indefinitely (LOW)
- Remote state backend commented out — local state only (MEDIUM)
- price_class drift: code says PriceClass_100, tfstate shows PriceClass_200 (LOW)
- Custom error response returns 200 for 404 — correct for SPA but not a static multi-page site (LOW)
