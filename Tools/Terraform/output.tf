output "ServerIP" {
  value = aws_instance.jenkinsUbuntuServer.public_ip
}
output "amiID" {
  value = data.aws_ami.latest_ubuntu.id
}