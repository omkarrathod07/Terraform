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
variable "runtime" {
  type = string
  default = "nodejs24.x"
}
variable "environment" {
  type = map(string)
  default = {
    ENVIRONMENT = "Production"
    LOG_LEVEL = "Info"
  }
}