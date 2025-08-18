resource "aws_instance" "roboshop" {
 // count=4
   count = length(var.instances)
  ami           = "ami-09c813fb71547fc4f"  //wihtou out variable
  //ami           =  var.ami_id  //with vairable
  #instance_type = "t3.micro"
    instance_type = var.environment == "uat" ? "t3.micro" : "t3.small"  //we are using micro  ll but prod it may rquire bigger..else it will crash
  //resourcetype.resourncename.id ..creted security group below...spec
  vpc_security_group_ids = [aws_security_group.allow_all.id]  // its list...so used [  

# tags =  {

#          Name = "${local.prefix}-${var.instances[count.index]}"
#     }

  # tags = merge(
  #   local.common_tags,
  #   {
  #     Name = "${local.name_tag.Name}-${var.instances[count.index]}"
  #   }
  # )

  
  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_tag.Name}-${var.instances[count.index]}"
    }
  )
  
  }

  

resource "aws_security_group" "allow_all" {
    name        = var.sg_name
    description = var.sg_description

    ingress {
        from_port        = var.from_port
        to_port          = var.to_port
        protocol         = "-1"
        cidr_blocks      = var.cidr_blocks
        ipv6_cidr_blocks = ["::/0"]
    }
    egress {
        from_port        = var.from_port
        to_port          = var.to_port
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = var.sg_tags
}