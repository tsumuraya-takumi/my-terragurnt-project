locals {
  environment = "development"
}

include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

terraform {
  source = "../../../modules/network"
}

inputs = {
  environment = local.environment
}