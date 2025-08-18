#  scenario---create security group and verify in console manually created or not


# instance name is used as  this   means it is not project specic it geneirc name
# this is common method/resource  defined   keys and values are getting from variables
# for ami,isntace_type specifying valus in variable becoz those are fixed for all projects
#for sgid and tags are project or env specic..ie dynamic..so passing from project
module  "ec2_instance" {
  # ami           = var.ami_id  
  # instance_type = var.instance_type
  # vpc_security_group_ids = var.sg_ids
  # tags = var.tags

   #source = "../terraform-aws-instance-modcreate"
      count = length(var.dbinstances)
   source = "../../modules-/application"
   sg_ids = ["sg-079888676816cb4ae"]                                       #its list..so use [ ]...open security goup..select "allow-all" and get sg_id
   ami_id          = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
   environment="dev"
   project="roboshop" 
  instances=var.dbinstances
 tags={
  Name="${var.project}-${var.dbinstances[count.index]}-${var.envi}"
 }
#  tags = {
#    # Name =  "${project}-${instances[count.index]}-${environment}"

#    Name =  "testuat"
#   }

}

