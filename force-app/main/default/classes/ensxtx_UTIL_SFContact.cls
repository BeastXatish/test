public with sharing class ensxtx_UTIL_SFContact
{
    private static final ensxsdk.Logger logger = new ensxsdk.Logger(ensxtx_UTIL_SFContact.class);

    // Returns the field name which stores the SAP Contact number
    public static String ContactFieldName
    {
        get
        {
            return (String)ensxtx_UTIL_AppSettings.getValue(ensxtx_UTIL_AppSettings.EnterpriseApp, 'Contact.ContactFieldName', 'FLD_ContactPersonNumber__c');
        }
    }

    // Returns the field name which stores the SAP Customer number
    public static String ContactCustomerFieldName
    {
        get
        {
            return (String)ensxtx_UTIL_AppSettings.getValue(ensxtx_UTIL_AppSettings.EnterpriseApp, 'Contact.ContactCustomerFieldName', 'FLD_CustomerNumber__c');
        }
    }

    // getContactFromId()
    //
    // Get the contact from the given Id
    public static Contact getContactFromId(Id value)
    {
        Contact result = null;

        try
        {
            if (null != value)
            {
                result = Database.query(
                    'SELECT Id, FirstName, LastName, Phone, AccountId, Department, Email, ' + 
                    'Fax, MobilePhone, Title, ' + ensxtx_UTIL_SFContact.ContactFieldName + 
                    ' FROM Contact WHERE Id = \'' + value + '\' LIMIT 1');
            }
        }
        catch (Exception e) {}
        return result;
    }

    public static String getContactNumberFromContact(Contact contact)
    {
        return (String) contact.get(ensxtx_UTIL_SFContact.ContactFieldName);
    }

    public static void setContactContactNumber(Contact contact, string contactNumber)
    {
        contact.put(ensxtx_UTIL_SFContact.ContactFieldName, contactNumber);
    }
}