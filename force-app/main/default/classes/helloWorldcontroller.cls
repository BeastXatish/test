public with sharing class helloWorldcontroller {
    public helloWorldcontroller() {

    }
    
    @AuraEnabled(cacheable=true)
    public static String getAccountRec(String accid){
            List<Account> acc = [SELECT Name FROM Account WHERE Id =:accid];

            return acc[0].Name;
    }
}