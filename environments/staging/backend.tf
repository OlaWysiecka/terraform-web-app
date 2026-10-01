terraform {
  backend "s3" {
    bucket = "terraform-web-app-staging-state"
    key    = "staging/terraform.tfstate"
    region = "eu-central-1"
  }
}
