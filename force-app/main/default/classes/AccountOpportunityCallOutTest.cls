@isTest
private class AccountOpportunityCallOutTest {
    
    @testSetup
    public static void testData(){
        Account acc = new Account(Name = 'FieldUpdate');
        insert acc;
        
        Account acc1 = new Account(Name = 'FieldUpdate1');
        insert acc1;
        
        Account acc2 = new Account(Name = 'FieldUpdate2');
        insert acc2;
        
        Opportunity opp = new Opportunity(Name = 'Test Opportunity',Amount = 100, StageName = 'Dummy', AccountId = acc.Id, CloseDate = Date.today());
        insert opp;
        
        Opportunity opp1 = new Opportunity(Name = 'Test Opportunity1',Amount = 100, StageName = 'Dummy1', AccountId = acc1.Id, CloseDate = Date.today());
        insert opp1;
        
        Opportunity opp2 = new Opportunity(Name = 'Test Opportunity2',Amount = 100, StageName = 'Dummy2', AccountId = acc2.Id, CloseDate = Date.today());
        insert opp2;
    }
    
    @isTest
    public static void testCallOut(){

        Account accRec = [Select Name From Account Where Name = 'FieldUpdate'];
        
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AccountOpportunityCallOutMock());
        Test.startTest();
        // Call method to test.
        // This causes a fake response to be sent from the class that implements HttpCalloutMock.
        AccountOpportunityCallOut.doCallout('FieldUpdate');
        System.assertEquals('FieldUpdate', accRec.Name); 
        Test.stopTest();
    }
    
    @isTest
    public static void testCallOut1(){
        Account accRec = [Select Name From Account Where Name = 'FieldUpdate1'];
        
        Test.setMock(HttpCalloutMock.class, new AccountOpportunityCallOutMock());
        Test.startTest();
        AccountOpportunityCallOut.doCallout('FieldUpdate1');
        System.assertEquals('FieldUpdate1', accRec.Name);
        Test.stopTest();
    }
    
    @isTest
    public static void testCallOut2(){
        Account accRec = [Select Name From Account Where Name = 'FieldUpdate2'];
        
        Test.setMock(HttpCalloutMock.class, new AccountOpportunityCallOutMock());
        Test.startTest();
        AccountOpportunityCallOut.doCallout('FieldUpdate2');
        System.assertEquals('FieldUpdate2', accRec.Name);
        Test.stopTest();
    }
}