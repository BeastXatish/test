public class AccountContactController	 {
    
    @AuraEnabled(cacheable = true)
    public static AccountContactWrapper myMethod(String accId){
        Account account = [Select Id,Name, Type, Phone, Industry, (SELECT Id, FirstName, LastName FROM Contacts) From Account Where Id =:accId LIMIT 1];
        
        AccountContactWrapper accountContactsObject = new AccountContactWrapper(account);
        System.debug('AccountContactsObject'+accountContactsObject);
        return accountContactsObject;
    }
    
    @AuraEnabled
    public static void updateAccountDetail(String objInstance){
        system.debug('Data'+objInstance);
        try{
            AccountContactWrapper rec = (AccountContactWrapper)JSON.deserialize(objInstance, AccountContactWrapper.class);
            System.debug('rec.account'+rec.account);
            System.debug('rec.contacts'+rec.contacts);
            update rec.account;
            update rec.contacts;
        }catch(Exception e){
      		throw new AuraHandledException(e.getMessage());
        }
    } 
    @AuraEnabled
    public Static Contact returnNewContactFromLWC(String objInstance1, String accIds){
        System.debug('objInstance1'+objInstance1);
        System.debug('accIds'+accIds);
        Contact conNew =  (Contact)JSON.deserialize(objInstance1,Contact.class);
        //conNew.LastName = (String)JSON.deserialize(objInstance1,Contact.class);
        conNew.AccountId = accIds;
        Insert conNew;
       System.debug('ConNew'+conNew);
        return conNew;
    }
    public class AccountContactWrapper{
        @AuraEnabled public Account account;
        @AuraEnabled public List<Contact> contacts;

        AccountContactWrapper(Account account){
            this.account = account;
            this.contacts = account.contacts;
        }
    }
}