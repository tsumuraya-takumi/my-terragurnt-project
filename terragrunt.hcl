remote_state {
  backend = "s3"

  config = {
    bucket = "terraform-state-key"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region = "ap-northeast-1"
    encrypt = true
    kms_key_id = "arn:aws:kms:ap-northeast-1:381492180439:key/1e1dc460-fc41-4fb0-9ff0-6c9fb0416dc5"
    use_lockfile = true
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}