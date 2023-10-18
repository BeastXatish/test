/// enosiX Inc. Generated Apex Model
/// Generated On: 8/17/2022 8:19:47 PM
/// SAP Host: From REST Service On: https://oregontool--sfd.my.salesforce.com
/// CID: From REST Service On: https://oregontool--sfd.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES_Meta', new Type[] {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.RESULT.class
            , ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_ACC_STMT.class
            , ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CASH_MGT_GRP.class
            , ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_COMP_SORT_KEY.class
            , ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CUST_GRP.class
            , ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PLANT.class
            , ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PRIO.class
            , ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_CLERK.class
            , ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_PROC.class
            , ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_TOLERANCE_GRP.class
            } 
        );
    }

    public ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES()
    {
        super('Z_ENSX_GET_DROPDOWN_VALUES', ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.RESULT.class);
    }

    public override Type getType() { return ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.class; }

    public RESULT PARAMS
    {
        get { return (RESULT)this.getParameterContext(); }
    }

    public RESULT execute()
    {
        return (RESULT)this.executeFunction();
    }
    
    public class RESULT extends ensxsdk.EnosixFramework.FunctionObject
    {    	
        public RESULT()
        {
            super(new Map<string,type>
            {
                'ET_ACC_STMT' => ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_ACC_STMT.class
        ,'ET_CASH_MGT_GRP' => ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CASH_MGT_GRP.class
        ,'ET_COMP_SORT_KEY' => ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_COMP_SORT_KEY.class
        ,'ET_CUST_GRP' => ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CUST_GRP.class
        ,'ET_DEL_PLANT' => ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PLANT.class
        ,'ET_DEL_PRIO' => ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PRIO.class
        ,'ET_DUNNING_CLERK' => ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_CLERK.class
        ,'ET_DUNNING_PROC' => ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_PROC.class
        ,'ET_TOLERANCE_GRP' => ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_TOLERANCE_GRP.class
            });	
        }
        
        public override Type getType() { return ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.RESULT.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_ACC_STMT> ET_ACC_STMT_List
    {
        get 
        {
            List<ET_ACC_STMT> results = new List<ET_ACC_STMT>();
            this.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_ACC_STMT.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_CASH_MGT_GRP> ET_CASH_MGT_GRP_List
    {
        get 
        {
            List<ET_CASH_MGT_GRP> results = new List<ET_CASH_MGT_GRP>();
            this.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CASH_MGT_GRP.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_COMP_SORT_KEY> ET_COMP_SORT_KEY_List
    {
        get 
        {
            List<ET_COMP_SORT_KEY> results = new List<ET_COMP_SORT_KEY>();
            this.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_COMP_SORT_KEY.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_CUST_GRP> ET_CUST_GRP_List
    {
        get 
        {
            List<ET_CUST_GRP> results = new List<ET_CUST_GRP>();
            this.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CUST_GRP.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_DEL_PLANT> ET_DEL_PLANT_List
    {
        get 
        {
            List<ET_DEL_PLANT> results = new List<ET_DEL_PLANT>();
            this.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PLANT.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_DEL_PRIO> ET_DEL_PRIO_List
    {
        get 
        {
            List<ET_DEL_PRIO> results = new List<ET_DEL_PRIO>();
            this.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PRIO.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_DUNNING_CLERK> ET_DUNNING_CLERK_List
    {
        get 
        {
            List<ET_DUNNING_CLERK> results = new List<ET_DUNNING_CLERK>();
            this.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_CLERK.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_DUNNING_PROC> ET_DUNNING_PROC_List
    {
        get 
        {
            List<ET_DUNNING_PROC> results = new List<ET_DUNNING_PROC>();
            this.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_PROC.class).copyTo(results);
            return results;
        }
    }
    @AuraEnabled public List<ET_TOLERANCE_GRP> ET_TOLERANCE_GRP_List
    {
        get 
        {
            List<ET_TOLERANCE_GRP> results = new List<ET_TOLERANCE_GRP>();
            this.getCollection(ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_TOLERANCE_GRP.class).copyTo(results);
            return results;
        }
    }
        @AuraEnabled public Boolean IV_ACC_STMT
        {
            get { return this.getBoolean('IV_ACC_STMT'); } 
            set { this.setBoolean(value, 'IV_ACC_STMT'); }
        }

        @AuraEnabled public String IV_BUKRS
        {
            get { return this.getString ('IV_BUKRS'); } 
            set { this.Set (value, 'IV_BUKRS'); }
        }

        @AuraEnabled public Boolean IV_CASH_MGT_GRP
        {
            get { return this.getBoolean('IV_CASH_MGT_GRP'); } 
            set { this.setBoolean(value, 'IV_CASH_MGT_GRP'); }
        }

        @AuraEnabled public Boolean IV_COMP_SORT_KEY
        {
            get { return this.getBoolean('IV_COMP_SORT_KEY'); } 
            set { this.setBoolean(value, 'IV_COMP_SORT_KEY'); }
        }

        @AuraEnabled public Boolean IV_CUST_GRP
        {
            get { return this.getBoolean('IV_CUST_GRP'); } 
            set { this.setBoolean(value, 'IV_CUST_GRP'); }
        }

        @AuraEnabled public Boolean IV_DEL_PLANT
        {
            get { return this.getBoolean('IV_DEL_PLANT'); } 
            set { this.setBoolean(value, 'IV_DEL_PLANT'); }
        }

        @AuraEnabled public Boolean IV_DEL_PRIO
        {
            get { return this.getBoolean('IV_DEL_PRIO'); } 
            set { this.setBoolean(value, 'IV_DEL_PRIO'); }
        }

        @AuraEnabled public Boolean IV_DUNNING_CLERK
        {
            get { return this.getBoolean('IV_DUNNING_CLERK'); } 
            set { this.setBoolean(value, 'IV_DUNNING_CLERK'); }
        }

        @AuraEnabled public Boolean IV_DUNNING_PROC
        {
            get { return this.getBoolean('IV_DUNNING_PROC'); } 
            set { this.setBoolean(value, 'IV_DUNNING_PROC'); }
        }

        @AuraEnabled public Boolean IV_TOLERANCE_GRP
        {
            get { return this.getBoolean('IV_TOLERANCE_GRP'); } 
            set { this.setBoolean(value, 'IV_TOLERANCE_GRP'); }
        }

        @AuraEnabled public String IV_VKORG
        {
            get { return this.getString ('IV_VKORG'); } 
            set { this.Set (value, 'IV_VKORG'); }
        }

        @AuraEnabled public String IV_VTWEG
        {
            get { return this.getString ('IV_VTWEG'); } 
            set { this.Set (value, 'IV_VTWEG'); }
        }

    	
    }
    public class ET_ACC_STMT extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_ACC_STMT()
        {
            super('ET_ACC_STMT', new Map<string,type>());
        }

        public override Type getType() { return ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_ACC_STMT.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.registerReflectionInfo();
        }

                    @AuraEnabled public String XAUSZ
        {
            get { return this.getString ('XAUSZ'); } 
            set { this.Set (value, 'XAUSZ'); }
        }

        @AuraEnabled public String TEXT1
        {
            get { return this.getString ('TEXT1'); } 
            set { this.Set (value, 'TEXT1'); }
        }

            
        }
    public class ET_CASH_MGT_GRP extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_CASH_MGT_GRP()
        {
            super('ET_CASH_MGT_GRP', new Map<string,type>());
        }

        public override Type getType() { return ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CASH_MGT_GRP.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.registerReflectionInfo();
        }

                    @AuraEnabled public String GRUPP
        {
            get { return this.getString ('GRUPP'); } 
            set { this.Set (value, 'GRUPP'); }
        }

        @AuraEnabled public String TEXTL
        {
            get { return this.getString ('TEXTL'); } 
            set { this.Set (value, 'TEXTL'); }
        }

            
        }
    public class ET_COMP_SORT_KEY extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_COMP_SORT_KEY()
        {
            super('ET_COMP_SORT_KEY', new Map<string,type>());
        }

        public override Type getType() { return ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_COMP_SORT_KEY.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.registerReflectionInfo();
        }

                    @AuraEnabled public String ZUAWA
        {
            get { return this.getString ('ZUAWA'); } 
            set { this.Set (value, 'ZUAWA'); }
        }

        @AuraEnabled public String TTEXT
        {
            get { return this.getString ('TTEXT'); } 
            set { this.Set (value, 'TTEXT'); }
        }

            
        }
    public class ET_CUST_GRP extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_CUST_GRP()
        {
            super('ET_CUST_GRP', new Map<string,type>());
        }

        public override Type getType() { return ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_CUST_GRP.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.registerReflectionInfo();
        }

                    @AuraEnabled public String KDGRP
        {
            get { return this.getString ('KDGRP'); } 
            set { this.Set (value, 'KDGRP'); }
        }

        @AuraEnabled public String KTEXT
        {
            get { return this.getString ('KTEXT'); } 
            set { this.Set (value, 'KTEXT'); }
        }

            
        }
    public class ET_DEL_PLANT extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_DEL_PLANT()
        {
            super('ET_DEL_PLANT', new Map<string,type>());
        }

        public override Type getType() { return ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PLANT.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.registerReflectionInfo();
        }

                    @AuraEnabled public String Plant
        {
            get { return this.getString ('WERKS'); } 
            set { this.Set (value, 'WERKS'); }
        }

        @AuraEnabled public String Name1
        {
            get { return this.getString ('NAME1'); } 
            set { this.Set (value, 'NAME1'); }
        }

            
        }
    public class ET_DEL_PRIO extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_DEL_PRIO()
        {
            super('ET_DEL_PRIO', new Map<string,type>());
        }

        public override Type getType() { return ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DEL_PRIO.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.registerReflectionInfo();
        }

                    @AuraEnabled public String DeliveryPriority
        {
            get { return this.getString ('LPRIO'); } 
            set { this.Set (value, 'LPRIO'); }
        }

        @AuraEnabled public String BEZEI
        {
            get { return this.getString ('BEZEI'); } 
            set { this.Set (value, 'BEZEI'); }
        }

            
        }
    public class ET_DUNNING_CLERK extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_DUNNING_CLERK()
        {
            super('ET_DUNNING_CLERK', new Map<string,type>());
        }

        public override Type getType() { return ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_CLERK.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.registerReflectionInfo();
        }

                    @AuraEnabled public String BUSAB
        {
            get { return this.getString ('BUSAB'); } 
            set { this.Set (value, 'BUSAB'); }
        }

        @AuraEnabled public String SNAME
        {
            get { return this.getString ('SNAME'); } 
            set { this.Set (value, 'SNAME'); }
        }

            
        }
    public class ET_DUNNING_PROC extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_DUNNING_PROC()
        {
            super('ET_DUNNING_PROC', new Map<string,type>());
        }

        public override Type getType() { return ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_DUNNING_PROC.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.registerReflectionInfo();
        }

                    @AuraEnabled public String MAHNA
        {
            get { return this.getString ('MAHNA'); } 
            set { this.Set (value, 'MAHNA'); }
        }

        @AuraEnabled public String TEXTM
        {
            get { return this.getString ('TEXTM'); } 
            set { this.Set (value, 'TEXTM'); }
        }

            
        }
    public class ET_TOLERANCE_GRP extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_TOLERANCE_GRP()
        {
            super('ET_TOLERANCE_GRP', new Map<string,type>());
        }

        public override Type getType() { return ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.ET_TOLERANCE_GRP.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_Z_ENSX_GET_DROPDOWN_VALUES.registerReflectionInfo();
        }

                    @AuraEnabled public String TOGRU
        {
            get { return this.getString ('TOGRU'); } 
            set { this.Set (value, 'TOGRU'); }
        }

        @AuraEnabled public String TXT30
        {
            get { return this.getString ('TXT30'); } 
            set { this.Set (value, 'TXT30'); }
        }

            
        }
}