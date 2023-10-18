public class GetAccountPagination {
    @AuraEnabled(cacheable = true)
    public static List<GetAccountPaginationWrapper> getAccounts(){
        
        List<GetAccountPaginationWrapper> accWrapperList = new List<GetAccountPaginationWrapper>();
        List<Account> acc = [SELECT Id, Name, Phone, Industry, Ownership FROM Account];
        
        for(Account accRec:acc){
            
            GetAccountPaginationWrapper accWrapperInstance = new GetAccountPaginationWrapper();
            accWrapperInstance.id = accRec.Id;
            accWrapperInstance.phoneValue = accRec.Phone;
            accWrapperInstance.industryValue = accRec.Industry;
            accWrapperInstance.ownershipValue = accRec.Ownership;
            accWrapperInstance.accName = accRec.Name;
            accWrapperList.add(accWrapperInstance);
        }
        
        return accWrapperList;
    }
    public class GetAccountPaginationWrapper{
        @AuraEnabled public Boolean isActive = false;
        @AuraEnabled public String id;
        @AuraEnabled public String phoneValue;
        @AuraEnabled public String industryValue;
        @AuraEnabled public String ownershipValue;
        @AuraEnabled public String accName;
    }
    
}