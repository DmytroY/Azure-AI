# Azure AI Search with custom skillset

Based on [this](https://microsoftlearning.github.io/mslearn-knowledge-mining/Instructions/Exercises/02-search-skills.html) Microsoft learn manual.


1) Create Azure AI services multi-service account resource, fill SUBSCRIPTION_ID, RESOURCE_GROUP and LOCATION in  .env file in parent folder.
2) Login to Azure CLI (az login) and Run setup.cmd (CMD) or setup.sh(shell) . It will creates storage account, upload data to it, create AI search resource. At the end it will show credentials of of those resourses.
3) Note *create-search\data_source.json* file, it is definition of data source. In this file add *connectionString* parameter with the connection string for your Azure storage account you received in previous step (also you can find the connection string on the Access keys page of storage account in the Azure portal.)