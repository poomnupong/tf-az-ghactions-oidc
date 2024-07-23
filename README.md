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

### Step 2: Edit parameter file



## References

- [Microsoft Learn - Use Github Actions to connect to Azure](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux#use-the-azure-login-action-with-openid-connect)

- A great article from Jon Gallant  has a very good summary of how OpenID Connect works in this scenario.
[Connect to Azure from a GitHub Action with OpenID Connect (OIDC)](https://github.com/poomnupong/tf-az-ghactions-oidc)
