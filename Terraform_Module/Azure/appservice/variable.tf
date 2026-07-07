variable "name" {
  type = string
  default = "practic"
}
variable "location" {
  type = string
  default = "Central India"
  description = "Central India is default resion location"
}
variable "connection_string" {
  type = map(string)
  default = {
    "name" = "Nathsarkar"
    "type" = "SQLServer"
    "value" = "add here"
  }
}
variable "sku" {
  type = map(string)
  default = {
    "tier" = "Standard"
    "size" = "S1"
  }
}
variable "site_config" {
  type = map(string)
  default = {
    "dotnet_framework_version" = "v4.0"
    "scm_type" = "LocalGit"
  }
}