terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"

    }
  }

  backend "s3" {
    bucket         = "landing-zone-terraform-state-164461234859"
    key            = "org/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "landing-zone-terraform-state-lock"
    encrypt        = true
  }
}
provider "aws" {
  region = var.aws_region
}

resource "aws_organizations_organization" "this" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]
  feature_set = "ALL"

  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
  ]
}

resource "aws_organizations_organizational_unit" "shared_services" {
  name      = "shared-services"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_organizational_unit" "workloads" {
  name      = "workloads"
  parent_id = aws_organizations_organization.this.roots[0].id
}

resource "aws_organizations_policy" "region_lockdown" {
  name        = "${var.project_name}-region-lockdown"
  description = "Prevents any resources from being created outside eu-central-1"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "DenyAllOutsideOfRegion",
        Effect   = "Deny"
        Action   = "*"
        Resource = "*"
        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" = "eu-central-1"
          }
        }
        }, {
        Sid    = "AllowGlobalServices"
        Effect = "Allow"
        Action = [
          "iam:*",
          "organizations:*",
          "route53:*",
        "sts:*", ]
        Resource = "*"
      }
    ]
  })
}
resource "aws_organizations_policy_attachment" "region_lockdown_workloads" {
  policy_id = aws_organizations_policy.region_lockdown.id
  target_id = aws_organizations_organizational_unit.workloads.id
}