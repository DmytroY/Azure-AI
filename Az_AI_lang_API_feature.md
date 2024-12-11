# About Azure AI API URL

I do not know why, but Azure use two different API URL for language services. One is

`<your_AI_service_endpoint>/text/analytics/v3.1/languages?`

and another is

`<your_AI_service_endpoint>/language/:analyze-text?api-version=2024-11-01`

I will ilustrate it with detecting language by raw cURL command (powershall syntaxis). Pay attention - payload json files sintaxis is also different for those 2 cases:
### Variant 1
`curl.exe -X POST <your_AI_service_endpoint>/text/analytics/v3.1/languages? -H "Content-Type: application/json" -H "Ocp-Apim-Subscription-Key: <your_AI_service_KEY>" -d "@lang_detect_payload1.json"`

### Variant 2
`curl.exe -X POST <your_AI_service_endpoint>/language/:analyze-text?api-version=2024-11-01 -H "Content-Type: application/json" -H "Ocp-Apim-Subscription-Key: <your_AI_service_KEY>" -d "@lang_detect_payload2.json"`
