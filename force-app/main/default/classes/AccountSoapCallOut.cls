public class AccountSoapCallOut {
    
    @AuraEnabled
    public static String sendAccountViaSoap(){
        String xmlstring = '<?xml version="1.0" encoding="utf-8"?>'+
            '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'+
            '<soap:Body>'+
            '<Divide xmlns="http://tempuri.org/">'+
            '<intA>5</intA>'+
            '<intB>5</intB>'+
            '</Divide>'+
            '</soap:Body>'+
            '</soap:Envelope>';
        HttpRequest httpReq = new HttpRequest();
        httpReq.setEndpoint('http://www.dneonline.com/calculator.asmx');
        httpReq.setMethod('POST');
        httpReq.setHeader('Content-Type', 'text/xml; charset=utf-8');
        httpReq.setHeader('SOAPAction', 'http://tempuri.org/Divide');
        httpReq.setBody(xmlstring);
        
        Http http = new Http();
        HTTPResponse res = http.send(httpReq);
        System.debug('Here is your response:'+res.getBody());
        System.debug('Response Code ='+res.getStatusCode());
        String result = res.getBody();
        System.debug('Result is'+result);
        return result; 
    }

    /*public static void makeSoapCallout(){
        String WebServiceURL ='http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso';
        
        String xmlBody='<?xml version="1.0" encoding="utf-8"?><soap12:Envelope xmlns:soap12="http://www.w3.org/2003/05/soap-envelope"><soap12:Body><ListOfCountryNamesByName xmlns="http://www.oorsprong.org/websamples.countryinfo"></ListOfCountryNamesByName></soap12:Body></soap12:Envelope>';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(WebServiceURL);       
        req.setMethod('POST');
        req.setHeader('Accept', 'text/html,application/xhtml+xml,application/xml,application/soap+xml');
        req.setHeader('Content-Type', 'application/soap+xml');
        req.setHeader('MediaType', 'application/xml');
        req.setCompressed(false);
        req.setBody(xmlBody);
        req.setTimeout(30000);
        
        http http = new Http();
        HttpResponse res = http.send(req);
        System.debug('Status Code is'+res.getStatusCode());
        if (res.getStatusCode() == 200) {
            String response = res.getBody();
            // Parse the XML response and extract the relevant data
            System.debug(response);
        } else {
            System.debug('Error: ' + res.getStatus());
        }
    }*/
}