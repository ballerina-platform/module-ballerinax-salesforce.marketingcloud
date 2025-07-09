// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string subDomain = ?;

Client mcClient = check new (
    subDomain,
    config = {
        auth: {
            clientId,
            clientSecret
        }
    }
);

@test:Config {
    enable: false
}
public function testGetJourneys() returns error? {
    JourneysList response = check mcClient->getJourneys();
    test:assertNotEquals(response.items, [], msg = "Expected non-empty journeys list, but got empty list");
}

@test:Config {
}
public function searchContactsByAttribute() returns error? {
    ContactAttributeFilterCondition filterCondition = {
        filterConditionOperator: "Is",
        filterConditionValue: "LastModifiedDate=2024-01-01T00:00:00Z AND LastModifiedDate=2024-12-31T23:59:59Z"
    };
    SearchContactsByAttributeResponse response = check mcClient->searchContactsByAttribute("LastModifiedDate", payload = filterCondition);
    test:assertNotEquals(response.addresses, [], msg = "Expected non-empty contacts list, but got empty list");
}

@test:Config {
}
public function searchContactsByEmail() returns error? {
    SearchContactsByEmailResponse response = check mcClient->searchContactsByEmail({
        channelAddressList: ["niveathika@gmail.com"]
    });
    test:assertNotEquals(response.channelAddressResponseEntities, [], msg = "Expected non-empty contacts list, but got empty list");
}

@test:Config {
}
public function createContact() returns error? {
    UpsertContactResponse upsertContactResponse = check mcClient->createContact({
        contactKey: "test-contact",
        attributeSets: [
            {
                name: "Email Addresses",
                items: [
                    {
                        values: [
                            {
                                name: "Email Address",
                                value: "test@wso2.com"
                            },
                            {
                                name: "HTML Enabled",
                                value: true
                            }
                        ]
                    }
                ]
            }
        ]
    });
    test:assertNotEquals(upsertContactResponse.contactKey, "", msg = "Expected non-empty contact key, but got empty string");
}

@test:Config {
    dependsOn: [createContact]
}
public function updateContact() returns error? {
    UpsertContactResponse upsertContactResponse = check mcClient->updateContact({
        contactKey: "test-contact",
        attributeSets: [
            {
                name: "Email Addresses",
                items: [
                    {
                        values: [
                            {
                                name: "Email Address",
                                value: "123@gmail.com"
                            }
                        ]
                    }
                ]
            }
        ]
    });
    test:assertEquals(upsertContactResponse.isNewContactKey, false, msg = "Expected isNewContactKey to be false, but got true");
}

@test:Config {
}
public function getCampaigns() returns error? {
    CampaignList response = check mcClient->getCampaigns();
    test:assertNotEquals(response.items, [], msg = "Expected non-empty campaigns list, but got empty list");
}
