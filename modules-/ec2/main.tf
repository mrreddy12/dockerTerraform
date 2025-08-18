#  scenario---create security group and verify in console manually created or not

# instance name is used as  this   means it is not project specic it geneirc name
# this is common method/resource  defined   keys and values are getting from variables
# for ami,isntace_type specifying valus in variable becoz those are fixed for all projects
#for sgid and tags are project or env specic..ie dynamic..so passing from project
resource "aws_instance" "this" {
  ami                   = var.ami_id
  instance_type         = var.instance_type
  vpc_security_group_ids= var.sg_ids
  tags                   = var.tags




  
}
