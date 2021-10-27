#!/bin/bash
# safer bash scripts - makes it similar to high level programming languages scripts
# see https://explainshell.com/explain?cmd=set+-euxo+pipefail
set -x          # print each command before executing it
set -e          # exit immediately when a command fails
set -u          # unset variables throw an error and exit immediately
set -o pipefail # exit code of a pipeline is set to that of the rightmost command to exit with a non-zero status

chown -R ubuntu:ubuntu /home/ubuntu/
az login --service-principal -u "${client_id}" -p "${client_secret}" --tenant "${tenant_id}"
PERSONAL_ACCESS_TOKEN=$(az keyvault secret show --name cicdpersonalaccesstoken --vault-name cicdthralonso --query value -o tsv)
ID=$(gpw 1 8)
cd /home/ubuntu/agent-config/
sudo -H -u ubuntu bash -c './config.sh --unattended --url https://dev.azure.com/thralonso --auth pat --token $0 --pool selfhostedlinux --agent ubuntu1804$1' $PERSONAL_ACCESS_TOKEN $ID
./svc.sh install
systemctl start "vsts.agent.thralonso.selfhostedlinux.ubuntu1804$ID.service"