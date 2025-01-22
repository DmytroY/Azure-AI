#!/bin/bash
# This script submit the JSON definitions to the REST interface for our Azure AI Search resource

echo Load environment variables from .env file, namely namely here we need SEARCH_URL and SEARCH_ADMIN_KEY
# Read the .env file line by line
while IFS='=' read -r key value; do
    # Export the key-value pair as an environment variable
    export "$key=$value"
done < .env

echo SEARCH_URL: $SEARCH_URL
echo SEARCH_ADMIN_KEY: $SEARCH_ADMIN_KEY

echo -----
echo Creating the skillset...
curl -X POST "$SEARCH_URL/datasources?api-version=2020-06-30" -H "Content-Type: application/json" -H "api-key: $SEARCH_ADMIN_KEY" -d @data_source.json

echo -----
echo Creating the index...
curl -X POST "$SEARCH_URL/indexes/margies-custom-index?api-version=2020-06-30" -H "Content-Type: application/json" -H "api-key: $SEARCH_ADMIN_KEY" -d @index.json

sleep 3

echo -----
echo Creating the indexer...
curl -X PUT "$SEARCH_URL/indexers/margies-custom-indexer?api-version=2020-06-30" -H "Content-Type: application/json" -H "api-key: $SEARCH_ADMIN_KEY" -d @indexer.json
