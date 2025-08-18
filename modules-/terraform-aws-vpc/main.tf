# VPC roboshop-dev
#//below two per vpc creation...till data base

#================================vpc creation starts=====================
resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"  # its common
  enable_dns_hostnames = "true"  # add this extra apart from copied code

  tags = merge(
    var.vpc_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}"
    }
  )

}

# need to specify vpc id and tags(for its name roboshop-uat)
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id # association with VPC

  tags = merge(
    var.igw_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}" # IGW roboshop-dev
    }
  )
}


#roboshop-dev-us-east-1a
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]
  
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true
  tags = merge(
    var.public_subnet_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-public-${local.az_names[count.index]}"
    }
  )
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidrs[count.index]
  
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.private_subnet_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-private-${local.az_names[count.index]}"
    }
  )
}

resource "aws_subnet" "database" {
  count = length(var.database_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_subnet_cidrs[count.index]
  
  availability_zone = local.az_names[count.index]

  tags = merge(
    var.database_subnet_tags,
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-database-${local.az_names[count.index]}"
    }
  )
}
#================================vpc creation done=====================

#================================create elastic ip & NAT gateway and its vars=====================
resource "aws_eip" "nat" {
  domain   = "vpc"
  tags = merge(
    var.eip_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}"
    }
  )
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id # getting elastic ip from above method
  subnet_id     = aws_subnet.public[0].id  # we are assinging to first public subnet so..its i0

  tags = merge(
    var.nat_gateway_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}"
    }
    
  )
   # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]

}
  #===============================create route table  creation  and its vars=====================
   # crete 3 roubte tables for  3 subnets 

   resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.public_route_table_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-public"
    }
  )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.private_route_table_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-private"
    }
  )
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.database_route_table_tags,
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-database"
    }
  )
}
  #===============================route table  creation done and its vars=====================

  #===============================associstae routes with  subensts creation  and its vars=====================

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id//we have two routes ...so suing index and getting id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id//we have two routes ...so suing index and getting id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidrs)
  subnet_id      = aws_subnet.database[count.index].id//we have two routes ...so suing index and getting id
  route_table_id = aws_route_table.database.id
}