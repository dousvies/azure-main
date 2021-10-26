#!/bin/bash
# safer bash scripts - makes it similar to high level programming languages scripts
# see https://explainshell.com/explain?cmd=set+-euxo+pipefail
set -x          # print each command before executing it
set -e          # exit immediately when a command fails
set -u          # unset variables throw an error and exit immediately
set -o pipefail # exit code of a pipeline is set to that of the rightmost command to exit with a non-zero status

ACCOUNT_KEY=$(az storage account keys list --resource-group "terraform_state" --account-name "terraformstatethralonso" --query '[0].value' -o tsv)
echo "account key: $ACCOUNT_KEY"
az keyvault secret set --vault-name "terraformstatethralonso" --name "terraformstatestorageaccountkey" --value "$ACCOUNT_KEY"
# PERSONAL_ACCESS_TOKEN: value was set mannually while executing this script
az keyvault secret set --vault-name "cicdthralonso" --name "cicdpersonalaccesstoken" --value "$PERSONAL_ACCESS_TOKEN"