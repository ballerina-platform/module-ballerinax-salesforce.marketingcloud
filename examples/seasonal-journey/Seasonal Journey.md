# Enrol users to Seasonal Journey 

This example shows how to enroll new users into the Seasonal Journey by adding a row to a Data Extension, with checks to prevent enrolling users who are already part of the Rewin Journey.

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
curl -X POST "http://localhost:9090/marketing/journey/seasonal" \
  -H "Content-Type: application/json" \
  -d '{
        "userId": "harry@hogwarts.com",
        "email": "harry@hogwarts.com",
        "firstName": "Harry",
        "signupSource": "web"
    }'
```
