variable "name" {
  type = string
  default = "practic"
}
variable "location" {
  type = string
  default = "Central India"
  description = "Default location is Central India."
}
variable "vm_size" {
  type = string
  default = "Standard_DS1_v2"
  description = "Default Size is Standard_DS1_v2"
}
variable "address_space" {
  type = list(string)
  default = [ "10.0.0.0/16" ]
}
variable "address_prefixes" {
  type = list(string)
  default = [ "10.0.1.0/24" ]
}
variable "tags" {
  type = map(string)
  default = {
    Name = "Practic"
    Env = "Dev"
    Resource-Group = "Practic-RG"
  }
}
variable "os_profile" {
  type = map(string)
  default = {
    "computer_name" = "ubuntu"
    "admin_password" = "Root@123"
    "admin_username" = "root"
  }
  description = "default user is root and passward is Root@123"
}
variable "storage_os_disk" {
  type = map(string)
  default = {
    "name" = "myosdisk1"
    "caching" = "ReadWrite"
    "create_option" = "FromImage"
    "managed_disk_type" = "Standard_LRS"
  }
}
variable "storage_image_reference" {
  type = map(string)
  default = {
    "publisher" = "Canonical"
    "offer" = "0001-com-ubuntu-server-jammy"
    "sku" = "22_04-lts"
    "version" = "latest"
  }
}