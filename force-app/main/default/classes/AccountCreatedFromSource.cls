public class AccountCreatedFromSource {
     public class deserializeResponse{

       // public String id;

        public String access_token;
         
        public String instance_url;

    }
   
    @future(callout=true)

    public static void createAccountinTargetOrg(String accName, String accId){ 
	 
        String clientId = '3MVG9n_HvETGhr3B71t.6BLh0N0ZKfBTeQvaEiuGQMfS3dg9GkFieEq2KoJFKx_RGNeu3M8BC455GMsx64qIS';//your consumer Key

        String clientSecret = '9B34451C4811BBB82F08C07F7A0445F416CC2F34F993C8531756F63F0FAA824B';//your consumer secret

        String username = 'vicky.kaushal@letsdoit.com';

        String password = 'Qwerty@123';

        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;

        Http h = new Http();

        HttpRequest req = new HttpRequest(); // This http request we are doing to get the access token 

        req.setBody(reqbody);

        req.setMethod('POST');

       req.setEndpoint('https://login.salesforce.com/services/oauth2/token');

        HttpResponse res = h.send(req);
	System.debug('Response'+res);
        deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
	System.debug('Resp1'+resp1);
        if(resp1.access_token != null){

            String endPoint = resp1.instance_url+'/services/apexrest/createAccount/';
	System.debug('endPoint'+endPoint);
            String jsonstr = '{"AccName" : "' + accName + '"}';
	System.debug('AccName' +jsonstr);
            Http h2 = new Http();

            HttpRequest req1 = new HttpRequest(); // This Http is used to hit the end point 

            req1.setHeader('Authorization','Bearer ' + resp1.access_token);// Just Like postman be did Bearer then space Access token

            req1.setHeader('Content-Type','application/json');

            req1.setHeader('accept','application/json');

            req1.setBody(jsonstr);

            req1.setMethod('POST');

            req1.setEndpoint(endPoint);
            
            System.debug('req1'+req1);

            HttpResponse res1 = h2.send(req1);
            System.debug('res1'+res1);

        }

    }

}