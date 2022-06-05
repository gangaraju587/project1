terraform {
  backend "s3" {
    bucket = "testterraform1679"
    key    = "statefile/terraform.tfstate"
    region = "ap-south-1"
  }
}