trigger duplicateContact on Contact (before insert, before update) {
    Set<String> setEmail = new Set<String>();
    Set<String> setExistingEmail = new Set<String>();
    Set<String> setPhone = new Set<String>();
    Set<String> setExistingPhone = new Set<String>();
    
    if(Trigger.isbefore && Trigger.isupdate){
        //Add all email in set to fetch related existing records
        for(Contact con : Trigger.new)
        {
            if(Trigger.oldMap.get(con.Id).Email != con.Email && con.Email != null){
                setEmail.add(con.Email);
            }
            
            if(Trigger.oldMap.get(con.Id).Phone != con.Phone && con.Phone != null){
                setPhone.add(con.Phone);
            }
            
        }
    }
    // Before Insert
    if(Trigger.isBefore && Trigger.isInsert){
        for(Contact con : Trigger.new)
        {
            if(con.Email != null){
                setEmail.add(con.Email);
            }
            if(con.Phone != null){
                 setPhone.add(con.Phone);
            }
        }
    }
    // get all records in database.
    if(setEmail.size()>0 || setPhone.size()>0){
        for(Contact con : [select Email, Phone from contact where Email in : setEmail OR Phone in : setPhone])
        {
            setExistingEmail.add(con.email);
            setExistingPhone.add(con.Phone);
        }
        
        //compare and add error if already exist
        for(Contact con:Trigger.new)
        {
            if( setExistingEmail.contains(con.email))
            {
                con.Email.adderror('This email already exists');
            }
            if(  setExistingPhone.contains(con.Phone))
            {
                con.Phone.adderror('This Number Already Exists');
            }
        }
    }
}