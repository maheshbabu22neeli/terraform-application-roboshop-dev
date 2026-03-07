variable "project" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "bastion_policy_arns" {
  description = "List of IAM Policy ARNs to be attached to the role"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
  ]
}

variable "zone_id" {
  type = string
  default = "Z013175831RO1NWFBESW7"
}