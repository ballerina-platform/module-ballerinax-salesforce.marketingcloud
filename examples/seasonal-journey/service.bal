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

import ballerina/http;
import ballerina/log;
import ballerinax/salesforce.marketingcloud as mc;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string subDomain = ?;
configurable string accountId = ?;

type User record {
    string userId;
    string email;
    string firstName;
    string signupSource;
};

mc:Client marketingCloudClient = check new (
    subDomain,
    config = {
        auth: {
            clientId,
            clientSecret,
            accountId
        }
    }
);

const string REWIN_JOURNEY_DEFINITION_KEY = "aa0c871b-d1eb-66fb-c039-0a7cab4e20cd";
const string DE_DEFINITION_KEY = "DecSeasonal25";

service /marketing/journey on new http:Listener(9090) {

    resource function post seasonal(User newUser) returns http:Ok|error {
        mc:ContactMembershipResponse res = check marketingCloudClient->getContactMembership({
            contactKeyList: [newUser.email]
        });

        mc:ContactMembershipDetail[] membership = res.results?.contactMemberships ?: [];
        foreach mc:ContactMembershipDetail item in membership {
            if item.definitionKey == REWIN_JOURNEY_DEFINITION_KEY {
                log:printInfo(string `User ${newUser.userId} is part of the Rewin Journey. Skipping Seasonal Journey enrollment.`);
                return http:OK;
            }
        }

        _ = check marketingCloudClient->upsertDERowSetByKey(DE_DEFINITION_KEY, [
            {
                keys: {
                    "id": newUser.userId
                },
                values: {
                    "SubscriberKey": newUser.email,
                    "EmailAddress": newUser.email
                }
            }
        ]);

        log:printInfo(string `User ${newUser.userId} enrolled in Seasonal Journey successfully.`);
        return http:OK;
    }
}
