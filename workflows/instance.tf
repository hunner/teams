provider "aws" {
    region = "sa-east-1"
    shared_credentials_file = "C:/users/luiz.siqueira.CSPDOMAIN/Desktop/TerraformBuilds/AWS/credentials"
    profile = "terraform"
}

resource "aws_instance" "example" {
    ami = "ami-094c359b4d8c6a8ca"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.my-key.key_name}"
    security_groups = ["${aws_security_group.allow_ssh.name}"]
}

resource "aws_key_pair" "my-key" {
    key_name = "my-key"
    public_key = "${file("C:/Users/luiz.siqueira.CSPDOMAIN/Dropbox/AWS Key/Terraform/default.pub")}"
}

resource "aws_security_group" "allow_ssh" {
    name = "allow_ssh"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0 // all
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "example_public_dns" {
    value = "${aws_instance.example.public_dns}"
}