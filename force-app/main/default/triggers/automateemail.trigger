trigger automateemail on Account (after insert) {
    
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    // We need to get the user email address as well
    User usobj = [SELECT id, Profile.Name, Email from user where Profile.Name = 'System Administrator'];
    
    for(Account acc: Trigger.new){
        if(usobj.Email !=null){
            // assigining a single mail to send
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setSubject('An Account has been Created' +acc.Name);
            mail.setPlainTextBody('This is the sample body for the email');
            //Assigning the receiver Mail Address
            mail.toAddresses = new String[]{usobj.Email};
                mails.add(mail);
            
        }
        if(mails.size()>0){
            Messaging.sendEmail(mails);
        }
        // Messaging.sendEmail(mails) " is used to send the list of mails
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        //we are checking if the mails are sent or not.
        if (results[0].success)
        {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: '+ results[0].errors[0].message);
        }
    }
    
}