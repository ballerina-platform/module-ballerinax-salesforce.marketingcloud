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

isolated function getUpdatedAuthConfig(OAuth2ClientCredentialsGrantConfig auth, string subDomain) returns http:OAuth2ClientCredentialsGrantConfig {
    string tokenUrl = string `https://${subDomain}.auth.marketingcloudapis.com/v2/token`;
    http:OAuth2ClientCredentialsGrantConfig updatedAuth = {
        tokenUrl: tokenUrl,
        clientId: auth.clientId,
        clientSecret: auth.clientSecret,
        scopes: auth.scopes,
        defaultTokenExpTime: auth.defaultTokenExpTime,
        clockSkew: auth.clockSkew,
        credentialBearer: auth.credentialBearer,
        clientConfig: auth.clientConfig
    };

    string? accountId = auth.accountId;
    map<string>? optionalParams = auth.optionalParams;
    if accountId is string {
        if optionalParams is map<string> {
            optionalParams["account_id"] = accountId;
            updatedAuth.optionalParams = optionalParams;
        } else {
            updatedAuth.optionalParams = {"account_id": accountId};
        }
    }

    return updatedAuth;
}
