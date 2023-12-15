provider "aws" {
	region = "us-east-2"
}
	resource "aws_vpc" "Myvpc" {
		cidr_block = "10.0.0.0/16"
		tags = {
			Name = "Myvpc"

}
}
	resource "aws_subnet" "mypublicsubnet" 	{
		vpc_id = aws_vpc.Myvpc.id
		availability_zone = "us-east-2"
		cidr_block = "10.0.1.0/24"
		tags = {
			Name = "mypublicsubnet"
}
}
	resource "aws_subnet" "myprivatesubnet" {
		vpc_id = aws_vpc.Myvpc.id
		availability_zone = us-east-2
		tags = {
			Name = "myprivatesubnet"
}
}
	resource "aws_internet_gateway" "igw" {
		vpc_id = aws_vpc.Myvpc.id		
		tags = {
			Name = "igw"
}
}
	resource "aws_route_table" "mainrtb" {
		vpc_id = aws_vpc.Myvpc.id
		route = {
				cidr_block = "0.0.0.0/0"
				gateway_id = aws_internet_gateway.igw.id
}
} 	
	resource "aws_route_table_association" "publicsubnet" {
		subnet_id = aws_subnet.mypublicsubnet.id
		route_table_id = aws_route_table.mainrtb.id
}
	resource "aws_s3_bucket" "s3_bucket" {
		bucket = "mybucket1234"
}
	resource = "aws_instance" "Myinstance" {
		ami = "ami-0f599bbc07afc299a"
		instance_type = "t2.micro"
		subnet_id = aws_subnet.mypublicsubnet.id
		tags = {
			Name = "Myinstance"
}
}
	resource "aws_key_pair" "TF_key" {
		key_name = "TF_key"
		public_key = tls_private_key.rsa.public_key_openssh
}
      	resource "tls_private_key" "rsa" {
        	algorithm = "RSA"
        	rsa_bits  = 4096
}
      	resource "local_file" "TF_key" {
        	content  = tls_private_key.rsa.private_key_pem
        	filename = "tfkey"
}
	resource "aws_security_group" "sg" {
		vpc_id = aws_vpc.Myvpc.id
		description = "Allow inbound rules"
	  	ingress {
				description = "ssh"
				from_port = 22
				to_port = 22
				protocol = "tcp
		        }
		ingress {
				description = "http"
				from_port = 80
				to_port = 80
				protocol = "tcp"
			}
		egress {
			from_port = 0
			to_port = 0
			protocol = "-1"
			cidr_blocks = ["0.0.0.0/0"]
			ipv6_cidr_blocks = ["::/0"]
			}
		tags {
			Name = "sg"
		}
}
		
