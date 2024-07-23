resource "azuread_application" "example" {
  display_name = "example-app"
  identifier_uris = ["api://${var.github_org}/${github_repository.example.name}"]
}

resource "azuread_service_principal" "example" {
  application_id = azuread_application.example.application_id
}

resource "azuread_application_federated_identity_credential" "github_oidc" {
  application_object_id = azuread_application.example.object_id
  display_name          = "GitHub OIDC"
  audiences             = ["api://${var.github_org}/${github_repository.example.name}"]
  issuer                = "https://token.actions.githubusercontent.com"
  subject               = "repo:${var.github_org}/${github_repository.example.name}:ref:refs/heads/${var.branch}"
}

resource "azurerm_role_assignment" "example" {
  principal_id   = azuread_service_principal.example.id
  role_definition_name = "Contributor"
  scope          = data.azurerm_subscription.primary.id
}
