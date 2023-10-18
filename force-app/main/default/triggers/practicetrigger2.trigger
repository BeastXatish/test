// whenever the account billingstreet is changed we have to change the associate contact mailing street same as account billingstreet.
trigger practicetrigger2 on Account (after update) {
    if(Trigger.isafter && Trigger.isUpdate){
       Set<Id> accids = new Set<Id>();
        for(Account acc: Trigger.new){
            Account oldrecvalues = Trigger.oldMap.get(acc.id);
            if(acc.BillingStreet != oldrecvalues.BillingStreet && acc.BillingStreet!=null){
                accids.add(acc.id);
            }
        }
        List<Contact> conrealtedtoacc = [SELECT lastname , AccountId FROM Contact Where AccountId in :accids];
        List<Contact> conlist = new List<Contact>();
        for(Contact con: conrealtedtoacc){
            con.MailingStreet = Trigger.newMap.get(con.AccountId).BillingStreet;
            conlist.add(con);
        }
        update conlist;
    }
    
}