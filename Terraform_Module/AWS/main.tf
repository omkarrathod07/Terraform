module "s3" {
  source = "./s3"
  bucket = "omkar-rathod-04032025-practical-Lab"
}
module "vpc" {
  source = "./vpc"
  VPC_cidr_block = "192.167.0.0/16"
  Public_cidr_block = "192.167.1.0/24"
  Private_cidr_block = "192.167.2.0/24"
  availability_zone = "ap-south-1a"
}
module "ec2" {
  source = "./ec2"
  instances_type = "t3.micro"
}
module "elb" {
  source = "./elb"
}
module "eks"{
  source = "./eks"
  instance_types = "t3.large"
}
module "lambda" {
  source = "./lambda"
}