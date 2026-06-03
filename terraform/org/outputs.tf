output "organization_id" {
  description = "The ID of the AWS Organization"
  value       = aws_organizations_organization.this.id
}

output "shared_services_ou_id" {
  description = "The ID of the shared services organizational unit"
  value       = aws_organizations_organizational_unit.shared_services.id
}

output "workloads_ou_id" {
  description = "The ID of the workloads organizational unit"
  value       = aws_organizations_organizational_unit.workloads.id
}