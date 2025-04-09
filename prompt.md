# GitHub Copilot Prompt: Infrastructure-as-Code Enhancement & Security for CloudSigma Terraform Provider

## Repository: cloudsigma-terraform-provider
## Objective:
Enhance and secure the forked CloudSigma Terraform Provider repository with production-grade best practices for deployment, automation, infrastructure management, and documentation. The project is part of BrainIncubator, BrainSAIT's enterprise infrastructure platform for incubating educational and commercial software projects.

## Purpose:
This project is the backbone of BrainIncubator — an educational development framework that provides:
- Full-featured **Infrastructure as a Service (IaaS)**.
- Scalable **Platform as a Service (PaaS)** for deploying containerized apps.
- **Network management** automation.
- Integrated **AI/ML tools** for smart DevOps.
- Secure and optimized **SaaS application deployment**.
- Developer-friendly environments for **small businesses and large companies**.
- Fully documented and modular infrastructure.

## Required Enhancements from Copilot:

### 1. **Security & Compliance**
- Automatically scan for secrets using GitHub Advanced Security.
- Enforce branch protection rules via `.github/workflows`.
- Suggest Terraform security best practices (e.g., using least privilege IAM roles, encryption, access logs).
- Integrate tools like `tfsec`, `checkov`, and `terraform-compliance`.

### 2. **Infrastructure as Code Setup**
- Refactor modules with reusable `main.tf`, `variables.tf`, `outputs.tf`, `providers.tf`.
- Configure backend with remote state using S3 + DynamoDB (or CloudSigma equivalent).
- Use Terraform workspaces to manage environments (dev, staging, prod).
- Auto-generate backend configuration templates.

### 3. **CI/CD Pipeline**
- Set up GitHub Actions workflows for Terraform linting, planning, and apply.
- Trigger PR validation workflows for infrastructure changes.
- Deploy modules via environments using GitHub environments and approvals.

### 4. **Documentation**
- Auto-generate module documentation using `terraform-docs`.
- Create a `docs/` directory with architecture diagrams, use-cases, and environment guides.
- Add contribution guidelines and a SECURITY.md file.

### 5. **Modules and Features for BrainIncubator**
- Create Terraform modules for:
  - Kubernetes clusters with K3s and Helm support.
  - VPC + Subnet + Firewall Rules for BrainIncubator environments.
  - PaaS setup for Node.js/Python/Django apps.
  - PostgreSQL + Redis modules.
  - Load balancer with TLS termination.
- Build an example `/examples/incubator_project` folder to show end-to-end use.

### 6. **Platform Support and AI Integration**
- Integrate optional AI agent for DevOps via LangChain (triggered on pull requests for recommendations).
- Include support for deploying to multiple clouds via abstraction (CloudSigma, AWS, Azure).
- Configure telemetry and usage tracking via a centralized metrics module.

## Development Standards
- Follow BrainSAIT’s guidelines for building secure, scalable multi-tenant infrastructure.
- Use clear comments and best-practice structure for onboarding new teams and educational partners.

## Output Expectations
- Suggest full Terraform code for core infrastructure modules.
- Write GitHub Actions workflow files with reusable templates.
- Recommend folder structure and best practices for Terraform projects.
- Provide Markdown templates for README, CONTRIBUTING, SECURITY, and USAGE.

## Reference Context
Refer to the previously provided internal BrainSAIT documentation for:
- Enterprise Infrastructure Incubation Blueprints.
- BrainIncubator educational framework and developer support goals.
- AI-enhanced DevOps and CI/CD integrations.