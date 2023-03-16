terraform {
  backend "s3" {
    bucket = "terraform-new-786"
    key    = "terraform-folder/why"
    region = "us-east-1"
  }
}