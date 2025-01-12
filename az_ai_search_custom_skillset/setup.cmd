REM This script creates a storage account, uploads files to it, and creates a search service
@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

rem Load environment variables from .env file, namely SUBSCRIPTION_ID, RESOURCE_GROUP, and LOCATION
for /f "tokens=1,2 delims==" %%a in ('type ..\.env') do set %%a=%%b

rem Get random numbers to create unique resource names
set unique_id=!random!!random!

echo Creating storage...
call az storage account create --name ai102str!unique_id! --subscription !SUBSCRIPTION_ID! --resource-group !RESOURCE_GROUP! --LOCATION !LOCATION! --sku Standard_LRS --encryption-services blob --default-action Allow --allow-blob-public-access true --only-show-errors --output none

echo Uploading files...
rem get storage key
for /f "tokens=*" %%a in ( 
'az storage account keys list --subscription !SUBSCRIPTION_ID! --resource-group !RESOURCE_GROUP! --account-name ai102str!unique_id! --query "[?keyName=='key1'].{keyName:keyName, permissions:permissions, value:value}"' 
) do ( 
set key_json=!key_json!%%a 
) 
set key_string=!key_json:[ { "keyName": "key1", "permissions": "Full", "value": "=!
set AZURE_STORAGE_KEY=!key_string:" } ]=!
call az storage container create --account-name ai102str!unique_id! --name margies --public-access blob --auth-mode key --account-key %AZURE_STORAGE_KEY% --output none
call az storage blob upload-batch -d margies -s data --account-name ai102str!unique_id! --auth-mode key --account-key %AZURE_STORAGE_KEY%  --output none

echo Creating search service...
echo (If this gets stuck at '- Running ..' for more than a couple minutes, press CTRL+C then select N)
call az search service create --name ai102srch!unique_id! --subscription !SUBSCRIPTION_ID! --resource-group !RESOURCE_GROUP! --LOCATION !LOCATION! --sku basic --output none

echo -------------------------------------
echo Storage account: ai102str!unique_id!
call az storage account show-connection-string --subscription !SUBSCRIPTION_ID! --resource-group !RESOURCE_GROUP! --name ai102str!unique_id!
echo ----
echo Search Service: ai102srch
echo  Url: https://ai102srch!unique_id!.search.windows.net
echo  Admin Keys:
call az search admin-key show --subscription !SUBSCRIPTION_ID! --resource-group !RESOURCE_GROUP! --service-name ai102srch!unique_id!
echo  Query Keys:
call az search query-key list --subscription !SUBSCRIPTION_ID! --resource-group !RESOURCE_GROUP! --service-name ai102srch!unique_id!
