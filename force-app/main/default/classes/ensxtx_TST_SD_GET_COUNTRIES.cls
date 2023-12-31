/// enosiX Inc. Generated Apex Model
/// Generated On: 8/5/2020 5:50:36 PM
/// SAP Host: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// CID: From REST Service On: https://platform-force-5128-dev-ed.cs95.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class ensxtx_TST_SD_GET_COUNTRIES
{
    public class Mockensxtx_RFC_SD_GET_COUNTRIES implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_COUNTRIES.class, new Mockensxtx_RFC_SD_GET_COUNTRIES());
        ensxtx_RFC_SD_GET_COUNTRIES rfc = new ensxtx_RFC_SD_GET_COUNTRIES();
        ensxtx_RFC_SD_GET_COUNTRIES.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        ensxtx_RFC_SD_GET_COUNTRIES.RESULT funcObj = new ensxtx_RFC_SD_GET_COUNTRIES.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_COUNTRIES.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        //Check all the collections
        funcObj.getCollection(ensxtx_RFC_SD_GET_COUNTRIES.ET_OUTPUT.class).add(new ensxtx_RFC_SD_GET_COUNTRIES.ET_OUTPUT());
        System.assertEquals(1,funcObj.ET_OUTPUT_List.size());

        funcObj.getCollection(ensxtx_RFC_SD_GET_COUNTRIES.ET_REGIONS.class).add(new ensxtx_RFC_SD_GET_COUNTRIES.ET_REGIONS());
        System.assertEquals(1,funcObj.ET_REGIONS_List.size());

    }

    @isTest
    static void testET_OUTPUT()
    {
        ensxtx_RFC_SD_GET_COUNTRIES.ET_OUTPUT funcObj = new ensxtx_RFC_SD_GET_COUNTRIES.ET_OUTPUT();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_COUNTRIES.ET_OUTPUT.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.MANDT = 'X';
        System.assertEquals('X', funcObj.MANDT);

        funcObj.SPRAS = 'X';
        System.assertEquals('X', funcObj.SPRAS);

        funcObj.LAND1 = 'X';
        System.assertEquals('X', funcObj.LAND1);

        funcObj.LANDX = 'X';
        System.assertEquals('X', funcObj.LANDX);

        funcObj.NATIO = 'X';
        System.assertEquals('X', funcObj.NATIO);

        funcObj.LANDX50 = 'X';
        System.assertEquals('X', funcObj.LANDX50);

        funcObj.NATIO50 = 'X';
        System.assertEquals('X', funcObj.NATIO50);

        funcObj.PRQ_SPREGT = 'X';
        System.assertEquals('X', funcObj.PRQ_SPREGT);

    }
    @isTest
    static void testET_REGIONS()
    {
        ensxtx_RFC_SD_GET_COUNTRIES.ET_REGIONS funcObj = new ensxtx_RFC_SD_GET_COUNTRIES.ET_REGIONS();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_COUNTRIES.ET_REGIONS.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.LAND1 = 'X';
        System.assertEquals('X', funcObj.LAND1);

        funcObj.REGIO = 'X';
        System.assertEquals('X', funcObj.REGIO);

        funcObj.BEZEI = 'X';
        System.assertEquals('X', funcObj.BEZEI);

    }
}