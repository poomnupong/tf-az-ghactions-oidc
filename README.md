# Terraform code to set up OpenID Connect between Entra ID and Github Actions

This code will setup necessary components on Entra ID for OpenID Connect, ready for resource deployment with Github Actions.

This streamline the provisioning of OpenID Connect trusted connectivity between Entra ID and Github Actions, which is more secure than using secret in your code/repository.

## The important bits: requirements, scopes, design principles & assumptions

- Need the obvious: Entra ID tenant and an Azure subscription
- Runtime environment with Azure CLI already authenticated with target Entra ID tenant (TODO: does cloudshell work?)
- Store state locally for this version

## Usage

### Step 1: Pre-requisites & gather parameters

Make sure the environment is already authenticated with correct tenant with access to the right subscriptions
``` bash
az account list -otable
```
Then grab the parameters for next steps:
| Name         | Detail          |
|--------------|-----------------|
| Tenant ID    | Entra ID tenant ID |
| Subscription ID | Azure subscription ID |
| App Name     | name of the app registration. This should be unique in the Entra ID |
| Github org name | Github organization name |
| Github repo name | Github repository name |
| Github branch name | name of the branch used to run this federated workflow |

### Step 2: Edit parameter file

Copy terraform.tfvars.example into terraform.tfvars and fill in the parameters.
For example:
```
TENANTID       = "123e4567-e89b-12d3-a456-426614174000"
SUBSCRIPTIONID = "987fbc97-4bed-5078-af07-9141ba07c9f3"
APPNAME        = "githubactions-oidc1-app"
GHORGNAME      = "poomnupong"
GHREPONAME     = "testrepo1"
GHBRANCHNAME   = "main"
```

Then deploy it.  

### Next:

From this point you can create the matching Github repo with workflows in the matching branch name, specifying only tenant ID and subscription ID in the code which will authenticate thorugh this service principal.

## References

- [Microsoft Learn - Use Github Actions to connect to Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux#use-the-azure-login-action-with-openid-connect)

- A great article from Jon Gallant  has a very good summary of how OpenID Connect works in this scenario.
[Connect to Azure from a GitHub Action with OpenID Connect (OIDC)](https://github.com/poomnupong/tf-az-ghactions-oidc)
