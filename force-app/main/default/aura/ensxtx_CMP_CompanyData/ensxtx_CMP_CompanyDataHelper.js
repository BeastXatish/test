({
    setShipInfo: function(component) {
        let shipInfo = component.get('v.shipInfo');
        if (shipInfo) {
            let paymentTerms = shipInfo.ET_PAY_TERMS_List.filter(pt => pt.ZTERM);
            component.set('v.paymentTerms', paymentTerms);
        }
    },

    getDropDownValues: function(component) {
        return new Promise(function(resolve, reject) {
            console.log('getDropDownValues');
            let action = component.get('c.getDropDownValues');
            action.setParams({
                cmpnyCode : component.get('v.companyData.CompanyCode'),
                sOrg : null,
                distChan : null,
                fromMaincmp : false
            })
            action.setCallback(this, function(res) {
                let response = res.getReturnValue();       
                if (response && response.data) {
                    component.set('v.sortKeys', response.data.ET_COMP_SORT_KEY_List);
                    component.set('v.cashMgmtGroups', response.data.ET_CASH_MGT_GRP_List);
                    component.set('v.tolerenceGroups', response.data.ET_TOLERANCE_GRP_List);
                    component.set('v.dunningProcedures', response.data.ET_DUNNING_PROC_List);
                    component.set('v.dunningClerks', response.data.ET_DUNNING_CLERK_List);
                    component.set('v.accountStatements', response.data.ET_ACC_STMT_List);
                }
                else {
                    component.set('v.messages', response.messages);
                }
                resolve(true);
            })

            $A.enqueueAction(action);
        })
    },
})