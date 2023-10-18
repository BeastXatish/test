trigger Oppolineupdate on OpportunityLineItem (before insert) {
    Set<Id> oppolineId = new Set<Id>();
    
    List<OpportunityLineItem> oppProdListTOUpdate = new List<OpportunityLineItem>();
    for(OpportunityLineItem opp: Trigger.new){
        oppolineId.add(opp.Id);
    }
    //Map of Opportunity Id and SeralNo of OpportunityLineItem
    Map<Id,String> oppIdSerialNoMap =new Map<Id,String>();
    List<OpportunityLineItem> oppProdList=[Select Id,Serial_No__c,OpportunityId from OpportunityLineItem where OpportunityId=:oppolineId];
    if(oppProdList.size()>0){
        
        for(OpportunityLineItem opps: oppProdList){
            if(opps.Serial_No__c!=null){
                //Getting the last number of the SerialNo field
                String lastword = opps.Serial_No__c.right(1);
                //converting String into Integer so that I can increment the lastnumber which is already there in SerialNo field
                Integer num = Integer.valueOf(lastword);
                num++;
                //appending the incremented number
                opps.Serial_No__c = opps.Serial_No__c+','+(num);
                oppProdListTOUpdate.add(opps);
                
                //adding it to Map so that i can make changes for the OpportunityLineItem which is newly getting inserted
                oppIdSerialNoMap.put(opps.OpportunityId,opps.Serial_No__c);
            }
        }
    }
}