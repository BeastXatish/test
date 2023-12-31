/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:36:05 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
private class ensxtx_TST_EnosixSalesDocFlow_Search
{

    public class Mockensxtx_SBO_EnosixSalesDocFlow_Search implements ensxsdk.EnosixFramework.SearchSBOInitMock, ensxsdk.EnosixFramework.SearchSBOSearchMock
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
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixSalesDocFlow_Search.class, new Mockensxtx_SBO_EnosixSalesDocFlow_Search());
        ensxtx_SBO_EnosixSalesDocFlow_Search sbo = new ensxtx_SBO_EnosixSalesDocFlow_Search();
        System.assertEquals(ensxtx_SBO_EnosixSalesDocFlow_Search.class, sbo.getType(), 'getType() does not match object type.');

        System.assertEquals(null, sbo.initialize(null));
        System.assertEquals(null, sbo.search(null));

        ensxtx_SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SC sc = new ensxtx_SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SC();
        System.assertEquals(ensxtx_SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SC.class, sc.getType(), 'getType() does not match object type.');

        sc.registerReflectionForClass();
        System.assertEquals(null, sc.result);

        System.assertNotEquals(null, sc.SEARCHPARAMS);

    }
    
    
    @isTest
    static void testSEARCHPARAMS()
    {
        ensxtx_SBO_EnosixSalesDocFlow_Search.SEARCHPARAMS childObj = new ensxtx_SBO_EnosixSalesDocFlow_Search.SEARCHPARAMS();
        System.assertEquals(ensxtx_SBO_EnosixSalesDocFlow_Search.SEARCHPARAMS.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        childObj.SalesDocument = 'X';
        System.assertEquals('X', childObj.SalesDocument);

        childObj.CustomerPONumber = 'X';
        System.assertEquals('X', childObj.CustomerPONumber);

        childObj.DocumentCategory = 'X';
        System.assertEquals('X', childObj.DocumentCategory);

        childObj.X_PrecedingDocuments = true;
        System.assertEquals(true, childObj.X_PrecedingDocuments);

        childObj.X_SubsequentDocuments = true;
        System.assertEquals(true, childObj.X_SubsequentDocuments);


    }

    @isTest
    static void testEnosixSalesDocFlow_SR()
    {
        ensxtx_SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SR sr = new ensxtx_SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SR();

        sr.registerReflectionForClass();

        System.assertEquals(ensxtx_SBO_EnosixSalesDocFlow_Search.EnosixSalesDocFlow_SR.class, sr.getType(), 'getType() does not match object type.');

        System.assertNotEquals(null, sr.getResults());
    }


    @isTest
    static void testSEARCHRESULT()
    {
        ensxtx_SBO_EnosixSalesDocFlow_Search.SEARCHRESULT childObj = new ensxtx_SBO_EnosixSalesDocFlow_Search.SEARCHRESULT();
        System.assertEquals(ensxtx_SBO_EnosixSalesDocFlow_Search.SEARCHRESULT.class, childObj.getType(),'getType() does not match object type.');

        childObj.registerReflectionForClass();
        ensxtx_SBO_EnosixSalesDocFlow_Search.SEARCHRESULT_COLLECTION childObjCollection = new ensxtx_SBO_EnosixSalesDocFlow_Search.SEARCHRESULT_COLLECTION();
        System.assertNotEquals(null, childObjCollection.getAsList());

        childObj.SalesDocument = 'X';
        System.assertEquals('X', childObj.SalesDocument);

        childObj.ItemNumber = 'X';
        System.assertEquals('X', childObj.ItemNumber);

        childObj.DocumentCategory = 'X';
        System.assertEquals('X', childObj.DocumentCategory);

        childObj.DocumentCategoryText = 'X';
        System.assertEquals('X', childObj.DocumentCategoryText);

        childObj.CustomerNumber = 'X';
        System.assertEquals('X', childObj.CustomerNumber);

        childObj.CreateDate = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.CreateDate);

        childObj.CreatedBy = 'X';
        System.assertEquals('X', childObj.CreatedBy);

        childObj.DateChanged = Date.valueOf('2020-12-31');
        System.assertEquals(Date.valueOf('2020-12-31'), childObj.DateChanged);

        childObj.ChangedBy = 'X';
        System.assertEquals('X', childObj.ChangedBy);

        childObj.X_PrecedingDocuments = true;
        System.assertEquals(true, childObj.X_PrecedingDocuments);

        childObj.X_SubsequentDocuments = true;
        System.assertEquals(true, childObj.X_SubsequentDocuments);

        childObj.DocumentStatus = 'X';
        System.assertEquals('X', childObj.DocumentStatus);


    }

}