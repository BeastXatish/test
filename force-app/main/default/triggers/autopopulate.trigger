trigger autopopulate on Account (after update) {
    if(Trigger.isBefore && Trigger.isInsert){
        Set<Id> accids = new Set<Id>();
        for(Account acc: Trigger.new){
            accids.add(acc.id);
        }
        List<Opportunity> opplistupdated = new List<Opportunity>();
        DateTime day30=system.now()-30; // using DateTime instance and storing the todaydate-30 day value
        List<Opportunity> oppwidacc = [SELECT id, StageName,CreatedDate from Opportunity Where AccountId In :accids];
        if(oppwidacc.size()>0){
            for(Opportunity opp:oppwidacc){
                if(opp.StageName!='Closed Won' && opp.CreatedDate<day30){
                    opp.StageName = 'Closed Lost';
                    opp.CloseDate=system.today(); // This is a mandatory field when we are changing the Stage to Closed Lost so setting it to today Date.
                    opplistupdated.add(opp);
                }
            }
        }
        if(opplistupdated.size()>0){
            update opplistupdated;
        }
    }
}