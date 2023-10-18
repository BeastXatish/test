trigger practiceTrigger1 on Account (after insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        List<Contact> cons = new List<Contact>();
        for(Account acc: Trigger.new){
            Contact con = new Contact();
            con.AccountId = acc.Id;
            con.LastName = acc.Name;
            cons.add(con);
        }
        insert cons;
    }
}