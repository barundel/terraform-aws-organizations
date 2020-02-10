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

No provider.

## Inputs

No input.

## Outputs

No output.
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