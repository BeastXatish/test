@isTest
public class ensxtx_TSTD_Customer_Detail
{
    @isTest
    public static void test_customerDetail()
    {
        ensxtx_DS_Customer_Detail customerDetail = createCustomerDetail();
    }

    public static ensxtx_DS_Customer_Detail createCustomerDetail()
    {
        ensxtx_DS_Customer_Detail customerDetail = new ensxtx_DS_Customer_Detail();
        customerDetail.CustomerAccountGroup = '1';
        customerDetail.Name = 'Bob';
        customerDetail.Name2 = 'Bob';
        customerDetail.PhoneNumber = '999';
        customerDetail.FaxNumber = '000';
        customerDetail.StreetAddress = '111 Street';
        customerDetail.City = 'Dayton';
        customerDetail.Region = 'OH';
        customerDetail.PostalCode = '333';
        customerDetail.Country = 'US';
        customerDetail.CustomerNumber = '111';
        customerDetail.SearchTerm1 = 'Hello';
        customerDetail.EmailAddress = 'test@test.com';
        customerDetail.Street2 = 'test';
        customerDetail.District = 'test';
        customerDetail.TransportationZone = 'test';
        customerDetail.Language = 'EN';
        customerDetail.Attribute7 = 'test';
        customerDetail.IsSuccess = true;

        ensxtx_DS_Customer_Detail.SALES_TEXT salesText = new ensxtx_DS_Customer_Detail.SALES_TEXT();
        salesText.TextLanguage = 'E';
        customerDetail.SALES_TEXT = new List<ensxtx_DS_Customer_Detail.SALES_TEXT>{salesText};

        ensxtx_DS_Customer_Detail.COMPANY_DATA companyData = new ensxtx_DS_Customer_Detail.COMPANY_DATA();
        companyData.CompanyCode = '1';
        companyData.ReconciliationAccount = '1';
        companyData.PaymentTerms = '1';
        companyData.RecordPaymentHistoryIndicator = true;
        companyData.IndicatorForPeriodicAccountStatements = 'test';
        companyData.SortKey = '1';
        companyData.PlanningGroup ='1';
        companyData.InterestCalculatioIndicator ='1';
        companyData.ToleranceGroup = '1';
        companyData.PaymentTermsKeyForCreditMemos = '1';
        companyData.DunningAccountingClerk = '1';
        companyData.DunningProcedure ='1';
        companyData.AccountingClerkAbbreviation = '1';
        companyData.InterestCycle = '1';

        customerDetail.COMPANY_DATA = new List<ensxtx_DS_Customer_Detail.COMPANY_DATA>{companyData};

        ensxtx_DS_Customer_Detail.SALES_DATA salesData = new ensxtx_DS_Customer_Detail.SALES_DATA();
        salesData.SalesOrganization = '1111';
        salesData.DistributionChannel = '111';
        salesData.Division = '0';
        salesData.SalesGroup = '1';
        salesData.SalesDistrict = '1';
        salesData.SalesOffice = '1';
        salesData.PriceGroup = '1';
        salesData.PriceListType = '2';
        salesData.ShippingConditions = '1';
        salesData.DeliveryPlant = '1';
        salesData.PaymentTerms = '1';
        salesData.IncoTerms1 = '1';
        salesData.IncoTerms2 = '2';
        salesData.CurrencyKey = 'US';
        salesData.AccountAssignmentGroup = '1';
        salesData.CustomerPricingProcedure = '3';
        salesData.CustomerBlock = '3';
        salesData.ExchangeRateType = '1';
        salesData.StatisticsGroup = '1';
        salesData.ABCClass = '1';
        salesData.DeliveryPriority = '1';
        salesData.Rebate = true;
        salesData.TaxClassification = '1';
        salesData.CustomerGroup = '1';
        salesData.CustomerGroup1 = '1';
        salesData.CustomerGroup3 = '1';
        salesData.CustomerGroup4 = '1';
        salesData.CustomerGroup5 = '1';
        customerDetail.SALES_DATA = new List<ensxtx_DS_Customer_Detail.SALES_DATA>{salesData};

        ensxtx_DS_Customer_Detail.TAX_CLASSIFICATION tax = new ensxtx_DS_Customer_Detail.TAX_CLASSIFICATION();
        tax.CountryCode = 'US';
        tax.TaxCategory = '1';
        tax.TaxClassification = '1';
        customerDetail.TAX_CLASSIFICATION = new List<ensxtx_DS_Customer_Detail.TAX_CLASSIFICATION>{tax};

        ensxtx_DS_Customer_Detail.PARTNERS part1 = new ensxtx_DS_Customer_Detail.PARTNERS();
        part1.City = 'US';
        part1.ContactFirstName = '1';
        part1.ContactLastName = '1';
        part1.ContactNumber = '12345667890';
        part1.CountryKey = 'US';
        part1.DefaultPartner = true;
        part1.DistributionChannel = 'test';
        part1.District = 'test';
        part1.Division = 'test';
        part1.DivisionName = 'test';
        part1.HouseNumber = '123456';
        part1.PartnerFunction = 'PE';
        part1.PartnerFunctionInternal = 'test';
        part1.PartnerFunctionName = 'test';
        part1.PartnerName = 'test';
        part1.PartnerNumber = '123456';
        part1.PersonnelFirstName = 'test';
        part1.PersonnelLastName = 'test';
        part1.PersonnelNumber = '123456';
        part1.PostalCode = '123456';
        part1.Region = 'MH';
        part1.SalesOrganization = 'test';
        part1.SalesOrganizationName = 'test';
        part1.Street = 'test';
        part1.VendorName = 'test';
        part1.VendorNumber = '123456';
        customerDetail.PARTNERS = new List<ensxtx_DS_Customer_Detail.PARTNERS>{part1};

        return customerDetail;
    }
}