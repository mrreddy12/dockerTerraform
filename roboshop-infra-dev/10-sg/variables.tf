
#for security group===================
variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

#for front end===================
variable "frontend_sg_name" {
    default = "frontend"
}

variable "frontend_sg_description" {
    default = "created sg for frontend instance"
}

# for bastin=========================================
variable "bastion_sg_name" {
    default = "bastion"
}

variable "bastion_sg_description" {
    default = "created sg for bastion instance"
}