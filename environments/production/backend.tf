terraform {
  backend "s3" {
    bucket = "terraform-web-app-production-state"
    key    = "production/terraform.tfstate"
    region = "eu-central-1"
  }
}
