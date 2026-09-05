---
name: Portfolio DMI Cost Analysis - First Review
description: Cost optimization findings for static portfolio website (S3 + CloudFront) - March 2026
type: project
---

**Analysis Date:** 2026-03-13
**Infrastructure:** Static HTML portfolio deployed via S3 + CloudFront (OAC-secured)
**Current Costs (estimated):** ~$20-30/month (varies with traffic)

## Key Finding
This infrastructure has 3 significant cost issues for a low-traffic educational portfolio:

### High-Impact Issues

1. **S3 Versioning Enabled (Unnecessary)**
   - Enabled without lifecycle rules to clean old versions
   - Creates multiple copies of every file uploaded, consuming storage
   - **Use Case Mismatch:** A static portfolio needs no version history

2. **CloudFront Price Class 200 (Not Optimized for Budget)**
   - Currently set to PriceClass_200 (uses edge locations in 2 price tiers)
   - Could downgrade to PriceClass_100 (only cheapest edge locations)
   - Saves ~30% on CloudFront costs for educational use

3. **Custom 404 Error Response (SPA Pattern Misuse)**
   - Configured to return /index.html for 404s with 300s TTL
   - This is for Single Page Applications (React/Vue), not static multi-page sites
   - Wastes CloudFront caching and creates unnecessary 200 responses for missing assets

## Specific Recommendations

| Resource | Current | Recommended | Impact |
|----------|---------|-------------|--------|
| S3 Versioning | Enabled, no cleanup | Disable or add lifecycle rule | **HIGH**: Remove duplicate storage costs (~$0.023/GB/month per version) |
| CloudFront Price Class | PriceClass_200 | PriceClass_100 | **MEDIUM**: ~30% savings on CloudFront delivery (~$3-5/month) |
| 404 Error Handling | /index.html + 300s TTL | Remove custom error response | **LOW**: Eliminate cache misses, but minimal cost impact (~$0.50/month) |
| S3 Bucket Policy | OAC with s3:GetObject only | Keep as-is | **POSITIVE**: Current config is correct and secure |
| Cache Policy | CachingOptimized (managed) | Keep as-is | **POSITIVE**: AWS-managed policy is well-tuned |

## Why These Issues Exist

- **Versioning:** Terraform enabled it for "backup and recovery" but a portfolio has no rollback requirement
- **PriceClass_200:** Default choice but not optimized for single static site (no global traffic pattern)
- **404 Error Response:** Likely copied from SPA template or tutorial; incorrect for multi-page static site

## Implementation Priority

1. **First:** Disable S3 versioning (or add lifecycle rule to delete old versions after 30 days)
2. **Second:** Change CloudFront PriceClass_200 → PriceClass_100
3. **Third:** Remove custom error response for 404 (let CloudFront serve real 404s)

## Why NOT to change

- OAC + restricted bucket policy: KEEP (security best practice)
- IPv6 enabled: KEEP (no cost, improves accessibility)
- Compression enabled: KEEP (reduces bandwidth costs)
- Managed cache policy: KEEP (well-tuned by AWS)
