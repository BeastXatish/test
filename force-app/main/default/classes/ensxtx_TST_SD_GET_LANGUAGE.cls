/// enosiX Inc. Generated Apex Model
/// Generated On: 5/19/2022 8:08:43 PM
/// SAP Host: From REST Service On: https://knf--enosixdev.my.salesforce.com
/// CID: From REST Service On: https://knf--enosixdev.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class ensxtx_TST_SD_GET_LANGUAGE
{
    public class Mockensxtx_RFC_SD_GET_LANGUAGE implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_LANGUAGE.class, new Mockensxtx_RFC_SD_GET_LANGUAGE());
        ensxtx_RFC_SD_GET_LANGUAGE rfc = new ensxtx_RFC_SD_GET_LANGUAGE();
        ensxtx_RFC_SD_GET_LANGUAGE.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        ensxtx_RFC_SD_GET_LANGUAGE.RESULT funcObj = new ensxtx_RFC_SD_GET_LANGUAGE.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_LANGUAGE.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        //Check all the collections
        funcObj.getCollection(ensxtx_RFC_SD_GET_LANGUAGE.ET_LANG.class).add(new ensxtx_RFC_SD_GET_LANGUAGE.ET_LANG());
        System.assertEquals(1,funcObj.ET_LANG_List.size());

    }

    @isTest
    static void testET_LANG()
    {
        ensxtx_RFC_SD_GET_LANGUAGE.ET_LANG funcObj = new ensxtx_RFC_SD_GET_LANGUAGE.ET_LANG();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_SD_GET_LANGUAGE.ET_LANG.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.LAISO = 'X';
        System.assertEquals('X', funcObj.LAISO);

        funcObj.SPTXT = 'X';
        System.assertEquals('X', funcObj.SPTXT);

    }
}