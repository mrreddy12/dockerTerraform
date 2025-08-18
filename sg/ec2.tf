#  scenario---create security group and verify in console manually created or not




#  first...security group create..run it and verify ...frist arg we cant change
resource "aws_security_group" "allow_all" {
    name        = "allow_all"  #giving name to security group--manually we select from dropdown
    description = "allow all traffic"   #optional

   #inbound rules .. allow all means from port ...to port 0 to 0 protocol -1
    ingress {
        from_port        = 0  #all
        to_port          = 0  #all
        protocol         = "-1"  # -1 means all ports..all traffic
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    #outbound rules
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow-all123"
    }
}


