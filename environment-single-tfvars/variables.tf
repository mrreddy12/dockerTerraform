variable "ami_id" {
  description = "AMI ID of joindevops RHEL9" #desc..optional
  type        = string   #type
 #default     = "ami-09c813fb71547fc4f"  #value
 
}

variable "environment" {
    description = "to specify environment type" #desc..optional
  type        = string   #type
    #default = "dev"
}


variable "instances" {
      description = "to specify db isntances" #desc..optional

 # default = ["mongodb", "redis", "mysql", "rabbitmq"]
}
# variable "instances" {
#   default = ["oracle"]
# }

variable "zone_id" {
  description = "to specify zone id" #desc..optional

   #default = "Z00750791B78G13C0X9TE"
}

variable "domain_name" {
  description = "to specify domain name"
    #default = "mrreddy.site"
}
