/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class ensxtx_TST_SD_GET_PERIO
{
    public class Mockensxtx_RFC_SD_GET_PERIO implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_PERIO.class, new Mockensxtx_RFC_SD_GET_PERIO());
        ensxtx_RFC_SD_GET_PERIO rfc = new ensxtx_RFC_SD_GET_PERIO();
        ensxtx_RFC_SD_GET_PERIO.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        ensxtx_RFC_SD_GET_PERIO.RESULT funcObj = new ensxtx_RFC_SD_GET_PERIO.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_PERIO.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        //Check all the collections
        funcObj.getCollection(ensxtx_RFC_SD_GET_PERIO.OUTPUT.class).add(new ensxtx_RFC_SD_GET_PERIO.OUTPUT());
        System.assertEquals(1,funcObj.OUTPUT_List.size());

    }

    @isTest
    static void testOUTPUT()
    {
        ensxtx_RFC_SD_GET_PERIO.OUTPUT funcObj = new ensxtx_RFC_SD_GET_PERIO.OUTPUT();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_PERIO.OUTPUT.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.PERIO = 'X';
        System.assertEquals('X', funcObj.PERIO);

        funcObj.BEZEICH = 'X';
        System.assertEquals('X', funcObj.BEZEICH);

    }
}