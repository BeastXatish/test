public class ensxtx_UTIL_CustomerCreate {

    public static final String PARTNER_TYPE = 'Partner';
    public static final String CUSTOMER_TYPE = 'Customer';

    public class SFObject
    {
        @AuraEnabled public String sfObjectType { get; set; }
        @AuraEnabled public String sfObjectLabel { get; set; }
        @AuraEnabled public SObject sfMainObject { get; set; }
        @AuraEnabled public String createType { get; set; }
        @AuraEnabled public String customerNumber { get; set; }
        @AuraEnabled public String parentCustomerNumber { get; set; }
        @AuraEnabled public String status { get; set; }
        @AuraEnabled public Boolean includeSalesData { get; set; }
        @AuraEnabled public Boolean includeCompanyData { get; set; }
    }

    public static sObject getSFAccountInfo(Id recordId)
    {
        List<String> fields = new List<String>{
            'ParentId',
            'Fax',
            'BillingCountry',
            'BillingState',
            'ShippingStreet',
            'ShippingPostalCode',
            'ShippingCity',
            'ShippingStateCode',
            'ShippingCountryCode',
            'FLD_Email__c',
            'Dist_Channel__c',
            'Sales_District__c',
            'Sales_Group__c',
            'Name2__c',
            'SearchTerm__c',
            'ShippingStreet2__c',
            'Archiving_Flag__c',
            'Customer_Group__c',
            'ABC_Class__c',
            'Sales_Order_Block__c',
            'ShippingDistrict__c',
            'Sales_Org__c',
            'Sales_Office__c',
            'FLD_SAP_Account_Group__c'
        };

        return ensxtx_UTIL_SFAccount.getAccountById(recordId, fields);
    }

    // Mapping from SObject(Account) to ensxtx_DS_Customer_Detail
    public static ensxtx_DS_Customer_Detail mapCustomerDetailFromSFObject(
        ensxtx_DS_Customer_Detail customerDetail, SObject sfSObject)
    {
        Account acc = (Account) sfSObject;

        if (customerDetail == null) customerDetail = new ensxtx_DS_Customer_Detail();
        String fname = acc.Name;
        fname = fname.toUpperCase();
        customerDetail.Name = fname;
        customerDetail.Name2 = acc.Name2__c;
        customerDetail.PhoneNumber = acc.Phone;
        customerDetail.FaxNumber = acc.Fax;
        customerDetail.StreetAddress = acc.ShippingStreet;
        customerDetail.Street2 = acc.ShippingStreet2__c;
        customerDetail.City = acc.ShippingCity;
        customerDetail.District = acc.ShippingDistrict__c;
        customerDetail.PostalCode = acc.ShippingPostalCode;
        customerDetail.Region = acc.ShippingStateCode;
        customerDetail.Country = acc.ShippingCountryCode;
        customerDetail.CustomerNumber = (String) acc.get(ensxtx_UTIL_SFAccount.CustomerFieldName);
        customerDetail.CustomerAccountGroup = acc.FLD_SAP_Account_Group__c !=null ? acc.FLD_SAP_Account_Group__c : '0001';
        customerDetail.Language = 'EN';
        customerDetail.EmailAddress = acc.FLD_Email__c;
        customerDetail.Attribute7 = acc.Dist_Channel__c;
        customerDetail.SearchTerm1= acc.SearchTerm__c;

        // SALES DATA
        // New Sales Data and Company Data for new customer
        ensxtx_DS_Customer_Detail.SALES_DATA newSalesData = new ensxtx_DS_Customer_Detail.SALES_DATA();
        customerDetail.SALES_DATA = new List<ensxtx_DS_Customer_Detail.SALES_DATA>();
        newSalesData.SalesOrganization = acc.Sales_Org__c;
        newSalesData.DistributionChannel = acc.Dist_Channel__c;
        if(acc.Sales_Org__c != null && acc.Dist_Channel__c != null) newSalesData.Division = '10';
        newSalesData.SalesDistrict = acc.Sales_District__c;
        newSalesData.SalesGroup = acc.Sales_Group__c;
        newSalesData.CustomerGroup = acc.Customer_Group__c;
        newSalesData.ABCClass = acc.ABC_Class__c;
        newSalesData.CustomerBlock = acc.Sales_Order_Block__c;
        newSalesData.SalesOffice = acc.Sales_Office__c;
        customerDetail.SALES_DATA.add(newSalesData);

        // COMPANY DATA
        //ensxtx_DS_Customer_Detail.COMPANY_DATA newCompanyData = new ensxtx_DS_Customer_Detail.COMPANY_DATA();
        //customerDetail.COMPANY_DATA = new List<ensxtx_DS_Customer_Detail.COMPANY_DATA>();
        //customerDetail.COMPANY_DATA.add(newCompanyData);

        return customerDetail;
    }

    // Convert from ensxtx_DS_Customer_Detail to SBO Customer Detail
    public static ensxsdk.EnosixFramework.DetailObject convertToSBO(ensxsdk.EnosixFramework.DetailObject detailObj, 
        ensxtx_DS_Customer_Detail docObj, ensxtx_UTIL_CustomerCreate.SFObject sfSObject, String operation)
    {
        ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer sboObject;

        if (detailObj == null) sboObject = new ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer();
        else sboObject = (ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer) detailObj;

        // HEADER
        if (String.isNotEmpty(docObj.CustomerAccountGroup)) sboObject.CustomerAccountGroup = docObj.CustomerAccountGroup;
        if (String.isNotEmpty(docObj.Name)) sboObject.Name = docObj.Name;
        if (String.isNotEmpty(docObj.Name2)) sboObject.Name2 = docObj.Name2;
        if (String.isNotEmpty(docObj.PhoneNumber)) sboObject.TelephoneNO = docObj.PhoneNumber;
        if (String.isNotEmpty(docObj.FaxNumber)) sboObject.FaxNumber = docObj.FaxNumber;
        if (String.isNotEmpty(docObj.EmailAddress)) sboObject.EmailAddress = docObj.EmailAddress;
        if (String.isNotEmpty(docObj.StreetAddress)) sboObject.Street = docObj.StreetAddress;
        if (String.isNotEmpty(docObj.Street2)) sboObject.Street2 = docObj.Street2;
        if (String.isNotEmpty(docObj.City)) sboObject.City = docObj.City;
        if (String.isNotEmpty(docObj.District)) sboObject.District = docObj.District;
        if (String.isNotEmpty(docObj.Region)) sboObject.Region = docObj.Region;
        if (String.isNotEmpty(docObj.PostalCode)) sboObject.PostalCode = docObj.PostalCode;
        if (String.isNotEmpty(docObj.Country)) sboObject.CountryKey = docObj.Country;
        if(operation != 'initialize'){
            if (String.isNotEmpty(docObj.TransportationZone)) sboObject.TransportationZone = docObj.TransportationZone;
        }
        if (String.isNotEmpty(docObj.Language)) sboObject.Language = docObj.Language;
        if (String.isNotEmpty(docObj.Attribute7)) sboObject.Attribute7 = docObj.Attribute7;

        if(String.isNotEmpty(docObj.SearchTerm1)) {
            sboObject.SearchTerm1 = docObj.SearchTerm1;
        }
        else{
            String searchTermVar = sboObject.Name;
            if(searchTermVar.length() >= 20 ){
                searchTermVar = searchTermVar.substring(0, 20);
                List<String> filterLogicSplittedbySpace = searchTermVar.split(' '); //split by space and send only till first space.
                searchTermVar = filterLogicSplittedbySpace[0];
            }
            else{
                List<String> filterLogicSplittedbySpace = searchTermVar.split(' '); //split by space and send only till first space.
                searchTermVar = filterLogicSplittedbySpace[0];
            }
            sboObject.SearchTerm1 = searchTermVar;
        }

        //SALES_TEXT
        // Integer salesTot = docObj.SALES_TEXT.size();
        // for (Integer salesCnt = 0 ; salesCnt < salesTot ; salesCnt++)
        // {
        //     ensxtx_DS_Customer_Detail.SALES_TEXT salesTxt = docObj.SALES_TEXT[salesCnt];
        //     ensxtx_SBO_EnosixCustomer_Detail.SALES_TEXT sboSalesTxt = createNewSalesTextSBO(salesTxt);
        //     if (sboSalesTxt != null) sboObject.SALES_TEXT.add(sboSalesTxt);
        // }

        //COMPANY_DATA
        //if (sfSObject.includeCompanyData == true) {
        if(operation != 'initialize'){
            Integer cmpTot = docObj.COMPANY_DATA.size();
            for (Integer cmpCnt = 0 ; cmpCnt < cmpTot ; cmpCnt++)
            {
                ensxtx_DS_Customer_Detail.COMPANY_DATA cmpTxt = docObj.COMPANY_DATA[cmpCnt];
                ensxtx_SBO_EnosixCustomer_Detail.COMPANY_DATA sboCmpTxt = createNewCompanyDataSBO(cmpTxt);
                if (sboCmpTxt != null) sboObject.COMPANY_DATA.add(sboCmpTxt);
            }
        }
        //}

        //PARTNERS
        if(operation != 'initialize'){
            Integer partTot = docObj.PARTNERS.size();
            for (Integer partCnt = 0 ; partCnt < partTot ; partCnt++)
            {
                ensxtx_DS_Customer_Detail.PARTNERS partner = docObj.PARTNERS[partCnt];
                ensxtx_SBO_EnosixCustomer_Detail.PARTNERS sbopartner = createNewPartnerDataSBO(partner);
                if (sbopartner != null) sboObject.PARTNERS.add(sbopartner);
            }
        }

        //SALES_DATA
        if (sfSObject.includeSalesData == true) {
            Integer slsDTot = docObj.SALES_DATA.size();
            for (Integer slsCnt = 0 ; slsCnt < slsDTot ; slsCnt++)
            {
                ensxtx_DS_Customer_Detail.SALES_DATA salesData1 = docObj.SALES_DATA[slsCnt];
                ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA sboSlsData = createNewSalesDataSBO(salesData1, operation);
                if (sboSlsData != null) sboObject.SALES_DATA.add(sboSlsData);
            }
        }

        // TAX_CLASSIFICATION
        // Integer taxTot1 = docObj.TAX_CLASSIFICATION.size();
        // for (Integer taxCnt = 0 ; taxCnt < taxTot1 ; taxCnt++)
        // {
        //     ensxtx_DS_Customer_Detail.TAX_CLASSIFICATION taxData = docObj.TAX_CLASSIFICATION[taxCnt];
        //     ensxtx_SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION sboTaxCData = createNewTaxClassificationSBO(taxData);
        //     if (sboTaxCData != null) sboObject.TAX_CLASSIFICATION.add(sboTaxCData);
        // }

        return sboObject;
    }

    // private static ensxtx_SBO_EnosixCustomer_Detail.SALES_TEXT createNewSalesTextSBO(ensxtx_DS_Customer_Detail.SALES_TEXT salesText)
    // {
    //     ensxtx_SBO_EnosixCustomer_Detail.SALES_TEXT newSalesTxt;

    //     if (String.isNotEmpty(salesText.TextLanguage))
    //     {
    //         newSalesTxt = new ensxtx_SBO_EnosixCustomer_Detail.SALES_TEXT();

    //         newSalesTxt.TextLanguage = salesText.TextLanguage;
    //     }

    //     return newSalesTxt;
    // }

    private static ensxtx_SBO_EnosixCustomer_Detail.COMPANY_DATA createNewCompanyDataSBO(ensxtx_DS_Customer_Detail.COMPANY_DATA cmpData)
    {
        ensxtx_SBO_EnosixCustomer_Detail.COMPANY_DATA newCmpData;
        newCmpData = new ensxtx_SBO_EnosixCustomer_Detail.COMPANY_DATA();
        newCmpData.CompanyCode = cmpData.CompanyCode;
        newCmpData.RecordPaymentHistoryIndicator = cmpData.RecordPaymentHistoryIndicator;
        newCmpData.IndicatorForPeriodicAccountStatements = cmpData.IndicatorForPeriodicAccountStatements;
        newCmpData.ReconciliationAccount = cmpData.ReconciliationAccount;
        newCmpData.TermsofPaymentKey = cmpData.PaymentTerms;
        newCmpData.SortKey = cmpData.SortKey;
        newCmpData.PlanningGroup = cmpData.PlanningGroup;
        newCmpData.InterestCalculatioIndicator = cmpData.InterestCalculatioIndicator;
        newCmpData.ToleranceGroup = cmpData.ToleranceGroup;
        newCmpData.PaymentTermsKeyForCreditMemos = cmpData.PaymentTermsKeyForCreditMemos;
        newCmpData.DunningProcedure = cmpData.DunningProcedure;
        newCmpData.AccountingClerkAbbreviation = cmpData.AccountingClerkAbbreviation;
        newCmpData.InterestCycle = cmpData.InterestCycle;
        newCmpData.DunningAccountingClerk = cmpData.DunningAccountingClerk;
        return newCmpData;
    }

    private static ensxtx_SBO_EnosixCustomer_Detail.PARTNERS createNewPartnerDataSBO(ensxtx_DS_Customer_Detail.PARTNERS partnerData)
    {
        ensxtx_SBO_EnosixCustomer_Detail.PARTNERS newpartnerData;
        newpartnerData = new ensxtx_SBO_EnosixCustomer_Detail.PARTNERS();
        newpartnerData.SalesOrganization = partnerData.SalesOrganization;
        newpartnerData.DistributionChannel = partnerData.DistributionChannel;
        newpartnerData.Division = partnerData.Division;
        newpartnerData.PartnerFunction = partnerData.PartnerFunction;
        newpartnerData.PartnerFunctionInternal = partnerData.PartnerFunctionInternal;
        newpartnerData.PartnerFunctionName = partnerData.PartnerFunctionName;
        newpartnerData.PartnerNumber = partnerData.PartnerNumber;
        newpartnerData.PartnerName = partnerData.PartnerName;
        newpartnerData.VendorNumber = partnerData.VendorNumber;
        newpartnerData.VendorName = partnerData.VendorName;
        newpartnerData.ContactNumber = partnerData.ContactNumber;
        newpartnerData.ContactFirstName = partnerData.ContactFirstName;
        newpartnerData.ContactLastName = partnerData.ContactLastName;
        newpartnerData.PersonnelFirstName = partnerData.PersonnelFirstName;
        newpartnerData.PersonnelLastName = partnerData.PersonnelLastName;
        newpartnerData.HouseNumber = partnerData.HouseNumber;
        newpartnerData.Street = partnerData.Street;
        newpartnerData.City = partnerData.City;
        newpartnerData.District = partnerData.District;
        newpartnerData.PostalCode = partnerData.PostalCode;
        newpartnerData.Region = partnerData.Region;
        newpartnerData.CountryKey = partnerData.CountryKey;
        newpartnerData.DefaultPartner = partnerData.DefaultPartner;
        return newpartnerData;
    }

    private static ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA createNewSalesDataSBO(ensxtx_DS_Customer_Detail.SALES_DATA slsData, String operation)
    {
        ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA newSlsData;
        newSlsData = new ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA();
        newSlsData.SalesOrganization = slsData.SalesOrganization;
        newSlsData.DistributionChannel = slsData.DistributionChannel;
        newSlsData.Division = slsData.Division;
        newSlsData.SalesGroup = slsData.SalesGroup;
        newSlsData.SalesDistrict = slsData.SalesDistrict;
        newSlsData.CustomerGroup = slsData.CustomerGroup;
        newSlsData.SalesOffice = slsData.SalesOffice;
        newSlsData.ABCClass = slsData.ABCClass;
        
        if(operation != 'initialize'){
            newSlsData.CustomerGroup1 = slsData.CustomerGroup1;
            newSlsData.PriceGroup = slsData.PriceGroup;
            newSlsData.DeliveryPlant = slsData.DeliveryPlant;
            newSlsData.CustomerGroup4 = slsData.CustomerGroup4;
            newSlsData.CustomerGroup5 = slsData.CustomerGroup5;
            newSlsData.SalesOffice = slsData.SalesOffice;
            newSlsData.ShippingConditions = slsData.ShippingConditions;
            newSlsData.TermsofPaymentKey = slsData.PaymentTerms;
            newSlsData.IncotermsPart1 = slsData.IncoTerms1;
            newSlsData.IncotermsPart2 = slsData.IncoTerms2;
            newSlsData.CurrencyKey = slsData.CurrencyKey;
            newSlsData.AccountAssignmentGroup = slsData.AccountAssignmentGroup;
            newSlsData.CustomerPricingProcedure = slsData.CustomerPricingProcedure;
            newSlsData.PriceListType = slsData.PriceListType;
            newSlsData.ExchangeRateType = slsData.ExchangeRateType;
            newSlsData.StatisticsGroup = slsData.StatisticsGroup;
            newSlsData.ABCClass = slsData.ABCClass;
            newSlsData.CustomerBlock = slsData.CustomerBlock;
            newSlsData.DeliveryPriority = slsData.DeliveryPriority;
            newSlsData.Rebate = slsData.Rebate;
            newSlsData.TaxClassification = slsData.TaxClassification;
            newSlsData.CustomerGroup = slsData.CustomerGroup;
            newSlsData.CustomerGroup3 = slsData.CustomerGroup3;
        }
        return newSlsData;
    }

    // private static ensxtx_SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION createNewTaxClassificationSBO(ensxtx_DS_Customer_Detail.TAX_CLASSIFICATION taxData)
    // {
    //     ensxtx_SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION newTaxData;
    //     newTaxData = new ensxtx_SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION();
    //     newTaxData.CountryCode = taxData.CountryCode;
    //     newTaxData.TaxClassification = taxData.TaxClassification;
    //     return newTaxData;
    // }



    // Convert to from SBO TO ensxtx_DS_Customer_Detail object
    public static void convertToObject(ensxsdk.EnosixFramework.DetailObject detailObj, ensxtx_DS_Customer_Detail docObj)
    {
        ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer sboObject = (ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer) detailObj;

        // HEADER
        docObj.CustomerAccountGroup = sboObject.CustomerAccountGroup;
        docObj.Name = sboObject.Name;
        docObj.Name2 = sboObject.Name2;
        docObj.PhoneNumber = sboObject.TelephoneNO;
        docObj.FaxNumber = sboObject.FaxNumber;
        docObj.EmailAddress = sboObject.EmailAddress;
        docObj.StreetAddress = sboObject.Street;
        docObj.Street2 = sboObject.Street2;
        docObj.City = sboObject.City;
        docObj.District = sboObject.District;
        docObj.Region = sboObject.Region;
        docObj.PostalCode = sboObject.PostalCode;
        docObj.Country = sboObject.CountryKey;
        docObj.TransportationZone = sboObject.TransportationZone;
        docObj.Language = sboObject.Language;
        docObj.CustomerNumber = sboObject.CustomerNumber;
        docObj.IsSuccess = sboObject.isSuccess();
        docObj.SearchTerm1 = sboObject.SearchTerm1;

        // SALES_TEXT
        docObj.SALES_TEXT = new List<ensxtx_DS_Customer_Detail.SALES_TEXT>();
        List<ensxtx_SBO_EnosixCustomer_Detail.SALES_TEXT> salesTextList = sboObject.SALES_TEXT.getAsList();
        Integer salesTextTot = salesTextList.size();
        for (Integer cnt = 0 ; cnt < salesTextTot ; cnt++)
        {
            ensxtx_SBO_EnosixCustomer_Detail.SALES_TEXT salesTxt = salesTextList[cnt];
            docObj.SALES_TEXT.add(convertSBOSalesText(salesTxt));
        }

        // COMPANY_DATA
        docObj.COMPANY_DATA = new List<ensxtx_DS_Customer_Detail.COMPANY_DATA>();
        List<ensxtx_SBO_EnosixCustomer_Detail.COMPANY_DATA> cmpDatatList = sboObject.COMPANY_DATA.getAsList();
        Integer cmpDataTot = cmpDatatList.size();
        for (Integer cnt = 0 ; cnt < cmpDataTot ; cnt++)
        {
            ensxtx_SBO_EnosixCustomer_Detail.COMPANY_DATA cmpData = cmpDatatList[cnt];
            docObj.COMPANY_DATA.add(convertSBOCompanyData(cmpData));
        }

        // PARTNER
        docObj.PARTNERS = new List<ensxtx_DS_Customer_Detail.PARTNERS>();
        List<ensxtx_SBO_EnosixCustomer_Detail.PARTNERS> partnerDataList = sboObject.PARTNERS.getAsList();
        Integer partnerTot = partnerDataList.size();
        for (Integer cnt = 0 ; cnt < partnerTot ; cnt++)
        {
            ensxtx_SBO_EnosixCustomer_Detail.PARTNERS partnerData = partnerDataList[cnt];
            docObj.PARTNERS.add(convertSBOPartnerData(partnerData));
        }

        // SALES_DATA
        docObj.SALES_DATA = new List<ensxtx_DS_Customer_Detail.SALES_DATA>();
        List<ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA> slsDatatList = sboObject.SALES_DATA.getAsList();
        Integer slsDataTot = slsDatatList.size();
        for (Integer cnt = 0 ; cnt < slsDataTot ; cnt++)
        {
            ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA slsData = slsDatatList[cnt];
            docObj.SALES_DATA.add(convertSBOSalesData(slsData));
        }

        // TAX_CLASSIFICATION
        docObj.TAX_CLASSIFICATION = new List<ensxtx_DS_Customer_Detail.TAX_CLASSIFICATION>();
        List<ensxtx_SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION> taxList = sboObject.TAX_CLASSIFICATION.getAsList();
        Integer taxTot = taxList.size();
        for (Integer cnt = 0 ; cnt < taxTot ; cnt++)
        {
            ensxtx_SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION taxData = taxList[cnt];
            docObj.TAX_CLASSIFICATION.add(convertSBOTaxClassification(taxData));
        }
    }

    // Convert List of SBO SALES_TEXT to ensxtx_DS SALES_TEXT;
    private static ensxtx_DS_Customer_Detail.SALES_TEXT convertSBOSalesText(ensxtx_SBO_EnosixCustomer_Detail.SALES_TEXT sboTxt)
    {
        ensxtx_DS_Customer_Detail.SALES_TEXT newText = new ensxtx_DS_Customer_Detail.SALES_TEXT();
        newText.TextLanguage = sboTxt.TextLanguage;
        return newText;
    }

    // Convert List of SBO COMPANY_DATA to ensxtx_DS COMPANY_DATA;
    private static ensxtx_DS_Customer_Detail.COMPANY_DATA convertSBOCompanyData(ensxtx_SBO_EnosixCustomer_Detail.COMPANY_DATA sboCmpData)
    {
        ensxtx_DS_Customer_Detail.COMPANY_DATA newData = new ensxtx_DS_Customer_Detail.COMPANY_DATA();
        newData.CompanyCode = sboCmpData.CompanyCode;
        newData.RecordPaymentHistoryIndicator = sboCmpData.RecordPaymentHistoryIndicator;
        newData.IndicatorForPeriodicAccountStatements = sboCmpData.IndicatorForPeriodicAccountStatements;
        newData.ReconciliationAccount = sboCmpData.ReconciliationAccount;
        newData.PaymentTerms = sboCmpData.TermsofPaymentKey;
        newData.SortKey = sboCmpData.SortKey;
        newData.PlanningGroup = sboCmpData.PlanningGroup;
        newData.InterestCalculatioIndicator = sboCmpData.InterestCalculatioIndicator;
        newData.ToleranceGroup = sboCmpData.ToleranceGroup;
        newData.PaymentTermsKeyForCreditMemos = sboCmpData.PaymentTermsKeyForCreditMemos;
        newData.DunningProcedure = sboCmpData.DunningProcedure;
        newData.AccountingClerkAbbreviation = sboCmpData.AccountingClerkAbbreviation;
        newData.InterestCycle = sboCmpData.InterestCycle;
        newData.DunningAccountingClerk = sboCmpData.DunningAccountingClerk;
        return newData;
    }

    // Convert List of SBO COMPANY_DATA to ensxtx_DS COMPANY_DATA;
    private static ensxtx_DS_Customer_Detail.PARTNERS convertSBOPartnerData(ensxtx_SBO_EnosixCustomer_Detail.PARTNERS sboPartnerData)
    {
        ensxtx_DS_Customer_Detail.PARTNERS newPartnerData = new ensxtx_DS_Customer_Detail.PARTNERS();

        newPartnerData.SalesOrganization = sboPartnerData.SalesOrganization;
        newPartnerData.DistributionChannel = sboPartnerData.DistributionChannel;
        newPartnerData.Division = sboPartnerData.Division;
        newPartnerData.PartnerFunction = sboPartnerData.PartnerFunction;
        newPartnerData.PartnerFunctionInternal = sboPartnerData.PartnerFunctionInternal;
        newPartnerData.PartnerFunctionName = sboPartnerData.PartnerFunctionName;
        newPartnerData.PartnerNumber = sboPartnerData.PartnerNumber;
        newPartnerData.PartnerName = sboPartnerData.PartnerName;
        newPartnerData.VendorNumber = sboPartnerData.VendorNumber;
        newPartnerData.VendorName = sboPartnerData.VendorName;
        newPartnerData.ContactNumber = sboPartnerData.ContactNumber;
        newPartnerData.ContactFirstName = sboPartnerData.ContactFirstName;
        newPartnerData.ContactLastName = sboPartnerData.ContactLastName;
        newPartnerData.PersonnelFirstName = sboPartnerData.PersonnelFirstName;
        newPartnerData.PersonnelLastName = sboPartnerData.PersonnelLastName;
        newPartnerData.HouseNumber = sboPartnerData.HouseNumber;
        newPartnerData.Street = sboPartnerData.Street;
        newPartnerData.City = sboPartnerData.City;
        newPartnerData.District = sboPartnerData.District;
        newPartnerData.PostalCode = sboPartnerData.PostalCode;
        newPartnerData.Region = sboPartnerData.Region;
        newPartnerData.CountryKey = sboPartnerData.CountryKey;
        newPartnerData.DefaultPartner = sboPartnerData.DefaultPartner;

        return newPartnerData;
    }

    // Convert List of SBO SALES_DATA to ensxtx_DS SALES_DATA;
    private static ensxtx_DS_Customer_Detail.SALES_DATA convertSBOSalesData(ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA sboSalesData)
    {
        ensxtx_DS_Customer_Detail.SALES_DATA newSalesData = new ensxtx_DS_Customer_Detail.SALES_DATA();
        newSalesData.SalesOrganization = sboSalesData.SalesOrganization;
        newSalesData.DistributionChannel = sboSalesData.DistributionChannel;
        newSalesData.Division = sboSalesData.Division;
        newSalesData.SalesGroup = sboSalesData.SalesGroup;
        newSalesData.SalesOffice = sboSalesData.SalesOffice;
        newSalesData.SalesDistrict = sboSalesData.SalesDistrict;
        newSalesData.ShippingConditions = sboSalesData.ShippingConditions;
        newSalesData.DeliveryPlant = sboSalesData.DeliveryPlant;
        newSalesData.PaymentTerms = sboSalesData.TermsofPaymentKey;
        newSalesData.IncoTerms1 = sboSalesData.IncotermsPart1;
        newSalesData.IncoTerms2 = sboSalesData.IncotermsPart2;
        newSalesData.CurrencyKey = sboSalesData.CurrencyKey;
        newSalesData.AccountAssignmentGroup = sboSalesData.AccountAssignmentGroup;
        newSalesData.CustomerPricingProcedure = sboSalesData.CustomerPricingProcedure;
        newSalesData.PriceGroup = sboSalesData.PriceGroup;
        newSalesData.PriceListType = sboSalesData.PriceListType;
        newSalesData.ExchangeRateType = sboSalesData.ExchangeRateType;
        newSalesData.StatisticsGroup = sboSalesData.StatisticsGroup;
        newSalesData.ABCClass = sboSalesData.ABCClass;
        newSalesData.CustomerBlock = sboSalesData.CustomerBlock;
        newSalesData.DeliveryPriority = sboSalesData.DeliveryPriority;
        newSalesData.Rebate = sboSalesData.Rebate;
        newSalesData.TaxClassification = sboSalesData.TaxClassification;
        newSalesData.CustomerGroup1 = sboSalesData.CustomerGroup1;
        newSalesData.CustomerGroup3 = sboSalesData.CustomerGroup3;
        newSalesData.CustomerGroup4 = sboSalesData.CustomerGroup4;
        newSalesData.CustomerGroup5 = sboSalesData.CustomerGroup5;
        newSalesData.CustomerGroup = sboSalesData.CustomerGroup;
        return newSalesData;
    }

    // Convert List of SBO TAX_CLASSIFICATION to ensxtx_DS TAX_CLASSIFICATION;
    private static ensxtx_DS_Customer_Detail.TAX_CLASSIFICATION convertSBOTaxClassification(ensxtx_SBO_EnosixCustomer_Detail.TAX_CLASSIFICATION sboTax)
    {
        ensxtx_DS_Customer_Detail.TAX_CLASSIFICATION newTax = new ensxtx_DS_Customer_Detail.TAX_CLASSIFICATION();
        newTax.CountryCode = sboTax.CountryCode;
        newTax.TaxClassification = sboTax.TaxClassification;
        return newTax;
    }


    // Add the newly created Partner to the parent Customer
    public static void addPartnerToParentCustomer(ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer partnerDetail,
        String parentCustomerNumber, String partnerFunction)
    {
        ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer parentCustomerDetail;
        ensxtx_SBO_EnosixCustomer_Detail customerSBO = new ensxtx_SBO_EnosixCustomer_Detail();

        if (String.isNotEmpty(parentCustomerNumber)) {
            parentCustomerDetail = customerSBO.getDetail(parentCustomerNumber);
        }

        if (parentCustomerDetail != null) {
            ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA salesArea = findMatchingSalesArea(parentCustomerDetail, partnerDetail);

            if (null == salesArea)
            {
                throw new NoMatchingSalesAreaException(Label.Enosix_Customer_Message_NoMatchingSalesArea);
            }

            clearCustomerCollections(parentCustomerDetail);
            parentCustomerDetail.SALES_DATA.add(salesArea);

            ensxtx_SBO_EnosixCustomer_Detail.PARTNERS partner = new ensxtx_SBO_EnosixCustomer_Detail.PARTNERS();
            partner.SalesOrganization = salesArea.SalesOrganization;
            partner.DistributionChannel = salesArea.DistributionChannel;
            partner.Division = salesArea.Division;
            partner.PartnerFunction = partnerFunction;
            partner.PartnerNumber = partnerDetail.CustomerNumber;
            partner.PartnerName = partnerDetail.Name;

            parentCustomerDetail.PARTNERS.add(partner);

            ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer result = customerSBO.save(parentCustomerDetail);

            if (!result.isSuccess()) {
                ensxtx_UTIL_PageMessages.addFrameworkMessages(result.getMessages());
                throw new AddPartnerToCustomerException();
            }
        }
    }

    // Find the matching Sales Area when creating partner
    private static ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA findMatchingSalesArea(
        ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer customer,
        ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer partnerDetail)
    {
        ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA result = null;
        List<ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA> custSalesList = customer.SALES_DATA.getAsList();
        Integer salesTot1 = custSalesList.size();
        List<ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA> partnerSalesList = partnerDetail.SALES_DATA.getAsList();
        Integer salesTot2 = partnerSalesList.size();
        for (Integer salesCnt1 = 0 ; salesCnt1 < salesTot1 ; salesCnt1++)
        {
            ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA customerSalesArea = custSalesList[salesCnt1];
            for (Integer salesCnt2 = 0 ; salesCnt2 < salesTot2 ; salesCnt2++)
            {
                ensxtx_SBO_EnosixCustomer_Detail.SALES_DATA partnerSalesArea = partnerSalesList[salesCnt2];
                if (customerSalesArea.SalesOrganization == partnerSalesArea.SalesOrganization &&
                    customerSalesArea.DistributionChannel == partnerSalesArea.DistributionChannel &&
                    customerSalesArea.Division == partnerSalesArea.Division)
                {
                    result = customerSalesArea;
                    break;
                }
            }

            if (result != null) break;
        }

        return result;
    }

    private static void clearCustomerCollections(ensxtx_SBO_EnosixCustomer_Detail.EnosixCustomer customer)
    {
        if (customer.COMPANY_DATA.size() > 0) customer.COMPANY_DATA.clear();
        if (customer.SALES_DATA.size() > 0) customer.SALES_DATA.clear();
        if (customer.PAYMENT_DATA.size() > 0) customer.PAYMENT_DATA.clear();
        if (customer.PARTNERS.size() > 0) customer.PARTNERS.clear();
        if (customer.SALES_TEXT.size() > 0) customer.SALES_TEXT.clear();
        if (customer.USER_DEFINED.size() > 0) customer.USER_DEFINED.clear();
        if (customer.CONTACTS.size() > 0) customer.CONTACTS.clear();
    }

    // Save the customer number to the account
    public static void saveCustomerInfoToSObject(String customerNumber, SObject sfSObject)
    {
        Account account = (Account) sfSObject;
        account.put(ensxtx_UTIL_SFAccount.CustomerFieldName, customerNumber);

        upsert account;
    }

    public class NoMatchingSalesAreaException extends Exception {}
    public class AddPartnerToCustomerException extends Exception {}
}