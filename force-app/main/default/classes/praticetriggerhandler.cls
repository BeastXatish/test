public class praticetriggerhandler {
    public static void triggerhandler(List<Contact> newcontact, List<Contact> oldcontact){
        Set<Id> accids = new Set<Id>();
        if(!newcontact.isEmpty()){
            for(Contact con : newcontact){
                if(con.AccountId!=null){
                    accids.add(con.AccountId);
                }  
            }
        }
        if(oldcontact!=null){
            for(Contact con : oldcontact){
                accids.add(con.AccountId);
            }
        }
        List<Account> accs = [SELECT id,NumberofContact__c,(SELECT id from Contacts)from Account where Id in:accids];
        if(accs!=null){
            for(Account acc: accs){
                acc.NumberofContact__c = acc.Contacts.size();
            }
        }
        
        if(!accs.isEmpty()){
            update accs;
        }
        
    }
    
}