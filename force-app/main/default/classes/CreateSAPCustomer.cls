/**
 * Created by Sreekanth (S2) on 11/12/22.
 * Function: developed to support FLOW "Create SAP Customer" to make SAP Callout
 * Input Account id, Output: SAP customer id and messages
 * Validates the account data, if any validations fails, returns Error messages
 * Prepares payload as per soft mapping
 * Rest Callout to "Create SAP Customer" and returns SAP Customer Id
 * Capture logs in Account 'Create customer Log' field
 */

global with sharing class CreateSAPCustomer {
    static final String ERROR = 'ERROR';
    static final String SUCCESS = 'SUCCESS';

    @InvocableMethod(Label='Create SAP Customer' Description='Create SAP Customer API Callout')
    public static List<Response_CreateSAPCustomer> makeAPICallOut(List<Id> accountIds) {
        Map<Id, Response_CreateSAPCustomer> returnMap = new Map<Id, Response_CreateSAPCustomer>();

        if (accountIds.size() == 0 || accountIds == null) {
            return returnMap.values();
        }else{
            System.debug('Input Accounts :'+accountIds);
        }


        //get callout setting
        OT_CallOut_Setting__mdt calloutSetting = [SELECT Id,Named_Credential__c,Path__c FROM OT_CallOut_Setting__mdt WHERE DeveloperName = 'CreateSAPCustomer'];
        if(calloutSetting == null){
            System.debug('Error : callout setting is not defined in Custom metadata OT_CallOut_Setting__mdt');
            return returnMap.values();
        }
        List<String> queryFieldsAccount = new List<String>{'SAP_ID__c', 'Sales_Area_Defaults_Key__c'};
        List<String> queryFieldsSalesAreaDefaults = new List<String>{'MasterLabel'};
        List<String> fieldsInOrder = new List<String>();
        Map<String, Create_SAP_Customer_Mapping__mdt> fieldMappingCMDT = new Map<String, Create_SAP_Customer_Mapping__mdt>();

        for (Create_SAP_Customer_Mapping__mdt cmdt : [
                SELECT Id, MasterLabel, SF_Source_Object__c, SF_Source_Field__c, Payload_Field_Name__c, Mandatory_Field_In_SAP__c
                FROM Create_SAP_Customer_Mapping__mdt
                ORDER BY MasterLabel DESC ]) {

            switch on cmdt.SF_Source_Object__c {
                when 'Account' {
                    queryFieldsAccount.add(cmdt.SF_Source_Field__c);        //colllect fields for SOQL Query
                }
                when 'Sales_Area_Default__mdt' {
                    queryFieldsSalesAreaDefaults.add(cmdt.SF_Source_Field__c); //colllect fields for SOQL Query
                }
                when else {
                    System.debug('Invalid Source Object in Create_SAP_Customer_Mapping__mdt >> '+cmdt);
                }
            }
            fieldMappingCMDT.put(cmdt.SF_Source_Field__c, cmdt);      //colllect metadata for required fields validation checkpoint
            fieldsInOrder.add(cmdt.SF_Source_Field__c);
        }

        //Get Account data
        String queryAccount = 'SELECT ' + String.join(queryFieldsAccount, ', ') + ' FROM ACCOUNT WHERE ID IN :accountIds';
        Map<Id, Account> accountsMap = new Map<Id, Account>((Account[]) Database.query(queryAccount));

        //Get Sales area defaults data
        List<String> salesAreaDefaultsKeys = new List<String>();
        for (Id accId : accountsMap.keySet()) {
            if (String.isnotblank(accountsMap.get(accId).Sales_Area_Defaults_Key__c)) {
                salesAreaDefaultsKeys.add(accountsMap.get(accId).Sales_Area_Defaults_Key__c);   //collect keys to soql filter sales area default records
            }
        }
        String querySalesAreaDefaults = 'SELECT ' + String.join(queryFieldsSalesAreaDefaults, ', ') + ' FROM Sales_Area_Default__mdt WHERE MasterLabel IN :salesAreaDefaultsKeys';
        Map<String, Sales_Area_Default__mdt> salesAreaDefaultsMap = new Map<String, Sales_Area_Default__mdt>();
        for (Sales_Area_Default__mdt sadefault : Database.query(querySalesAreaDefaults)) {
            System.debug('salesAreaDefaults for '+sadefault.MasterLabel +' >>> ' + +sadefault);
            salesAreaDefaultsMap.put(sadefault.MasterLabel, sadefault); //collect Sales area defaults
        }


        //get fields metadata to capture field labels
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> accountSchema = schemaMap.get('Account').getDescribe().fields.getMap();
        Map<String, Schema.SObjectField> salesAreaSchema = schemaMap.get('Sales_Area_Default__mdt').getDescribe().fields.getMap();
        String accountObjLabel = schemaMap.get('Account').getDescribe().getLabel();
        String salesAreaObjLabel = schemaMap.get('Sales_Area_Default__mdt').getDescribe().getLabel();

        //******************* ************************ *********************** ***********************
        // Process Accounts for Callout
        //******************* ************************ *********************** ***********************
        for (Id accId : accountsMap.keySet()) {

            errorLog.clear();
            apiLog.clear();

            if (!returnMap.containsKey(accId)) {
                returnMap.put(accId, new Response_CreateSAPCustomer(accId, '', '', '', ''));
            }

            //*********** Validations  *********** ??
            //Make sure SAP Id is not populated on the account
            if (accountsMap.get(accId).SAP_ID__c != null) {
                //SAP Id already exists on Account
                logError(System.Label.CreateSAPCustomer_SAPIdalreadyexists);
                returnMap.get(accId).Status = ERROR;
                returnMap.get(accId).ErrorLog = getErrorLog();
                continue;
            }
            //determine if the sales area default key is on the account to determine defaults.
            if (String.isBlank(accountsMap.get(accId).Sales_Area_Defaults_Key__c)) {
                //Sales Area Default Key is not found. Sales Org, Dish Channel, Division might be blank
                logError(System.Label.CreateSAPCustomer_SalesAreaDefaultKeyNotfound);
                returnMap.get(accId).Status = ERROR;
                returnMap.get(accId).ErrorLog = getErrorLog();
                continue;
            }

            map<string, object> mapToSerializePayload = new map<string, object>();

            for (String sourceField : fieldsInOrder) {

                Object fieldValue;          //capture dynamic field value
                String fieldLabel;
                String fieldObject;
                if(fieldMappingCMDT.get(sourceField).SF_Source_Object__c == 'Account'){
                    fieldValue = accountsMap.get(accId).get(sourceField);
                    fieldLabel = accountSchema.get(sourceField).getDescribe().getLabel();
                    fieldObject = accountObjLabel;
                }else if(fieldMappingCMDT.get(sourceField).SF_Source_Object__c == 'Sales_Area_Default__mdt'){
                    System.debug(sourceField);
                    fieldValue = salesAreaDefaultsMap.get(accountsMap.get(accId).Sales_Area_Defaults_Key__c).get(sourceField);
                    fieldLabel = salesAreaSchema.get(sourceField).getDescribe().getLabel();
                    fieldObject = salesAreaObjLabel;
                }

                //*********** check for required field populated  *********** ??
                if(fieldMappingCMDT.get(sourceField).Mandatory_Field_In_SAP__c){
                    if (fieldValue == null) {
                        //Mandatory Field "{0}" on {1} must be completed
                        logError(String.format(System.Label.CreateSAPCustomer_MandatoryFieldError,
                                new List<Object>{ fieldLabel, fieldObject}));
                        returnMap.get(accId).Status = ERROR;
                        returnMap.get(accId).ErrorLog = getErrorLog();
                        continue; //log it as error and skip to next field
                    }
                }
                //*********** Payload Mapping  *********** ??
                //payload mapping to blank value for null
                mapToSerializePayload.put(fieldMappingCMDT.get(sourceField).Payload_Field_Name__c, fieldValue == null ? '':fieldValue);
                System.debug(accId +':' + fieldMappingCMDT.get(sourceField).Payload_Field_Name__c +':' +fieldValue);
            }   //end of fields loop


            //************************************************************
            //CALLOUT - fire callout only if all validations are passed
            if(returnMap.get(accId).Status != ERROR && !mapToSerializePayload.isEmpty()){

                try{
                    String body = JSON.serialize(mapToSerializePayload);
                    System.debug('API REQUEST PAYLOAD  >> ' + body);
                    logAPI('API REQUEST PAYLOAD  >> ' + body);
                    HttpResponse response = RestClient.makeApiCall(
                            calloutSetting.Named_Credential__c,
                            RestClient.HttpVerb.POST,
                            calloutSetting.Path__c,
                            '',
                            body,
                            null
                    );

                    if(response.getStatusCode() == 200){        //SUCCESS PATH
                        System.debug('API RESPONSE PAYLOAD >> ' + response.getBody());
                        logAPI('API RESPONSE PAYLOAD >> ' + response.getBody());
                        returnMap.get(accId).Status = SUCCESS;
                        Map<String,Object> responseMap = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
                        returnMap.get(accId).SAP_CustomerId = (String) responseMap.get('SAP_ID__c');
//                        if(String.isBlank(returnMap.get(accId).SAP_CustomerId)){    //only for unit testing, will need to remvoed when deployment
//                            returnMap.get(accId).SAP_CustomerId = 'DUMMY-'+String.valueOf(Integer.valueof((Math.random() * 199999)));
//                        }
                        returnMap.get(accId).SAP_ExtendedId = (String) responseMap.get('SAP_Extended_Id__c');

                    }else{      //ERROR PATH
                        logError('Integration Callout Error: '+response.getStatus() +' : '+ response.getStatusCode() +' : '+ response.getBody());
                    }
                }catch(System.CalloutException e) {
                    logError('Integration Callout Error: '+ e );
                }
            } //CALLOUT

            if(String.isNotBlank(getErrorLog())){
                returnMap.get(accId).Status = ERROR;
                returnMap.get(accId).ErrorLog = getErrorLog();
            }
            if(String.isNotBlank(getAPILog())){
                returnMap.get(accId).APILog = getAPILog();
            }
        } //accounts loop
        return returnMap.values();
    }


    //************ ERROR LOGGER *********************
    public static List<String> errorLog = new List<String>();
    public static void  logError(String message){
        errorLog.add(message);
        System.debug(message);
    }
    public static String  getErrorLog(){
       return String.join(errorLog,'\n');
    }


    //************ API CALLOUT LOGGER *********************
    public static List<String> apiLog = new List<String>();
    public static void logAPI(String message){
        apiLog.add(message);
        System.debug(message);
    }
    public static String getAPILog(){
        return String.join(apiLog,'<br>'+'************************************************'+'<br>');
    }


    //************ invocable warpper class *********************
    global class Response_CreateSAPCustomer {
        @InvocableVariable
        global Id AccountId;

        @InvocableVariable(Label='SAP Customer Id' Description='SAP Customer Id')
        global String SAP_CustomerId;

        @InvocableVariable(Label='SAP Customer Id' Description='SAP Customer Id')
        global String SAP_ExtendedId;

        @InvocableVariable(Label='Status' Description='Status ERROR || SUCCESS')
        global String Status;

        @InvocableVariable(Label='Error Log' Description='Error Log to show it to User')
        global String ErrorLog;

        @InvocableVariable(Label='Status Log' Description='Status Log to capture on account field')
        global String APILog;

        global Response_CreateSAPCustomer(Id AccountId, String SAP_CustomerId, String SAP_ExtendedId, String APIStatus, String APIError) {
            this.AccountId = AccountId;
            this.SAP_CustomerId = SAP_CustomerId;
            this.SAP_ExtendedId = SAP_ExtendedId;
            this.Status = APIStatus;
            this.ErrorLog = APIError;
        }
    }




}