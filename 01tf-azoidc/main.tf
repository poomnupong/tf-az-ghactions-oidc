
#== provider =====

provider "azurerm" {
  features {}
  tenant_id       = var.TENANTID
  subscription_id = var.SUBSCRIPTIONID
}

#== variables =====

variable "TENANTID" {
  description = "The Tenant ID of the Entra ID"
  type        = string
}

variable "SUBSCRIPTIONID" {
  description = "The Subscription ID of the Azure subscription"
  type        = string
}

variable "APPNAME" {
  description = "The name of the app registration. This should be unique in the Entra ID"
  type        = string
}

variable "GHORGNAME" {
  description = "The GitHub organization name"
  type        = string
}

variable "GHREPONAME" {
  description = "The GitHub repository name"
  type        = string
}

variable "GHBRANCHNAME" {
  description = "The GitHub branch name"
  type        = string
}

#== resources =====

#== data sources =====

data "azurerm_subscription" "primary" {
  subscription_id = var.SUBSCRIPTIONID
}

# create azuread application, service principal, role assignment to the given subscription as owner, and federated identity credential
resource "azuread_application" "example" {
  display_name = var.APPNAME
  #identifier_uris = ["api://${var.TENANTID}/${var.APPNAME}"]
}

resource "azuread_service_principal" "example" {
  client_id = azuread_application.example.client_id
}

resource "azurerm_role_assignment" "example" {
  principal_id   = azuread_service_principal.example.id
  role_definition_name = "Contributor"
  scope          = data.azurerm_subscription.primary.id
}

resource "azuread_application_federated_identity_credential" "github_oidc" {
  application_id = azuread_application.example.id
  display_name          = "oidc-gh-${var.GHORGNAME}-${var.GHREPONAME}-${var.GHBRANCHNAME}"
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = "https://token.actions.githubusercontent.com"
  # this example use branch
  subject               = "repo:${var.GHORGNAME}/${var.GHREPONAME}:ref:refs/heads/${var.GHBRANCHNAME}"
  # use below instead for environment
  #subject               = "repo:${var.GHORGNAME}/${var.GHREPONAME}:environment:prod"
}
