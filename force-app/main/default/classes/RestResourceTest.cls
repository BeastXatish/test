@isTest
public class RestResourceTest {
    
    @testSetup
    static void createTestData(){
        
        List<Account> accList = new List<Account>();
        for(Integer i =0; i<2;i++){
            accList.add(new Account(Name ='TestAccount'+i));
        }
        insert accList;
    }
    
    @isTest
    static void getTestMethod(){
        
        Account acc1 =[Select Name From Account Where Name ='TestAccount0' Limit 1];
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/atish/';
        req.params.put('Id',acc1.Id);
        req.httpMethod = 'Get';
        req.addHeader('Content-Type', 'application/json');
        
        RestResponse res = new RestResponse();
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        RestResource.getData();
        Test.stopTest();
    }
    
    @isTest
    static void postMethodTest(){
        Account acc2 =[Select Name From Account Where Name ='TestAccount1' limit 1];
        Test.startTest();
        RestResource.postData(acc2.Name);
        Test.stopTest();
    }
    
    @isTest 
    static void testPutMethod_itUpdatesAccountWithProvidedValue(){
        List<Account> accounts = [Select Id,Name From Account];
        List<RestResource.Record> accRecList = new List<RestResource.Record>();
        
        for(Account acc: accounts){
            accRecList.add(new RestResource.Record(acc.Id,'New Name'));
        }
        RestResource.AccountWrapper accObj = new RestResource.AccountWrapper();
        accObj.records =accRecList;
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/atish/';
        req.httpMethod = 'Put';
        req.addHeader('Content-Type', 'application/json');
        req.requestBody = Blob.valueOf(JSON.serialize(accObj));
        
        RestResponse res = new RestResponse();
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        RestResource.updateAccData();
        Test.stopTest();
    }
    
    @isTest 
    static void testPutMethod_itThrowsExceptionWhenIdIsWrong(){
        
        List<RestResource.Record> accRecList = new List<RestResource.Record>();
        accRecList.add(new RestResource.Record('0015j000014NuaDAAS','New Name'));
        
        RestResource.AccountWrapper accObj = new RestResource.AccountWrapper();
        accObj.records =accRecList;
        
        RestRequest req = new RestRequest();
        
        req.requestURI = '/services/apexrest/atish/';
        req.httpMethod = 'Put';
        req.addHeader('Content-Type', 'application/json');
        //request body we get in Blob type
        req.requestBody = Blob.valueOf(JSON.serialize(accObj));
        
        RestResponse res = new RestResponse();
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        RestResource.updateAccData();
        Test.stopTest();
    }
    
}