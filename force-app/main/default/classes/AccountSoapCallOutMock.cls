@isTest
global class AccountSoapCallOutMock implements HttpCalloutMock{

    global HTTPResponse respond(HTTPRequest req){
        AccountSoapCallOut exp = new AccountSoapCallOut();
        System.assertEquals('http://www.dneonline.com/calculator.asmx', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        HttpResponse res = new HttpResponse();
        if(res.getStatusCode()==200){
            System.debug('All Ok');
        }
        return res;
    }
}