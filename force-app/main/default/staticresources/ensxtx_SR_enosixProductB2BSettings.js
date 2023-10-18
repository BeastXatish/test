{
    "$schema": "../../staticresources/ensxtx_SR_SalesDocAppSettings_schema.json",
    "SalesDoc": {
        "DefaultOrder": {
            "itemNumberIncrement": 10,
            "bomItemNumberIncrement": 1,
            "sortOrderIncrement": 10,
            "autoSimulate": {
                "afterPartnerSelection": false,
                "afterItemAdd": false,
                "afterItemEditSave": false,
                "afterItemDelete": false,
                "afterItemClone": false,
                "afterItemConfiguration": false,
                "afterFieldUpdate": false,
                "afterSortItems": false
            },
            "showHeaderIncompletionLogs": false,
            "showItemIncompletionLogs": false,
            "incompletionLogsAsErrors": false,
            "enableBoMCountCommand": false,
            "enableBoMItemEdit": false,
            "updateLineItems": true,
            "deleteLineItems": false,
            "useConvertToObjectTrigger": false,
            "enableConfiguration": false,
            "SAPDocType": "Order",
            "SBODetailType": "SalesDocument",
            "DefaultDocType": "ZOR2",
            "DefaultDocTypeInternal": "ZOR2",
            "DefaultSalesOrganization": "3000",
            "DefaultDistributionChannel": "10",
            "DefaultDivision": "00",
            "sfInvokeFrom": "Commerce",
            "DocTypes": [],
            "salesAreasFromCustomer": true,
            "SalesAreas": [
            ],
            "optionValuesToInclude": {
                "Header": {
                    "Conditions": []
                },
                "Item": {
                    "Conditions":[]
                }
            },
            "Header": {
                "PartnerPickers": [
                    {
                        "PartnerFunction": "SP",
                        "PartnerFunctionInternal": "AG",
                        "PartnerFunctionName": "SoldTo",
                        "CustomLabel_PartnerFunctionName": "Enosix_SalesDoc_Field_SoldTo",
                        "ComponentType": "CustomerSearch",
                        "SearchType": "Partner",
                        "autoSearch": false,
                        "allowSearch": false,
                        "allowAddressOverride": false,
                        "autoPopulateAddressOverrideFromCustomer": false
                    },
                    {
                        "PartnerFunction": "SH",
                        "PartnerFunctionInternal": "WE",
                        "PartnerFunctionName": "ShipTo",
                        "CustomLabel_PartnerFunctionName": "Enosix_SalesDoc_Field_ShipTo",
                        "ComponentType": "PartnerSearch",
                        "SearchType": "Partner",
                        "autoSearch": false,
                        "allowSearch": false,
                        "allowAddressOverride": false,
                        "autoPopulateAddressOverrideFromCustomer": false
                    }
                ],
                "Texts":[
                    {
                        "Id": "0001",
                        "Description": "Shipping Notes:",
                        "Required": false
                    }
                ]
            },
            "Item": {
                "PartnerPickers": [],
                "Texts":[]
            },
            "Default": {
                "autoInvoke": false,
                "displaySimulate": false,
                "displaySort": false,
                "displaySaveToSOject": false,
                "displaySaveToSAP": false,
                "AddMaterial": {"display": false, "edit": false },
                "Tabs": {
                    "Header": {},
                    "Item": {}
                },
                "Fields": {
                    "Header": {},
                    "ItemTable": {},
                    "ItemEdit": {}
                }
            },
            "InvokeMethodAppSettings": [
                {
                    "InvokeMethod": "Simulate",
                    "insertSalesDocLog": false,
                    "skipAddedLineValidation": false
                },
                {
                    "InvokeMethod": "Create",
                    "insertSalesDocLog": true,
                    "skipAddedLineValidation": false
                }
            ]
        }
    }
}