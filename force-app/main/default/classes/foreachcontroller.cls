public with sharing class foreachcontroller {
    public foreachcontroller() {
    }

    @AuraEnabled(cacheable = true)
    public static List<Contact> getcontactlist(){
       
            List<Contact> mycont =[SELECT Id , LastName FROM Contact];
            
        return mycont;
    }
}