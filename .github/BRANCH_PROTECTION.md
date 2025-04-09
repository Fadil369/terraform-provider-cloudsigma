# Branch Protection Rules

This file defines the branch protection rules that should be implemented in the GitHub repository settings.

## Main Branch Protection

The `main` branch should have the following protections enabled:
- Require pull request reviews before merging
- Require status checks to pass before merging
  - Required status checks:
    - terraform-lint
    - terraform-security
    - scan-secrets
- Require signed commits
- Include administrators in these restrictions
- Allow force pushes: Disabled
- Allow deletions: Disabled

## Release Branches Protection

All `release-*` branches should have the following protections:
- Require pull request reviews before merging
- Require status checks to pass before merging
  - Required status checks:
    - terraform-lint
    - terraform-security
    - scan-secrets
- Require signed commits
- Include administrators in these restrictions
- Allow force pushes: Disabled
- Allow deletions: Disabled

---
Note: These protections need to be manually configured in the GitHub repository settings.
