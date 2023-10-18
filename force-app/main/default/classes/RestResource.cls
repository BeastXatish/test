@RestResource(urlMapping = '/atish/*')
global class RestResource {
    @HttpGet
    global static Account getData(){
        Map<string, string> paramsMap = RestContext.request.params;
        String accId = paramsMap.get('Id');
        
        return [Select Id,Name from Account Where Id =:accId];
    }
    @HttpPost
    global static Account postData(String Name){
        Account acc = new Account();
        acc.Name = Name;
        
        insert acc;
        return acc;
    }
    
    @HttpPut
    global static List<Account> updateAccData(){
        System.debug(RestContext.request.requestBody.toString());
        String requestBody = RestContext.request.requestBody.toString();// getting the body and converting it into String
        
        AccountWrapper awObj = parse(requestBody);
        
        System.debug(awObj.records.size());
        
        List<Account> accList = new List<Account>();
        
        for(Record record : awObj.records){
            accList.add(new Account(Id = record.Id, Name = record.Name));
        }
        
        try{
            if(accList.size()>0){
                update accList;
                return accList;
            }
        }catch(Exception ex){
            return null; 
        }
        
        return null;
    }
    //Method
    public static AccountWrapper parse(String json){
        return (AccountWrapper)System.JSON.deserialize(json, AccountWrapper.class);
    }
    // Wrapper Class 
    public class AccountWrapper{
        public Record[] records;
    }
    
    public class Record {
        public String Id;	
        public String Name;	
        public Record(String Id, String Name){
            this.Id = Id;
            this.Name = Name;
        }
    }
    
}