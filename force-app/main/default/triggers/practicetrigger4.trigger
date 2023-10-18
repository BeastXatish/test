// when lead is created or updated check if the email in the lead in already there in existing contacts of that lead if yes then throw an error
// object name :- lead 
// Unrealted OBJECTS
// using list to fetch Contacts and then to connect lead(trigger.new) and contact using Map.
// Event :-  before(as we are writing the trigger on the same object and thorwing the error on lead itself) when doing something on 'A' do something on 'B' then use "After"
trigger practicetrigger4 on Lead (before insert, before update) {
    
    Map<String,Contact> conMap = new Map<String,Contact>();
    List<Contact> conlist = [SELECT id,lastName from Contact];
    
    for(Contact con: conlist){
        // key instead of Id we are taking as Email because we want to check with Email that's why Map.
        conMap.put(con.Email,con);
    }
    for(Lead ld: Trigger.new){
        if((ld.Email!=null) && (trigger.isInsert || (ld.Email!= trigger.oldmap.get(ld.Id).Email))){
            if(conMap.containsKey(ld.Email)){
                ld.Email.addError('Email address already existed in the contacts');
                }
        
    }
    
}
}