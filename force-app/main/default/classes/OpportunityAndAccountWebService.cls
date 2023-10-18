@RestResource(urlMapping = '/letsdo/*')
global class OpportunityAndAccountWebService {
    
    @HttpGet
    global static Records getAccountWithOpportunity(){
        Map<string, string> paramsMap = RestContext.request.params;
        String accountName = paramsMap.get('name');
       
        
        List<Account> accountRecordToExpose = [Select Id,Name From Account Where Name =:accountName];
        List<Opportunity> opportunityListToExpose;
        
        if(accountRecordToExpose.size()>0){
            opportunityListToExpose  = [Select Name, StageName, Amount From Opportunity Where AccountId =:accountRecordToExpose[0].Id];
        }else{
            return new Records(null,null,'Account Not Found'+accountName);
        }
        
        return new Records(accountRecordToExpose,opportunityListToExpose,'Success');
    }
    
    global class Records{
        public List<Account> account;
        public List<Opportunity> opportunityList;
        public String status;
        
        public Records(List<Account> account, List<Opportunity> opportunityList , String status){
            this.account = account;
            this.opportunityList = opportunityList;
            this.status = status;
        }
    }
}