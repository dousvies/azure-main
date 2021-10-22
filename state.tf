resource "azurerm_resource_group" "terraform-state" {
  name     = "terraform_state"
  location = "East US"
}

resource "azurerm_storage_account" "terraform-state" {
  name                     = "terraformstatethralonso"
  resource_group_name      = azurerm_resource_group.terraform-state.name
  location                 = azurerm_resource_group.terraform-state.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

resource "azurerm_storage_container" "terraform-state" {
  name                  = "terraform-state"
  storage_account_name  = azurerm_storage_account.terraform-state.name
  container_access_type = "blob"
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "terraform-state" {
  name                        = "terraformstatethralonso"
  location                    = azurerm_resource_group.terraform-state.location
  resource_group_name         = azurerm_resource_group.terraform-state.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "get",
    ]
    secret_permissions = [
      "get",
      "set",
    ]
    storage_permissions = [
      "get",
    ]
  }
}