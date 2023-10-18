@isTest
public class ensxtx_TSTC_CustomerCreate
{
    public class MOC_ensxtx_SBO_EnosixCustomer_Detail implements ensxsdk.EnosixFramework.DetailSBOInitMock,
        ensxsdk.EnosixFramework.DetailSBOGetMock, ensxsdk.EnosixFramework.DetailSBOSaveMock, ensxsdk.EnosixFramework.DetailSBOCommandMock
    {
        private boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.DetailObject executeInitialize(ensxsdk.EnosixFramework.DetailObject obj)
        {
            if (throwException) throw new CalloutException();

            ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer result = new ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer();
            createResult(result);
            result.setSuccess(this.success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            if (throwException) throw new CalloutException();

            ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer result = new ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer();
            createResult(result);
            result.setSuccess(this.success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            if (throwException) throw new CalloutException();
            
            ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer result = (ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer) obj;
            createResult(result);
            result.setSuccess(this.success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeCommand(String command, ensxsdk.EnosixFramework.DetailObject obj)
        {
            if (throwException) throw new CalloutException();

            ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer result = new ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer();
            result.setSuccess(success);
            return result;
        }

        private void createResult(ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer result)
        {
            ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA salesData = new ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA();
            salesData.SalesOrganization = 'SalesOrganization';
            salesData.DistributionChannel = 'DistributionChannel';
            salesData.Division = 'Division';
            result.SALES_DATA.add(salesData);
            result.COMPANY_DATA.add(new ensxtx_SBO_EnosixCustomer_Detail.COMPANY_DATA());
            result.PAYMENT_DATA.add(new ensxtx_SBO_EnosixCustomer_Detail.PAYMENT_DATA());
            result.SALES_TEXT.add(new ensxtx_SBO_EnosixCustomer_Detail.SALES_TEXT());
            result.CONTACTS.add(new ensxtx_SBO_EnosixCustomer_Detail.CONTACTS());
            result.CustomerNumber = 'CustomerNumber';
            result.CountryKey = 'US';
        }
    }

    public class MOC_ensxtx_RFC_SD_GET_COUNTRIES implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            ensxtx_RFC_SD_GET_COUNTRIES.RESULT result = new ensxtx_RFC_SD_GET_COUNTRIES.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_ensxtx_RFC_SD_GET_SALES_AREAS implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            ensxtx_RFC_SD_GET_SALES_AREAS.RESULT result = new ensxtx_RFC_SD_GET_SALES_AREAS.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_ensxtx_RFC_SD_GET_GROUP_OFFICE implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            ensxtx_RFC_SD_GET_GROUP_OFFICE.RESULT result = new ensxtx_RFC_SD_GET_GROUP_OFFICE.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_ensxtx_RFC_SD_GET_PRICING_STAT implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            ensxtx_RFC_SD_GET_PRICING_STAT.RESULT result = new ensxtx_RFC_SD_GET_PRICING_STAT.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_ensxtx_RFC_SD_GET_SHIP_INFO implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            ensxtx_RFC_SD_GET_SHIP_INFO.RESULT result = new ensxtx_RFC_SD_GET_SHIP_INFO.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_ensxtx_RFC_SD_GET_CURRENCY_LIST implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            ensxtx_RFC_SD_GET_CURRENCY_LIST.RESULT result = new ensxtx_RFC_SD_GET_CURRENCY_LIST.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    public class MOC_ensxtx_RFC_SD_GET_COMPANY_CODES implements ensxsdk.EnosixFramework.RFCMock
    {
        public boolean success = true;

        public void setSuccess(boolean successful)
        {
            this.success = successful;
        }

        private boolean throwException = false;

        public void setThrowException(boolean throwException)
        {
            this.throwException = throwException;
        }

        public ensxsdk.EnosixFramework.FunctionObject executeFunction()
        {
            if (throwException) throw new CalloutException();
            ensxtx_RFC_SD_GET_COMPANY_CODES.RESULT result = new ensxtx_RFC_SD_GET_COMPANY_CODES.RESULT();
            result.setSuccess(this.success);
            return result;
        }
    }

    @isTest
    public static void test_initSFObject()
    {
        Account newAccount = ensxtx_TSTU_SFTestObject.createTestAccount();
        ensxtx_TSTU_SFTestObject.upsertWithRetry(newAccount);

        Id pricebookId = ensxtx_UTIL_Pricebook.getStandardPriceBookId();
        Opportunity opp = ensxtx_TSTU_SFTestObject.createTestOpportunity();
        opp.AccountId = newAccount.Id;
        opp.Pricebook2Id = pricebookId;
        opp.Type = 'Renewal';
        ensxtx_TSTU_SFTestObject.upsertWithRetry(opp);

        try
        {
            ensxtx_CTRL_CustomerCreate.initSFObject(newAccount.Id);
        }
        catch(Exception e) { }

        try
        {
            ensxtx_CTRL_CustomerCreate.initSFObject(opp.Id);
        }
        catch(Exception e) { }

        Account shipAccount = ensxtx_TSTU_SFTestObject.createTestAccount();
        shipAccount.ParentId = newAccount.Id;
        ensxtx_TSTU_SFTestObject.upsertWithRetry(shipAccount);

        try
        {
            ensxtx_CTRL_CustomerCreate.initSFObject(shipAccount.Id);
        }
        catch(Exception e) { }
    }

    @isTest
    public static void test_initcustomerDetailFromSFObject()
    {
        Account newAccount = ensxtx_TSTU_SFTestObject.createTestAccount();
        ensxtx_TSTU_SFTestObject.upsertWithRetry(newAccount);

        ensxtx_DS_Customer_Detail customerDetail = new ensxtx_DS_Customer_Detail();
        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.initCustomerDetailFromSFObject(customerDetail, newAccount);
        ensxtx_CTRL_CustomerCreate.initCustomerDetailFromSFObject(null, null);
    }

    @isTest
    public static void test_getCountries()
    {
        MOC_ensxtx_RFC_SD_GET_COUNTRIES mocRfc = new MOC_ensxtx_RFC_SD_GET_COUNTRIES();
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_COUNTRIES.class, mocRfc);

        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.getCountries();

        mocRfc.setThrowException(true);
        response = ensxtx_CTRL_CustomerCreate.getCountries();
    }

    @isTest
    public static void test_getSalesAreas()
    {
        MOC_ensxtx_RFC_SD_GET_SALES_AREAS mocRfc = new MOC_ensxtx_RFC_SD_GET_SALES_AREAS();
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_SALES_AREAS.class, mocRfc);

        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.getSalesAreas();

        mocRfc.setThrowException(true);
        response = ensxtx_CTRL_CustomerCreate.getSalesAreas();
    }

    @isTest
    public static void test_getPricingStat()
    {
        MOC_ensxtx_RFC_SD_GET_PRICING_STAT mocRfc = new MOC_ensxtx_RFC_SD_GET_PRICING_STAT();
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_PRICING_STAT.class, mocRfc);

        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.getPricingStat();

        mocRfc.setThrowException(true);
        response = ensxtx_CTRL_CustomerCreate.getPricingStat();
    }

    @isTest
    public static void test_getGroupOffice()
    {
        MOC_ensxtx_RFC_SD_GET_GROUP_OFFICE mocRfc = new MOC_ensxtx_RFC_SD_GET_GROUP_OFFICE();
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_GROUP_OFFICE.class, mocRfc);

        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.getGroupOffice();

        mocRfc.setThrowException(true);
        response = ensxtx_CTRL_CustomerCreate.getGroupOffice();
    }

    @isTest
    public static void test_getShipInfo()
    {
        MOC_ensxtx_RFC_SD_GET_SHIP_INFO mocRfc = new MOC_ensxtx_RFC_SD_GET_SHIP_INFO();
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_SHIP_INFO.class, mocRfc);

        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.getShipInfo();

        mocRfc.setThrowException(true);
        response = ensxtx_CTRL_CustomerCreate.getShipInfo();
    }

    @isTest
    public static void test_getCurrency()
    {
        MOC_ensxtx_RFC_SD_GET_CURRENCY_LIST mocRfc = new MOC_ensxtx_RFC_SD_GET_CURRENCY_LIST();
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_CURRENCY_LIST.class, mocRfc);

        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.getCurrency();

        mocRfc.setThrowException(true);
        response = ensxtx_CTRL_CustomerCreate.getCurrency();
    }

    @isTest
    public static void test_getCompanyCodes()
    {
        MOC_ensxtx_RFC_SD_GET_COMPANY_CODES mocRfc = new MOC_ensxtx_RFC_SD_GET_COMPANY_CODES();
        ensxsdk.EnosixFramework.setMock(ensxtx_RFC_SD_GET_COMPANY_CODES.class, mocRfc);

        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.getCompanyCodes();

        mocRfc.setThrowException(true);
        response = ensxtx_CTRL_CustomerCreate.getCompanyCodes();
    }

    @isTest
    public static void test_initializeCustomerDetail()
    {
        MOC_ensxtx_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_ensxtx_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        ensxtx_DS_Customer_Detail customerDetail = ensxtx_TSTD_Customer_Detail.createCustomerDetail();

        Account newAccount = ensxtx_TSTU_SFTestObject.createTestAccount();
        ensxtx_TSTU_SFTestObject.upsertWithRetry(newAccount);

        ensxtx_UTIL_CustomerCreate.SFObject sfSObject = new ensxtx_UTIL_CustomerCreate.SFObject();
        sfSObject.sfMainObject = newAccount;
        sfSObject.createType = ensxtx_UTIL_CustomerCreate.PARTNER_TYPE;
        sfSObject.parentCustomerNumber = '111';

        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.initializeCustomerDetail(sfSObject, customerDetail);
        mocEnosixCustomerDetail.setThrowException(true);
        response = ensxtx_CTRL_CustomerCreate.initializeCustomerDetail(sfSObject, customerDetail);
    }

    @isTest
    public static void test_getCustomerDetail()
    {
        MOC_ensxtx_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_ensxtx_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.getCustomerDetail('TEST');
        mocEnosixCustomerDetail.setThrowException(true);
        response = ensxtx_CTRL_CustomerCreate.getCustomerDetail('TEST');
    }

    @isTest
    public static void test_createSAPCustomer()
    {
        MOC_ensxtx_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_ensxtx_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        ensxtx_DS_Customer_Detail customerDetail = ensxtx_TSTD_Customer_Detail.createCustomerDetail();

        Account newAccount = ensxtx_TSTU_SFTestObject.createTestAccount();
        ensxtx_TSTU_SFTestObject.upsertWithRetry(newAccount);

        ensxtx_UTIL_CustomerCreate.SFObject sfSObject = new ensxtx_UTIL_CustomerCreate.SFObject();
        sfSObject.sfMainObject = newAccount;
        sfSObject.createType = ensxtx_UTIL_CustomerCreate.PARTNER_TYPE;
        sfSObject.parentCustomerNumber = '111';

        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.createSAPCustomer(sfSObject, customerDetail);
        mocEnosixCustomerDetail.setThrowException(true);
        response = ensxtx_CTRL_CustomerCreate.createSAPCustomer(sfSObject, customerDetail);
    }

    @isTest
    public static void test_updateSAPCustomer()
    {
        MOC_ensxtx_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_ensxtx_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        ensxtx_DS_Customer_Detail customerDetail = ensxtx_TSTD_Customer_Detail.createCustomerDetail();

        Account newAccount = ensxtx_TSTU_SFTestObject.createTestAccount();
        ensxtx_TSTU_SFTestObject.upsertWithRetry(newAccount);

        ensxtx_UTIL_CustomerCreate.SFObject sfSObject = new ensxtx_UTIL_CustomerCreate.SFObject();
        sfSObject.sfMainObject = newAccount;
        sfSObject.createType = ensxtx_UTIL_CustomerCreate.PARTNER_TYPE;
        sfSObject.parentCustomerNumber = '111';

        ensxtx_UTIL_Aura.Response response = ensxtx_CTRL_CustomerCreate.updateSAPCustomer(sfSObject, customerDetail);
        mocEnosixCustomerDetail.setThrowException(true);
        response = ensxtx_CTRL_CustomerCreate.updateSAPCustomer(sfSObject, customerDetail);
    }
}