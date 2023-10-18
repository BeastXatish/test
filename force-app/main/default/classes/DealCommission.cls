public with sharing class DealCommission {
    
    @AuraEnabled(cacheable = true)
    public static List<DealCommissionWrapper> getDealCommission(Id DealId){
        List<DealCommissionWrapper> dealWrapperList = new List<DealCommissionWrapper>();
        Map<Id,Decimal> mmap = new Map<Id,Decimal>();
        for(AggregateResult ar: [SELECT Rep_Name__c, SUM(Amount__c)sumOfAmount FROM Commission__c Where Deal__c =: DealId Group By Rep_Name__c])
        {
            mmap.put((Id)ar.get('Rep_Name__c'),(Decimal)ar.get('sumOfAmount'));// getting values from aggregate result
        }
        
        System.debug('Map'+mmap);
        System.debug('Map Values'+mmap.Values());
        System.debug('Map Keys '+mmap.keySet());
        List<Commission__c> dealList =[SELECT Id,Deal__c,Amount__c,Rep_Name__c, Rep_Name__r.FirstNAme from Commission__c WHERE Rep_Name__r.Id in: mmap.keySet()];
      //  System.debug('Deal Record With Commission'+dealList.size());
        Map<Id,Commission__c> mapOfCommission = new  Map<Id,Commission__c>();
        
        for(Commission__c c: dealList){
          //  System.debug('Map Data' +mmap.get(c.Rep_Name__c));
            mapOfCommission.put(c.Rep_Name__c,c);
        }
        System.debug('Map of Commission'+mapOfCommission);
        system.debug('mapOfCommission '+mapOfCommission.size());
        Decimal total = 0;
        for(Id idInstacneforRepName : mapOfCommission.keyset()){
            DealCommissionWrapper dealComm = new DealCommissionWrapper();
            //columnsname = record values
            dealComm.subtotal = mmap.get(idInstacneforRepName);
            dealComm.name = mapOfCommission.get(idInstacneforRepName).Rep_Name__r.FirstName;
            total = total+ dealComm.subtotal;
            dealWrapperList.add(dealComm);
        }
        DealCommissionWrapper dealComm = new DealCommissionWrapper();
         dealComm.Total = total;
         dealWrapperList.add(dealComm);
         System.debug('dealCommList '+dealWrapperList);
        return dealWrapperList;
    }
    public class DealCommissionWrapper{
        @AuraEnabled public Decimal Total = 0;
        @AuraEnabled public Decimal subtotal;
        @AuraEnabled public String name;
        
        
    }
}