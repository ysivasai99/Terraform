provider "aws" {
        region = "us-east-2"
}
    resource "aws_vpc" "Myvpc" {
      cidr_block = "10.0.0.0/16"
      tags = {
          Name = "Myvpc"
}
}
   resource "aws_subnet" "awspublicsubnet" {
       vpc_id = "aws_vpc.Myvpc
       availaibility_zone = "us-east-2a"
       cidr_block = "10.0.1.0/24"
       tags = {
              Name = "awspublicsubnet"
}
}
   resource "aws_subnet" "awsprivatesubnet" {
       vpc_id = aws_vpc.Myvpc.id
       availaibility_zone = "us-east-2a"
       cidr_block = "10.0.2.0/24"
       tags = {
              Name = "awsprivatesubnet"
}
}
     resource "aws_internet_gateway" "Myigw" {
        vpc_id = aws_vpc.Myvpc.id
        tags = {
            Name = "Myigw"
}
}
      resource "aws_route_table" "mainrtb" {
          vpc_id = aws_vpc.myvpc.id
          route = {
                cidr_block = "0.0.0.0/0"
                gateway_id = "aws_internet_gateway.Myigw.id
}
}
      resource "aws_route_table_association" "Publicsubnet" {
        subnet_id = "aws_subnet.aws_internet_gateway.id
        route_table_id = "aws_route_table.mainrtb.id
}
      resource = "aws_s3_bucket" "s3_bucket" {
          bucket = "mybucket1324"
}
      resource "aws_instance" "Myinstance" {
          ami = "ami-0f599bbc07afc299a"
          instance_type = "t2.micro"
          subnet_id = "aws_subnet.awspublicsubnet.id
          tags = {
              Name = "Myinstance"
}
}
      resource "aws_key_pair" "TF_key" {
        key_name   = "TF_key"
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
        name        = "sg"
        description = "Allow TLS inbound traffic"
        vpc_id      = aws_vpc.myvpc.id

      ingress {
          description      = "ssh"
          from_port        = 22
          to_port          = 22
          protocol         = "tcp"
  }

      ingress {
        description      = "http"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
  }

      egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
  }

      tags = {
        Name = "sg"
  }
}
