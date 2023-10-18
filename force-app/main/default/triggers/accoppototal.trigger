trigger accoppototal on Account (before insert) {
    
    Set<Id> accset = new Set<Id>();
    for(Account acc: Trigger.new){
        accset.add(acc.Id);
    }
    
    //map to get the Account Id and the sum of its related opportunities amount to insert later
    Map<Id,Double> amountMap = new Map<Id,Double>();
    // when giving id in the query why giving error
    List<AggregateResult> arrs = [SELECT AccountId, sum(Amount) from Opportunity where AccountId in :accset group by AccountId];
    for(AggregateResult arr: arrs){
        //getting the AccountId and sum(Amount) in separate variables and putting it to map
        Id accountId = (Id)arr.get('AccountId');
        double TotalAmount = (double)arr.get('Amount');
        amountMap.put(accountId, TotalAmount);
    }
    for(Account acc: Trigger.new){
        if(amountMap.containsKey(acc.Id)){
           acc.Total_Oppo_amount__c = amountMap.get(acc.Id);
        }
    }
}