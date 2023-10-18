@isTest
private class AccountSoapCallOutTest {
    
    @isTest
    public static void testSoapCallOut(){
        Integer a = 5;
        Integer b = 5;
        Integer result = a/b;
        
        Test.setMock(HttpCalloutMock.class, new AccountSoapCallOutMock());
        Test.startTest();
        AccountSoapCallOut.sendAccountViaSoap();
        System.assertEquals(1, result);
        Test.stopTest();
    }
    
}