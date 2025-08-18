variable "ami_id" {
  type        = string   #type
  default     = "ami-09c813fb71547fc4f"  #value
  description = "AMI ID of joindevops RHEL9" #desc..optional
}

variable "environment" {
    default = "dev"
}


variable "instances" {
  default = ["mongodb", "redis", "mysql", "rabbitmq"]
}
# variable "instances" {
#   default = ["oracle"]
# }

variable "zone_id" {
    default = "Z00750791B78G13C0X9TE"
}

variable "domain_name" {
    default = "mrreddy.site"
}
