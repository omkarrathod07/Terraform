resource "aws_instance" "jenkinsUbuntuServer" {
  ami = data.aws_ami.latest_ubuntu.id
  instance_type = var.instanceType
  availability_zone = var.availabilityZone
  key_name = "Practic"
  vpc_security_group_ids = [ "sg-037e0bcd651733417" ]
  user_data = file("./insta.sh")

  tags = {
    Name = "Maven - Ubuntu"
    Env = "Dev"
    Date = "03052026"
    Size = "08 GB"
  }
}