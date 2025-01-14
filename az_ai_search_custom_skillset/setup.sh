#!/bin/bash
# This script creates a storage account, uploads files to it, and creates a search service

echo Load environment variables from .env file, namely SUBSCRIPTION_ID, RESOURCE_GROUP, and LOCATION
# Read the .env file line by line
while IFS='=' read -r key value; do
    # Export the key-value pair as an environment variable
    export "$key=$value"
done < ../.env

echo SUBSCRIPTION_ID: $SUBSCRIPTION_ID
echo RESOURCE_GROUP: $RESOURCE_GROUP
echo LOCATION: $LOCATION

# Get random numbers and create unique resource names
unique_id="${RANDOM}${RANDOM}"
account_name="ai102str${unique_id}"
search_name="ai102srch${unique_id}"

echo Creating storage...
az storage account create --name $account_name \
  --subscription $SUBSCRIPTION_ID \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS \
  --encryption-services blob \
  --default-action Allow \
  --allow-blob-public-access true \
  --only-show-errors --output none

# Fetch the storage account key JSON, extract the key value and load it to environment variable
key_json=$(az storage account keys list --account-name $account_name --query [0].value)
key_string=$(echo "$key_json" | tr -d '"')
export AZURE_STORAGE_KEY="$key_string"

echo In the storage account create container and upload blob
az storage container create --account-name $account_name --name margies --public-access blob --auth-mode key --account-key $AZURE_STORAGE_KEY --output none
az storage blob upload-batch -d margies -s data --account-name $account_name --auth-mode key --account-key $AZURE_STORAGE_KEY  --output none

echo Creating search service...
echo "(If this gets stuck at '- Running ..' for more than a couple minutes, press CTRL+C then select N)"
az search service create --name $search_name --subscription $SUBSCRIPTION_ID --resource-group $RESOURCE_GROUP --location $LOCATION --sku basic --output none

echo -------------------------------------
echo Storage account: $account_name
az storage account show-connection-string --subscription $SUBSCRIPTION_ID --resource-group $RESOURCE_GROUP --name $account_name
echo ----
echo Search Service: $search_name
echo  Url: https://{$search_name}.search.windows.net
echo  Admin Keys:
az search admin-key show --subscription $SUBSCRIPTION_ID --resource-group $RESOURCE_GROUP --service-name $search_name
echo  Query Keys:
az search query-key list --subscription $SUBSCRIPTION_ID --resource-group $RESOURCE_GROUP --service-name $search_name
