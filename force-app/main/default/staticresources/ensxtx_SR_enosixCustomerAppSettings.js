{
    "$schema": "../staticresources/ensxtx_SR_CustomerAppSettings_schema.json",
    "Customer": {
        "DefaultCustomer": {
            "showSalesData": true,
            "showCompanyData": true,
            "showPartnerData": true,
            "autoInvoke": false,
            "saveToSObject": true,
            "isUpdateAllowed": false,
            "accountGroups":[
                {
                    "Id": "0001",
                    "Description": "Oregon Tool Sold-to party"
                }
            ],
            "languages":[
                {
                    "Id": "EN",
                    "Description": "English"
                },
                {
                    "Id": "DE",
                    "Description": "German"
                }
            ],
            "salesOrgToFilter": ["0310", "0050"],
            "Fields": {
                "Default": {
                    "Header": {
                        "CustomerNumber": {"display": true},
                        "CustomerAccountGroup": {"display": true, "edit": false, "required": false},
                        "Name": {"display": true, "edit": false, "required": true},
                        "Name2": {"display": false, "edit": true, "required": false},
                        "PhoneNumber": {"display": true, "edit": false, "required": false},
                        "FaxNumber": {"display": false, "edit": true, "required": false},
                        "Street": {"display": true, "edit": false, "required": true},
                        "City": {"display": true, "edit": false, "required": false},
                        "Region": {"display": true, "edit": false, "required": false},
                        "PostalCode": {"display": true, "edit": false, "required": true},
                        "Country": {"display": true, "edit": false, "required": true},
                        "Language": {"display": true, "edit": true, "required": true},
                        "EmailAddress": {"display": true, "edit": false, "required": false},
                        "TransportationZone": {"display": false, "edit": false, "required": true},
                        "Attribute7": {"display": true, "edit": false, "required": true},
                        "SearchTerm1": {"display": true, "edit": false, "required": true}
                    },
                    "CompanyData": {
                        "CompanyCode": {"display": true, "edit": false, "required": true},
                        "ReconciliationAccount": {"display": true, "edit": false, "required": true},
                        "PaymentTerms": {"display": true, "edit": false, "required": false},
                        "SortKey": {"display": true, "edit": false, "required": false},
                        "PlanningGroup": {"display": true, "edit": false, "required": false},
                        "ToleranceGroup": {"display": true, "edit": false, "required": false},
                        "PaymentTermsKeyForCreditMemos": {"display": true, "edit": false, "required": false},
                        "DunningProcedure": {"display": true, "edit": false, "required": false},
                        "DunningAccountingClerk": {"display": true, "edit": false, "required": false},
                        "AccountingClerkAbbreviation": {"display": true, "edit": false, "required": false},
                        "IndicatorForPeriodicAccountStatements": {"display": true, "edit": false, "required": false}
                    },
                    "SalesData": {
                        "SalesOrganization": {"display": true, "edit": false, "required": true},
                        "DistributionChannel": {"display": true, "edit": false, "required": true},
                        "Division": {"display": true, "edit": false, "required": true},
                        "SalesOffice": {"display": true, "edit": false, "required": true},
                        "SalesGroup": {"display": true, "edit": false, "required": true},
                        "SalesDistrict": {"display": true, "edit": false, "required": false},
                        "PriceGroup": {"display": false, "edit": true, "required": false},
                        "PricingProcedure": {"display": false, "edit": true, "required": true},
                        "PriceList": {"display": false, "edit": true, "required": false},
                        "ShippingConditions": {"display": false, "edit": true, "required": true},
                        "PaymentTerms": {"display": false, "edit": true, "required": true},
                        "IncoTerms1": {"display": false, "edit": true, "required": true},
                        "IncoTerms2": {"display": false, "edit": true, "required": true},
                        "DeliveryPlant": {"display": false, "edit": true, "required": false},
                        "CurrencyKey": {"display": false, "edit": true, "required": true},
                        "CustomerGroup": {"display": true, "edit": false, "required": false},
                        "ABCClass": {"display": true, "edit": true, "required": false},
                        "DeliveryPriority": {"display": true, "edit": false, "required": true}
                    }
                },
                "Update": {
                    "SalesData": {
                        "SalesOrganization": {"display": true, "edit": false, "required": false},
                        "DistributionChannel": {"display": true, "edit": false, "required": false},
                        "Division": {"display": false, "edit": false, "required": false},
                        "SalesOffice": {"display": true, "edit": true, "required": false},
                        "SalesGroup": {"display": true, "edit": true, "required": false},
                        "SalesDistrict": {"display": true, "edit": true, "required": false},
                        "PriceGroup": {"display": false, "edit": true, "required": false},
                        "PricingProcedure": {"display": false, "edit": true, "required": false},
                        "PriceList": {"display": false, "edit": true, "required": false},
                        "ShippingConditions": {"display": false, "edit": true, "required": false},
                        "PaymentTerms": {"display": false, "edit": true, "required": false},
                        "IncoTerms1": {"display": false, "edit": true, "required": false},
                        "IncoTerms2": {"display": false, "edit": true, "required": false},
                        "DeliveryPlant": {"display": false, "edit": true, "required": false},
                        "CurrencyKey": {"display": true, "edit": true, "required": false}
                    }
                }
            }
        }
    }
}