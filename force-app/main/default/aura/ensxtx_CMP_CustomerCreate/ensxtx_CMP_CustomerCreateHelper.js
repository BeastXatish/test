({
    loadAppSettings: function(component) {
        return new Promise(function(resolve, reject) {
            console.log('init app settings');

            let appSettingsName = component.get('v.appSettingsName');
            let appSettingsNamespace = component.get('v.appSettingsNamespace');
            let appSettingsKey = component.get('v.appSettingsKey');
            let appSettingsTypeName = component.get('v.appSettingsTypeName');

            let staticResourceName = appSettingsNamespace ? appSettingsNamespace + '__' + appSettingsName : appSettingsName

            let staticResource = $A.get('$Resource.' + staticResourceName); 
            let req = new XMLHttpRequest();

            req.open("GET", staticResource);
            req.addEventListener("load", $A.getCallback(function() {
                console.log('loaded app settings');
                let response = JSON.parse(req.response);
                let appSettings = response[appSettingsKey] ? response[appSettingsKey][appSettingsTypeName] : null;
                if (!appSettings) {
                    let messages = [{
                        messageType: 'ERROR', 
                        message: 'App Settings is not found on ' + staticResourceName + '. Please Configure the App Settings first.'
                    }];
                    component.set('v.messages', messages);
                }
                else {
                    component.set('v.appSettings', appSettings);    
                }
                resolve();  
            }));
            req.send(null);
        })
    },

    initSFObject: function(component, recordId, helper) {
        console.log('in initSFObject');
        return new Promise(function(resolve, reject) {
            console.log('init Customer');
            let action = component.get('c.initSFObject');
            let appSettings = component.get('v.appSettings');

            action.setParams({
                recordId: recordId
            })
            action.setCallback(this, function(res) {
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        if (data) {
                            data.includeSalesData = appSettings.showSalesData;
                            data.includeCompanyData = appSettings.showCompanyData;
                            component.set('v.sfObject', data);
                            component.set('v.recordId', data.sfMainObject.Id);

                            if (data.createType === 'Partner' && !data.parentCustomerNumber) {
                                // If creating ShipTo/Partner and the Parent account doesn't have customer number
                                let messages = [{
                                    message: $A.get("$Label.c.Enosix_Customer_Message_ParentAccountNoCustomerNumber"), messageType: 'WARNING'
                                }];
                                let vMessages = component.get('v.messages');
                                vMessages.push(...messages);
                                component.set('v.messages', vMessages);
                                component.set('v.isValidForCreation', false);
                            }
                        }
                        else return reject();
                    }
                );
            })

            $A.enqueueAction(action);
        })
    },

    initializeCustomer: function(component, helper) {
        return new Promise(function(resolve, reject) {
            console.log('initialize customer detail');
            let sfObject = component.get('v.sfObject');
            let customerDetail = component.get('v.customerDetail');

            let action = component.get('c.initializeCustomerDetail');
            action.setParams({
                sfSObject: sfObject,
                customerDetail: customerDetail
            })

            action.setCallback(this, function(res) {
                console.log('return initialize customer detail');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        component.set('v.customerDetail', data);
                    }
                );
            });
            $A.enqueueAction(action);
        })
    },

    getCustomerDetail: function(component, helper) {
        return new Promise(function(resolve, reject) {
            console.log('get customer detail');

            let action = component.get('c.getCustomerDetail');
            action.setParams({
                customerNumber: component.get('v.sfObject.customerNumber')
            })

            action.setCallback(this, function(res) {
                console.log('return get customer detail');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        component.set('v.customerDetail', data);
                    }
                );
            });
            $A.enqueueAction(action);
        })
    },

    setCustomerFromSobject: function(component, helper) {
        return new Promise(function(resolve, reject) {
            console.log('set CustomerDetails from Sobject');
            let sfObject = component.get('v.sfObject');

            let customerDetail = component.get('v.customerDetail');

            let action = component.get('c.initCustomerDetailFromSFObject');

            action.setParams({
                customerDetail: customerDetail,
                sfObject: sfObject.sfMainObject
            })

            action.setCallback(this, function(res) {
                console.log('return set CustomerDetails from sobject');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        component.set('v.customerDetail', data);
                        if(data.CustomerNumber)
                        {
                            // we can disable create sap customer button if SAP customerNumber exists
                            let messages = [{
                                message: $A.get("$Label.c.Enosix_Customer_Message_SAPCustomerExist"), messageType: 'WARNING'
                            }];
                            let vMessages = component.get('v.messages');
                            vMessages.push(...messages);
                            component.set('v.messages', vMessages);
                            component.set('v.isValidForCreation', false);
                        }
                    }
                );
            });
        
            $A.enqueueAction(action);
        })
    },

    getFieldSettings: function(component)
    {
        let fields = component.get('v.appSettings.Fields');
        let status = component.get('v.sfObject.status');
        if (component.get('v.customerDetail.CustomerNumber')) {
            status = 'Update';
            component.set('v.isUpdate', true);
            component.set('v.sfObject.status', status);
        }

        let fieldSettings = fields.Default;

        let overrideSettings = fields[status];
        if (overrideSettings) {
            for (const fieldSection in overrideSettings) {
                let fieldSectionObject = overrideSettings[fieldSection];
                for (const field in fieldSectionObject) {
                    fieldSettings[fieldSection][field] = fieldSectionObject[field]
                }
            }
        }

        component.set('v.fieldSettings', fieldSettings);
    },

    navigateToDetail: function(component) {
        let navigate = component.get("v.navigateFlow");
        navigate("NEXT");
    },

    showToast: function(title, message, type) {
        let toastEvent = $A.get("e.force:showToast");
        
        toastEvent.setParams({
            title: title,
            message: message,
            type: type,
            mode: "dismissible"
        });
        toastEvent.fire();
    },

    create: function(component, helper) {
        console.log('create sap customer');
        component.set('v.messages', []);
        component.set('v.displaySpinner', true);
        let sfObject = component.get('v.sfObject');

        helper.createSAPCustomer(component, helper)
            .then(function(res) {
                console.log('create success');
                helper.showToast(
                    $A.get("$Label.c.Enosix_Customer_Message_SuccessTitle"),
                    'SAP Customer Successfully ' + sfObject.status + 'd : ' + res, 'success');
                helper.navigateToDetail(component);
            })
            .catch(function() {
                console.log('fail create here');
                component.set('v.displaySpinner', false);
            })
    },

    createSAPCustomer: function(component, helper) {
        return new Promise(function(resolve, reject) {
            console.log('create SAP Customer');
            let sfObject = component.get('v.sfObject');
            let customerDetail = component.get('v.customerDetail');


            let action = component.get('v.isUpdate') ? 
                component.get('c.updateSAPCustomer'): component.get('c.createSAPCustomer');

            action.setParams({
                sfSObject: sfObject,
                customerDetail: customerDetail
            })

            action.setCallback(this, function(res) {
                console.log('finish create SAP Customer');
                helper.handleResponse(component, action.getName(), res, resolve, reject,
                    function(data) {
                        if (data) {
                            let customerDetail = data;
                            if (customerDetail.IsSuccess) {
                                component.set('v.customerNumber', customerDetail.CustomerNumber);
                                return resolve(customerDetail.CustomerNumber);
                            }
                        }
                    }
                )
            })

            $A.enqueueAction(action);
        })
    },

    getLanguage: function(component) {
        return new Promise(function(resolve, reject) {
            console.log('getLanguage');
            let action = component.get('c.getLanguage');
            action.setCallback(this, function(res) {
                let response = res.getReturnValue();       
                if (response && response.data) {
                    let allLangs = response.data.ET_LANG_List;
                    component.set('v.languages', allLangs);
                }
                else {
                    component.set('v.messages', response.messages);
                }
                resolve(true);
            })

            $A.enqueueAction(action);
        })
    },

    getDropDownValues: function(component) {
        return new Promise(function(resolve, reject) {
            console.log('getDropDownValues');
            let customerDetail = component.get('v.customerDetail');
            let action = component.get('c.getDropDownValues');
            action.setParams({
                cmpnyCode : null,
                sOrg : customerDetail.SALES_DATA[0].SalesOrganization,
                distChan : customerDetail.SALES_DATA[0].DistributionChannel,
                fromMaincmp : true
            })
            action.setCallback(this, function(res) {
                let response = res.getReturnValue();       
                if (response && response.data) {
                    component.set('v.custGroups', response.data.ET_CUST_GRP_List);
                    component.set('v.delPrios', response.data.ET_DEL_PRIO_List);
                    component.set('v.delPlants', response.data.ET_DEL_PLANT_List);
                }
                else {
                    component.set('v.messages', response.messages);
                }
                resolve(true);
            })

            $A.enqueueAction(action);
        })
    },

    getCountries: function(component) {
        return new Promise(function(resolve, reject) {
            console.log('get Countries');
            let action = component.get('c.getCountries');
            action.setCallback(this, function(res) {
                let response = res.getReturnValue();       
                if (response && response.data) {
                    let countries = response.data.ET_OUTPUT_List.filter(item => item.LAND1);
                    let allRegions = response.data.ET_REGIONS_List;
                    component.set('v.countries', countries);
                    component.set('v.allRegions', allRegions);
                }
                else {
                    component.set('v.messages', response.messages);
                }
                resolve(true);
            })

            $A.enqueueAction(action);
        })
    },

    setCountryAndRegion: function(component) {
        let customerDetail = component.get('v.customerDetail');
        let regions = [];

        if (customerDetail.Country) {
            let allRegions = component.get('v.allRegions');
            regions = allRegions.filter(region => region.LAND1 === customerDetail.Country);
            component.set('v.regions', regions);

            setTimeout(function() {
                // This needs to wait inside a timeout because regions need to finish rendering
                if (customerDetail.Region) {
                    let region = regions.find(reg => reg.REGIO === customerDetail.Region);

                    if (region) {
                        customerDetail.Region = region.REGIO;
                    }
                    else customerDetail.Region = '';
                    component.set('v.customerDetail', customerDetail);
                }
            }, 50)
        }
    },

    getSalesAreas: function(component, helper)
    {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            let appSettings = component.get('v.appSettings');
            if (appSettings.showSalesData && fieldSettings.SalesData && (
                fieldSettings.SalesData.SalesOrganization.display ||
                fieldSettings.SalesData.DistributionChannel.display ||
                fieldSettings.SalesData.Division.display
            )) {
                console.log('get sales areas');
                let action = component.get('c.getSalesAreas');
                action.setCallback(this, function(res) {
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                component.set('v.salesAreas', data.SalesAreas_List);
                            }
                        })
                })
                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    getGroupOffice: function(component, helper)
    {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            let appSettings = component.get('v.appSettings');
            if (appSettings.showSalesData && fieldSettings.SalesData && (
                fieldSettings.SalesData.SalesGroup.display ||
                fieldSettings.SalesData.SalesOffice.display ||
                fieldSettings.SalesData.SalesDistrict.display
            )) {
                console.log('get group office');
                let action = component.get('c.getGroupOffice');
                action.setCallback(this, function(res) {
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                component.set('v.groupOffice', data);
                            }
                        })
                })
                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    getShipInfo: function(component, helper)
    {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            let appSettings = component.get('v.appSettings');
            if (appSettings.showSalesData && (
                fieldSettings.SalesData.ShippingConditions.display ||
                fieldSettings.CompanyData.PaymentTerms.display ||
                fieldSettings.SalesData.IncoTerms1.display
            )) {
                console.log('get ship info');
                let action = component.get('c.getShipInfo');
                action.setCallback(this, function(res) {
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                component.set('v.shipInfo', data);
                            }
                        })
                })
                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    getPricingStat: function(component, helper)
    {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            let appSettings = component.get('v.appSettings');
            if (appSettings.showSalesData && fieldSettings.SalesData && (
                fieldSettings.SalesData.PriceGroup.display ||
                fieldSettings.SalesData.PricingProcedure.display ||
                fieldSettings.SalesData.PriceList.display
            )) {
                console.log('get pricing stat');
                let action = component.get('c.getPricingStat');
                action.setCallback(this, function(res) {
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                component.set('v.pricingStat', data);
                            }
                        })
                })
                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    getCurrency: function(component, helper)
    {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            let appSettings = component.get('v.appSettings');
            if (appSettings.showSalesData && fieldSettings.SalesData && (
                fieldSettings.SalesData.CurrencyKey))
            {
                console.log('get currency');
                let action = component.get('c.getCurrency');
                action.setCallback(this, function(res) {
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                let currencies = data.ET_CURRENCY_List.filter(curr => curr.FieldCurrency);
                                component.set('v.currencies', currencies);
                            }
                        })
                })
                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    getCompanyCodes: function(component, helper)
    {
        return new Promise(function(resolve, reject) {
            let fieldSettings = component.get('v.fieldSettings');
            let appSettings = component.get('v.appSettings');
            if (appSettings.showCompanyData && fieldSettings.CompanyData && (
                fieldSettings.CompanyData.CompanyCode))
            {
                console.log('get company codes');
                let action = component.get('c.getCompanyCodes');
                action.setCallback(this, function(res) {
                    helper.handleResponse(component, action.getName(), res, resolve, reject,
                        function(data) {
                            if (data) {
                                let companyCodes = data.OUTPUT_List.filter(code => code.BUKRS);
                                component.set('v.companyCodes', companyCodes);
                            }
                        })
                })
                $A.enqueueAction(action);
            }
            else resolve(true);
        })
    },

    handleResponse: function (component, method, response, resolve, reject, dataFunction, rejectForErrorInResponse)
    {
        console.log('in handleResponse');
        let state = response.getState();
        console.log('state is '+state);
        if (state === "SUCCESS") {
            let returnValue = response.getReturnValue();
            console.log('returnValue is '+ returnValue);
            if (returnValue) {
                let messages = returnValue.messages;
                console.log('2 messages are'+ messages);
                if (messages && messages.length > 0) {
                    let vMessages = component.get('v.messages');
                    if (!vMessages) vMessages = [];
                    vMessages.push(...messages);
                    component.set('v.messages', vMessages);
                    if (false !== rejectForErrorInResponse) {
                        for (let index in messages) {
                            if (messages[index].messageType === 'ERROR') {
                                if (reject) reject(false);
                            }
                        }
                    }
                }
                if (dataFunction) dataFunction(returnValue.data);
            }
            if (resolve) resolve(true);
        } 
        else {
            let messages = [];
            messages.push({message: 'There was an error in CTRL_CustomerCreateLtng.' + method, messageType: "ERROR"});

            let errors = response.getError();
            if (errors) {
                for (let errCnt in errors) {
                    let fieldErrors = errors[errCnt].fieldErrors;
                    if (fieldErrors) {
                        messages.push({message: fieldErrors, messageType: "ERROR"});
                    }
                    let pageErrors = errors[errCnt].pageErrors;
                    if (pageErrors) {
                        for (let pageCnt in pageErrors) {
                            messages.push({message: pageErrors[pageCnt].message, messageType: "ERROR"});
                        }
                    }
                    let message = errors[errCnt].message;
                    if (message) {
                        messages.push({message: message, messageType: "ERROR"});
                    }
                }
            }
            let vMessages = component.get('v.messages');
            if (!vMessages) vMessages = [];
            vMessages.push(...messages);
            component.set('v.messages', vMessages);
            if (reject) reject('There was an error in CTRL_CustomerCreateLtng.' + method);
        }
    },
})