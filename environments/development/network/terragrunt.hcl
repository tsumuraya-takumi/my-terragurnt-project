locals {
  environment = "development"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../../modules/network"
}

inputs = {
  environment  = local.environment
  project_name = include.root.locals.project_name
}