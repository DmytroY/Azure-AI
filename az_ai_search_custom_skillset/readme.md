# Azure AI Search with custom skillset

Based on [this](https://microsoftlearning.github.io/mslearn-knowledge-mining/Instructions/Exercises/02-search-skills.html) Microsoft learn manual.


1) Create Azure AI services multi-service account resource, fill SUBSCRIPTION_ID, RESOURCE_GROUP and LOCATION in .env file in parent folder.
1) Login to Azure CLI (az login). Go to the folder where situated setup.cmd (CMD) and setup.sh(shell), run resepectively setup.cmd (CMD) or setup.sh(shell) depending of your kind of terminal. It will creates storage account, upload data to storage, create AI search resource. At the end it will show credentials of of those resourses.
1) Create in **create-search** folder .env file and  add to ir SEARCH_URL and SEARCH_ADMIN_KEY of you newly created search resource
1) review next files:
   * **create-search/data_source.json** - it is definition of data source. In this file add **connectionString** parameter with the connection string for your Azure storage account you received in previous step (also you can find the connection string on the Access keys page of storage account in the Azure portal.)
   * **create-search/skillset.json** - definition for a skillset named margies-custom-skillset. In this file fill your Azure AI servuices KEY.
   * **create-search/index.json** -  definition for an index named margies-custom-index.
   * **create-search/indexer.json** - definition for an indexer named margies-custom-indexer.
 1) Go to the create-search folder and run either create-search.cmd or create-search.sh. This batch script uses CURL to submit the JSON definitions to the REST interface for your Azure AI Search resource. Whet this script completes we will have indext and can search it. You can check it in Azure AI Search resource in Search explorer.
 1) create Azure Function for a custom skill in accordance with respective paragraoh of [this](https://microsoftlearning.github.io/mslearn-knowledge-mining/Instructions/Exercises/02-search-skills.html) manual.
 1) 
 