provider "aws" {
        region = "us-east-2"
}
    resource "aws_instance" "newterraform" {
        ami = "ami-09f85f3aaae282910"
        instance_type = "t2.micro"
        tags = {
                Name = "newterraform"
}
}
