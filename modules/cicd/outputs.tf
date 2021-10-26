output "client_id" { value = azuread_service_principal.cicd.application_id }
output "tenant_id" { value = azuread_service_principal.cicd.application_tenant_id }
output "client_secret" { value = azuread_service_principal_password.cicd.value }
output "subscription_id" { value = data.azurerm_subscription.current.subscription_id }
output "vm_password" { value = random_string.cicd.id }