public class AccountSoapCallOut1 {
    
    @AuraEnabled
    public static String sendAccountViaSoap(Integer firstValue, Integer secondValue){
        String xmlstring = '<?xml version="1.0" encoding="utf-8"?>'+
            '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'+
            '<soap:Body>'+
            '<Divide xmlns="http://tempuri.org/">'+
            '<intA>'+firstValue+'</intA>'+
            '<intB>'+secondValue+'</intB>'+
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
        
        Dom.Document doc = res.getBodyDocument(); 
        System.debug('Doc'+doc);
        
        Dom.XMLNode address = doc.getRootElement();
        System.debug('address'+address);
        System.debug('values'+address.getChildElements());        
        
        String Value;
        for(Dom.XmlNode node: address.getChildElements()) {
            for(Dom.XmlNode node1: node.getChildElements()) {
                for(Dom.XmlNode node2: node1.getChildElements()) {
                    System.debug( 'Elements'+node2.getChildElements());
                    Value = node2.getText();
                    System.debug('Divide Result' +Value);
                    System.debug('node name'+node2.getName()+node2.getNodeType());
                }
            }
        }
        
        String result = res.getBody();
        System.debug('Result is'+result);
        
        return Value;
    }
}