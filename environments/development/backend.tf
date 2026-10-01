terraform {
  backend "s3" {
    bucket = "terraform-web-app-development-state"
    key    = "development/terraform.tfstate"
    region = "eu-central-1"
  }
}
