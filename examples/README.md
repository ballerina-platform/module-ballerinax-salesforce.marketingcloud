# Examples

The `ballerinax/salesforce.marketingcloud` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/tree/main/examples) to understand how to capture and process database change events effectively.

1. [Seasonal Journey](https://github.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/tree/main/examples/seasonal-journey) – Shows how to enroll new users into the Seasonal Journey by adding a row to a Data Extension, with checks to prevent enrolling users who are already part of the Rewin Journey.
2. [Sync Images](https://github.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/tree/main/examples/sync-images) - demonstrates how to synchronize images from Digital Asset Management (DAM) systems to Salesforce Marketing Cloud Content Builder using the Ballerina client. It retrieves images from external URLs, encodes them in base64, and uploads them to a specified category (folder) in Content Builder.

## Prerequisites

1. Follow instructions to set up OAuth2 app in Salesforce Marketing Cloud.

2. For each example, create a config.toml file with your OAuth2 tokens, client ID, and client secret. Here's an example of how your config.toml file should look:
```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
subDomain = "<sub-domain>"
```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
