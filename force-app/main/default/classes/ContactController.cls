public class ContactController {

    @AuraEnabled
    public static List<Contact> getContacts(Id recordId){
        return [Select Id, LastName, FirstName, Phone From Contact Where AccountId =:recordId];
    }
    
     @AuraEnabled
    public static void updateContact(List<Contact> conList ){
        update conList;
    }
}