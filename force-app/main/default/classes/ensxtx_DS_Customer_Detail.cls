public with sharing class ensxtx_DS_Customer_Detail
{
    // HEADER
    @AuraEnabled public String CustomerNumber { get; set; }
    @AuraEnabled public String CustomerAccountGroup { get; set; }
    @AuraEnabled public String Name { get; set; }
    @AuraEnabled public String Name2 { get; set; }
    @AuraEnabled public String PhoneNumber { get; set; }
    @AuraEnabled public String FaxNumber { get; set; }
    @AuraEnabled public String EmailAddress { get; set; }
    @AuraEnabled public String StreetAddress { get; set; }
    @AuraEnabled public String Street2 { get; set; }
    @AuraEnabled public String City { get; set; }
    @AuraEnabled public String District { get; set; }
    @AuraEnabled public String Region { get; set; }
    @AuraEnabled public String PostalCode { get; set; }
    @AuraEnabled public String Country { get; set; }
    @AuraEnabled public String SearchTerm1 { get; set; }
    @AuraEnabled public Boolean IsSuccess { get; set; }
    @AuraEnabled public String TransportationZone { get; set; }
    @AuraEnabled public String Language { get; set; }
    @AuraEnabled public String Attribute7 { get; set; }

    @AuraEnabled public List<SALES_TEXT> SALES_TEXT { get; set; }
    @AuraEnabled public List<COMPANY_DATA> COMPANY_DATA { get; set; }
    @AuraEnabled public List<SALES_DATA> SALES_DATA { get; set; }
    @AuraEnabled public List<TAX_CLASSIFICATION> TAX_CLASSIFICATION { get; set; }
    @AuraEnabled public List<PARTNERS> PARTNERS { get; set; }

    //SALES_TEXT
    public class SALES_TEXT
    {
        @AuraEnabled public String TextLanguage { get; set; }
    }

    //COMPANY_DATA
    public class COMPANY_DATA
    {
        @AuraEnabled public String CompanyCode { get; set; }
        @AuraEnabled public String ReconciliationAccount { get; set; }
        @AuraEnabled public String PaymentTerms { get; set; }
        @AuraEnabled public Boolean RecordPaymentHistoryIndicator { get; set; }
        @AuraEnabled public String IndicatorForPeriodicAccountStatements { get; set; }
        @AuraEnabled public String SortKey { get; set; }
        @AuraEnabled public String PlanningGroup { get; set; }
        @AuraEnabled public String InterestCalculatioIndicator { get; set; }
        @AuraEnabled public String ToleranceGroup { get; set; }
        @AuraEnabled public String PaymentTermsKeyForCreditMemos { get; set; }
        @AuraEnabled public String DunningProcedure { get; set; }
        @AuraEnabled public String AccountingClerkAbbreviation { get; set; }
        @AuraEnabled public String InterestCycle { get; set; }
        @AuraEnabled public String DunningAccountingClerk { get; set; }
    }

        //PARTNERS
    public class PARTNERS
    {
        @AuraEnabled public String SalesOrganization { get; set; }
        @AuraEnabled public String SalesOrganizationName { get; set; }
        @AuraEnabled public String DistributionChannel { get; set; }
        @AuraEnabled public Boolean DistributionChannelName { get; set; }
        @AuraEnabled public String Division { get; set; }
        @AuraEnabled public String DivisionName { get; set; }
        @AuraEnabled public String PartnerFunction { get; set; }
        @AuraEnabled public String PartnerFunctionInternal { get; set; }
        @AuraEnabled public String PartnerFunctionName { get; set; }
        @AuraEnabled public String PartnerNumber { get; set; }
        @AuraEnabled public String PartnerName { get; set; }
        @AuraEnabled public String VendorNumber { get; set; }
        @AuraEnabled public String VendorName { get; set; }
        @AuraEnabled public String ContactNumber { get; set; }
        @AuraEnabled public String ContactFirstName { get; set; }
        @AuraEnabled public String ContactLastName { get; set; }
        @AuraEnabled public String PersonnelNumber { get; set; }
        @AuraEnabled public String PersonnelFirstName { get; set; }
        @AuraEnabled public String PersonnelLastName { get; set; }
        @AuraEnabled public String HouseNumber { get; set; }
        @AuraEnabled public String Street { get; set; }
        @AuraEnabled public String City { get; set; }
        @AuraEnabled public String District { get; set; }
        @AuraEnabled public String PostalCode { get; set; }
        @AuraEnabled public String Region { get; set; }
        @AuraEnabled public String CountryKey { get; set; }
        @AuraEnabled public Boolean DefaultPartner { get; set; }
    }

    //SALES_DATA
    public class SALES_DATA
    {
        @AuraEnabled public String SalesOrganization { get; set; }
        @AuraEnabled public String DistributionChannel { get; set; }
        @AuraEnabled public String Division { get; set; }
        @AuraEnabled public String SalesDistrict { get; set; }
        @AuraEnabled public String SalesOffice { get; set; }
        @AuraEnabled public String SalesGroup { get; set; }
        @AuraEnabled public String PriceGroup { get; set; }
        @AuraEnabled public String PriceListType { get; set; }
        @AuraEnabled public String ShippingConditions { get; set; }
        @AuraEnabled public String DeliveryPlant { get; set; }
        @AuraEnabled public String PaymentTerms { get; set; }
        @AuraEnabled public String IncoTerms1 { get; set; }
        @AuraEnabled public String IncoTerms2 { get; set; }
        @AuraEnabled public String CurrencyKey { get; set; }
        @AuraEnabled public String AccountAssignmentGroup { get; set; }
        @AuraEnabled public String CustomerPricingProcedure { get; set; }
        @AuraEnabled public String CustomerBlock { get; set; }
        @AuraEnabled public String ExchangeRateType { get; set; }
        @AuraEnabled public String StatisticsGroup { get; set; }
        @AuraEnabled public String ABCClass { get; set; }
        @AuraEnabled public String DeliveryPriority { get; set; }
        @AuraEnabled public Boolean Rebate { get; set; }
        @AuraEnabled public String TaxClassification { get; set; }
        @AuraEnabled public String CustomerGroup1 { get; set; }
        @AuraEnabled public String CustomerGroup3 { get; set; }
        @AuraEnabled public String CustomerGroup4 { get; set; }
        @AuraEnabled public String CustomerGroup5 { get; set; }
        @AuraEnabled public String CustomerGroup { get; set; }
    }

    //TAX_CLASSIFICATION
    public class TAX_CLASSIFICATION
    {
        @AuraEnabled public String CountryCode { get; set; }
        @AuraEnabled public String TaxCategory { get; set; }
        @AuraEnabled public String TaxClassification { get; set; }
    }

    // Constructor
    public ensxtx_DS_Customer_Detail()
    {
        this.COMPANY_DATA = new List<ensxtx_DS_Customer_Detail.COMPANY_DATA>();
        this.SALES_DATA = new List<ensxtx_DS_Customer_Detail.SALES_DATA>();
        this.SALES_TEXT = new List<ensxtx_DS_Customer_Detail.SALES_TEXT>();
        this.TAX_CLASSIFICATION = new List<ensxtx_DS_Customer_Detail.TAX_CLASSIFICATION>();
        this.PARTNERS = new List<ensxtx_DS_Customer_Detail.PARTNERS>();
    }
}