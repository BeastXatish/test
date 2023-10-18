trigger practiceTrigger on Case (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Case c: Trigger.new){
            if(c.Origin == 'email'){
                c.Status = 'Escalated';
                c.Priority = 'Medium';
            }
        }
    }

}