data "azurerm_subscription" "current" {}
data "azuread_client_config" "current" {}
data "azurerm_client_config" "current" {}

data "azurerm_image" "image" {
  name                = var.image_name
  resource_group_name = azurerm_resource_group.cicd.name
}

data "azurerm_ssh_public_key" "cicd" {
  name                = "azurehelloworld"
  resource_group_name = "cicd"
}
