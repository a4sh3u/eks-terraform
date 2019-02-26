variable "account_id" {}
variable "account_name" {}
variable "home_dir" {}

variable "administrator_role" {
  default = "AdministratorRole"
}

variable "profile_name" {
  default = "default"
}

variable "region" {
  default = "eu-central-1"
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type        = "list"

  default = [
    {
      role_arn = "arn:aws:iam::880641691172:role/AdministratorRole"
      username = "AdministratorRole"
      group    = "system:masters"
    },
  ]
}

variable "map_roles_count" {
  description = "The count of roles in the map_roles list."
  type        = "string"
  default     = 1
}
