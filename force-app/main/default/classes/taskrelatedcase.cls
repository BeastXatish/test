public with sharing class taskrelatedcase {
    
    @AuraEnabled(cacheable=true)
    public static Account getaccrecord(String conId){
          
        	Contact con = [Select Id, AccountId from Contact where Id =:conId];
            Account acc = [SELECT ID,AnnualRevenue,AccountNumber FROM Account where Id =:con.AccountId LIMIT 1];
            return acc;
           
    }
}