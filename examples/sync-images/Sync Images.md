# Sync Images from DAM Systems to Salesforce Marketing Cloud Content Builder

This example demonstrates how to synchronize images from Digital Asset Management (DAM) systems to Salesforce Marketing Cloud Content Builder using the Ballerina client. It retrieves images from external URLs, encodes them in base64, and uploads them to a specified category (folder) in Content Builder.

## Prerequisites

1. Follow instructions to set up OAuth2 app in Salesforce Marketing Cloud.

2. For each example, create a `config.toml` file with your OAuth2 tokens, client ID, and client secret. Here's an example of how your `config.toml` file should look:
```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
subDomain = "<sub-domain>"
accountId = "<account-id>"
```

## Run the Example

1. Execute the following command to run the example:

```bash
bal run
```

2. Send the following CURL command:

```bash
curl --location 'http://localhost:9090/upload/image' \
--header 'Content-Type: application/json' \
--data '{
    "fileName": "shoes.jpg",
    "fileUrl": "<image-link>",
    "category": "My New Folder"
}'
```
