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
resource "aws_subnet" "public-subnet-1" {
        vpc_id = aws_vpc.Projectvpc.id
        cidr_block = "10.0.1.0/24"
        availability_zone = : "us-east-2a"
        map_public_ip_on_launch = "true"
        tags = {
                Name = "public-subnet-1"
}
}
resource "aws_subnet" "public-subnet-2" {
        vpc_id = aws_vpc.Projectvpc.id
        cidr_block = "10.0.1.0/24"
        availability_zone = "us-east-2b"
        map_public_ip_on_launch = "true"
        tags = {
                Name = "public-subnet-2"
}
}
# route tables
resource "aws_route
        

