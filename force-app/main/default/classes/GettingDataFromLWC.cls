public class GettingDataFromLWC {
    
    public static MainWrapper wrapperInstance = new MainWrapper() ;
    public static  FileUploader fileDataWrapper = new FileUploader();
    
    public static void sendLWCDataToExternalSystem(FileUploader fu){
        String firstName = wrapperInstance.name.firstName;
        String lastName = wrapperInstance.name.lastName;
        List<String> city = new List<String>();
        List<String> country = new List<String>();
        List<String> state = new List<String>();
        
        String xmlstring = '<?xml version="1.0" encoding="utf-8"?>'+
            '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'+
            '<soap:Body>'+
            '<finalData xmlns="http://tempuri.org/">'+
            '<name>'+
            '<firstname>'+firstName+'</firstname>'+
            '<lastname>'+lastName+'</lastname>'+
            '</name>'+
            '<files>';
            
        System.debug('FileName'+fu.name);
            for(String fileData: fu.name){
                xmlstring +='<file>'+
                    		'<name>'+fileData+'</name>';
            }
        for(String fileData1: fu.contentVersionid){
                xmlstring += '<contentVersionid>'+ fileData1+'</contentVersionid>'+
                    			'</file>';
            }
            xmlstring+= 
                		'</files>'+
                		'<addresses>';
        
        for(GettingDataFromLWC.Address data: wrapperInstance.Address){
            xmlstring +=  '<address>'+
                '<city>'+ data.city+ '</city>'+
                '<state>'+ data.state+ '</state>'+
                '<country>'+ data.country+ '</country>'+
                '</address>';
        }
        xmlstring += '</addresses>'+
            '</finalData>'+ 
            '</soap:Body>'+
            '</soap:Envelope>';
        System.debug('xmlstring'+xmlstring);
        
        HttpRequest httpReq = new HttpRequest();
        httpReq.setEndpoint('http://www.google.com');
        httpReq.setMethod('POST');
        httpReq.setBody(xmlstring);
        
        Http http = new Http();
        HTTPResponse res = http.send(httpReq);
        System.debug('Here is your response:'+res.getBody());
        System.debug('Response Code ='+res.getStatusCode());
    }
    
    
    @AuraEnabled(cacheable = true)
    public static MainWrapper method1(String jsonData,String fileData){
        System.debug('jsonData'+jsonData);
        wrapperInstance = (MainWrapper)System.JSON.deserialize(jsonData,MainWrapper.class);
        fileDataWrapper = (FileUploader)System.JSON.deserialize(fileData, FileUploader.class);
        System.debug('wrapperInstance'+wrapperInstance);
        System.debug('File Wrapper'+fileDataWrapper);
        GettingDataFromLWC.sendLWCDataToExternalSystem(fileDataWrapper);
        return wrapperInstance;
    }
    
    @AuraEnabled(cacheable = true)
    public static FileUploader uploadFile(List<Object> fileObj) {
        System.debug('Filesss'+fileObj);
        try{
            for(Object obj: fileObj){
              	Map<object,object> res = (Map<object,object>)obj;
                  //  System.debug('Key = '+key + ' Value= '+res.get(key+''));
                            fileDataWrapper.contentVersionid.add((String)res.get('contentVersionId'));
                   		    fileDataWrapper.name.add((String)res.get('name'));
            }
            	   System.debug('File Name'+fileDataWrapper.name);
                   System.debug('File ContentId'+fileDataWrapper.contentVersionid);
        }
        catch(Exception ex){
            System.debug('Error is '+ex.getMessage());
        }
         //GettingDataFromLWC.sendLWCDataToExternalSystem();
        return fileDataWrapper;
    }
    public class MainWrapper{
        @AuraEnabled public Name name;
        @AuraEnabled public List <Address> address;
        /*public MainWrapper(List <Address> blockInfo, Name nameBlock){
					this.name = nameBlock;
					this.address = blockInfo;
		}*/
    }
    
    public class Address{
        @AuraEnabled public Integer index;
        @AuraEnabled public String city;
        @AuraEnabled public String state;
        @AuraEnabled public String country;
        /* public Address(String city, String state, String country, Integer index){
			this.index = index;
			this.city = city;
			this.state = state;
			this.country = country;
			}*/
    }
    public class Name{
        @AuraEnabled public String firstName;
        @AuraEnabled public String lastName;
        /* public Name(String firstName, String lastName){
		this.firstName = firstName;
		this.lastName= lastName;
		}*/
    }
    public class FileUploader{
        @AuraEnabled public List<String> contentVersionid = new List<String>();
        @AuraEnabled public List<String> name = new List<String>();
    }
}