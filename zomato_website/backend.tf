terraform {
  backend "s3" {
    bucket = "tf-buck"
    key = "project1.tfstate"
    region = "ap-south-1"
    profile = "tf-user1"
  }
}

