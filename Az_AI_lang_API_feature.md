# Option to connect Azure AI API.

Azure propose use two different API URL for the same language services.
 One is

```
<your_AI_service_endpoint>/text/analytics/v3.1/languages?
```

and another is

```
<your_AI_service_endpoint>/language/:analyze-text?api-version=2024-11-01
```

I will ilustrate it with detecting language by raw cURL command (powershall syntaxis). Pay attention - payload json files sintaxis is also different for those 2 cases:
### Variant 1
```
curl.exe -X POST <your_AI_service_endpoint>/text/analytics/v3.1/languages? -H "Content-Type: application/json" -H "Ocp-Apim-Subscription-Key: <your_AI_service_KEY>" -d "@lang_detect_payload1.json"
```

### Variant 2
```
curl.exe -X POST <your_AI_service_endpoint>/language/:analyze-text?api-version=2024-11-01 -H "Content-Type: application/json" -H "Ocp-Apim-Subscription-Key: <your_AI_service_KEY>" -d "@lang_detect_payload2.json"
```

Note. AI_service_endpoint has format:
```
https://<zure AI services sevice or multi-service account name>.cognitiveservices.azure.com/
```

## Example of Authorisation with token
### Step 1. Get token

```
curl.exe -v -X POST \
"https://<YOUR-REGION>.api.cognitive.microsoft.com/sts/v1.0/issueToken" \
-H "Content-type: application/x-www-form-urlencoded" \
-H "Content-length: 0" \
-H "Ocp-Apim-Subscription-Key: <YOUR_SUBSCRIPTION_KEY>"
```
as responce you will receive token, use it:

### Step 2. Use token to access API
```
curl -X POST 'https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&from=en&to=de' \
-H 'Authorization: Bearer <YOUR_AUTH_TOKEN>' \
-H 'Content-Type: application/json' \
--data-raw '[{ "text": "How much for the cup of coffee?" }]' | json_pp
```

## run in Docker container
Azure Cognitive service can be ran in Docker container either in Azure container instance or localy. 
Example of local run for sentiment analytics (other services use other mcr.microsoft containers, see MS Azure documentation):
```
docker run --rm -it -p 5000:5000 --memory 4g --cpus 1 mcr.microsoft.com/azure-cognitive-services/textanalytics/sentiment:latest Eula=accept Billing=<endpoint> ApiKey=<key>
```
Endpoint and Key should be provided for Azure can make billing for you use image with Azure service.

Wher Docker container with Azure AI service run loclay you can call it with localhost:
```
curl -X POST "localhost:5000/text/analytics/v3.1/sentiment" -H "Content-Type: application/json" --data-ascii "{'documents':[{'id':1,'text':'The performance was amazing! The sound could have been clearer.'},{'id':2,'text':'The food and service were unacceptable. While the host was nice, the waiter was rude and food was cold.'}]}"
```
How to ran in Azure container instance see here: https://microsoftlearning.github.io/mslearn-ai-services/Instructions/Exercises/04-use-a-container.html
