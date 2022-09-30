#!/bin/bash
echo "Defining variables..."
export RESOURCE_GROUP_NAME=tailspin-space-game-rg
export  AKS_NAME=tailspinspacegame-24592
export  ACR_NAME=tailspinspacegame24592.azurecr.io
echo "Obtaining credentials..."
az aks get-credentials -n $AKS_NAME -g $RESOURCE_GROUP_NAME

export DNS_NAME=$(az network dns zone list -o json --query "[?contains(resourceGroup,'$RESOURCE_GROUP_NAME')].name" -o tsv)
sed -i  's+!IMAGE!+'"$ACR_NAME"'/contoso-website+g' kubernetes/deployment.yaml
sed -i  's+!DNS!+'"$DNS_NAME"'+g' kubernetes/ingress.yaml
echo "Installation concluded, copy these values and store them, you'll use them later in this exercise:"
echo "-> Resource Group Name: $RESOURCE_GROUP_NAME"
echo "-> ACR Name: $ACR_NAME"
echo "-> AKS Cluster Name: $AKS_NAME"
echo "-> AKS DNS Zone Name: $DNS_NAME"

