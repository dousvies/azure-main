resource "azurerm_virtual_network" "cicd" {
  name                = "${var.app_name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.cicd.location
  resource_group_name = azurerm_resource_group.cicd.name
}

resource "azurerm_subnet" "cicd" {
  name                 = "${var.app_name}-internal"
  resource_group_name  = azurerm_resource_group.cicd.name
  virtual_network_name = azurerm_virtual_network.cicd.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "cicd" {
  name                = "${var.app_name}-public-ip"
  resource_group_name = azurerm_resource_group.cicd.name
  location            = azurerm_resource_group.cicd.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "cicd" {
  name                = "${var.app_name}-nic"
  location            = azurerm_resource_group.cicd.location
  resource_group_name = azurerm_resource_group.cicd.name

  ip_configuration {
    name                          = "${var.app_name}-internal"
    subnet_id                     = azurerm_subnet.cicd.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.cicd.id
  }
}
