public class accountContactStandardController {

    @AuraEnabled(cacheable = true)
        public static Account getAccountDetail(Id accId){
            Account singleAccount = [Select Name From Account Where Id =:accId];
            System.debug('singleAccount'+singleAccount.Id);
            return singleAccount;
    }
     
     
    @AuraEnabled(cacheable = true)
        public static List<Id> getContactDetail(Id accIdForContact){
            List<Id> conIdList = new List<Id>();
            System.debug('accIdForContact'+accIdForContact);
           for(Contact con: [Select Id,LastName,Phone From Contact Where AccountId =: accIdForContact]){
            conIdList.add(con.Id); 
           }
            System.debug('conIdList'+conIdList);
            return conIdList;
    }
}