public class AccountContactLWC {
    
    
    public static Account myMethod(String accId){
        Account accRec = [SELECT Name,Industry FROM Account Where Id =:accId];
           return accRec;
    }  

}