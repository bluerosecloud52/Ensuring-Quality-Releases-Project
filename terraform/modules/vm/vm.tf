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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDcm1KCTCHJjLbQY9iq+yF2t0HVHgL2h2uRj0a1cOxXuaHIZAq9S/GUredKtW2w3XY0FZRYBb3pfHbUF8IavHxo0NDqHiQUNCflSO3N8iXV9BUHevbiAPgK2wge+H+ohZCrtt0qLS49m5RDZ905EB/wFJXSmmEphMh9tfNE/tCT2WEk8jDbOwyamCW5wSO2oOTgxRO2dNT864rnUoxNuTpRNMJYd8aPb/O1OqjGVZNWST2ilaQlaCu27xxNiwdF5ty57OXaiGYZVVe3I5kDUE1v+bQl8+rNjs+2d6y9af/CpovVi3XOwN3dfnUmgc9oCkT/SDkIfIs7BQZ4ssZxN8Xtxau9iIsUbfHhkIpjFT9e6PJTsDxHYu9AuzJWQhCU6tl8bxIdMy90eG5W7pwITik3bdP6OzQXXxJMuVDy/lzMuEH+K7QglUqd0wiXvwHHSccsiAORjZpBqqNyBndhh448m2t78w9cKfvy1RV1w045GpHiZ8oZ9QsY0P8EAz4IHMk= generated-by-azure"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    id = "/subscriptions/c761712a-772e-4832-b4d5-73b3a4b12e0b/resourceGroups/Azuredevops/providers/Microsoft.Compute/galleries/AzureVirtualMachineGalllery/images/AzureVirtualMachineUbuntu"
  }
}
