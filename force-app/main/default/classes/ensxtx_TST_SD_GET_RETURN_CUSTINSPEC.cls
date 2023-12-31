/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class ensxtx_TST_SD_GET_RETURN_CUSTINSPEC
{
    public class Mockensxtx_RFC_SD_GET_RETURN_CUSTINSPEC implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.class, new Mockensxtx_RFC_SD_GET_RETURN_CUSTINSPEC());
        ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC rfc = new ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC();
        ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.RESULT funcObj = new ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        //Check all the collections
        funcObj.getCollection(ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_CUST_INSPECTION.class).add(new ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_CUST_INSPECTION());
        System.assertEquals(1,funcObj.ET_CUST_INSPECTION_List.size());

        funcObj.getCollection(ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_ORDER_REASON.class).add(new ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_ORDER_REASON());
        System.assertEquals(1,funcObj.ET_ORDER_REASON_List.size());

        funcObj.getCollection(ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_REFUND_TYPE.class).add(new ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_REFUND_TYPE());
        System.assertEquals(1,funcObj.ET_REFUND_TYPE_List.size());

        funcObj.getCollection(ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_RETURN_REASON.class).add(new ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_RETURN_REASON());
        System.assertEquals(1,funcObj.ET_RETURN_REASON_List.size());

    }

    @isTest
    static void testET_CUST_INSPECTION()
    {
        ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_CUST_INSPECTION funcObj = new ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_CUST_INSPECTION();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_CUST_INSPECTION.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.CODE = 'X';
        System.assertEquals('X', funcObj.CODE);

        funcObj.CODE_TEXT = 'X';
        System.assertEquals('X', funcObj.CODE_TEXT);

    }
    @isTest
    static void testET_ORDER_REASON()
    {
        ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_ORDER_REASON funcObj = new ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_ORDER_REASON();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_ORDER_REASON.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.AUGRU = 'X';
        System.assertEquals('X', funcObj.AUGRU);

        funcObj.BEZEI = 'X';
        System.assertEquals('X', funcObj.BEZEI);

    }
    @isTest
    static void testET_REFUND_TYPE()
    {
        ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_REFUND_TYPE funcObj = new ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_REFUND_TYPE();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_REFUND_TYPE.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.REFUND_TYPE = 'X';
        System.assertEquals('X', funcObj.REFUND_TYPE);

        funcObj.REFUND_TYPE_TEXT = 'X';
        System.assertEquals('X', funcObj.REFUND_TYPE_TEXT);

    }
    @isTest
    static void testET_RETURN_REASON()
    {
        ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_RETURN_REASON funcObj = new ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_RETURN_REASON();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_RETURN_CUSTINSPEC.ET_RETURN_REASON.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.RET_REASON = 'X';
        System.assertEquals('X', funcObj.RET_REASON);

        funcObj.BEZEI = 'X';
        System.assertEquals('X', funcObj.BEZEI);

    }
}