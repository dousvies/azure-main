data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}
data "azuread_user" "owner" {
  user_principal_name = "thralonso_outlook.com#EXT#@thralonsooutlook.onmicrosoft.com"
}

data "azurerm_image" "image" {
  name                = "${var.image_name}_${var.image_version}"
  resource_group_name = azurerm_resource_group.cicd.name
}

data "azurerm_ssh_public_key" "cicd" {
  name                = "azurehelloworld"
  resource_group_name = "cicd"
}
