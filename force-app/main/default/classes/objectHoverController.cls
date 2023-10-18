public class objectHoverController		 {
    @AuraEnabled(cacheable=true)
    public static accWrapper getAccounts(){
         map<Id,List<Contact>> accountContactMap = new map<id,List<Contact>>();
        
        List<Account> lstAccount = [SELECT AccountNumber, Name, (SELECT Id, Name FROM Contacts Where AccountId!= Null) FROM Account Limit 7];
        
        for(Account acc : lstAccount)
        {
           accountContactMap.put(acc.id, acc.Contacts);
        }
        
        System.debug('Map Data'+accountContactMap);
        /*  List<Account> accList = [SELECT Name ,Id from Account Limit 10];
Map<Id,Contact> accWithContacts = new Map<Id,Contact>();
for(Account acc:accList){
for(Contact con: [SELECT AccountId, LastName FROM Contact WHERE AccountId =:acc.Id]){
accWithContacts.put(con.AccountId,con);
}   
System.debug('Accounts With Associated Contacts'+accwithContacts);
} */
        accWrapper wrapInstance = new accWrapper();
        wrapInstance.accListWrapper = lstAccount;
        wrapInstance.conListWrapper = accountContactMap;
        
        return wrapInstance;
    }
    public class accWrapper{
    @AuraEnabled public List<Account> accListWrapper{get;set;}
     @AuraEnabled public map<Id,List<Contact>> conListWrapper{get;set;}
}
}