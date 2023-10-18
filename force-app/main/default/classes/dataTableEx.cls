public with sharing class dataTableEx {
  
        @AuraEnabled(cacheable=true)
    public static Account getaccrecord(String conId){
            System.debug('Contact Id :' +conId);
        	Contact con = [Select Id, AccountId from Contact where Id =:conId];
            Account acc = [SELECT ID,AccountNumber FROM Account Where Id = '0015j0000081p7HAAQ'];
            return acc;
           
    }

    
}