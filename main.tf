locals {
  policy_id = coalescelist(aws_organizations_policy.policy.*.id, [var.policy_id])
}

resource "aws_organizations_organization" "org" {
  count = var.create_organization ? 1 : 0

  aws_service_access_principals = var.aws_service_access_principles
  enabled_policy_types          = var.enable_policy_types
  feature_set                   = var.feature_Set
}

resource "aws_organizations_organizational_unit" "ou" {
  count = length(var.ou_name) > 0 ? 1 : 0

  name      = var.ou_name
  parent_id = var.ou_parent_id
}

resource "aws_organizations_account" "account" {
  count = length(var.account_name) > 0 ? 1 : 0

  name  = var.account_name
  email = var.account_email

  iam_user_access_to_billing = var.iam_user_access_to_billing
  parent_id                  = var.account_parent_id
  role_name                  = var.role_name

  tags = var.tags
}

resource "aws_organizations_policy" "policy" {
  count = length(var.policy_name) > 0 ? 1 : 0

  name        = var.policy_name
  description = var.policy_description

  type = var.policy_type

  content = var.policy_content
}

resource "aws_organizations_policy_attachment" "policy_attachment" {
  count = length(var.target_id) > 0 ? length(var.target_id) : 0

  policy_id = local.policy_id[0]
  target_id = tolist(var.target_id)[count.index]
}
