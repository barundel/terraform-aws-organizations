output "ou_arn" {
  value       = concat(aws_organizations_organizational_unit.ou.*.arn, [""])[0]
  description = "ARN of the organizational unit"
}

output "ou_id" {
  value       = concat(aws_organizations_organizational_unit.ou.*.id, [""])[0]
  description = "Identifier of the organization unit"
}

output "account_arn" {
  value       = concat(aws_organizations_account.account.*.arn, [""])[0]
  description = "ARN of the organization account"
}

output "account_id" {
  value       = concat(aws_organizations_account.account.*.id, [""])[0]
  description = "Identifier of the organization account"
}

output "policy_arn" {
  value       = concat(aws_organizations_policy.policy.*.arn, [""])[0]
  description = "ARN of the organization policy"
}

output "policy_id" {
  value       = concat(aws_organizations_policy.policy.*.id, [""])[0]
  description = "Identifier of the organization policy"
}

output "org_accounts" {
  value       = concat(aws_organizations_organization.org.*.accounts, [""])[0]
  description = "List of organization accounts including the master account"
}

output "org_arn" {
  value       = concat(aws_organizations_organization.org.*.arn, [""])[0]
  description = "ARN of the organization"
}

output "org_id" {
  value       = concat(aws_organizations_organization.org.*.id, [""])[0]
  description = "ID of the organization"
}

output "master_account_arn" {
  value       = concat(aws_organizations_organization.org.*.master_account_arn, [""])[0]
  description = "ARN of the master account"
}

output "master_account_email" {
  value       = concat(aws_organizations_organization.org.*.master_account_email, [""])[0]
  description = "Email of the master account"
}

output "master_account_id" {
  value       = concat(aws_organizations_organization.org.*.master_account_id, [""])[0]
  description = "ID of the master account"
}

output "non_master_accounts" {
  value       = concat(aws_organizations_organization.org.*.non_master_accounts, [""])[0]
  description = "List of organization accounts excluding the master account"
}

output "roots" {
  value       = concat(aws_organizations_organization.org.*.roots, [""])[0]
  description = "List of organization roots"
}
