terraform {
  backend "s3" {
    bucket = "ddogra1-clo835-labs"    // Bucket where to SAVE Terraform State
    key    = "Labs/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "us-east-1"              // Region where bucket is created
  }
}
  