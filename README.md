# terraform-aws-organizations-
Collection of terraform resources for aws organizations.

# terraform-gitlab-modules
 

# terraform-aws-organizations [![Build Status](https://github.com/barundel/terraform-aws-organizations/workflows/build/badge.svg)](https://github.com/barundel/terraform-aws-organizations/actions)

> **A Terraform module for creating GitLab resources.**

## Table of Contents

- [Maintenance](#maintenance)
- [Getting Started](#getting-started)
- [License](#license)

## Maintenance

This project is maintained [Ben](https://github.com/barundel), anyone is welcome to contribute. 

## Getting Started

`count = length(var.resource_path_part) > 0 ? 1 : 0` Controls if to create new methods, need to detail this.

#### Example
````
module "org" {
  source = "../../tf-modules/terraform-aws-organizations"

  ou_name = "ou_2"
  ou_parent_id = "r-0000"
}

module "org_2" {
  source = "../../tf-modules/terraform-aws-organizations"

  ou_name = "ou_2"
  ou_parent_id = "ou-0000000000"
}

module "org_3" {
  source = "../../tf-modules/terraform-aws-organizations"

  ou_name = "ou_2"
  ou_parent_id = module.org_2.ou_id
}

module "scp_1" {
  source = "../../tf-modules/terraform-aws-organizations"

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
  source = "../../tf-modules/terraform-aws-organizations"

  policy_id = module.scp_1.policy_id
  target_id = module.org_3.ou_id
}
````

<!--- BEGIN_TF_DOCS --->
## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| account\_email | The email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account. | `string` | `""` | no |
| account\_name | A friendly name for the member account. | `string` | `""` | no |
| account\_parent\_id | Parent Organizational Unit ID or Root ID for the account. Defaults to the Organization default Root ID. A configuration must be present for this argument to perform drift detection. | `string` | `""` | no |
| iam\_user\_access\_to\_billing | If set to ALLOW, the new account enables IAM users to access account billing information if they have the required permissions. If set to DENY, then only the root user of the new account can access account billing information. | `string` | `"DENY"` | no |
| ou\_name | The name for the organizational unit | `string` | `""` | no |
| ou\_parent\_id | ID of the parent organizational unit, which may be the root | `string` | `""` | no |
| policy\_content | The policy content to add to the new policy. For example, if you create a [service control policy (SCP)](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scp.html), this string must be JSON text that specifies the permissions that admins in attached accounts can delegate to their users, groups, and roles. For more information about the SCP syntax, see the [Service Control Policy Syntax documentation](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_reference_scp-syntax.html) and for more information on the Tag Policy syntax, see the [Tag Policy Syntax documentation.](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_example-tag-policies.html) | `string` | `"{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": {\n    \"Effect\": \"Allow\",\n    \"Action\": \"*\",\n    \"Resource\": \"*\"\n  }\n}\n"` | no |
| policy\_description | A description to assign to the policy | `string` | `""` | no |
| policy\_id | The unique identifier (ID) of the policy that you want to attach to the target | `string` | `""` | no |
| policy\_name | The friendly name to assign to the policy | `string` | `""` | no |
| policy\_type | The type of policy to create. Currently, the only valid values are SERVICE\_CONTROL\_POLICY (SCP) and TAG\_POLICY. Defaults to SERVICE\_CONTROL\_POLICY | `string` | `"SERVICE_CONTROL_POLICY"` | no |
| role\_name | n/a | `string` | `"The name of an IAM role that Organizations automatically preconfigures in the new member account. This role trusts the master account, allowing users in the master account to assume the role, as permitted by the master account administrator. The role has administrator permissions in the new member account. The Organizations API provides no method for reading this information after account creation, so Terraform cannot perform drift detection on its value and will always show a difference for a configured value after import unless ignore_changes is used."` | no |
| tags | Map of tags to assign to the reqsource. | `map` | `{}` | no |
| target\_id | The unique identifier (ID) of the root, organizational unit, or account number that you want to attach the policy to | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| account\_arn | n/a |
| account\_id | n/a |
| ou\_arn | ARN of the organizational unit |
| ou\_id | Identifier of the organization unit |
| policy\_arn | n/a |
| policy\_id | n/a |
<!--- END_TF_DOCS --->

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