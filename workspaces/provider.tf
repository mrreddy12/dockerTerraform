terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.98.0"
    }
  }

    backend "s3" {
    bucket = "mr-remote-state-bucket"  #bucket name
    key    = "mr-statefile"  # state file name
    region = "us-east-1"
    encrypt = true
    use_lockfile = false
  }

}

provider "aws" {
  # Configuration options
}