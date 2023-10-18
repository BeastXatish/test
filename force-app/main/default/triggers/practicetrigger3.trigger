// prevent account from deleting why before beacuse before deleting we are checking with contacts.
trigger practicetrigger3 on Account (before delete) {
    if(Trigger.isBefore && Trigger.isDelete){
        Set<Id> accIdSet = new Set<Id>();
        Map<id,Account> mmap = new Map<id,Account>();
        for(Account acc:Trigger.old){
            accIdSet.add(acc.id); // In this loop we are taking all the account we have and storing in a Set so we have list of accounts
        }
        
        // here we are checking all the accounts having contact from the Set and puting those in Map why Map because here are using relationship query that's why using map
        for(Account accwidcon: [SELECT id, Name,(SELECT Id, lastName FROM contacts)FROM Account WHERE id in: accIdSet]){
            // in this map we are having the filtered list of account and there related contacts
            mmap.put(accwidcon.id,accwidcon);
        }
        
        for(Account accs: Trigger.old){
            //here we are getting the map with key accid that means the account with contact and then checking the contacts size using the relationship field name.
            if(mmap.get(accs.id).contacts.size()>=2){
                accs.addError('Account having contact more than or equal to 2 cannot be deleted');
            }
        }
    }

}