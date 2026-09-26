variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "public_subnet_azs" {
  type        = list(string)
  description = "パブリックサブネットを配置するAZのリスト"
}

variable "private_subnet_azs" {
  type        = list(string)
  description = "プライベートサブネットを配置するAZのリスト"
}