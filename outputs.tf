output "client_id" { value = module.cicd.client_id }
output "tenant_id" { value = module.cicd.tenant_id }
output "subscription_id" { value = module.cicd.subscription_id }
output "client_secret" {
  value     = module.cicd.client_secret
  sensitive = true
}