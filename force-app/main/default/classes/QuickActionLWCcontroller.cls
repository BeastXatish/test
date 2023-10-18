public with sharing class QuickActionLWCcontroller {
    public QuickActionLWCcontroller() {

    }

    @AuraEnabled
    public static void createAccount(String accName, String accPhone, String parentrecId){
        try {

            Account acc =new Account(Name = accName , Phone = accPhone , ParentId = parentrecId);
            insert acc;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}