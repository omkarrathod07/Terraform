variable "region" {
  type = string
  default = "ap-south-1"
  description = "Default value is mumbai"
}
variable "name" {
  type = string
  default = "lambda"
}
variable "tags" {
  type = map(string)
  default = {
    "Name" = "lambda-function"
    "Env" = "Lab"
    "Date" = "08192026"
  }
}