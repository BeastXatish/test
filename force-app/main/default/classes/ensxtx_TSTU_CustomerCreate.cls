@isTest
public class ensxtx_TSTU_CustomerCreate
{
    public class MOC_ensxtx_SBO_EnosixCustomer_Detail implements ensxsdk.EnosixFramework.DetailSBOGetMock,
            ensxsdk.EnosixFramework.DetailSBOSaveMock, ensxsdk.EnosixFramework.DetailSBOCommandMock
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

        public ensxsdk.EnosixFramework.DetailObject executeGetDetail(object key)
        {
            ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer result = new ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer();
            createResult(result);
            result.setSuccess(this.success);
            return result;
        }

        public ensxsdk.EnosixFramework.DetailObject executeSave(ensxsdk.EnosixFramework.DetailObject obj)
        {
            ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer result = (ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer) obj;
            createResult(result);
            result.setSuccess(this.success);
            if (throwException)
            {
                throw new CalloutException();
            }
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
            salesData.SalesOrganization = '1111';
            salesData.DistributionChannel = '111';
            salesData.Division = '0';
            result.SALES_DATA.add(salesData);
            result.COMPANY_DATA.add(new ensxtx_SBO_EnosixCustomer_Detail.COMPANY_DATA());
            result.PAYMENT_DATA.add(new ensxtx_SBO_EnosixCustomer_Detail.PAYMENT_DATA());
            result.SALES_TEXT.add(new ensxtx_SBO_EnosixCustomer_Detail.SALES_TEXT());
            result.CONTACTS.add(new ensxtx_SBO_EnosixCustomer_Detail.CONTACTS());
            result.CustomerNumber = 'CustomerNumber';
            result.CountryKey = 'US';
        }
    }

    @isTest
    public static void test_properties()
    {
        String createType = ensxtx_UTIL_CustomerCreate.PARTNER_TYPE;
        createType = ensxtx_UTIL_CustomerCreate.CUSTOMER_TYPE;

        ensxtx_UTIL_CustomerCreate.SFObject sfObject = new ensxtx_UTIL_CustomerCreate.SFObject();
        sfObject.sfObjectType = 'test';
        sfObject.sfObjectLabel = 'label';
        sfObject.sfMainObject = new Account();
        sfObject.createType = 'Create';
        sfObject.customerNumber = '1111';
        sfObject.parentCustomerNumber = '111';
        sfObject.status = 'Create';
        sfObject.includeSalesData = true;
        sfObject.includeCompanyData = true;
    }

    @isTest
    public static void test_getSFAccount()
    {
        Account newAccount = ensxtx_TSTU_SFTestObject.createTestAccount();
        ensxtx_TSTU_SFTestObject.upsertWithRetry(newAccount);

        SObject acct = ensxtx_UTIL_CustomerCreate.getSFAccountInfo(newAccount.Id);
        ensxtx_DS_Customer_Detail customerDetail = new ensxtx_DS_Customer_Detail();
        try
        {
            customerDetail = ensxtx_UTIL_CustomerCreate.mapCustomerDetailFromSFObject(customerDetail, acct);
        }
        catch(Exception e) { }
        
        //ensxtx_UTIL_CustomerCreate.saveCustomerInfoToSObject('1111', acct);
    }

    @isTest
    public static void test_convertToSBOAndObject()
    {
        MOC_ensxtx_SBO_EnosixCustomer_Detail mocEnosixCustomerDetail = new MOC_ensxtx_SBO_EnosixCustomer_Detail();
        ensxsdk.EnosixFramework.setMock(ensxtx_SBO_EnosixCustomer_Detail.class, mocEnosixCustomerDetail);

        ensxtx_DS_Customer_Detail customerDetail = ensxtx_TSTD_Customer_Detail.createCustomerDetail();
        ensxtx_UTIL_CustomerCreate.SFObject sfObject = new ensxtx_UTIL_CustomerCreate.SFObject();
        sfObject.includeSalesData = true;
        sfObject.includeCompanyData = true;
        ensxsdk.EnosixFramework.DetailObject detailObject = ensxtx_UTIL_CustomerCreate.convertToSBO(null, customerDetail, sfObject, 'create');
        detailObject = ensxtx_UTIL_CustomerCreate.convertToSBO(detailObject, customerDetail, sfObject, 'create');
        ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer sboObject = (ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer) detailObject;
        ensxtx_SBO_EnosixCustomer_Detail.SALES_TEXT newSalesText = new ensxtx_SBO_EnosixCustomer_Detail.SALES_TEXT();
        newSalesText.TextLanguage = 'TextLanguage';
        sboObject.SALES_TEXT.add(newSalesText);
        ensxtx_SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION newTaxData = new ensxtx_SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION();
        newTaxData.CountryCode = 'US';
        newTaxData.TaxClassification = 'TaxClassification';
        sboObject.TAX_CLASSIFICATION.add(newTaxData);
        ensxtx_UTIL_CustomerCreate.convertToObject(detailObject, customerDetail);

        ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer enosixCustomer = (ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer) detailObject;

        ensxtx_UTIL_CustomerCreate.addPartnerToParentCustomer(enosixCustomer, '111', 'SH');
        try {
            ensxtx_UTIL_CustomerCreate.addPartnerToParentCustomer(new ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer(), '111', 'SH');
        } catch (Exception e) {}
        mocEnosixCustomerDetail.setSuccess(false);
        try {
            ensxtx_UTIL_CustomerCreate.addPartnerToParentCustomer(enosixCustomer, '111', 'SH');
        } catch (Exception e) {}
    }
}