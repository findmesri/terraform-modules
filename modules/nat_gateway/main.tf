# create eip1, this eip will be allocated to nat1
resource "aws_eip" "eip1" {
  domain   = "vpc"

  tags = {
    Name = "eip-1"
  }
}

# create eip2, this eip will be allocated to nat2
resource "aws_eip" "eip2" {
  domain   = "vpc"

  tags = {
    Name = "eip-2"
  }
}

# create nat gateway1
resource "aws_nat_gateway" "nat1" {
  allocation_id = aws_eip.eip1.id
  subnet_id     = var.pubsub1

  tags = {
    Name = "nat-1"
  }
  depends_on = [var.igw]
}

# create nat gateway2
resource "aws_nat_gateway" "nat2" {
  allocation_id = aws_eip.eip2.id
  subnet_id     = aws_subnet.pubsub2.id

  tags = {
    Name = "nat-2"
  }
  depends_on = [var.igw]
}

# create private route table 1
resource "aws_route_table" "prt1" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat1.id
  }

  tags = {
    Name = "prt1"
  }
}

# create private route table 2
resource "aws_route_table" "prt2" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat2.id
  }

  tags = {
    Name = "prt2"
  }
}

# create private route table association 1
resource "aws_route_table_association" "a" {
  subnet_id      = var.prisub1
  route_table_id = aws_route_table.prt1.id
}

# create private route table association 2
resource "aws_route_table_association" "a" {
  subnet_id      = var.prisub2
  route_table_id = aws_route_table.prt2.id
}
