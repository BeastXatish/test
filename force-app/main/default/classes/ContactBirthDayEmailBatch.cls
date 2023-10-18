public class ContactBirthDayEmailBatch implements Database.Batchable<Sobject>{
    
    public Database.QueryLocator start(Database.BatchableContext dbc)
    {
        return Database.getQueryLocator('SELECT id, email , Birthdate,name from Contact WHERE Birthdate = TODAY');
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> listfromstartmethod)
    {	system.debug('inside execute');
        List<Messaging.SingleEmailMessage> emailList = new List <Messaging.SingleEmailMessage>();
        
        for(Contact con: listfromstartmethod)
        {
            Messaging.SingleEmailMessage singleMsg = new Messaging.SingleEmailMessage();
            //singleMsg.toaddresses = new List<String>{con.Email};
            singleMsg.setToAddresses(new List<String>{con.Email});
            singleMsg.subject = 'Opt Out Test Message';
            singleMsg.plainTextBody = 'Happy Birthday. '+ con.Name;
            emailList.add(singleMsg);
            
        }
        system.debug('emailList'+emailList);
        Messaging.SendEmailResult[] results = Messaging.sendEmail(emailList);
        system.debug('last exucute');
        
    }
    public void finish(Database.BatchableContext dbc)
    {
        
        
    }
}