#!/bin/bash
# This script update the JSON definitions to the REST interface for our Azure AI Search resource

echo Load environment variables from .env file, namely namely here we need SEARCH_URL and SEARCH_ADMIN_KEY
# Read the .env file line by line
while IFS='=' read -r key value; do
    # Export the key-value pair as an environment variable
    export "$key=$value"
done < ../create-search/.env

# Check
echo SEARCH_URL: $SEARCH_URL
echo SEARCH_ADMIN_KEY: $SEARCH_ADMIN_KEY

echo -----
echo Updating the skillset...
curl -X PUT "$SEARCH_URL/skillsets/margies-custom-skillset?api-version=2020-06-30" -H "Content-Type: application/json" -H "api-key: $SEARCH_ADMIN_KEY" -d @update-skillset.json

echo -----
echo Updating the index...
curl -X PUT "$SEARCH_URL/indexes/margies-custom-index?api-version=2020-06-30" -H "Content-Type: application/json" -H "api-key: $SEARCH_ADMIN_KEY" -d @update-index.json

sleep 3


echo -----
echo Updating the indexer...
curl -X PUT "$SEARCH_URL/indexers/margies-custom-indexer?api-version=2020-06-30" -H "Content-Type: application/json" -H "api-key: $SEARCH_ADMIN_KEY" -d @update-indexer.json

echo -----
echo Resetting the indexer
call curl -X POST "$SEARCH_URL/indexers/margies-custom-indexer/reset?api-version=2020-06-30" -H "Content-Type: application/json" -H "Content-Length: 0" -H "api-key: $SEARCH_ADMIN_KEY" 

sleep 5

echo -----
echo Rerunning the indexer
call curl -X POST "$SEARCH_URL/indexers/margies-custom-indexer/run?api-version=2020-06-30" -H "Content-Type: application/json" -H "Content-Length: 0" -H "api-key: $SEARCH_ADMIN_KEY" 

