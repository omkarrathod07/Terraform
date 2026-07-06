resource "azurerm_resource_group" "Practic-Resource-Group" {
  name = "${var.name}-rg"
  location = var.location
  tags = var.tags
}
resource "azurerm_virtual_network" "practic-vnet" {
  name = "${var.name}-vnet"
  location = var.location
  address_space = var.address_space
  resource_group_name = azurerm_resource_group.Practic-Resource-Group.name
  tags = var.tags
}
resource "azurerm_subnet" "practic-subnet" {
  name = "${var.name}-subnet"
  resource_group_name = azurerm_resource_group.Practic-Resource-Group.name
  virtual_network_name = azurerm_virtual_network.practic-vnet.name
  address_prefixes = var.address_prefixes
}
resource "azurerm_network_interface" "practic-net-interface" {
  name = "${var.name}-nic"
  location = var.location
  resource_group_name = azurerm_resource_group.Practic-Resource-Group.name

  ip_configuration {
    name = "ipconfig-1"
    subnet_id = azurerm_subnet.practic-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = var.tags
}
resource "azurerm_virtual_machine" "practic-VM" {
  name = "${var.name}-vm"
  location = var.location
  resource_group_name = azurerm_resource_group.Practic-Resource-Group.name
  network_interface_ids = [azurerm_network_interface.practic-net-interface.id]
  vm_size = var.vm_size
  delete_data_disks_on_termination = true
  delete_os_disk_on_termination = true
  zones = [ "Zone1" ]

  storage_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version = "latest"
  }
  storage_os_disk {
    name = "myosdisk1"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name = var.os_profile.computer_name
    admin_password = var.os_profile.admin_password
    admin_username = var.os_profile.admin_username
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.tags
}