#!/bin/bash
# safer bash scripts - makes it similar to high level programming languages scripts
# see https://explainshell.com/explain?cmd=set+-euxo+pipefail
set -x          # print each command before executing it
set -e          # exit immediately when a command fails
set -u          # unset variables throw an error and exit immediately
set -o pipefail # exit code of a pipeline is set to that of the rightmost command to exit with a non-zero status

ARM_ACCESS_KEY=$(az keyvault secret show --name terraformstatestorageaccountkey --vault-name terraformstatethralonso --query value -o tsv)
export ARM_ACCESS_KEY=$ARM_ACCESS_KEY