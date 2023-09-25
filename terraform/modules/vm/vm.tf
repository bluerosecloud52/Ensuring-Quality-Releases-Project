resource "azurerm_network_interface" "test" {
  name                = "NIC-${var.resource_type}-${var.application_type}"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.public_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                  = "${var.resource_type}-${var.application_type}"
  location              = var.location
  resource_group_name   = var.resource_group
  size                  = "B1s"
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.test.id]
  admin_ssh_key {
    username   = var.admin_username
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDX0iF+V/v/ECrI7vpA2403fnlD2YVvopPujDMf7MH1x/FJpvzNTx3GHlGd5O1fg/OVrf0w6k/TOj8JANBdncj0G0D4s6ZBegbj6LMbxLCAWSVewjNHtlKzXQHCnmqTaNdc/E0Q8t/2/Z3+92uS4p/WAeKxH7VQVgch+aTpxnRT+Hnwedz/quo9u75tCDzFjSSRkDWsXeK//uiklT9MAvTNkENogCY3sBnsUMD2/ZeRvMLsCCp3a+deRsjQhWvEliSssGENpVTYBx5OtLRJ5eVOb4QIxNfCuuYHgXqFC8BFcnXCyEN1C3tYKyXPpI30uTjkhzSkdCTZWX7t1/6fEESxjp7/yd/DY5HI6C045Gj4dA+MYqj4tunCXPTNkH/guQ5GTJc+k5iHPX5vrlWNwznivKTDjRbXD73pztEmzmttZRwOIlG8iwkfDpp+3q3p8I04jKXEKhVoIq3M2QzoufVL1kCM0/3ntRDzGXMs6eXXpH0r7dGgMF09uBi4rO09bM0= generated-by-azure"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    id = "/subscriptions/ad6befd3-6a77-4714-b24d-181b38cb2753/resourceGroups/Azuredevops/providers/Microsoft.Compute/galleries/AzureVirtualMachineGalllery/images/AzureVirtualMachineUbuntu"
  }
}
