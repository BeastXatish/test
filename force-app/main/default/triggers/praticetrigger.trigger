trigger praticetrigger on Contact (after insert, after update) {
    
    if(Trigger.isAfter && Trigger.isInsert || Trigger.isAfter && Trigger.isUpdate){
        praticetriggerhandler.triggerhandler(Trigger.new, Trigger.old);
    }
}