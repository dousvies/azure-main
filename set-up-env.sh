#!/usr/bin/bash

set -e
set -u
set -o pipefail

ARM_ACCESS_KEY=$(az keyvault secret show --name terraformstatestorageaccountkey --vault-name terraformstatethralonso --query value -o tsv)
export ARM_ACCESS_KEY=$ARM_ACCESS_KEY