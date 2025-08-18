# variable "security_group_ids" {
#     default = ["sg-0ccba06af95f41fdb"]
# }

# variable "tags" {
#     default = {
#         Name = "roboshop-cart"
#         Terraform = "true"
#         Environment = "dev"
#     }
# }

# variable "instance_type" {
#     default = "t3.small"
# }



# variable "tags" {
#     default = {
#         #Name = "mr"
#         Name =  "${project}-${instances[count.index]}-${environment}"
#     }
# }

variable "project" {
    default = "roboshop"
   
}
variable "envi" {
  type = string
  default="dev"
}
variable "dbinstances" {
  #  default = ["mongodb", "redis", "mysql", "rabbitmq"]
    default=  ["mongodb", "mysql"]
    
}



