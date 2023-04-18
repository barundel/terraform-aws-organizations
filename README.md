# terraform-aws-organizations [![Build Status](https://github.com/barundel/terraform-aws-organizations/workflows/build/badge.svg)](https://github.com/barundel/terraform-aws-organizations/actions)

> **A Terraform module for creating AWS Organization resources like organizational units and service control policies.**

## Table of Contents

- [Maintenance](#maintenance)
- [Getting Started](#getting-started)
- [License](#license)

## Maintenance

This project is maintained [Ben](https://github.com/barundel), anyone is welcome to contribute with fixes or new features.

## Getting Started

#### Organization Example

The following example creates an organisation within your AWS account.
````
module "the_organization" {
  source = "github.com/barundel/terraform-aws-organizations"

  create_organization = true

  aws_service_access_principles = [
    "tagpolicies.tag.amazonaws.com"
  ]

  feature_Set = "ALL"

  enable_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY"
  ]

}
````

#### Organization Example

This example creates a tagging policy and assigns it to multiple targets.
````
module "tagging_rules_1" {
  source = "github.com/barundel/terraform-aws-organizations"

  policy_name = "tagging-rules"
  policy_description = "Testing tagging policy"

  policy_type = "TAG_POLICY"

  policy_content = <<CONTENT
{
    "tags": {
        "CostCenter": {
            "tag_key": {
                "@@assign": "CostCenter",
                "@@operators_allowed_for_child_policies": ["@@none"]
            }
        },
        "Project": {
            "tag_key": {
                "@@assign": "Project",
                "@@operators_allowed_for_child_policies": ["@@none"]
            }
        }
    }
}
CONTENT

  target_id = ["r-dgk7", module.development_ou.ou_id]

}
````

#### Other Examples
````
module "org" {
  source = "github.com/barundel/terraform-aws-organizations"

  ou_name = "ou_2"
  ou_parent_id = "r-0000"
}

module "org_2" {
  source = "github.com/barundel/terraform-aws-organizations"

  ou_name = "ou_2"
  ou_parent_id = "ou-0000000000"
}

module "org_3" {
  source = "github.com/barundel/terraform-aws-organizations"

  ou_name = "ou_2"
  ou_parent_id = module.org_2.ou_id
}

module "scp_1" {
  source = "github.com/barundel/terraform-aws-organizations"

  policy_name = "scp_policy_all"
  policy_description = "A description of the policy"

  policy_content = <<CONTENT
  {
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  }
  CONTENT
}

module "attach_policy" {
  source = "github.com/barundel/terraform-aws-organizations"

  policy_id = module.scp_1.policy_id
  target_id = module.org_3.ou_id
}
````
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_email | The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account. | `string` | `""` | no |
| account\_name | A friendly name for the member account. | `string` | `""` | no |
| account\_parent\_id | Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID. A configuration must be present for this argument to perform drift detection. | `string` | `""` | no |
| aws\_service\_access\_principles | List of AWS service principal names for which you want to enable integration with your organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com. Organization must have feature\_set set to ALL. For additional information, see the [AWS Organizations User Guide.](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html). | `list(string)` | `[]` | no |
| close\_on\_deletion | If true, a deletion event will close the account. Otherwise, it will only remove from the organization. This is not supported for GovCloud accounts | `bool` | `true` | no |
| create\_organization | Tue or false on if to create an organization, defaults to false | `bool` | `false` | no |
| enable\_policy\_types | List of Organizations policy types to enable in the Organization Root. Organization must have feature\_set set to ALL. For additional information about valid policy types (e.g. SERVICE\_CONTROL\_POLICY and TAG\_POLICY), see the [AWS Organizations API Reference.](https://docs.aws.amazon.com/organizations/latest/APIReference/API_EnablePolicyType.html) | `list(string)` | `[]` | no |
| feature\_Set | Specify ALL (default) or CONSOLIDATED\_BILLING | `string` | `"ALL"` | no |
| iam\_user\_access\_to\_billing | If set to ALLOW, the new account enables IAM users to access account billing information if they have the required permissions. If set to DENY, then only the root user of the new account can access account billing information. | `string` | `"DENY"` | no |
| ou\_name | The name for the organizational unit | `string` | `""` | no |
| ou\_parent\_id | ID of the parent organizational unit, which may be the root | `string` | `""` | no |
| policy\_content | The policy content to add to the new policy. For example, if you create a [service control policy (SCP)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html), this string must be JSON text that specifies the permissions that admins in attached accounts can delegate to their users, groups, and roles. For more information about the SCP syntax, see the [Service Control Policy Syntax documentation](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_reference_scp-syntax.html) and for more information on the Tag Policy syntax, see the [Tag Policy Syntax documentation.](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_example-tag-policies.html) | `string` | `"{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": {\n    \"Effect\": \"Allow\",\n    \"Action\": \"*\",\n    \"Resource\": \"*\"\n  }\n}\n"` | no |
| policy\_description | A description to assign to the policy | `string` | `""` | no |
| policy\_id | The unique identifier (ID) of the policy that you want to attach to the target | `string` | `""` | no |
| policy\_name | The friendly name to assign to the policy | `string` | `""` | no |
| policy\_type | The type of policy to create. Currently, the only valid values are SERVICE\_CONTROL\_POLICY (SCP) and TAG\_POLICY. Defaults to SERVICE\_CONTROL\_POLICY | `string` | `"SERVICE_CONTROL_POLICY"` | no |
| role\_name | The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account. The Organizations API provides no method for reading this information after account creation, so Terraform cannot perform drift detection on its value and will always show a difference for a configured value after import unless ignore\_changes is used. | `string` | `""` | no |
| tags | Map of tags to assign to the reqsource. | `map(string)` | `{}` | no |
| target\_id | The unique identifier (ID) of the root, organizational unit, or account number that you want to attach the policy to | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| account\_arn | ARN of the organization account |
| account\_id | Identifier of the organization account |
| master\_account\_arn | ARN of the master account |
| master\_account\_email | Email of the master account |
| master\_account\_id | ID of the master account |
| non\_master\_accounts | List of organization accounts excluding the master account |
| org\_accounts | List of organization accounts including the master account |
| org\_arn | ARN of the organization |
| org\_id | ID of the organization |
| ou\_arn | ARN of the organizational unit |
| ou\_id | Identifier of the organization unit |
| policy\_arn | ARN of the organization policy |
| policy\_id | Identifier of the organization policy |
| roots | List of organization roots |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
