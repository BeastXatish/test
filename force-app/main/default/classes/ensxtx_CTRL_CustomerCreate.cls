public class ensxtx_CTRL_CustomerCreate {

    private static final ensxsdk.Logger logger = new ensxsdk.Logger(ensxtx_CTRL_CustomerCreate.class);

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response initSFObject(Id recordId)
    {
        logger.enterAura('initSFObject', new Map<String, Object>{
            'recordId' => recordId
        });

        ensxtx_UTIL_CustomerCreate.SFObject result = new ensxtx_UTIL_CustomerCreate.SFObject();
        SObject sfSObject = ensxtx_UTIL_SFSObjectDoc.getSObject(recordId);

        if (sfSObject == null) {
           sfSObject = ensxtx_UTIL_CustomerCreate.getSFAccountInfo(recordId);
        }
        else
        {
            Id accountId = ensxtx_UTIL_SFSObjectDoc.getAccountId(sfSObject);
            sfSObject = ensxtx_UTIL_CustomerCreate.getSFAccountInfo(accountId);
        }

        result.sfMainObject = sfSObject;
        result.status = 'Create';
        result.createType = ensxtx_UTIL_CustomerCreate.CUSTOMER_TYPE;
        String parentId = (String) sfSObject.get('ParentId');

        if (String.isNotEmpty(parentId)) {
            result.createType = ensxtx_UTIL_CustomerCreate.PARTNER_TYPE;
            SObject parentSFObject = ensxtx_UTIL_CustomerCreate.getSFAccountInfo(parentId);
            result.parentCustomerNumber = (String) parentSFObject.get(ensxtx_UTIL_SFAccount.CustomerFieldName);
        }
        result.customerNumber = (String) sfSObject.get(ensxtx_UTIL_SFAccount.CustomerFieldName);

        return ensxtx_UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response initializeCustomerDetail(ensxtx_UTIL_CustomerCreate.SFObject sfSObject, ensxtx_DS_Customer_Detail customerDetail)
    {
        logger.enterAura('initializeCustomerDetail', null);

        try
        {
            ensxsdk.EnosixFramework.DetailSBO sbo = initializeSBODetail();
            ensxsdk.EnosixFramework.DetailObject result = ensxtx_UTIL_CustomerCreate.convertToSBO(null, customerDetail, sfSobject, 'initialize');
            result = sbo.executeCommand('CMD_APPLY_EDITS', result);

            ensxtx_UTIL_CustomerCreate.convertToObject(result, customerDetail);

        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
            return ensxtx_UTIL_Aura.createResponse(null);
        }

        return ensxtx_UTIL_Aura.createResponse(customerDetail);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response initCustomerDetailFromSFObject(ensxtx_DS_Customer_Detail customerDetail,
        SObject sfObject)
    {
        logger.enterAura('initCustomerDetailFromSFObject', new Map<String, Object>{
            'customerDetail' => customerDetail,
            'sfObject' => sfObject
        });

        try
        {
            ensxtx_DS_Customer_Detail newCustomerDetail = ensxtx_UTIL_CustomerCreate.mapCustomerDetailFromSFObject(customerDetail, sfObject);
            if (newCustomerDetail != null) customerDetail = newCustomerDetail;
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
            return ensxtx_UTIL_Aura.createResponse(null);
        }

        return ensxtx_UTIL_Aura.createResponse(customerDetail);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response getCountries()
    {
        logger.enterAura('getCountries', null);

        ensxtx_RFC_SD_GET_COUNTRIES.RESULT result;
        try
        {
            ensxtx_RFC_SD_GET_COUNTRIES rfc = new ensxtx_RFC_SD_GET_COUNTRIES();
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
            return ensxtx_UTIL_Aura.createResponse(null);
        }

        return ensxtx_UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response getLanguage()
    {
        logger.enterAura('getLanguage', null);

        ensxtx_RFC_SD_GET_LANGUAGE.RESULT result;
        try
        {
            ensxtx_RFC_SD_GET_LANGUAGE rfc = new ensxtx_RFC_SD_GET_LANGUAGE();
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
            return ensxtx_UTIL_Aura.createResponse(null);
        }

        return ensxtx_UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response getDropDownValues(String cmpnyCode, String sOrg, String distChan, Boolean fromMaincmp)
    {
        logger.enterAura('getDropDownValues', null);

        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.RESULT result;
        try
        {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES rfc = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES();
            if(fromMaincmp){
                rfc.PARAMS.IV_VKORG = sOrg;
                rfc.PARAMS.IV_VTWEG = distChan;
                rfc.PARAMS.IV_CUST_GRP = true;
                rfc.PARAMS.IV_DEL_PLANT = true;
                rfc.PARAMS.IV_DEL_PRIO = true;
            }
            else{
                rfc.PARAMS.IV_BUKRS = cmpnyCode;
                rfc.PARAMS.IV_ACC_STMT = true;
                rfc.PARAMS.IV_CASH_MGT_GRP = true;
                rfc.PARAMS.IV_COMP_SORT_KEY = true;
                rfc.PARAMS.IV_DUNNING_CLERK = true;
                rfc.PARAMS.IV_DUNNING_PROC = true;
                rfc.PARAMS.IV_TOLERANCE_GRP = true;
            }

            result = rfc.execute();
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
            return ensxtx_UTIL_Aura.createResponse(null);
        }

        return ensxtx_UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response getSalesAreas()
    {
        logger.enterAura('getSalesAreas', null);

        ensxtx_RFC_SD_GET_SALES_AREAS.RESULT result;
        try
        {
            ensxtx_RFC_SD_GET_SALES_AREAS rfc = new ensxtx_RFC_SD_GET_SALES_AREAS();
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
            return ensxtx_UTIL_Aura.createResponse(null);
        }

        return ensxtx_UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response getGroupOffice()
    {
        logger.enterAura('getGroupOffice', null);

        ensxtx_RFC_SD_GET_GROUP_OFFICE.RESULT result;
        try
        {
            ensxtx_RFC_SD_GET_GROUP_OFFICE rfc = new ensxtx_RFC_SD_GET_GROUP_OFFICE();
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
            return ensxtx_UTIL_Aura.createResponse(null);
        }

        return ensxtx_UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response getPricingStat()
    {
        logger.enterAura('getPricingStat', null);

        ensxtx_RFC_SD_GET_PRICING_STAT.RESULT result;
        try
        {
            ensxtx_RFC_SD_GET_PRICING_STAT rfc = new ensxtx_RFC_SD_GET_PRICING_STAT();
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
            return ensxtx_UTIL_Aura.createResponse(null);
        }

        return ensxtx_UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response getShipInfo()
    {
        logger.enterAura('getShipInfo', null);

        ensxtx_RFC_SD_GET_SHIP_INFO.RESULT result;
        try
        {
            ensxtx_RFC_SD_GET_SHIP_INFO rfc = new ensxtx_RFC_SD_GET_SHIP_INFO();
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
            return ensxtx_UTIL_Aura.createResponse(null);
        }

        return ensxtx_UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response getCurrency()
    {
        logger.enterAura('getCurrency', null);

        ensxtx_RFC_SD_GET_CURRENCY_LIST.RESULT result;
        try
        {
            ensxtx_RFC_SD_GET_CURRENCY_LIST rfc = new ensxtx_RFC_SD_GET_CURRENCY_LIST();
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
            return ensxtx_UTIL_Aura.createResponse(null);
        }

        return ensxtx_UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response getCompanyCodes()
    {
        logger.enterAura('getCompanyCodes', null);

        ensxtx_RFC_SD_GET_COMPANY_CODES.RESULT result;
        try
        {
            ensxtx_RFC_SD_GET_COMPANY_CODES rfc = new ensxtx_RFC_SD_GET_COMPANY_CODES();
            result = rfc.execute();
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
            return ensxtx_UTIL_Aura.createResponse(null);
        }

        return ensxtx_UTIL_Aura.createResponse(result);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response getCustomerDetail(String customerNumber)
    {
        logger.enterAura('getCustomerDetail', new Map<String, Object>{
            'customerNumber' => customerNumber
        });

        ensxsdk.EnosixFramework.DetailSBO sbo = initializeSBODetail();
        ensxtx_DS_Customer_Detail customerDetail = new ensxtx_DS_Customer_Detail();

        try
        {
            Integer startCpu = Limits.getCpuTime();
            Integer startHeap = Limits.getHeapSize();
            System.debug('Start getCpuTime(): '+ startCpu);
            System.debug('Start getHeapSize(): '+ startHeap);
            DateTime startTimer = System.now();
            System.debug('Start Timer: '+ startTimer);

            ensxsdk.EnosixFramework.DetailObject result = sbo.executeGetDetail(customerNumber);

            DateTime endTimer = System.now();
            System.debug('End Timer: '+ endTimer);
            System.debug('MilliSecond Create: ' + (endTimer.getTime() - startTimer.getTime()));

            ensxtx_UTIL_CustomerCreate.convertToObject(result, customerDetail);
            ensxtx_UTIL_PageMessages.addFrameworkMessages(result.getMessages());

            Integer endCpu = Limits.getCpuTime();
            Integer endHeap = Limits.getHeapSize();
            System.debug('End getHeapSize(): '+ endHeap);
            System.debug('End getCpuTime(): '+ endCpu);
            System.debug('Heap diff: ' + (endHeap - startHeap));
            System.debug('CPU diff: ' + (endCpu - startCpu));
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
        }

        return ensxtx_UTIL_Aura.createResponse(customerDetail);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response createSAPCustomer(ensxtx_UTIL_CustomerCreate.SFObject sfSObject,
        ensxtx_DS_Customer_Detail customerDetail)
    {
        logger.enterAura('createSAPCustomer', new Map<String, Object>{
            'sfObject' => sfSObject,
            'customerDetail' => customerDetail
        });

        if (customerDetail == null) return ensxtx_UTIL_Aura.createResponse(null);

        ensxsdk.EnosixFramework.DetailSBO sbo = initializeSBODetail();

        try
        {
            Integer startCpu = Limits.getCpuTime();
            Integer startHeap = Limits.getHeapSize();
            System.debug('Start getCpuTime(): '+ startCpu);
            System.debug('Start getHeapSize(): '+ startHeap);
            ensxsdk.EnosixFramework.DetailObject result = ensxtx_UTIL_CustomerCreate.convertToSBO(null, customerDetail, sfSobject, 'create');
            DateTime startTimer = System.now();
            System.debug('Start Timer: '+ startTimer);

            result = sbo.executeSave(result);
            System.debug('pk result 2 is '+result);
            DateTime endTimer = System.now();
            System.debug('End Timer: '+ endTimer);
            System.debug('MilliSecond Create: ' + (endTimer.getTime() - startTimer.getTime()));

            ensxtx_UTIL_CustomerCreate.convertToObject(result, customerDetail);
            ensxtx_UTIL_PageMessages.addFrameworkMessages(result.getMessages());

            if (sfSObject.createType == ensxtx_UTIL_CustomerCreate.PARTNER_TYPE) {
                ensxtx_UTIL_CustomerCreate.addPartnerToParentCustomer((ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer) result,
                    sfSObject.parentCustomerNumber, ensxtx_UTIL_Customer.SHIP_TO_PARTNER_CODE);
            }

            if (customerDetail.IsSuccess) {
                ensxtx_UTIL_CustomerCreate.saveCustomerInfoToSObject(customerDetail.CustomerNumber, sfSObject.sfMainObject);
            }

            Integer endCpu = Limits.getCpuTime();
            Integer endHeap = Limits.getHeapSize();
            System.debug('End getHeapSize(): '+ endHeap);
            System.debug('End getCpuTime(): '+ endCpu);
            System.debug('Heap diff: ' + (endHeap - startHeap));
            System.debug('CPU diff: ' + (endCpu - startCpu));
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
        }

        return ensxtx_UTIL_Aura.createResponse(customerDetail);
    }

    @AuraEnabled
    public static ensxtx_UTIL_Aura.Response updateSAPCustomer(ensxtx_UTIL_CustomerCreate.SFObject sfSObject,
        ensxtx_DS_Customer_Detail customerDetail)
    {
        logger.enterAura('updateSAPCustomer', new Map<String, Object>{
            'sfObject' => sfSObject,
            'customerDetail' => customerDetail
        });

        if (customerDetail == null) return ensxtx_UTIL_Aura.createResponse(null);

        ensxsdk.EnosixFramework.DetailSBO sbo = initializeSBODetail();

        try
        {
            Integer startCpu = Limits.getCpuTime();
            Integer startHeap = Limits.getHeapSize();
            System.debug('Start getCpuTime(): '+ startCpu);
            System.debug('Start getHeapSize(): '+ startHeap);
            ensxsdk.EnosixFramework.DetailObject result = sbo.executeGetDetail(sfSObject.customerNumber);
            result = ensxtx_UTIL_CustomerCreate.convertToSBO(result, customerDetail, sfSobject, 'update');
            DateTime startTimer = System.now();
            System.debug('Start Timer: '+ startTimer);

            result = sbo.executeSave(result);
            System.debug('pk result 2 is '+result);
            DateTime endTimer = System.now();
            System.debug('End Timer: '+ endTimer);
            System.debug('MilliSecond Create: ' + (endTimer.getTime() - startTimer.getTime()));

            ensxtx_UTIL_CustomerCreate.convertToObject(result, customerDetail);
            ensxtx_UTIL_PageMessages.addFrameworkMessages(result.getMessages());

            if (sfSObject.createType == ensxtx_UTIL_CustomerCreate.PARTNER_TYPE) {
                ensxtx_UTIL_CustomerCreate.addPartnerToParentCustomer((ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer) result,
                    sfSObject.parentCustomerNumber, ensxtx_UTIL_Customer.SHIP_TO_PARTNER_CODE);
            }

            if (customerDetail.IsSuccess) {
                ensxtx_UTIL_CustomerCreate.saveCustomerInfoToSObject(customerDetail.CustomerNumber, sfSObject.sfMainObject);
            }

            Integer endCpu = Limits.getCpuTime();
            Integer endHeap = Limits.getHeapSize();
            System.debug('End getHeapSize(): '+ endHeap);
            System.debug('End getCpuTime(): '+ endCpu);
            System.debug('Heap diff: ' + (endHeap - startHeap));
            System.debug('CPU diff: ' + (endCpu - startCpu));
        }
        catch (Exception ex)
        {
            ensxtx_UTIL_PageMessages.addExceptionMessage(ex);
        }

        return ensxtx_UTIL_Aura.createResponse(customerDetail);
    }

    private static ensxsdk.EnosixFramework.DetailSBO initializeSBODetail()
    {
        String className = 'ensxtx_SBO_EnosixCustomer_Detail';
        System.Type detailType = Type.forName(className);
        return (ensxsdk.EnosixFramework.DetailSBO) detailType.newInstance();
    }
}