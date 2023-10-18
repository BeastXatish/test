public class accountDataTableController {

    @AuraEnabled(cacheable = true)
    public static List<Account> getAccList(){
        return [Select Id ,Name,AccountNumber From Account Limit 10];
    }
     @AuraEnabled
    public static String updatedAccount(Object objInstance){
        system.debug('Data'+objInstance);
        List<Account> accList = (List<Account>)JSON.deserialize(JSON.serialize(objInstance), List<Account>.class);
        if(!accList.isEmpty()){
            update accList;
            return 'Done';
        }
      return 'Failed';
    }
}