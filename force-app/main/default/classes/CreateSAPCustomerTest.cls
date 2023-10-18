/**
 * Created by Sreekanth (S2) on 11/18/22.
 * Tes "Create SAP Customer" to make SAP Callout
 * Input Account id, Output: SAP customer id and messages
 * Validates the account data, if any validations fails, returns Error messages
 * Prepares payload as per soft mapping
 * Rest Callout to "Create SAP Customer" and returns SAP Customer Id
 * Capture logs in Account 'Create customer Log' field
 */

@IsTest
public with sharing class CreateSAPCustomerTest {
    @TestSetup
    private static void testSetup() {
        Id prospectRTId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('FRAG_Prospect').getRecordTypeId();

        Skip_Execution__c cs = new Skip_Execution__c();
        cs.Active__c = true;
        insert cs;
        List<Account> accounts = new List<Account>();

        //get sales area default defined in Custom metadata
        String saleaAreaDefaultKey =  [select Id,MasterLabel from Sales_Area_Default__mdt LIMIT 1].MasterLabel;
        if(String.isBlank(saleaAreaDefaultKey)){
            System.debug('ERROR : Sales Area Defaults Custom Metadata is Blank' );
        }
        String salesOrg = saleaAreaDefaultKey.substring(0,4);
        String distChannel = saleaAreaDefaultKey.substring(5,7);
        String divison = saleaAreaDefaultKey.substring(8,10);

        //Scenario 1: Error 'SAP Id already exists, prospect invalid to send to SAP'
        accounts.add(new Account(
                Name            = 'InValid Account 1',
                RecordTypeId    = prospectRTId,
                SAP_ID__c       = 'SAP123'
        ));

        //Scenario 2: Error 'Sales Area Default Key is not found. Sales Org, Dish Channel, Division might be blank'
        accounts.add(new Account(
                Name            = 'InValid Account 2',
                RecordTypeId    = prospectRTId
        ));

        //Scenario 3: Error 'Mandatory field is not completed'
        accounts.add(new Account(
                Name                = 'InValid Account 3',
                RecordTypeId        = prospectRTId,
                Sales_Org__c        = SalesOrg,
                Dist_Channel__c     = distChannel,
                Division__c         = divison
        ));

        //Scenario 4: Happy path , good account with all required fields
        Account goodAccount = new Account(
                Name                    = 'Good Account 1',
                RecordTypeId            = prospectRTId,
                Sales_Org__c            = SalesOrg,
                Dist_Channel__c         = distChannel,
                Dist_Channel_KNVV__c    = distChannel,
                Division__c             = divison,
                ShippingCountryCode     = 'US',
                Sales_Office__c         = '0020',
                Communication_Language__c = 'EN',
                Account_group__c        = '0001',
                Payment_Terms__c        = 'N120',
                Incoterms_1__c          = 'CFR',
                ShippingTimeZone__c     = 'UTC'
        );
        //fill in ACCOUNT required field as per custom metadata settings (picklist values should be hardcoded above)
        for (Create_SAP_Customer_Mapping__mdt cmdt : [
                SELECT Id, SF_Source_Object__c, SF_Source_Field__c, Mandatory_Field_In_SAP__c
                FROM Create_SAP_Customer_Mapping__mdt
                WHERE SF_Source_Object__c = 'Account' AND Mandatory_Field_In_SAP__c = TRUE]) {

            if(goodAccount.get(cmdt.SF_Source_Field__c) == null) {
                goodAccount.put(cmdt.SF_Source_Field__c, 'Test Value');
                System.debug(cmdt.SF_Source_Field__c + ' Test Value');
            }
        }

        accounts.add(goodAccount);
        insert accounts;        //create prospect accounts
        System.debug('Accounts Test Data : ' + accounts);

    }

    // Test all possible scenarios
    @IsTest
    private static void createSAPCustomer_AllCases() {
        //retreive test accounts
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id,Name,Sales_Area_Defaults_Key__c FROM Account]);
        System.debug(accountMap);
        //Set REST API Mockup
        Test.setMock(HttpCalloutMock.class, new HTTPMockFactory(200, 'OK', '{"SAP_ID__c" : "SAP123" }', new Map<String,String>()));
        List<CreateSAPCustomer.Response_CreateSAPCustomer> resultList = new List<CreateSAPCustomer.Response_CreateSAPCustomer>();
        //Fire Test
        Test.startTest();
            resultList = CreateSAPCustomer.makeAPICallOut(new List<Id>(accountMap.keySet()));
        Test.stopTest();

        //Check for assertioons for various use cases
        Assert.areEqual(true,resultList.size() > 0, 'Response is invalid');
        for(CreateSAPCustomer.Response_CreateSAPCustomer res : resultList){
            System.debug(accountMap.get(res.AccountId).Name + ' Result >> '+res);
            switch on accountMap.get(res.AccountId).Name{
                when 'InValid Account 1' {          //Test case: Error 'SAP Id already exists'
                    Assert.areEqual(System.Label.CreateSAPCustomer_SAPIdalreadyexists,res.ErrorLog, 'SAP Id already exists Error failed');
                }
                when 'InValid Account 2' {          //Test case: Error 'Sales Area Default Key is not found. Sales Org, Dish Channel, Division might be blank'
                    Assert.areEqual(System.Label.CreateSAPCustomer_SalesAreaDefaultKeyNotfound, res.ErrorLog, 'Sales Area Defaults Key Determination Error failed');
                }
                when 'InValid Account 3' {          // Test case: Error 'Mandatory field is not completed'
                    Assert.isTrue(res.ErrorLog.contains('Mandatory Field'), 'Sales Area Defaults Key Determination Error failed');
                }
                when 'Good Account 1' {             // Test case: Good Account, create SAP Customer call out
                    Assert.areEqual('SAP123',res.SAP_CustomerId, 'SAP Customer Id assert failed');
                }
                when else {
                    Assert.fail('Test Data Error');
                }
            }
        }
    }
}