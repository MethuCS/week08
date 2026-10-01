data "azurerm_client_config" "current" {}

#
# Allow GitHub Actions to push Docker images to ACR
#
resource "azurerm_role_assignment" "pipeline_acr_push" {
  principal_id         = data.azurerm_client_config.current.object_id
  principal_type       = "ServicePrincipal"
  role_definition_name = "AcrPush"
  scope                = azurerm_container_registry.acr.id
}

#
# Allow GitHub Actions to access the AKS cluster
#
resource "azurerm_role_assignment" "pipeline_aks_user" {
  principal_id         = data.azurerm_client_config.current.object_id
  principal_type       = "ServicePrincipal"
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  scope                = azurerm_kubernetes_cluster.aks.id
}