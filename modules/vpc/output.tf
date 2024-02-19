output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
    value = aws_vpc.vpc.id  
}

output "pubsub1" {
  value = aws_subnet.pubsub1.id
}

output "pubsub2" {
  value = aws_subnet.pubsub2.id
}

output "prisub1" {
  value = aws_subnet.prisub1.id
}

output "prisub2" {
  value = aws_subnet.prisub2.id
}

output "igw" {
  value = aws_internet_gateway.igw
}