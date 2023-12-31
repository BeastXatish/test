/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class ensxtx_TST_SD_GET_SALES_AREAS
{
    public class Mockensxtx_RFC_SD_GET_SALES_AREAS implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_SALES_AREAS.class, new Mockensxtx_RFC_SD_GET_SALES_AREAS());
        ensxtx_RFC_SD_GET_SALES_AREAS rfc = new ensxtx_RFC_SD_GET_SALES_AREAS();
        ensxtx_RFC_SD_GET_SALES_AREAS.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        ensxtx_RFC_SD_GET_SALES_AREAS.RESULT funcObj = new ensxtx_RFC_SD_GET_SALES_AREAS.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_SALES_AREAS.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        //Check all the collections
        funcObj.getCollection(ensxtx_RFC_SD_GET_SALES_AREAS.SalesAreas.class).add(new ensxtx_RFC_SD_GET_SALES_AREAS.SalesAreas());
        System.assertEquals(1,funcObj.SalesAreas_List.size());

    }

    @isTest
    static void testSalesAreas()
    {
        ensxtx_RFC_SD_GET_SALES_AREAS.SalesAreas funcObj = new ensxtx_RFC_SD_GET_SALES_AREAS.SalesAreas();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_SALES_AREAS.SalesAreas.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.SalesOrganization = 'X';
        System.assertEquals('X', funcObj.SalesOrganization);

        funcObj.SalesOrganizationName = 'X';
        System.assertEquals('X', funcObj.SalesOrganizationName);

        funcObj.DistributionChannel = 'X';
        System.assertEquals('X', funcObj.DistributionChannel);

        funcObj.DistributionChannelName = 'X';
        System.assertEquals('X', funcObj.DistributionChannelName);

        funcObj.Division = 'X';
        System.assertEquals('X', funcObj.Division);

        funcObj.DivisionName = 'X';
        System.assertEquals('X', funcObj.DivisionName);

    }
}