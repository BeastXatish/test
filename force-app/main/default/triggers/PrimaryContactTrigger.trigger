trigger PrimaryContactTrigger on Contact (after insert,after Update) {
    	List<Contact> contactList = new List<Contact>();
        Set<Id> accountIdsWhereContactIsPrimary = new Set<Id>();
    
    if(Trigger.isAfter && Trigger.isInsert){
        for(Contact con: Trigger.new){
            if(con.Primary_Contact__c == true && con.AccountId != null){
                accountIdsWhereContactIsPrimary.add(con.AccountId);
            }
        }
        
        contactList = [Select Primary_Contact__c From Contact Where AccountId In :accountIdsWhereContactIsPrimary AND Primary_Contact__c = True AND Id NOT IN: Trigger.new];
        System.debug('contactList'+contactList);
        
        if(contactList.size()>0){
            for(Contact conList:contactList){
                conList.Primary_Contact__c = False;
            }
        }
        
        update contactList;
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        for(Contact con: Trigger.new){
            if(Trigger.oldMap.get(con.Id).Primary_Contact__c != True && con.Primary_Contact__c ==True){
                 accountIdsWhereContactIsPrimary.add(con.AccountId);
            }
        }
        contactList = [Select Primary_Contact__c From Contact Where AccountId In :accountIdsWhereContactIsPrimary AND Primary_Contact__c = True AND Id NOT IN: Trigger.new];
        System.debug('contactList'+contactList);
        
        if(contactList.size()>0){
            for(Contact conList:contactList){
                conList.Primary_Contact__c = False;
            }
        }
        
        update contactList;
    }
}