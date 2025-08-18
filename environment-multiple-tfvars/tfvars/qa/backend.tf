terraform {
     backend "s3" {
bucket = "mr-remote-state-bucket"
key    = "tfvars-demo"
region = "us-east-1"
encrypt        = true
use_lockfile = true
}
}