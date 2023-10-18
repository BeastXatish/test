@isTest
public class ensxtx_TSTU_SyncHelper
{
    private static Account createTestAccount()
    {
        Account testAccount = ensxtx_TSTU_SFTestObject.createTestAccount();
        testAccount.Name = 'test';
        testAccount.put(ensxtx_UTIL_SFAccount.CustomerFieldName, 'testId');
        ensxtx_TSTU_SFTestObject.upsertWithRetry(testAccount);

        OBJ_SAP_Sync__c sapSync = new OBJ_SAP_Sync__c();
        sapSync.Name = 'scheduleClass';
        sapSync.FLD_Sync_DateTime__c = System.today().addDays(-1);
        sapSync.FLD_Page_Number__c = 0;
        sapSync.FLD_Page_Size__c = 1;
        ensxtx_TSTU_SFTestObject.upsertWithRetry(sapSync);
        return testAccount;
    }

    @isTest
    public static void testExecuteBatch()
    {
        Account acct = createTestAccount();

        Test.startTest();
        ensxtx_UTIL_SyncHelper.executeBatch('batchClass', 'scheduleClass');
        ensxtx_UTIL_SyncHelper.executeBatch('batchClass', 'scheduleClass', null, 1);
        Test.stopTest();
    }

    @isTest
    public static void testLaunchAnotherBatchIfNeeded()
    {
        Account acct = createTestAccount();

        Test.startTest();
        ensxtx_UTIL_SyncHelper.launchAnotherBatchIfNeeded(true, 'scheduleClass');
        ensxtx_UTIL_SyncHelper.LastSync lastSync = new ensxtx_UTIL_SyncHelper.LastSync();
        lastSync.lastSyncDate = System.now().addDays(-1).date();
        lastSync.lastSyncTime = System.now().addDays(-1).time();
        ensxtx_UTIL_SyncHelper.launchAnotherBatchIfNeeded(false, 'scheduleClass', lastSync);
        ensxtx_UTIL_SyncHelper.launchAnotherBatchIfNeeded(true, 'scheduleClass', lastSync);
        Test.stopTest();
    }

    @isTest
    public static void testGetLastSyncFromTable()
    {
        Account acct = createTestAccount();

        Test.startTest();
        ensxtx_UTIL_SyncHelper.LastSync tst2 = ensxtx_UTIL_SyncHelper.getLastSyncFromTable('CreatedDate', 'Account', new ensxtx_UTIL_SyncHelper.LastSync());
        tst2.lastSyncDate = System.now().date();
        tst2.lastSyncTime = System.now().time();
        tst2.pageNumber = 1;
        String lastDateAndId = tst2.toString();
        tst2 = ensxtx_UTIL_SyncHelper.getLastSyncFromTable('CreatedDate', 'Account', tst2);
        tst2 = ensxtx_UTIL_SyncHelper.getLastSyncFromTable('CloseDate', 'Opportunity', tst2);
        tst2 = ensxtx_UTIL_SyncHelper.getLastSyncFromTable('CloseDate', 'Opportunity', new ensxtx_UTIL_SyncHelper.LastSync());
        tst2.lastSyncDate = System.now().date();
        tst2.lastSyncTime = System.now().time();
        tst2.pageNumber = 1;
        tst2 = ensxtx_UTIL_SyncHelper.getLastSyncFromTable('scheduleClass', tst2);
        tst2 = ensxtx_UTIL_SyncHelper.getLastSyncFromTable('scheduleClass', new ensxtx_UTIL_SyncHelper.LastSync());
        Test.stopTest();
    }

    @isTest
    public static void testCheckRetry()
    {
        Test.startTest();
        ensxtx_UTIL_SyncHelper.LastSync lastSync = new ensxtx_UTIL_SyncHelper.LastSync();
        ensxtx_UTIL_SyncHelper.checkRetry(lastSync, new ensxtx_UTIL_SyncHelper.SyncException(''), new List<String>());
        try {
            lastSync.retryCnt = 10;
            ensxtx_UTIL_SyncHelper.checkRetry(lastSync, new ensxtx_UTIL_SyncHelper.SyncException(''), new List<String>());
        } catch (Exception e) {}
        Test.stopTest();
    }

    @isTest
    public static void testResetPage()
    {
        Test.startTest();
        ensxtx_UTIL_SyncHelper.LastSync lastSync = new ensxtx_UTIL_SyncHelper.LastSync();
        lastSync.pageNumber = 100;
        ensxtx_UTIL_SyncHelper.resetPage(lastSync, 5);
        ensxtx_UTIL_SyncHelper.resetPage(lastSync, 200);
        lastSync.retryStart = 999999999;
        ensxtx_UTIL_SyncHelper.resetPage(lastSync, 201);
        lastSync.retryStart = -1;
        ensxtx_UTIL_SyncHelper.resetPage(lastSync, 100);
        Test.stopTest();
    }

    @isTest
    public static void testgetCurrentObjects()
    {
        Account acct = createTestAccount();

        Test.startTest();
        List<SObject> recs = ensxtx_UTIL_SyncHelper.getCurrentObjects('invalid table', 'Name', new Set<String>());
        recs = ensxtx_UTIL_SyncHelper.getCurrentObjects('Account', 'Name', new Set<String>{acct.Id});
        Test.stopTest();
    }

    @isTest
    public static void testCreateSObject()
    {
        Test.startTest();
        SObject obj = ensxtx_UTIL_SyncHelper.createSObject('Bad Object');
        obj = ensxtx_UTIL_SyncHelper.createSObject('Account');
        Test.stopTest();
    }

    @isTest
    public static void testDoesSobjectFieldExist()
    {
        Test.startTest();
        ensxtx_UTIL_SyncHelper.doesSobjectFieldExist('Account', 'Test Field');
        Test.stopTest();
    }

    @isTest
    public static void testAddLog()
    {
        Test.startTest();
        ensxtx_UTIL_SyncHelper.addLog(new List<sObject>(), 'Error', 'Test', 'json', 'Hello');
        Test.stopTest();
    }

    @isTest
    public static void testPrintJobInfo()
    {
        Test.startTest();
        ensxtx_UTIL_SyncHelper.printJobInfo(new List<String>{'Error', 'Test'});
        Test.stopTest();
    }

    @isTest
    public static void testDebugLogResultMessages()
    {
        Test.startTest();
        ensxsdk.EnosixFramework.Message message = new ensxsdk.EnosixFramework.Message(ensxsdk.EnosixFramework.MessageType.Error, 'Test');
        ensxtx_UTIL_SyncHelper.debugLogResultMessages(new List<ensxsdk.EnosixFramework.Message> {message});
        Test.stopTest();
    }

    @isTest
    public static void testGetPickListEntriesForFieldAndValueByLabel()
    {
        Test.startTest();
        List<Schema.PicklistEntry> pickListEntries = ensxtx_UTIL_SyncHelper.getPicklistEntriesForField('Account', 'Type');
        String val = ensxtx_UTIL_SyncHelper.getPicklistValueByLabel(pickListEntries, pickListEntries[0].getLabel());
        Test.stopTest();
    }

    public class MockSchedulable implements Schedulable
    {
        public void execute(SchedulableContext sc) {}
    }

    @isTest
    public static void testCombineStrings()
    {
        Test.startTest();
        ensxtx_UTIL_SyncHelper.combineStrings('first','second','combine');
        Test.stopTest();
    }

    @isTest
    public static void testValidateEmailAddress()
    {
        Test.startTest();
        ensxtx_UTIL_SyncHelper.validateEmailAddress('bad email');
        ensxtx_UTIL_SyncHelper.validateEmailAddress('goodEmail@good.com');
        Test.stopTest();
    }

    @isTest
    public static void testBuildErrorMessage()
    {
        Test.startTest();
        List<ensxsdk.EnosixFramework.Message> messages = new List<ensxsdk.EnosixFramework.Message>();
        ensxsdk.EnosixFramework.Message message = new ensxsdk.EnosixFramework.Message(ensxsdk.EnosixFramework.MessageType.Error, 'Test');
        messages.add(message);
        ensxtx_UTIL_SyncHelper.buildErrorMessage('BatchClassName', messages);
        Test.stopTest();
    }

    @isTest
    public static void testDeleteResults()
    {
        Test.startTest();
        List<SObject> records = new List<SObject>();
        records.add(ensxtx_TSTU_SFTestObject.createTestAccount());
        records.add(ensxtx_TSTU_SFTestObject.createTestAccount());
        ensxtx_TSTU_SFTestObject.upsertWithRetry(records);
        ensxtx_UTIL_SyncHelper.deleteResults('objType', new List<SObject>(), records, 'BatchClassName', 'id');
        ensxtx_UTIL_SyncHelper.deleteResults('objType', new List<SObject>(), records, 'BatchClassName', 'id');
        Test.stopTest();
    }

    @isTest
    public static void testCheckDeleteResults()
    {
        Test.startTest();
        Database.DeleteResult[] deleteResultList = new Database.DeleteResult[2];
        deleteResultList[0] = (Database.DeleteResult) JSON.deserialize('{"success":true,"id":"0013000000abcde"}', Database.DeleteResult.class);
        deleteResultList[1] = (Database.DeleteResult) JSON.deserialize('{"success":false,"errors":[{"message":"Error Message","statusCode":"FIELD_CUSTOM_VALIDATION_EXCEPTION"}]}', Database.DeleteResult.class);
        List<SObject> records = new List<SObject>();
        records.add(ensxtx_TSTU_SFTestObject.createTestAccount());
        records.add(ensxtx_TSTU_SFTestObject.createTestAccount());
        ensxtx_UTIL_SyncHelper.checkDeleteResults('objType', 'type', deleteResultList, new List<SObject>(), records, 'BatchClassName', 'id');
        Test.stopTest();
    }

    @isTest
    public static void testInsertUpdateResults()
    {
        Test.startTest();
        List<SObject> records = new List<SObject>();
        records.add(ensxtx_TSTU_SFTestObject.createTestAccount());
        records.add(ensxtx_TSTU_SFTestObject.createTestAccount());
        ensxtx_UTIL_SyncHelper.insertUpdateResults('objType', 'Insert', new List<SObject>(), new Set<Id>(), records, 'BatchClassName', 'id');
        ensxtx_UTIL_SyncHelper.insertUpdateResults('objType', 'Update', new List<SObject>(), new Set<Id>(), records, 'BatchClassName', 'id');
        Test.stopTest();
    }

    @isTest
    public static void testCheckSaveResults()
    {
        Test.startTest();
        Database.SaveResult[] saveResultList = new Database.SaveResult[2];
        saveResultList[0] = (Database.SaveResult) JSON.deserialize('{"success":true,"id":"0013000000abcde"}', Database.SaveResult.class);
        saveResultList[1] = (Database.SaveResult) JSON.deserialize('{"success":false,"errors":[{"message":"Error Message","statusCode":"FIELD_CUSTOM_VALIDATION_EXCEPTION"}]}', Database.SaveResult.class);
        List<SObject> records = new List<SObject>();
        records.add(ensxtx_TSTU_SFTestObject.createTestAccount());
        records.add(ensxtx_TSTU_SFTestObject.createTestAccount());
        ensxtx_UTIL_SyncHelper.checkSaveResults('objType', 'type', saveResultList, new List<SObject>(), new Set<Id>(), records, 'BatchClassName', 'id');
        Test.stopTest();
    }

    @isTest
    public static void testGetNotFoundAccountId()
    {
        Test.startTest();
        Id accountId = ensxtx_UTIL_SyncHelper.getNotFoundAccountId(new List<sObject>());
        ensxtx_UTIL_SyncHelper.notFoundAccount = null;
        accountId = ensxtx_UTIL_SyncHelper.getNotFoundAccountId(new List<sObject>());
        Test.stopTest();
    }

    @isTest
    public static void testCreateSObjectMap()
    {
        Test.startTest();
        ensxtx_UTIL_SyncHelper.CleanupObject cleanupObject = new ensxtx_UTIL_SyncHelper.CleanupObject(
            'Account', ensxtx_UTIL_SFAccount.CustomerFieldName, ensxtx_UTIL_SyncHelper.getNotFoundAccountId(new List<sObject>()),
            new List<ensxtx_UTIL_SyncHelper.CleanupField> {
                new ensxtx_UTIL_SyncHelper.CleanupField(ensxtx_UTIL_SFAccount.CustomerFieldName, 'AccountId')
            }
        );
        cleanupObject.sapKeyNumbers.add('1');
        Account testAccount = ensxtx_TSTU_SFTestObject.createTestAccount();
        testAccount.put(ensxtx_UTIL_SFAccount.CustomerFieldName, '1');
        ensxtx_TSTU_SFTestObject.upsertWithRetry(testAccount);
        ensxtx_UTIL_SyncHelper.createSObjectMap(cleanupObject);
        Test.stopTest();
    }
}