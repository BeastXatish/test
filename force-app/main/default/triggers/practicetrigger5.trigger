trigger practicetrigger5 on Account (after update) {
    if(Trigger.isafter && Trigger.isUpdate){
        
        //trigger.newmap.keyset returns list of Contact Id of only where Accountids is 'in' trigger.newmap and then storing it in list of contact
        //then iterating on that list and updating the contact fields value with AccountPhone old and new value then adding that updated contact value 
        //in a empty list of contacts then Updating that List
        List<Contact> conlist = [SELECT id,OtherPhone,HomePhone from Contact Where AccountId in: trigger.newmap.keySet()];
        List<Contact> contactlist = new List<Contact>();
        for(Account acc: Trigger.new){
            if(!conlist.isEmpty()){
                for(Contact con: conlist){
                    con.OtherPhone = Trigger.newmap.get(acc.Id).phone;
                    con.HomePhone = Trigger.oldmap.get(acc.Id).phone;
                    contactlist.add(con);
                }
            }
            
        }
        update contactlist;
    }
}