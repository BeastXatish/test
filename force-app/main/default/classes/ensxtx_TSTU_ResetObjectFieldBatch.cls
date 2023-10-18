@isTest
public with sharing class ensxtx_TSTU_ResetObjectFieldBatch
{
    public static testMethod void test_UTIL_ResetObjectFieldBatchString()
    {
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
            'SELECT ID, BillingStreet FROM Account WHERE BillingStreet != null', 'BillingStreet', 'String', null));
        Test.stopTest();
    }

    public static testMethod void test_UTIL_ResetObjectFieldBatchBoolean()
    {
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
            'SELECT ID, BillingStreet FROM Account WHERE BillingStreet != null', 'BillingStreet', 'Boolean', null));
        Test.stopTest();
    }

    public static testMethod void test_UTIL_ResetObjectFieldBatchInteger()
    {
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
            'SELECT ID, BillingStreet FROM Account WHERE BillingStreet != null', 'BillingStreet', 'Integer', null));
        Test.stopTest();
    }

    public static testMethod void test_UTIL_ResetObjectFieldBatchDecimal()
    {
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
            'SELECT ID, BillingStreet FROM Account WHERE BillingStreet != null', 'BillingStreet', 'Decimal', null));
        Test.stopTest();
    }

    public static testMethod void test_UTIL_ResetObjectFieldBatchLong()
    {
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
            'SELECT ID, BillingStreet FROM Account WHERE BillingStreet != null', 'BillingStreet', 'Long', null));
        Test.stopTest();
    }

    public static testMethod void test_UTIL_ResetObjectFieldBatchDouble()
    {
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
            'SELECT ID, BillingStreet FROM Account WHERE BillingStreet != null', 'BillingStreet', 'Double', null));
        Test.stopTest();
    }

    public static testMethod void test_UTIL_ResetObjectFieldBatchDatetime()
    {
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
            'SELECT ID, BillingStreet FROM Account WHERE BillingStreet != null', 'BillingStreet', 'Datetime', null));
        Test.stopTest();
    }

    public static testMethod void test_UTIL_ResetObjectFieldBatchDate()
    {
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
            'SELECT ID, BillingStreet FROM Account WHERE BillingStreet != null', 'BillingStreet', 'Date', null));
        Test.stopTest();
    }

    public static testMethod void test_UTIL_ResetObjectFieldBatchTime()
    {
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
            'SELECT ID, BillingStreet FROM Account WHERE BillingStreet != null', 'BillingStreet', 'Time', null));
        Test.stopTest();
    }

    public static testMethod void test_UTIL_ResetObjectFieldBatchDelete()
    {
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
            'SELECT ID FROM Account', '', 'Delete', null));
        Test.stopTest();
    }

    public static testMethod void test_UTIL_ResetObjectFieldBatchElse()
    {
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
            'SELECT ID, BillingStreet FROM Account WHERE BillingStreet != null', 'BillingStreet', 'Else', null));
        Test.stopTest();
    }

    public static testMethod void test_UTIL_ResetObjectFieldBatchError()
    {
        Test.startTest();
        try
        {
            Database.executeBatch(new ensxtx_UTIL_ResetObjectFieldBatch(
                'SELECT ID, Name FROM Account WHERE Name != null', 'Name', 'String', null));
        }
        catch (Exception e)
        {}
        Test.stopTest();
    }

    @testSetup
    private static void createExistingAccount()
    {
        Account acct = ensxtx_TSTU_SFTestObject.createTestAccount();
        acct.Name = 'Test Account One';
        acct.BillingStreet = 'BillingStreet One';
        ensxtx_TSTU_SFTestObject.upsertWithRetry(acct);

        acct = ensxtx_TSTU_SFTestObject.createTestAccount();
        acct.Name = 'Test Account Two';
        acct.BillingStreet = 'BillingStreet Two';
        ensxtx_TSTU_SFTestObject.upsertWithRetry(acct);

        acct = ensxtx_TSTU_SFTestObject.createTestAccount();
        acct.Name = 'Test Account Three';
        acct.BillingStreet = 'BillingStreet Three';
        ensxtx_TSTU_SFTestObject.upsertWithRetry(acct);
    }
}