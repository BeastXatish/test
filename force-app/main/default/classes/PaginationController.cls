public class PaginationController {
    @AuraEnabled(cacheable = true)
    public static List<Account> getAccountsData(){
        
        List<Account> accList = new List<Account>();
        
        for(Account accRec:[SELECT Id, Name, Phone, Industry, Ownership FROM Account]){
           acclist.add(accRec);
        }
        
        
        return accList;
    }
}