variable "region" {
  default = "us-east-1"
}
variable "instance_type" {
  type = map(string)

  default = {
    "dev" = "t2.medium"
  }
}
variable "ami" {
  
}

variable "workspace_tag" {
  type = map(string)

  default = {
    "dev" = "Dev"
    "prod" = "Prod"
    "stage" = "Stage"
  }
}
