terraform {
  backend "s3" {
    bucket = "dream-vacation-terraform-state-joe-dan"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
