terraform {
  backend "s3" {
    bucket         = "vuclip-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    profile        = "prod"
  }
}
