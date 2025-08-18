variable "ami_id" {
    #  description = "AMI ID of the EC2 instance"
    # type = string
    # default = "ami-09c813fb71547fc4f"
   
}

#validation part ... it cotnains two pars first one is isntance types...seocnd one is var.instance type
# that means var.itnatance type should be  any of these 3 values ...else..it throws error message eg: t3.large  means error
variable "instance_type" {
    # default = "t3.micro"
    # type = string
    # description = "Instance size"

    validation {
        condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
        error_message = "Valid values for instance_type are: t3.micro, t3.small, t3.medium"
    } 
}

# mandatory to provide
variable "sg_ids" {
#     type = list
}



variable "project" {
   # default = "roboshop"
   
}
variable "environment" {
   #default = "t3.micro"
}
variable "instances" {
    # type = map
}



variable "tags" {
    default = {
#         #Name = "mr"
        #Name =  "${project}-${count}-${environment}"
     }
}