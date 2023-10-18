public class AccountOpportunityCallOut {
    
    public static String doCallout(String Name){
        Account accountRecord = [Select Name From Account Where Name =:Name Limit 1];
        List<Opportunity> opporList = [Select Amount, StageName From Opportunity Where AccountId =: accountRecord.Id];
        String responseCodeMessage;
        
        RecordData recD = new RecordData(accountRecord,opporList); 
        String dataBody = JSON.serialize(recD);
        System.debug('dataBody'+dataBody);
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://www.google.com/');
        req.setBody(dataBody);
        
        HttpResponse res = h.send(req);
        System.debug('res.getStatusCode()'+res.getStatusCode());
        if(res.getStatusCode() == 200){
            return responseCodeMessage = 'All Ok';
        }
        else if(res.getStatusCode() == 401){
            return responseCodeMessage = 'Access Token is not valid or has been expired';
        }
        else{
            return responseCodeMessage = 'Please Check the ErrorCode and contact your System Admin';
        }
    }
    public class RecordData{
        public Account accountD;
        public List<Opportunity> opportunityListData;
        
        public RecordData(Account accountData, List<Opportunity> opportunityListData){
            this.accountD = accountData;
            this.opportunityListData = opportunityListData;
        }
    }
}