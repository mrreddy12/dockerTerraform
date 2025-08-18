#  scenario---create security group and verify in console manually created or not



resource "aws_instance" "create_instance" {
  #ami
  ami           = "ami-09c813fb71547fc4f"
  // instance type
  instance_type = "t3.micro"
 # Specifying a 50 GB root volume
  root_block_device {
    volume_size = 20 
    volume_type = "gp3" # Or another type like "gp3", "io1", etc.
  }

 
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





# install ohters/ws see later
# resource "aws_instance" "playwright_runner" {
#   ami           = "ami-xxxxxxxxxxxx"   # <-- replace with correct AMI for your region
#   instance_type = "t3.medium"          # Playwright needs a bit more memory than micro

#   user_data = <<-EOF
#     #!/bin/bash
#     set -e

#     # Update system
#     sudo dnf update -y

#     # Install Docker
#     sudo dnf install -y docker
#     sudo systemctl enable docker
#     sudo systemctl start docker
#     sudo usermod -aG docker ec2-user

#     # Install Node.js (from Amazon Linux Extras or AppStream repo)
#     sudo dnf install -y nodejs npm

#     # Install Playwright globally
#     sudo npm install -g playwright

#     # Install required browsers for Playwright
#     npx playwright install --with-deps

#     # Verify installs
#     docker --version
#     node --version
#     npm --version
#     npx playwright --version

#     echo "✅ Setup completed: Docker + Node.js + Playwright installed"
#   EOF

#   tags = {
#     Name = "Playwright-Runner"
#   }
# }