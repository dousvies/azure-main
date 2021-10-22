resource "azurerm_resource_group" "cicd" {
  name     = var.app_name
  location = "East US"
}

resource "azurerm_storage_account" "cicd" {
  name                     = "${var.app_name}thralonso"
  resource_group_name      = azurerm_resource_group.cicd.name
  location                 = azurerm_resource_group.cicd.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

resource "azuread_application" "cicd" {
  display_name = var.app_name
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "cicd" {
  application_id               = azuread_application.cicd.application_id
  owners                       = [data.azuread_client_config.current.object_id]
  app_role_assignment_required = false
}

resource "azuread_service_principal_password" "cicd" {
  service_principal_id = azuread_service_principal.cicd.id
}

resource "azurerm_role_assignment" "cicd" {
  principal_id         = azuread_service_principal.cicd.id
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
}