# Azure AI Services

This repository contains a collection of hands-on examples for Azure AI services, covering search, language, vision, speech, and content safety scenarios. The samples are designed to help explore Azure AI capabilities with notebooks, small Python scripts, and simple app examples.

## Overview

The project demonstrates how to:

- Use Azure AI Search to index and query content
- Extend search with custom skillsets and enrichment pipelines
- Work with Azure AI Language services for text analysis, translation, and custom models
- Use Azure AI Vision for OCR, face detection, image analysis, and custom vision
- Integrate Azure Speech for transcription, translation, and text-to-speech
- Apply Azure Content Safety and Responsible AI checks
- Access Azure services securely using environment variables or Azure Key Vault

## Repository structure

- `az_AI_search/` - Flask web app for a simple document-search experience using Azure AI Search
- `az_ai_search_custom_skillset/` - Example for extending Azure AI Search with custom skillsets and enrichment workflows
- `data/` - Supporting sample data for the search and AI demos
- `Az_AI_lang_API_feature.md` - Notes and examples about Azure AI Language API endpoint variants and authentication
- `az_ai_search.ipynb` - Basic Azure AI Search notebook example
- `az_ML_CLU.ipynb` - Conversational Language Understanding example
- `az_ML_train_connect.ipynb` - Notebook showing model training connection patterns
- `az_OCR.ipynb` - OCR example using Azure AI Vision
- `az_QnA.ipynb` - Azure QnA Maker / custom question-answering example
- `az_content_safety_text.ipynb` - Content safety classification demo for hate, self-harm, sexual, and violence content
- `az_content_safety_jailbrake.py` - Example related to content filtering and jailbreak detection patterns
- `az_custom_entiti_recogn.ipynb` - Custom entity recognition example
- `az_custom_vision.ipynb` - Custom Vision training and prediction example
- `az_detect_faces.ipynb` - Face detection sample with attributes like pose, blur, and mask type
- `az_detect_people.ipynb` - People detection using Azure Vision features
- `az_image_analysis.ipynb` - Image analysis sample
- `az_image_detection1.ipynb`, `az_image_detection2.ipynb` - Image detection examples
- `az_inteligence.ipynb` - Information extraction demo
- `az_key_vault_usage.py` - Example of retrieving Azure service credentials from Azure Key Vault
- `az_speech_recogn.ipynb` - Speech recognition example
- `az_speech_translator.py` - Speech translation sample
- `az_speech_tts_stt.py` - Speech-to-text and text-to-speech example
- `az_text_analysis.ipynb` - Text analysis sample
- `az_text_clasification.ipynb` - Text classification example
- `az_translator.ipynb` - Azure Translator sample
- `az_video_indexer_API.ipynb` - Azure Video Indexer API example

## Prerequisites

Before running the samples, make sure you have:

- An Azure subscription
- One or more Azure AI resource(s) deployed in Azure
- Access to the resource endpoint and API key (or a managed identity / Azure AD setup)
- Python 3.x installed
- Jupyter Notebook or VS Code with notebook support
- Azure CLI installed for some provisioning and authentication tasks

## Configuration

Many examples expect configuration values to be stored in a local `.env` file or exported as environment variables.

Example `.env` format:

```env
AZURE_AI_ENDPOINT=https://<your-resource-name>.cognitiveservices.azure.com/
AZURE_AI_KEY=<your-api-key>
```

You can load these values in Python with libraries like `python-dotenv`.

For Azure AI Search and language examples, you may also need values such as:

- search service endpoint
- search admin/query key
- index name
- API version values

## Quick start

1. Clone the repository:

```bash
git clone https://github.com/DmytroY/Azure-AI.git
cd Azure-AI
```

2. Create and activate a virtual environment (optional but recommended):

```bash
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
```

3. Install dependencies for the Python examples:

```bash
pip install -r requirements.txt
```

Some folders may have their own dependency files; check individual sample folders before running them.

4. Open the notebooks in Jupyter or VS Code and fill in the required endpoint and key values.

## Notes

- Some notebooks are intentionally educational and may require manual updates of endpoint URLs, keys, and model names.
- Credentials and secrets should never be committed to source control.
- Use a `.env` file or Azure Key Vault to store service values securely.
- For Azure AI Language endpoint differences, see `Az_AI_lang_API_feature.md`.

## License

This repository is provided for learning and experimentation. Review and respect the Azure service terms and any licensing requirements for the examples and sample data used.
