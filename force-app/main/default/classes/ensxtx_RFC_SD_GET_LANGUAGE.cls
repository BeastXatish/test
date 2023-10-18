/// enosiX Inc. Generated Apex Model
/// Generated On: 5/19/2022 8:08:43 PM
/// SAP Host: From REST Service On: https://knf--enosixdev.my.salesforce.com
/// CID: From REST Service On: https://knf--enosixdev.my.salesforce.com
/// Generator Version: 2.5.0.0, Target Framework ensxapp.v1.2

public with sharing class ensxtx_RFC_SD_GET_LANGUAGE extends ensxsdk.EnosixFramework.RFC
{
        static void registerReflectionInfo()
    {
        ensxsdk.EnosixFramework.registerReflectionResource('ensxtx_RFC_SD_GET_LANGUAGE_Meta', new Type[] {
            ensxtx_RFC_SD_GET_LANGUAGE.RESULT.class
            , ensxtx_RFC_SD_GET_LANGUAGE.ET_LANG.class
            } 
        );
    }

    public ensxtx_RFC_SD_GET_LANGUAGE()
    {
        super('/ENSX/SD_GET_LANGUAGE', ensxtx_RFC_SD_GET_LANGUAGE.RESULT.class);
    }

    public override Type getType() { return ensxtx_RFC_SD_GET_LANGUAGE.class; }

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
                'ET_LANG' => ensxtx_RFC_SD_GET_LANGUAGE.ET_LANG.class
            });	
        }
        
        public override Type getType() { return ensxtx_RFC_SD_GET_LANGUAGE.RESULT.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_SD_GET_LANGUAGE.registerReflectionInfo();
        }

        @AuraEnabled public List<ET_LANG> ET_LANG_List
    {
        get 
        {
            List<ET_LANG> results = new List<ET_LANG>();
            this.getCollection(ensxtx_RFC_SD_GET_LANGUAGE.ET_LANG.class).copyTo(results);
            return results;
        }
    }
    	
    }
    public class ET_LANG extends ensxsdk.EnosixFramework.ValueObject
    {
        public ET_LANG()
        {
            super('ET_LANG', new Map<string,type>());
        }

        public override Type getType() { return ensxtx_RFC_SD_GET_LANGUAGE.ET_LANG.class; }

        public override void registerReflectionForClass()
        {
            ensxtx_RFC_SD_GET_LANGUAGE.registerReflectionInfo();
        }

                    @AuraEnabled public String LAISO
        {
            get { return this.getString ('LAISO'); } 
            set { this.Set (value, 'LAISO'); }
        }

        @AuraEnabled public String SPTXT
        {
            get { return this.getString ('SPTXT'); } 
            set { this.Set (value, 'SPTXT'); }
        }

            
        }
}