provider "aws" {
        region = "us-east-2"
}
#vpc
resource "aws_vpc" "Projectvpc" {
        cidr_block = "10.0.0.0/16"
        tags = {
                Name = "Projectvpc"
}
}
#public subnets
resource "aws_subnet" "public-subnet-2a" {
        vpc_id = aws_vpc.Projectvpc.id
        cidr_block = "10.0.1.0/24"
        availability_zone = : "us-east-2a"
        map_public_ip_on_launch = "true"
        tags = {
                Name = "public-subnet-2a"
}
}
resource "aws_subnet" "public-subnet-2b" {
        vpc_id = aws_vpc.Projectvpc.id
        cidr_block = "10.0.3.0/24"
        availability_zone = "us-east-2b"
        map_public_ip_on_launch = "true"
        tags = {
                Name = "public-subnet-2b"
}
}
# Private Subnets
resource "aws_subnet" "private-subnet-2a" {
        vpc_id = aws_vpc.Projectvpc.id
        cidr_block = "10.0.2.0/24"
        availability_zone = "us-east-2a"
        map_public_ip_on_launch = "false"
        tags = {
                Name = "private-subnet-2a"
}
}
resource " aws_subnet" "private-subnet-2b" {
        vpc_id = aws_vpc.project.id
        cidr_block = "10.0.4.0/24"
        availability_zone = "us-east-2b"
        map_public_ip_on_launch = "false"
        tags = {
                Name = "private-subnet-2b"
}
}
# internet gateway
resource "aws_internet_gateway" "myig" {
        vpc_id = aws_vpc.Projectvpc.id
        tags = {
                Name = "myig"
}
}   
# Route Table
resource "aws_route_table" "web-rt" {
        vpc_id = aws_vpc.Projectvpc.id
        route {
                cidr_block = "0.0.0.0/0"
                gateway_id = aws_internet_gateway.myig.id
}
        tags = {
                Name = "web-rt"
}
}
resource "aws_route_table" "app-rt" {
        vpc_id = aws_vpc.Projectvpc.id
        route {
                cidr_block = "0.0.0.0/0"
                gateway_id = aws_nat_gateway.mynat.id
}
        tags = {
                Name = "app-rt"
}
}
# Route Table association
resource "aws_subnet_association" "pub-sub1" {
        subnet_id = aws_subnet.public-subnet-2a.id
        route_table_id = aws_route_table.web-rt.id
}
resource "aws_subnet_association" "pub-sub2" {
        subnet_id = aws_subnet.public-subnet-2b.id
        route_table_id = aws_route_table.web-rt.id
}
resource "aws_subnet_association" "prvt-sub-1" {
        subnet_id = aws_subnet.
        route_table_id = aws_route_table
}
resource "aws_subnet_association" "prvt-sub-2" {
        subnet_id = aws_subnet.private-subnet-2b.id
        route_table_id = aws_route_table.app-rt.id
}
#Elastic ip
resource "aws_eip" "eip" {
        vpc = true
        tags = {                
                Name = "eip"
}
}
# Nat Gateway
resource "aws_nat_gateway" "mynat" {
        vpc_id = aws_vpc.Projectvpc.id
        tags = {
                Name = "mynat"
}
}    

                
        

