@isTest
global class AccountOpportunityCallOutMock  implements HttpCalloutMock{
    
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        AccountOpportunityCallOut.RecordData recordDataInstance = (AccountOpportunityCallOut.RecordData)JSON.deserialize(req.getBody(), AccountOpportunityCallOut.RecordData.class);
        System.debug('recordDataInstance'+recordDataInstance);
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('https://www.google.com/', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        if(recordDataInstance.accountD.Name == 'FieldUpdate'){
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"example":"test"}');
            res.setStatusCode(200);
        }
        else if(recordDataInstance.accountD.Name == 'FieldUpdate1'){
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"example":"test1"}');
            res.setStatusCode(401);
        }
        else {
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"example":"test2"}');
            res.setStatusCode(402);
        }
        return res;
    }
}