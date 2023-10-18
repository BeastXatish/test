public class DeleteLWCaction {
    
    
    public static void Account(){
    List<Account> acc = [SELECT ID ,Name  FROM Account WHERE Name ='TestAction'];
      DELETE acc;
    }
    
}