({
    onInit: function(component, event, helper) {
        let recordId = component.get('v.recordId');
        if (!recordId) {
            component.set('v.messages', {messageType: 'ERROR', message: $A.get('$Label.c.Enosix_Customer_Message_RecordIdNotFound')});
            component.set('v.displaySpinner', false);
            return;
        }

        helper.loadAppSettings(component)
            .then($A.getCallback(function(res) {
                return helper.initSFObject(component, recordId, helper)
            }))
            .then($A.getCallback(function(res) {
                let customerNumber = component.get('v.sfObject.customerNumber');
                if (customerNumber) {
                    let appSettings = component.get('v.appSettings');
                    if (!appSettings.isUpdateAllowed) {
                        component.set('v.customerNumber', customerNumber);
                        helper.navigateToDetail(component); //redirect to customer detail if isUpdateAllowed is false
                    }
                    else{
                        return helper.getCustomerDetail(component, helper);
                    }
                }
                else {
                    return helper.setCustomerFromSobject(component, helper);
                }
            }), function() {
                component.set('v.isValidForCreation', false);
            })
            .then($A.getCallback(function(res) {
                helper.getFieldSettings(component);
            }))
            .then($A.getCallback(function(res) {
                helper.getCurrency(component, helper);
                helper.getSalesAreas(component, helper);
                helper.getGroupOffice(component, helper);
                helper.getShipInfo(component, helper);
                helper.getPricingStat(component, helper);
                helper.getCompanyCodes(component, helper);
                helper.getLanguage(component, helper);
                helper.getDropDownValues(component, helper);
                return helper.getCountries(component, helper);
            }))
            .then($A.getCallback(function(res) {
                helper.setCountryAndRegion(component);
            }))
            .then($A.getCallback(function(res){
                if (!component.get('v.customerDetail.CustomerNumber')){
                    helper.initializeCustomer(component, helper);
                }
            }))

            .then($A.getCallback(function() {
                let appSettings = component.get('v.appSettings');
                let isValidForCreation = component.get('v.isValidForCreation');
                if (appSettings.autoInvoke && isValidForCreation) {
                    helper.create(component, helper);
                }
                else component.set('v.displaySpinner', false);
            }))
    },

    onCountryChange: function(component, event, helper) {
        helper.setCountryAndRegion(component);
    },

    onCancelClick: function(component, event, helper) {
        console.log('on Cancel click');
        helper.navigateToDetail(component);
    },

    onCreateClick: function(component, event, helper) {
        console.log('on create click');
        helper.create(component, helper);
    },
    onSalesAreaChange: function(component, event, helper) {
        if (!component.get('v.customerDetail.CustomerNumber')){
            helper.initializeCustomer(component, helper);
        }
    }
})