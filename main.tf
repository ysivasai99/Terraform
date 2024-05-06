provider "aws" {
          region = "us-east-2"
          }
          resource "aws_vpc" "Myvpc" {
                    cidr_block = "10.0.0.0/16"
                    tags = {
                              Name = "Myvpc" 
                              }
                              }
          resource "aws_subnet" "public_subnet" {
                    vpc_id = aws_vpc.Myvpc.id
                    availability_zone = "us-east-2a"
                    cidr_block = "10.0.1.0/24"
                    tags = {
                            Name = "public_subnet"
                            }
                            }

          resource "aws_subnet" "private_subnet" {
                    cidr_block = "10.0.2.0/24"
                    vpc_id = aws_vpc.Myvpc.id
                    availability_zone = "us-east-2a"
                    tags = {
                            Name = "private_subnet"
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
                    route {
                            cidr_block = "0.0.0.0/0"
                            gateway_id = aws_internet_gateway.igw.id
                            }
                            }
          resource "aws_route_table_association" "for_public_subnet" {
                      subnet_id = aws_subnet.public_subnet.id
                      route_table_id = aws_route_table.mainrtb.id
                      }
          resource "aws_s3_bucket" "s3_bucket" {
                bucket = "mys3bucket7737734t"
               }
          resource "aws_instance" "myinstance" {
                  ami = "ami-0f599bbc07afc299a"
                  instance_type = "t2.micro"
                  subnet_id = aws_subnet.publicsubnet.id
                  tags = {
                            Name = "terraformdup"
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
                name        = "sg"
                description = "Allow ssh and tcp inbound traffic"
                vpc_id      = aws_vpc.Myvpc.id

                ingress {
                        description      = "Allow only ssh"
                        from_port        = 22
                        to_port          = 22
                        protocol         = "ssh"
                }
                ingress {
                        description      = "Allow only tcp"
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


        
                      
