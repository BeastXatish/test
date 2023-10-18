public class SoqlClass {
    
    public static void mymethod1()
    {
        //Comment
        List <Candidate__c> a1 = [select name from Candidate__c];
            
        for(Candidate__c a:a1)
        {
            System.debug(a.name);
        }
        
          
    }

}