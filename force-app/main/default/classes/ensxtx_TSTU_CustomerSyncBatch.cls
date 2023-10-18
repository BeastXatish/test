@isTest
public with sharing class ensxtx_TSTU_CustomerSyncBatch
{
    static final string TEST_JSON = '{"AccountGroups":["0001","0002"], "Logging": true}';

    public class MockSyncSearch implements ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        private boolean success = true;

        public void setSuccess(boolean success)
        {
            this.success = success;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext searchContext)
        {
            if (this.throwException)
            {
                throw new ensxtx_UTIL_SyncHelper.SyncException('');
            }

            ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SR searchResult =
                new ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SR();

            ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT result1 =
                new ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT();

            result1.CustomerNumber = '1';
            result1.AccountGroup = 'AccountGroup';
            result1.Name = 'Name';
            result1.Name2 = 'Name2';
            result1.Street = 'Street';
            result1.Street2 = 'Street2';
            result1.Street3 = 'Street3';
            result1.Street4 = 'Street4';
            result1.AssetLocation = 'AssetLocation';
            result1.HouseNumber = 'HouseNumber';
            result1.PostalCode = 'PostalCode';
            result1.City = 'City';
            result1.Country = 'Country';
            result1.Region = 'Region';
            result1.POBox = 'POBox';
            result1.POBoxPostalCode = 'POBoxPostalCode';
            result1.TelephoneNumber = 'TelephoneNumber';
            result1.EMailAddress = 'EMailAddress';

            searchResult.SearchResults.add(result1);

            ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT result2 =
                new ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT();

            result2.CustomerNumber = '2';
            result2.AccountGroup = 'AccountGroup';
            result2.Name = 'Name';
            result2.Name2 = 'Name2';
            result2.Street = 'Street';
            result2.Street2 = 'Street2';
            result2.Street3 = 'Street3';
            result2.Street4 = 'Street4';
            result2.AssetLocation = 'AssetLocation';
            result2.HouseNumber = 'HouseNumber';
            result2.PostalCode = 'PostalCode';
            result2.City = 'City';
            result2.Country = 'Country';
            result2.Region = 'Region';
            result2.POBox = 'POBox';
            result2.POBoxPostalCode = 'POBoxPostalCode';
            result2.TelephoneNumber = 'TelephoneNumber';
            result2.EMailAddress = 'valid@valid.com';

            searchResult.SearchResults.add(result2);

            ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT result3 =
                new ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT();

            result3.CustomerNumber = '3';
            result3.AccountGroup = 'AccountGroup';
            result3.Name = 'Name';
            result3.Name2 = 'Name2';
            result3.Street = 'Street';
            result3.Street2 = 'Street2';
            result3.Street3 = 'Street3';
            result3.Street4 = 'Street4';
            result3.AssetLocation = 'AssetLocation';
            result3.HouseNumber = 'HouseNumber';
            result3.PostalCode = 'PostalCode';
            result3.City = 'City';
            result3.Country = 'Country';
            result3.Region = 'Region';
            result3.POBox = 'POBox';
            result3.POBoxPostalCode = 'POBoxPostalCode';
            result3.TelephoneNumber = 'TelephoneNumber';
            result3.EMailAddress = 'valid@valid.com';
            result3.DeleteIndicator = true;

            searchResult.SearchResults.add(result3);

            ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT result4 =
                new ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT();

                result4.CustomerNumber = '1';
                result4.AccountGroup = 'AccountGroup';
                result4.Name = 'Name';
                result4.Name2 = 'Name2';
                result4.Street = 'Street';
                result4.Street2 = 'Street2';
                result4.Street3 = 'Street3';
                result4.Street4 = 'Street4';
                result4.AssetLocation = 'AssetLocation';
                result4.HouseNumber = 'HouseNumber';
                result4.PostalCode = 'PostalCode';
                result4.City = 'City';
                result4.Country = 'Country';
                result4.Region = 'Region';
                result4.POBox = 'POBox';
                result4.POBoxPostalCode = 'POBoxPostalCode';
                result4.TelephoneNumber = 'TelephoneNumber';
                result4.EMailAddress = 'EMailAddress';

            searchResult.SearchResults.add(result4);

            searchResult.setSuccess(this.success);
            searchContext.baseResult = searchResult;
            return searchContext;
        }
    }

    public static testMethod void test_CustomerSync()
    {
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixCustSync_Search.class, new MockSyncSearch());
        
        ensxtx_UTIL_AppSettings.settingsMap.put(ensxtx_UTIL_AppSettings.Prefix + ensxtx_UTIL_AppSettings.CustomerSyncBatch + ensxtx_UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        createExistingObject();
        Test.startTest();
        ensxtx_UTIL_CustomerSyncBatch controller = new ensxtx_UTIL_CustomerSyncBatch();
        ensxtx_UTIL_SyncHelper.LastSync lastSync = new ensxtx_UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);
        Database.executeBatch(controller);
        Test.stopTest();
    }

    public static testMethod void test_CustomerSyncInitialLoad()
    {
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixCustSync_Search.class, new MockSyncSearch());
        
        ensxtx_UTIL_AppSettings.settingsMap.put(ensxtx_UTIL_AppSettings.Prefix + ensxtx_UTIL_AppSettings.CustomerSyncBatch + ensxtx_UTIL_AppSettings.Suffix, (Map<String, Object>)JSON.deserializeUntyped(TEST_JSON));
        Test.startTest();
        ensxtx_UTIL_CustomerSyncBatch controller = new ensxtx_UTIL_CustomerSyncBatch();
        ensxtx_UTIL_SyncHelper.LastSync lastSync = new ensxtx_UTIL_SyncHelper.LastSync();
        lastSync.retryCnt = 1;
        controller.setBatchParam(lastSync);
        Database.executeBatch(controller);
        Test.stopTest();
    }

    public static testMethod void test_CustomerSyncFailure()
    {
        MockSyncSearch mockSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixCustSync_Search.class, mockSyncSearch);
        mockSyncSearch.setSuccess(false);

        createExistingObject();
        Test.startTest();
        ensxtx_UTIL_CustomerSyncBatch controller = new ensxtx_UTIL_CustomerSyncBatch();
        Database.executeBatch(controller);
        try
        {
            ensxtx_UTIL_SyncHelper.LastSync lastSync = new ensxtx_UTIL_SyncHelper.LastSync();
            lastSync.retryCnt = 11;
            controller.setBatchParam(lastSync);
        }
        catch (Exception e) {}
        Test.stopTest();
    }

    public static testMethod void test_CustomerSyncException()
    {
        MockSyncSearch mockSyncSearch = new MockSyncSearch();
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixCustSync_Search.class, mockSyncSearch);
        mockSyncSearch.setThrowException(true);

        createExistingObject();
        Test.startTest();
        ensxtx_UTIL_CustomerSyncBatch controller = new ensxtx_UTIL_CustomerSyncBatch();
        Database.executeBatch(controller);
        try
        {
            ensxtx_UTIL_SyncHelper.LastSync lastSync = new ensxtx_UTIL_SyncHelper.LastSync();
            lastSync.retryCnt = 11;
            controller.setBatchParam(lastSync);
            controller.start(null);
        }
        catch (Exception e) {}
        Test.stopTest();
    }

    public static testMethod void test_getRecordCount()
    {
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixCustSync_Search.class, new MockSyncSearch());

        Test.startTest();
        ensxtx_UTIL_CustomerSyncBatch.getTotalRecordCount();
        ensxtx_UTIL_CustomerSyncBatch.getNextIncrementalRecordCount();
        Test.stopTest();
    }

    private static void createExistingObject()
    {
        Account currentObject = ensxtx_TSTU_SFTestObject.createTestAccount();
        currentObject.Name = 'account1';
        currentObject.put(ensxtx_UTIL_CustomerSyncBatch.SFSyncKeyField,'1');
        ensxtx_TSTU_SFTestObject.upsertWithRetry(currentObject);

        OBJ_SAP_Sync__c sapSync = new OBJ_SAP_Sync__c();
        sapSync.Name = 'ensxtx_UTIL_CustomerSyncSchedule';
        sapSync.FLD_Sync_DateTime__c = System.today().addDays(-1);
        sapSync.FLD_Page_Number__c = 0;
        ensxtx_TSTU_SFTestObject.upsertWithRetry(sapSync);
    }
}