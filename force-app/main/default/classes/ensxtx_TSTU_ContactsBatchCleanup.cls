@isTest
public with sharing class ensxtx_TSTU_ContactsBatchCleanup
{
    public static testMethod void test_ContactCleanup()
    {
        Database.executeBatch(new ensxtx_UTIL_ContactsBatchCleanup());
        createExistingContactAndAccount();
        Test.startTest();
        Database.executeBatch(new ensxtx_UTIL_ContactsBatchCleanup());
        Test.stopTest();
    }

    public static testMethod void test_BadId_ContactCleanup()
    {
        ensxtx_UTIL_ContactsBatchCleanup cleanup = new ensxtx_UTIL_ContactsBatchCleanup();
        ensxtx_UTIL_ContactsBatchCleanup.CleanupObjectList = new List<ensxtx_UTIL_SyncHelper.CleanupObject> {
            new ensxtx_UTIL_SyncHelper.CleanupObject('Bad Object Name', ensxtx_UTIL_SFAccount.CustomerFieldName, ensxtx_TSTU_SFTestObject.getFakeId(Account.SObjectType),
                new List<ensxtx_UTIL_SyncHelper.CleanupField> {
                    new ensxtx_UTIL_SyncHelper.CleanupField(ensxtx_UTIL_SFContact.ContactCustomerFieldName, 'BadId')
                }
            )
        };
        Database.executeBatch(cleanup);
        createExistingContactAndAccount();
        Test.startTest();
    }

    public static testMethod void test_getRecordCount()
    {
        Test.startTest();
        ensxtx_UTIL_ContactsBatchCleanup.getTotalRecordCount();
        Test.stopTest();
    }

    private static void createExistingContactAndAccount()
    {
        Account acct = ensxtx_TSTU_SFTestObject.createTestAccount();
        acct.put(ensxtx_UTIL_SFAccount.CustomerFieldName, '12345');
        ensxtx_TSTU_SFTestObject.upsertWithRetry(acct);

        Contact contact = ensxtx_TSTU_SFTestObject.createTestContact(null);
        contact.put(ensxtx_UTIL_SFContact.ContactCustomerFieldName, '12345');
        ensxtx_TSTU_SFTestObject.upsertWithRetry(contact);
    }
}