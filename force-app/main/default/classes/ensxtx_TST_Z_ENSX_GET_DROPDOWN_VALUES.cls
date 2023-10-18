/// enosiX Inc. Generated Apex Model
/// Generated On: 8/17/2022 8:19:47 PM
/// SAP Host: From REST Service On: https://oregontool--sfd.my.salesforce.com
/// CID: From REST Service On: https://oregontool--sfd.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

@isTest
public with sharing class ensxtx_TST_Z_ENSX_GET_DROPDOWN_VALUES
{
    public class Mockensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES implements ensxsdk.EnosixFramework.RFCMock
    {
        public ensxsdk.EnosixFramework.FunctionObject executeFunction() 
        {
            return null;
        }
    }

    @isTest
    static void testExecute()
    {
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.class, new Mockensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES());
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES rfc = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES();
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.RESULT params = rfc.PARAMS;
        System.assertEquals(null, rfc.execute());
    }

    @isTest
    static void testRESULT()
    {
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.RESULT funcObj = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.RESULT();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.RESULT.class, funcObj.getType(), 'getType() does not match object type.');

        funcObj.IV_ACC_STMT = true;
        System.assertEquals(true, funcObj.IV_ACC_STMT);

        funcObj.IV_BUKRS = 'X';
        System.assertEquals('X', funcObj.IV_BUKRS);

        funcObj.IV_CASH_MGT_GRP = true;
        System.assertEquals(true, funcObj.IV_CASH_MGT_GRP);

        funcObj.IV_COMP_SORT_KEY = true;
        System.assertEquals(true, funcObj.IV_COMP_SORT_KEY);

        funcObj.IV_CUST_GRP = true;
        System.assertEquals(true, funcObj.IV_CUST_GRP);

        funcObj.IV_DEL_PLANT = true;
        System.assertEquals(true, funcObj.IV_DEL_PLANT);

        funcObj.IV_DEL_PRIO = true;
        System.assertEquals(true, funcObj.IV_DEL_PRIO);

        funcObj.IV_DUNNING_CLERK = true;
        System.assertEquals(true, funcObj.IV_DUNNING_CLERK);

        funcObj.IV_DUNNING_PROC = true;
        System.assertEquals(true, funcObj.IV_DUNNING_PROC);

        funcObj.IV_TOLERANCE_GRP = true;
        System.assertEquals(true, funcObj.IV_TOLERANCE_GRP);

        funcObj.IV_VKORG = 'X';
        System.assertEquals('X', funcObj.IV_VKORG);

        funcObj.IV_VTWEG = 'X';
        System.assertEquals('X', funcObj.IV_VTWEG);

        //Check all the collections
        funcObj.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_ACC_STMT.class).add(new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_ACC_STMT());
        System.assertEquals(1,funcObj.ET_ACC_STMT_List.size());

        funcObj.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CASH_MGT_GRP.class).add(new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CASH_MGT_GRP());
        System.assertEquals(1,funcObj.ET_CASH_MGT_GRP_List.size());

        funcObj.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_COMP_SORT_KEY.class).add(new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_COMP_SORT_KEY());
        System.assertEquals(1,funcObj.ET_COMP_SORT_KEY_List.size());

        funcObj.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CUST_GRP.class).add(new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CUST_GRP());
        System.assertEquals(1,funcObj.ET_CUST_GRP_List.size());

        funcObj.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PLANT.class).add(new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PLANT());
        System.assertEquals(1,funcObj.ET_DEL_PLANT_List.size());

        funcObj.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PRIO.class).add(new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PRIO());
        System.assertEquals(1,funcObj.ET_DEL_PRIO_List.size());

        funcObj.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_CLERK.class).add(new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_CLERK());
        System.assertEquals(1,funcObj.ET_DUNNING_CLERK_List.size());

        funcObj.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_PROC.class).add(new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_PROC());
        System.assertEquals(1,funcObj.ET_DUNNING_PROC_List.size());

        funcObj.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_TOLERANCE_GRP.class).add(new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_TOLERANCE_GRP());
        System.assertEquals(1,funcObj.ET_TOLERANCE_GRP_List.size());

    }

    @isTest
    static void testET_ACC_STMT()
    {
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_ACC_STMT funcObj = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_ACC_STMT();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_ACC_STMT.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.XAUSZ = 'X';
        System.assertEquals('X', funcObj.XAUSZ);

        funcObj.TEXT1 = 'X';
        System.assertEquals('X', funcObj.TEXT1);

    }
    @isTest
    static void testET_CASH_MGT_GRP()
    {
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CASH_MGT_GRP funcObj = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CASH_MGT_GRP();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CASH_MGT_GRP.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.GRUPP = 'X';
        System.assertEquals('X', funcObj.GRUPP);

        funcObj.TEXTL = 'X';
        System.assertEquals('X', funcObj.TEXTL);

    }
    @isTest
    static void testET_COMP_SORT_KEY()
    {
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_COMP_SORT_KEY funcObj = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_COMP_SORT_KEY();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_COMP_SORT_KEY.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.ZUAWA = 'X';
        System.assertEquals('X', funcObj.ZUAWA);

        funcObj.TTEXT = 'X';
        System.assertEquals('X', funcObj.TTEXT);

    }
    @isTest
    static void testET_CUST_GRP()
    {
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CUST_GRP funcObj = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CUST_GRP();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CUST_GRP.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.KDGRP = 'X';
        System.assertEquals('X', funcObj.KDGRP);

        funcObj.KTEXT = 'X';
        System.assertEquals('X', funcObj.KTEXT);

    }
    @isTest
    static void testET_DEL_PLANT()
    {
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PLANT funcObj = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PLANT();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PLANT.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.Plant = 'X';
        System.assertEquals('X', funcObj.Plant);

        funcObj.Name1 = 'X';
        System.assertEquals('X', funcObj.Name1);

    }
    @isTest
    static void testET_DEL_PRIO()
    {
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PRIO funcObj = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PRIO();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PRIO.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.DeliveryPriority = 'X';
        System.assertEquals('X', funcObj.DeliveryPriority);

        funcObj.BEZEI = 'X';
        System.assertEquals('X', funcObj.BEZEI);

    }
    @isTest
    static void testET_DUNNING_CLERK()
    {
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_CLERK funcObj = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_CLERK();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_CLERK.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.BUSAB = 'X';
        System.assertEquals('X', funcObj.BUSAB);

        funcObj.SNAME = 'X';
        System.assertEquals('X', funcObj.SNAME);

    }
    @isTest
    static void testET_DUNNING_PROC()
    {
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_PROC funcObj = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_PROC();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_PROC.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.MAHNA = 'X';
        System.assertEquals('X', funcObj.MAHNA);

        funcObj.TEXTM = 'X';
        System.assertEquals('X', funcObj.TEXTM);

    }
    @isTest
    static void testET_TOLERANCE_GRP()
    {
        ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_TOLERANCE_GRP funcObj = new ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_TOLERANCE_GRP();

        funcObj.registerReflectionForClass();

        System.assertEquals(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_TOLERANCE_GRP.class, funcObj.getType(), 'getType() does not match object type.');
        funcObj.TOGRU = 'X';
        System.assertEquals('X', funcObj.TOGRU);

        funcObj.TXT30 = 'X';
        System.assertEquals('X', funcObj.TXT30);

    }
}