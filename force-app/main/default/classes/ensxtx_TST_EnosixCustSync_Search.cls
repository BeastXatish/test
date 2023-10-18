/// enosiX Inc. Generated Apex Model
/// Generated On: 6/8/2022 6:38:21 PM
/// SAP Host: From REST Service On: https://oregontool--sfd.my.salesforce.com
/// CID: From REST Service On: https://oregontool--sfd.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class ensxtx_TST_EnosixCustSync_Search
{

    public class Mockensxtx_SBO_EnosixCustSync_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
    {
        public ensxsdk.EnosixFramework.SearchContext executeInitialize(ensxsdk.EnosixFramework.SearchContext sc)
        {
            return null;
        }
        public ensxsdk.EnosixFramework.SearchContext executeSearch(ensxsdk.EnosixFramework.SearchContext sc)
        {
            return null;
        }
    }

    @isTest
    static void testSBO()
    {
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixCustSync_Search.class, new Mockensxtx_SBO_EnosixCustSync_Search());
        ensxtx_SBO_EnosixCustSync_Search sbo = new ensxtx_SBO_EnosixCustSync_Search();
        System.assertEquals(ensxtx_SBO_EnosixCustSync_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SC sc = new ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SC();
        System.assertEquals(ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);
        System.assertNotEquals(null, sc.ACCOUNT_GROUPS);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        ensxtx_SBO_EnosixCustSync_Search.SEARCHPARAMS childObj = new ensxtx_SBO_EnosixCustSync_Search.SEARCHPARAMS();
        System.assertEquals(ensxtx_SBO_EnosixCustSync_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.DateFrom = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateFrom);

        childObj.DateTo = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateTo);

        childObj.InitialLoad = true;
        System.assertEquals(true, childObj.InitialLoad);


    }

    @isTest
    static void testACCOUNT_GROUPS()
    {
        ensxtx_SBO_EnosixCustSync_Search.ACCOUNT_GROUPS childObj = new ensxtx_SBO_EnosixCustSync_Search.ACCOUNT_GROUPS();
        System.assertEquals(ensxtx_SBO_EnosixCustSync_Search.ACCOUNT_GROUPS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        ensxtx_SBO_EnosixCustSync_Search.ACCOUNT_GROUPS_COLLECTION childObjCollection = new ensxtx_SBO_EnosixCustSync_Search.ACCOUNT_GROUPS_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.AccountGroup = 'X';
        System.assertEquals('X', childObj.AccountGroup);


    }

    @isTest
    static void testEnosixCustSync_SR()
    {
        ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SR sr = new ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SR();

        sr.registerReflectionForClass();

        System.assertEquals(ensxtx_SBO_EnosixCustSync_Search.EnosixCustSync_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT childObj = new ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT();
        System.assertEquals(ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT_COLLECTION childObjCollection = new ensxtx_SBO_EnosixCustSync_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.DeleteIndicator = true;
        System.assertEquals(true, childObj.DeleteIndicator);

        childObj.AccountGroup = 'X';
        System.assertEquals('X', childObj.AccountGroup);

        childObj.CustomerNumber = 'X';
        System.assertEquals('X', childObj.CustomerNumber);

        childObj.Name = 'X';
        System.assertEquals('X', childObj.Name);

        childObj.Name2 = 'X';
        System.assertEquals('X', childObj.Name2);

        childObj.Name3 = 'X';
        System.assertEquals('X', childObj.Name3);

        childObj.Name4 = 'X';
        System.assertEquals('X', childObj.Name4);

        childObj.Street = 'X';
        System.assertEquals('X', childObj.Street);

        childObj.Street2 = 'X';
        System.assertEquals('X', childObj.Street2);

        childObj.Street3 = 'X';
        System.assertEquals('X', childObj.Street3);

        childObj.Street4 = 'X';
        System.assertEquals('X', childObj.Street4);

        childObj.AssetLocation = 'X';
        System.assertEquals('X', childObj.AssetLocation);

        childObj.HouseNumber = 'X';
        System.assertEquals('X', childObj.HouseNumber);

        childObj.PostalCode = 'X';
        System.assertEquals('X', childObj.PostalCode);

        childObj.City = 'X';
        System.assertEquals('X', childObj.City);

        childObj.Country = 'X';
        System.assertEquals('X', childObj.Country);

        childObj.Region = 'X';
        System.assertEquals('X', childObj.Region);

        childObj.POBox = 'X';
        System.assertEquals('X', childObj.POBox);

        childObj.POBoxPostalCode = 'X';
        System.assertEquals('X', childObj.POBoxPostalCode);

        childObj.TelephoneNumber = 'X';
        System.assertEquals('X', childObj.TelephoneNumber);

        childObj.EMailAddress = 'X';
        System.assertEquals('X', childObj.EMailAddress);

        childObj.ChangeDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.ChangeDate);

        childObj.ChangeTime = Time.newInstance(1,1,1,0);
        System.assertEquals(Time.newInstance(1,1,1,0), childObj.ChangeTime);


    }

}