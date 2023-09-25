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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDL2wY6ZcMzMlUtCnyzCPUya5KU/JiF5ayIag4sbAj80H2TlZ4InVTSoTmYliPRnZTA7UeT154hptn7Z/i80AhIRHLq4xHYILE4YPXRyx2CwuV4fXxNQjO8EYkMbqwpZb6p+T+pVngvQRkIt199njd0wD14Q6MbxCSoSApaWj6MfbC82Aju8U0oIqYQBgB83LE/LsoLL+cnTJo479N4Si4q3c6d/4mT1HbBeNCCG+EE8Le25dGo3yqZMG29o6I4SKxDfQt67yq8+E13KVJv5KXjPGUBGPLATNc0OOfjWOxag0hgSgey1fuUO2+B7GDXQ5bG0GLThmDH0KG8fy6pPdaC0rllFU3m2j8X2udRu4M7WoAZzrpNn8e/kA3X9hbuCCidYBmhB3bf8DOPJY3FL92nSY+2fZkrBhfVsatHFx5CTZtSJAJcKp9DMZgY3njgkeHD7gL8qkH5GAwpTGIL+OAVCQVs0nkG0mA9IQCYz35VFWecrHfuVKbGBi1lUKd6aeU= generated-by-azure"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    id = "/subscriptions/c2974833-f9d6-49e2-b843-74513c83a919/resourceGroups/Azuredevops/providers/Microsoft.Compute/galleries/AzureVirtualMachineGalllery/images/AzureVirtualMachineUbuntu"
  }
}
