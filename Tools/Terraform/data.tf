data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # This is the official Canonical account ID for Ubuntu AMIs

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-*-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}