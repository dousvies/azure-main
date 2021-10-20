#!/usr/bin/env bash

set -e
set -u
set -o pipefail

ACCOUNT_KEY=$(az storage account keys list --resource-group "terraform_state" --account-name "terraformstatethralonso" --query '[0].value' -o tsv)
echo "account key: $ACCOUNT_KEY"
az keyvault secret set --vault-name "terraformstatethralonso" --name "terraformstatestorageaccountkey" --value "$ACCOUNT_KEY"