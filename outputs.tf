output "ou_arn" {
  value = concat(aws_organizations_organizational_unit.ou.*.arn, [""])[0]
  description = "ARN of the organizational unit"
}

output "ou_id" {
  value = concat(aws_organizations_organizational_unit.ou.*.id, [""])[0]
  description = "Identifier of the organization unit"
}

output "account_arn" {
  value = concat(aws_organizations_account.account.*.arn, [""])[0]
}

output "account_id" {
  value = concat(aws_organizations_account.account.*.id, [""])[0]
}

output "policy_arn" {
  value = concat(aws_organizations_policy.policy.*.arn, [""])[0]
}

output "policy_id" {
  value = concat(aws_organizations_policy.policy.*.id, [""])[0]
}

