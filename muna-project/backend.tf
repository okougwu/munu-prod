terraform {
  backend "s3" {
    bucket  = "agunigbo-terraform-remote-state"
    key     = "aguoko.tfstate"
    region  = "eu-west-2"
    profile = "munachi"
  }
}