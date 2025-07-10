# Ballerina Salesforce Marketing Cloud library

[![Build](https://github.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-salesforce.marketingcloud.svg)](https://github.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/salesforce.marketingcloud.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%salesforce.marketingcloud)

## Overview

[Salesforce Marketing Cloud](https://www.salesforce.com/products/marketing-cloud/overview/) is a leading digital marketing platform that enables businesses to manage and automate customer journeys, email campaigns, and personalized messaging.

The `ballerinax/salesforce.marketingcloud` package provides APIs to connect and interact with [Salesforce Marketing Cloud API](https://developer.salesforce.com/docs/atlas.en-us.mc-apis.meta/mc-apis/) endpoints, supporting a wide range of marketing automation and journey management

## Setup guide

This guide explains how to generate an access token in Salesforce Marketing Cloud using an Installed Package. 

### Step 1: Log in to Marketing Cloud

1. Navigate to your [Salesforce Marketing Cloud login page](https://mc.exacttarget.com/cloud/login.html) and log in with your credentials.

    ![SFMC login](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/main/docs/setup/resources/1-sfmc-login.png)

2. Once logged in, click on your username in the top right corner and select Setup from the dropdown menu.

    ![SFMC setup](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/main/docs/setup/resources/2-sfmc-setup.png)

### Step 2: Create an installed package

1. In the **Setup** menu, scroll down to the **Platform Tools** section.
2. Click on **Apps** and then select **Installed Packages**.

    ![SFMC installed packages](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/main/docs/setup/resources/3-installed-packages.png)

3. Click the **New** button.
4. Enter a **Name** and **Description** for your package (for example, `API Integration Package`).
5. Click **Save**.

    ![SFMC installed package component](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/main/docs/setup/resources/4-sfmc-new-component.png)

### Step 3: Add an API integration component

1. After saving, click on the package you just created to view its details.

    ![SFMC installed package component details](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/main/docs/setup/resources/5-sfmc-component-details.png)

2. Click on **Add Component**.
3. Choose **API Integration** as the component type.

    ![SFMC installed package component type](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/main/docs/setup/resources/6-sfmc-component-type.png)

4. Select Server-to-Server as the integration type.

    ![SFMC installed package integration type](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/main/docs/setup/resources/7-sfmc-integration-type.png)

5. In the list of available scopes, check the required permissions for your integration. For most token generation and API calls, you might need:
   * Read and Write access to Email Studio
   * Access to the REST API
   * Any additional scopes based on your specific use case

    ![SFMC component scopes](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/main/docs/setup/resources/8-sfmc-scope.png)

6. Click **Save** to add the component.

### Step 4: Retrieve the Client ID and Client Secret

On the package detail page, note down the Base URIs, Client ID and Client Secret generated for your integration. These credentials are required to authenticate API calls.
If necessary, click on Edit to update any integration details or to add further scopes.

![SFMC client secret](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/main/docs/setup/resources/9-sfmc-secret.png)

![SFMC client id](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/main/docs/setup/resources/10-sfmc-client.png)

### Step 5: Retrieve your user subdomain 

Extract the subdomain by taking the portion between `https://` and `.auth.marketingcloudapis.com` in your base URI. For example, from `https://mc123456gkz1x4p5b9m4gzx5b9.auth.marketingcloudapis.com/`, the subdomain is `mc123456gkz1x4p5b9m4gzx5b9`.

### Step 6: Retrieve your account id if necessary

Navigate to the top right corner of your SFMC account interface, hover over your account name, and the MID will be displayed.
>> **Note:** This is only needed if the cloud account has more than one business units.

![Account id](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/main/docs/setup/resources/11-account-id.png)

## Quickstart

To use the `salesforce.marketingcloud` connector in your Ballerina application, modify the `.bal` file as follows:

### Step 1: Import the module

Import the `salesforce.marketingcloud` module.

```ballerina
import ballerinax/salesforce.marketingcloud;
```

### Step 2: Instantiate a new connector

Create a `marketingcloud:ConnectionConfig` with the obtained OAuth2.0 tokens and initialize the connector with it.

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string subDomain = ?;
configurable string accountId = ?;

marketingcloud:Client marketingCloudClient = check new (
    subDomain,
    config = {
        auth: {
            clientId,
            clientSecret,
            accountId
        }
    }
);
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### See all the journeys contact is enrolled in

```ballerina
marketingcloud:ContactMembershipResponse res = 
        check marketingCloudClient->getContactMembership({
            contactKeyList: ["test@example.com"]
        });
```

## Examples

The `ballerinax/salesforce.marketingcloud` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/tree/main/examples) to understand how to capture and process database change events effectively.

1. [Seasonal Journey](https://github.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/tree/main/examples/seasonal-journey) – Shows how to enroll new users into the Seasonal Journey by adding a row to a Data Extension, with checks to prevent enrolling users who are already part of the Rewin Journey.
2. [Sync Images](https://github.com/ballerina-platform/module-ballerinax-salesforce.marketingcloud/tree/main/examples/sync-images) - demonstrates how to synchronize images from Digital Asset Management (DAM) systems to Salesforce Marketing Cloud Content Builder using the Ballerina client. It retrieves images from external URLs, encodes them in base64, and uploads them to a specified category (folder) in Content Builder.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`salesforce.marketingcloud` package](https://central.ballerina.io/ballerinax/salesforce.marketingcloud/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
