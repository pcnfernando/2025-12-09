import ballerina/http;
import ballerina/log;

listener http:Listener defaultListener = new (9091);

service / on defaultListener {
    resource function get validation(@http:Header {name: "tracking_id"} string? trackingIdHeader, int intId) returns Validation|http:BadRequest {
        if trackingIdHeader is () {
            return <http:BadRequest>{body: "'tracking_id' header is required"};
        }

        string trackingId = trackingIdHeader;
        log:printInfo(string `${trackingId} - Received request for validation with intId: ${intId}`);

        Validation validation = {fieldName: "firstName", validationType: "exists"};
        return validation;
    }
}

type Validation record {|
    string fieldName;
    string validationType;
|};