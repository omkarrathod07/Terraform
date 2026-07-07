variable "region" {
  type = string
  default = "ap-south-1"
  description = "Default region is mumbai ( ap-south-1 )"
}
variable "instanceType" {
  type = string
  default = "t3.small"
}
variable "availabilityZone" {
  type = string
  default = "ap-south-1b"
  description = "Default availability zone is ap-south-1b"
}