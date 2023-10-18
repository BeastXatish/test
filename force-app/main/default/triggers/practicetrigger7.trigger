trigger practicetrigger7 on Account (after update) {
    
    List<Contact> conlist = new List<Contact>();
    List<Account> acclist = [SELECT id,Balance__c,(SELECT id,Individual_Balance__c FROM Contacts)from Account Where Balance__c >0];
    for(Account acc: acclist){
        Decimal Storedamount = acc.Balance__c/acc.Contacts.size();
        
        for(Contact con: acc.Contacts){
            con.Individual_Balance__c = Storedamount;
            conlist.add(con);
                }
        update conlist;
    } 
    
}