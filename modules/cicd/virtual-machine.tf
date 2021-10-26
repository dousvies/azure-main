resource "random_string" "cicd" {
  length = 10
}

data "template_file" "script" {
  template = file("${path.module}/startup.sh")
  vars = {
    client_id = azuread_service_principal.cicd.application_id
    tenant_id = azuread_service_principal.cicd.application_tenant_id
    client_secret = azuread_service_principal_password.cicd.value
  }
}

resource "azurerm_linux_virtual_machine" "cicd" {
  name                            = "${var.app_name}-vm"
  resource_group_name             = azurerm_resource_group.cicd.name
  location                        = azurerm_resource_group.cicd.location
  size                            = "Standard_F2"
  source_image_id                 = data.azurerm_image.image.id
  disable_password_authentication = false
  admin_username                  = "ubuntu"
  admin_password                  = random_string.cicd.id
  network_interface_ids           = [azurerm_network_interface.cicd.id]
  custom_data                     = base64encode(data.template_file.script.rendered)

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}