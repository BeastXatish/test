public class displayMonthValue {
    
    public static void getMonthNameAsPerAccountDate(){
        List<String> pickListValuesList = new List<String>();
        List<String> firstList = new List<String>();
        List<String> secondList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Account.Month__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(pickListVal.getLabel());
        }
        System.debug('pickListValuesList'+pickListValuesList);
        
        Account accInstance =[SELECT Dummy_Date__c,Month__c FROM Account Where Name = 'TestAction' Limit 1];
        Integer monthNumber = accInstance.Dummy_Date__c.month();
        for(Integer i =1;i<monthnumber;i++){
            firstList.add(pickListValuesList[i-1]);
        }
        System.debug('firstList'+firstList);
        for(Integer i=monthnumber;i<=12;i++){
            secondList.add(pickListValuesList[i-1]); 
        }
        System.debug('secondList'+secondList);
    }
}