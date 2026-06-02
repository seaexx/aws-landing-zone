# AWS Landing Zone

A production-grade, multi-account AWS infrastructure built entirely with Terraform.
Designed to demonstrate real-world cloud architecture patterns used by engineering
teams.

## What this is

Most AWS tutorials show you how to spin up a single EC2 instance or S3 bucket in
one account. Real companies don't work that way. They use a multi-account structure
where different environments are completely isolated from each other, a mistake in
development can never affect production.

This project builds that structure from scratch using AWS Organizations, Terraform,
and GitHub Actions.

## Architecture

- **AWS Organizations** — a root organization with two Organizational Units:
  `shared-services` (logging, security) and `workloads` (dev, prod)
- **Networking** — isolated VPCs per account with public and private subnets,
  NAT gateway, and route tables
- **IAM** — least-privilege roles with cross-account assume-role trust policies
- **Logging** — CloudTrail across all accounts, CloudWatch log groups, centralised
  S3 log archive
- **Workload** — ECS Fargate cluster with ALB, ECR, and Secrets Manager
- **CI/CD** — GitHub Actions pipelines using OIDC authentication to AWS,
  no stored credentials

## Design decisions

**Why separate accounts per environment?**
Blast radius isolation. If a developer accidentally runs `terraform destroy` in dev,
it cannot touch production because they are completely separate AWS accounts with
separate IAM boundaries.

**Why Terraform over ClickOps?**
Every resource in this project is reproducible. The entire infrastructure can be
destroyed and rebuilt from scratch with two commands. No manual steps, no tribal
knowledge.

## Structure

terraform/
- **bootstrap/    # Remote state backend (S3 + DynamoDB)
- **org/          # AWS Organizations, OUs, SCPs
- **networking/   # VPC, subnets, routing
- **iam/          # Roles and policies
- **logging/      # CloudTrail, CloudWatch
- **workload/     # ECS Fargate, ALB, ECR

## Prerequisites

- AWS CLI configured with an IAM user with AdministratorAccess
- Terraform >= 1.0
- GitHub account for CI/CD pipelines

## Status

In progress — actively being built.