@IsTest
private class ensxtx_TSTU_SFAccount
{
    @isTest
    static void test_CustomerFieldNameAccessException()
    {
        Test.startTest();
        ensxtx_UTIL_SFAccount.CustomerFieldNameAccessException acctExcep = new ensxtx_UTIL_SFAccount.CustomerFieldNameAccessException();
        String message = acctExcep.getMessage();
        Test.stopTest();
    }

    @isTest
    static void test_getAccountFromId()
    {
        Test.startTest();
        Account acct = ensxtx_TSTU_SFTestObject.createTestAccount();
        ensxtx_TSTU_SFTestObject.upsertWithRetry(acct);
        Account fetched = ensxtx_UTIL_SFAccount.getAccountById(ensxtx_TSTU_SFTestObject.getFakeId(Opportunity.SObjectType));
        fetched = ensxtx_UTIL_SFAccount.getAccountById(acct.Id);
        fetched = ensxtx_UTIL_SFAccount.getAccountById(acct.Id, new List<String>{'name'});
        //System.assertEquals(acct.Name, fetched.Name);
        System.assertEquals(acct.Id, fetched.Id);
        ensxtx_UTIL_SFAccount.getValueFromAccountField(acct, '', 'warningMessageFormat');
        ensxtx_UTIL_SFAccount.getValueFromAccountField(acct, 'Bad Field', 'warningMessageFormat');
        ensxtx_UTIL_SFAccount.getValueFromAccountField(acct, 'Name', 'warningMessageFormat');
        acct.Name = null;
        ensxtx_UTIL_SFAccount.getValueFromAccountField(acct, 'Name', 'warningMessageFormat');
        Test.stopTest();
    }

    @isTest
    static void test_getCustomerNumberFromAccount()
    {
        Test.startTest();
        Account acct = ensxtx_TSTU_SFTestObject.createTestAccount();
        ensxtx_TSTU_SFTestObject.upsertWithRetry(acct);
        String testCustNumber = 'TESTCUST';
        ensxtx_UTIL_SFAccount.setAccountCustomerNumber(acct, testCustNumber);
        try 
        {
            String customerNumber=ensxtx_UTIL_SFAccount.getCustomerNumberFromAccount(acct);
            System.assertEquals(customerNumber, testCustNumber);
        }
        catch(Exception e) 
        {
            System.assertEquals(e.getMessage(),'Your account does not have access to Account field "AccountNumber" to retrieve the SAP customer.');
        }
        Test.stopTest();
    }
}