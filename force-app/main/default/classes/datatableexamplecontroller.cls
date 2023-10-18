public with sharing class datatableexamplecontroller {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getrelatedcontacts(String accid)
    {	system.debug('called');
        if(!String.isEmpty(accid)){
            System.debug('getting into the method');
            List<Contact> con = [SELECT Id, Name , Email , Phone FROM Contact WHERE AccountId =:accid];
            System.debug(con);
            return con;
        }
        return null;
    }

    @AuraEnabled
    public static String updatedContactDetail(Object objInstance){
        system.debug('Data'+objInstance);
        List<Contact> conList = (List<Contact>)JSON.deserialize(JSON.serialize(objInstance), List<Contact>.class);
        if(!conList.isEmpty()){
            update conList;
            return 'Done';
        }
      return 'Failed';
    }
}