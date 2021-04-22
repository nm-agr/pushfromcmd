provider "aws"{
profile = "default"
region = "us-east-1"
}
resource "aws_instance" "nmagr-terraform"{
ami = "ami-0742b4e673072066f"
instance_type = "t2.micro"
key_name = "nmagr"
}
