# create a vpc
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

#create a igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# use data source to gell all availability zones in region
data "aws_availability_zones" "available" {
  state = "available"
}

# create public subnet1
resource "aws_subnet" "pubsub1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pubsub1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub1"
  }
}

# create public subnet2
resource "aws_subnet" "pubsub2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pubsub2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "pubsub2"
  }
}

#create route table1
resource "aws_route_table" "prt1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "prt1"
  }
}

#create route table2
resource "aws_route_table" "prt2" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "prt2"
  }
}

# create route table association1
resource "aws_route_table_association" "prta1" {
  subnet_id      = aws_subnet.pubsub1.id
  route_table_id = aws_route_table.prt1.id
}

# create route table association2
resource "aws_route_table_association" "prta2" {
  subnet_id      = aws_subnet.pubsub2.id
  route_table_id = aws_route_table.prt2.id
}

# create private subnet1
resource "aws_subnet" "prisub1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.prisub1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false 

  tags = {
    Name = "prisub1"
  }
}

# create private subnet2
resource "aws_subnet" "prisub2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.prisub2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false 

  tags = {
    Name = "prisub2"
  }
}



