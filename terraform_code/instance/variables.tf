# Instance type
variable "instance_type" {
  default = {
    "prod"    = "t3.medium"
    "test"    = "t3.micro"
    "staging" = "t2.micro"
    "dev"     = "t3.medium"
  }
  description = "Type of the instance"
  type        = map(string)
}

# Variable to signal the current environment 
variable "env" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}

# Variable for the IAM Role that needs to have access to AWS ECR 
variable "iam_instance_profile_name" {
  default     = "EMR_EC2_DefaultRole"
  type        = string
  description = "IAM Role Name that will be used"
}




