terraform {
  backend "s3" {
    bucket       = "bits-aws-tf-bucket"
    key          = "Dev/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
  }
}
