#  scenario---create security group and verify in console manually created or not



resource "aws_instance" "create_instance" {
  #ami
  ami           = "ami-09c813fb71547fc4f"
  // instance type
  instance_type = "t3.micro"
 # Specifying a 50 GB root volume
  root_block_device {
    volume_size = 50 
    volume_type = "gp3" # Or another type like "gp3", "io1", etc.
  }

  # User data script
  user_data = <<-EOF
    #!/bin/bash
    sudo growpart /dev/nvme0n1 4
    sudo lvextend -L +10G /dev/mapper/RootVG-rootVol
    sudo xfs_growfs /
    sudo lvextend -L +10G /dev/mapper/RootVG-homeVol
    sudo xfs_growfs /home
    sudo lvextend -L +10G /dev/mapper/RootVG-varVol
    sudo xfs_growfs /var
  EOF

  
  //resourcetype.resourncename.id ..creted security group below...spec
    vpc_security_group_ids = [aws_security_group.allow_all.id]//getting id from below script
  tags = {
    Name = "Docker"
  }
}

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
        Name = "allow-all"
    }
}