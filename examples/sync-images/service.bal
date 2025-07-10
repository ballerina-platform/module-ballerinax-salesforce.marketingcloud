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
import ballerina/mime;
import ballerinax/salesforce.marketingcloud as mc;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string subDomain = ?;
configurable string accountId = ?;

type Image record {|
    string fileUrl;
    string fileName;
    string category;
|};

final map<record {string name; int id;}> assetType = {
    "jpe": {name: "jpe", id: 21},
    "jpeg": {name: "jpeg", id: 22},
    "jpg": {name: "jpg", id: 23},
    "png": {name: "png", id: 28}
};

service /upload on new http:Listener(9090) {
    mc:Client marketingCloud;

    function init() returns error? {
        self.marketingCloud = check new (
            subDomain,
            config = {
                auth: {
                    clientId,
                    clientSecret,
                    accountId
                }
            }
        );
    }

    resource function post image(Image image) returns error? {
        int? extensionIndex = image.fileName.lastIndexOf(".");
        if extensionIndex is () {
            return error("File name must have an extension");
        }
        string fileExtension = image.fileName.substring(extensionIndex + 1);
        string fileBytes = check downloadAndEncodeFile(image.fileUrl);
        string folderName = image.category;

        // Retrieve category IDs from Marketing Cloud
        mc:CategoryList categories = check self.marketingCloud->getCategories();
        int[] categoryIds = categories.items
            .filter(c => c.name == folderName)
            .map(c => c.id);

        if categoryIds.length() == 0 {
            return error(string `Category '${folderName}' not found in Marketing Cloud`);
        }

        mc:Asset asset = check self.marketingCloud->createAsset({
            name: image.fileName,
            category: {"id": categoryIds[0]},
            assetType: assetType[fileExtension.toLowerAscii()] ?: {"name": "unknown", "id": 0},
            "file": image.fileName,
            "fileData": fileBytes
        });
        log:printInfo(string `Image '${image.fileName}' uploaded successfully to category '${image.category}' with ID ${asset.id}.`);
    }
}

function downloadAndEncodeFile(string fileUrl) returns string|error {
    http:Client fileDownload = check new (fileUrl);
    http:Response res = check fileDownload->get("");
    byte[] fileBytes = check res.getBinaryPayload();
    byte[] base64Encoded = <byte[]>(check mime:base64Encode(fileBytes));
    string encodedFile = check string:fromBytes(base64Encoded);
    return encodedFile;
}
