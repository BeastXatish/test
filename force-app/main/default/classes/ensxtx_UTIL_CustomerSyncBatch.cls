public with sharing class ensxtx_UTIL_CustomerSyncBatch
    implements Database.Batchable<Object>,
    Database.AllowsCallouts,
    Database.Stateful,
    ensxtx_I_ParameterizedSync
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(ensxtx_UTIL_CustomerSyncBatch.class);
    public void logCallouts(String location)
    {
        if ((Boolean)ensxtx_UTIL_AppSettings.getValue(BatchClassName.substringAFter('UTIL_'), 'Logging', false))
        {
            logger.enterVfpConstructor(location, null);
        }
    }

    // jobInfo contains debug information persisted across contexts since start(),
    // execute(), and finish() all run in separate contexts with separate debug logs
    private List<String> jobInfo = new List<String>();
    
    // In this case, we will store the largest change date/time as the param
    private ensxtx_UTIL_SyncHelper.LastSync fromLastSync = new ensxtx_UTIL_SyncHelper.LastSync();
    private static String ObjectType = 'Account';

    @TestVisible
    private static String SFSyncKeyField = ensxtx_UTIL_SFAccount.CustomerFieldName;
    @TestVisible
    private static String BatchClassName = 'ensxtx_UTIL_CustomerSyncBatch';
    private static String ScheduleClassName = 'ensxtx_UTIL_CustomerSyncSchedule';

    /* ensxtx_I_ParameterizedSync methods - setBatchParam() */
    public void setBatchParam(Object value)
    {
        this.fromLastSync = (ensxtx_UTIL_SyncHelper.LastSync) value;
    }
    /* end ensxtx_I_ParameterizedSync methods */

    private static List<String> accountGroups 
    {
        get
        {
            return (List<String>)ensxtx_UTIL_AppSettings.getList(
                BatchClassName.substringAFter('UTIL_'), 'AccountGroups', String.class, new List<String>{});
        }
    }

    /* Database.Batchable methods start(), execute(), and finish() */
    // start()
    //
    // Calls SBO and returns search results of update customers
    public List<Object> start(Database.BatchableContext context)
    {
        logCallouts(BatchClassName + '.start');
        System.debug(context.getJobId() + ' started');

        ensxtx_SBO_EnosixCustSync_Search sbo = new ensxtx_SBO_EnosixCustSync_Search();

        this.fromLastSync = ensxtx_UTIL_SyncHelper.getLastSyncFromTable(
            ScheduleClassName,
            this.fromLastSync);

        this.fromLastSync.pageNumber = this.fromLastSync.pageNumber + 1;

        if (this.fromLastSync.retryCnt == -1)
        {
            ensxtx_UTIL_SyncHelper.resetPage(this.fromLastSync, (Integer) ensxtx_UTIL_AppSettings.getValue(
                BatchClassName.substringAFter('UTIL_'), 'SAPPageSize',
                512));
        }
        
        ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SC searchContext = buildSearchContext(this.fromLastSync);

        this.jobInfo.add('fromLastSync:' + this.fromLastSync.toString());
        System.debug('fromLastSync:' + this.fromLastSync.toString());

        // Execute the search
        ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SR result;
        try
        {
            sbo.search(searchContext);
            result = searchContext.result;
        }
        catch (Exception ex)
        {
            return ensxtx_UTIL_SyncHelper.checkRetry(this.fromLastSync, ex, this.jobInfo);
        }

        // Write any response messages to the debug log
        String errorMessage = ensxtx_UTIL_SyncHelper.buildErrorMessage(BatchClassName, result.getMessages());

        if (!result.isSuccess())
        {
            return ensxtx_UTIL_SyncHelper.checkRetry(this.fromLastSync, new ensxtx_UTIL_SyncHelper.SyncException(errorMessage), this.jobInfo);
        }

        List<Object> searchResults = result.getResults();
        System.debug('Result size: ' + searchResults.size());

        // let finish() know to queue up another instance
        this.fromLastSync.isAnotherBatchNeeded = searchResults.size() > 0;
        this.fromLastSync.retryCnt = -1;

        this.jobInfo.add('searchResultsSize:' + searchResults.size());
        this.jobInfo.add('fromLastSync:' + this.fromLastSync.toString());

        return searchResults;
    }

    private static ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SC buildSearchContext (ensxtx_UTIL_SyncHelper.LastSync fromLastSync)
    {
        ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SC searchContext = new ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SC();

        if (fromLastSync.lastSyncDate != null)
        {
            searchContext.SEARCHPARAMS.DateFrom = fromLastSync.lastSyncDate;
        }
        else searchContext.SEARCHPARAMS.InitialLoad = true;

        searchContext.pagingOptions.pageSize = fromLastSync.pageSize;
        searchContext.pagingOptions.pageNumber = fromLastSync.pageNumber;

        Integer agTot = accountGroups.size();
        if (agTot > 0)
        {    
            for (Integer agCnt = 0 ; agCnt < agTot ; agCnt++)
            {
                String acctGroup = accountGroups[agCnt];
                ensxtx_SBO_EnosixCustSync_Search.ACCOUNT_GROUPS newAcctGroup = new ensxtx_SBO_EnosixCustSync_Search.ACCOUNT_GROUPS();
                newAcctGroup.AccountGroup = acctGroup;
                searchContext.ACCOUNT_GROUPS.add(newAcctGroup);
            }
        }

        return searchContext;
    }

    // execute()
    //
    // Given the updated search results, does the work of updating the object table.
    public void execute(
        Database.BatchableContext context,
        List<Object> searchResults)
    {
        logCallouts(BatchClassName + '.execute');
        System.debug(context.getJobId() + ' executing');

        if (null == searchResults || 0 == searchResults.size()) return;

        List<SObject> errors = new List<SObject>();
        Map<String, Object> searchResultMap = createObjectKeyMap(searchResults);

        // First, update matching existing objects
        List<SObject> currentObjectList = ensxtx_UTIL_SyncHelper.getCurrentObjects(
            ObjectType,
            SFSyncKeyField,
            searchResultMap.keySet());
        Map<String, SObject> currentObjectMap = new Map<String, SObject>();
        Integer coTot = currentObjectList.size();
        for (Integer coCnt = 0 ; coCnt < coTot ; coCnt++)
        {
            SObject currentObject = currentObjectList[coCnt];
            currentObjectMap.put((String) currentObject.get(SFSyncKeyField),currentObject);
        }

        Boolean updateObject = (Boolean)ensxtx_UTIL_AppSettings.getValue(BatchClassName.substringAFter('UTIL_'), 'UpdateObject', true);
        Map<String, SObject> updateObjectMap = new Map<String, SObject>();
        if (updateObject) updateObjectMap = updateExistingObjects(searchResultMap, currentObjectMap, errors);

        Boolean insertObject = (Boolean)ensxtx_UTIL_AppSettings.getValue(BatchClassName.substringAFter('UTIL_'), 'InsertObject', true);
        Map<String, SObject> insertObjectMap = new Map<String, SObject>();
        if (insertObject) insertObjectMap = createNewObjects(searchResultMap, currentObjectMap, errors);

        Set<Id> savedIdSet = new Set<Id>();

        ensxtx_UTIL_SyncHelper.insertUpdateResults(ObjectType, 'Update', errors, savedIdSet, updateObjectMap.values(), BatchClassName, SFSyncKeyField);
        ensxtx_UTIL_SyncHelper.insertUpdateResults(ObjectType, 'Insert', errors, savedIdSet, insertObjectMap.values(), BatchClassName, SFSyncKeyField);
        ensxtx_UTIL_SyncHelper.insertUpdateResults('Error', 'Insert', errors, null, errors, BatchClassName, null);
    }

    // finish()
    //
    // queues up another batch when isAnotherBatchNeeded is true
    public void finish(Database.BatchableContext context)
    {
        logCallouts(BatchClassName + '.finish');
        System.debug(context.getJobId() + ' finished');
        ensxtx_UTIL_SyncHelper.printJobInfo(this.jobInfo);
        if (this.fromLastSync.retryCnt >= 0)
        {
            System.debug('Retry=' + this.fromLastSync.retryCnt + ' ' + System.Now());
        }

        ensxtx_UTIL_SyncHelper.launchAnotherBatchIfNeeded(
            this.fromLastSync.isAnotherBatchNeeded, ScheduleClassName, this.fromLastSync);

        Boolean contactsBatchCleanup = (Boolean)ensxtx_UTIL_AppSettings.getValue(BatchClassName.substringAFter('UTIL_'), 'ContactsBatchCleanup', true);
        if (!this.fromLastSync.isAnotherBatchNeeded && contactsBatchCleanup) Database.executeBatch(new ensxtx_UTIL_ContactsBatchCleanup());
    }

    private ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT getSboResult(Object searchResult)
    {
        return (ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT) searchResult;
    }

    // createObjectKeyMap()
    //
    // create map of objecy key / search result.
    private Map<String, Object> createObjectKeyMap(
        List<Object> searchResults)
    {
        Map<String, Object> result =
            new Map<String, Object>();

        Integer srTot = searchResults.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            Object searchResult = searchResults[srCnt];
            String key = getSboKey(searchResult);
            if (String.isNotEmpty(key))
            {
                result.put(key, searchResult);
            }
        }

        return result;
    }

    private Map<String, SObject> updateExistingObjects(
        Map<String, Object> searchResultMap,
        Map<String, SObject> currentObjectMap,
        List<SObject> errors)
    {
        Map<String, SObject> updateObjectMap = new Map<String, SObject>();

        List<Object> srList = searchResultMap.values();
        Integer srTot = srList.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            Object searchResult = srList[srCnt];
            String currentSboKey = getSboKey(searchResult);
            if (currentObjectMap.containsKey(currentSboKey))
            {
                SObject currentObject = currentObjectMap.get(currentSboKey);

                // Updates fields and adds to objectList list for later commit
                syncObject(
                    currentObject,
                    searchResult,
                    updateObjectMap,
                    errors);
            }
        }

        System.debug('Existing Object Size: ' + updateObjectMap.size());

        return updateObjectMap;
    }

    private Map<String, SObject> createNewObjects(
        Map<String, Object> searchResultMap,
        Map<String, SObject> currentObjectMap,
        List<SObject> errors)
    {
        Map<String, SObject> insertObjectMap = new Map<String, SObject>();

        List<Object> srList = searchResultMap.values();
        Integer srTot = srList.size();
        for (Integer srCnt = 0 ; srCnt < srTot ; srCnt++)
        {
            Object searchResult = srList[srCnt];
            if (!currentObjectMap.containsKey(getSboKey(searchResult)))
            {
                syncObject(
                    null,
                    searchResult,
                    insertObjectMap,
                    errors);
            }
        }

        System.debug('New Object Size: ' + insertObjectMap.size());

        return insertObjectMap;
    }

    private void syncObject(
        SObject currentObject,
        Object searchResult,
        Map<String, SObject> objectMap,
        List<SObject> errors)
    {
        ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
        if (currentObject == null)
        {
            if (sboResult.DeleteIndicator)
            {
                return;
            }
            currentObject = new Account();
        }
        Account acct = (Account) currentObject;
        String key = getSboKey(searchResult);
        acct.put(SFSyncKeyField,key);
        acct.FLD_SAP_Account_Group__c = sboResult.AccountGroup;
        acct.Name = ensxtx_UTIL_SyncHelper.combineStrings(sboResult.Name, sboResult.Name2, '; ');
        if (String.isEmpty(acct.Name))
        {
            System.debug(BatchClassName + ' ' + ObjectType + ' Name missing from Key ' + key);
            ensxtx_UTIL_SyncHelper.addLog(errors, 'ERROR', key, Json.serialize(acct), BatchClassName + ' ' + ObjectType + ' Name missing from Key ' + key);
            return;
        }
        acct.BillingStreet = ensxtx_UTIL_SyncHelper.combineStrings(sboResult.HouseNumber, sboResult.Street, ' ');
        acct.BillingStreet = ensxtx_UTIL_SyncHelper.combineStrings(acct.BillingStreet, sboResult.Street2, '\n');
        acct.BillingStreet = ensxtx_UTIL_SyncHelper.combineStrings(acct.BillingStreet, sboResult.Street3, '\n');
        acct.BillingStreet = ensxtx_UTIL_SyncHelper.combineStrings(acct.BillingStreet, sboResult.Street4, '\n');
        acct.BillingStreet = ensxtx_UTIL_SyncHelper.combineStrings(acct.BillingStreet, sboResult.AssetLocation, '\n');
        if (String.isNotEmpty(sboResult.POBox))
        {
            acct.BillingStreet = ensxtx_UTIL_SyncHelper.combineStrings(acct.BillingStreet, 'PO BOX ' + sboResult.POBox, '\n');
        }
        acct.BillingPostalCode = sboResult.POBoxPostalCode;
        if (String.isNotEmpty(sboResult.PostalCode))
        {
            acct.BillingPostalCode = sboResult.PostalCode;
        }
        acct.BillingCity = sboResult.City;
        
        Boolean isBillingCode = ensxtx_UTIL_SyncHelper.doesSobjectFieldExist('Account', 'BillingStateCode');
        String billingStateField = isBillingCode ? 'BillingStateCode' : 'BillingState';
        String billingCountryField = isBillingCode ? 'BillingCountryCode' : 'BillingCountry';
        acct.put(billingStateField, sboResult.Region);
        acct.put(billingCountryField, sboResult.Country);

        acct.Phone = sboResult.TelephoneNumber;
        acct.FLD_Email__c = null;
        if (String.isNotEmpty(sboResult.EmailAddress))
        {
            if (ensxtx_UTIL_SyncHelper.validateEmailAddress(sboResult.EmailAddress))
            {
                acct.FLD_Email__c = sboResult.EMailAddress;
            }
            else
            {                
                ensxtx_UTIL_SyncHelper.addLog(errors, 'ERROR', key, Json.serialize(acct), 
                    BatchClassName + '; Invalid email found: ' + sboResult.EmailAddress + '; Customer Number: ' + sboResult.CustomerNumber);
            }
        } 
        acct.FLD_SAP_Is_Deleted__c = sboResult.DeleteIndicator;
        objectMap.put(key, acct);
    }

    private String getSboKey(Object searchResult)
    {
        ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT sboResult = getSboResult(searchResult);
        return sboResult == null || sboResult.CustomerNumber == null ? '' : sboResult.CustomerNumber.replaceFirst('^0+(?!$)', '');
    }

    public static Integer getTotalRecordCount () 
    {
        return getRecordCount(true);
    }

    public static Integer getNextIncrementalRecordCount () 
    {
        return getRecordCount(false);
    }

    private static Integer getRecordCount(Boolean totalRecCount) 
    {
        new ensxsdk.Logger(null);
        ensxtx_UTIL_SyncHelper.LastSync fromLastSync = new ensxtx_UTIL_SyncHelper.LastSync();
        if (!totalRecCount)
        {
            fromLastSync = ensxtx_UTIL_SyncHelper.getLastSyncFromTable(ScheduleClassName, fromLastSync);
        }
        fromLastSync.pageSize = 1;
        fromLastSync.pageNumber = 1;

        ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SC searchContext = buildSearchContext(fromLastSync);
        ensxtx_SBO_EnosixCustSync_Search sbo = new ensxtx_SBO_EnosixCustSync_Search();
        sbo.search(searchContext);
        System.debug(searchContext.result.isSuccess());
        System.debug(searchContext.pagingOptions.totalRecords);

        return searchContext.pagingOptions.totalRecords;
    }
}