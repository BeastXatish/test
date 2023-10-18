({
    onInit: function(component, event, helper) {
        console.log('sales data on init');
        let salesAreas = component.get('v.salesAreas');
        helper.setSalesArea(component, salesAreas, component.get('v.salesData'));
        helper.setGroupOffice(component);
        helper.setShipInfo(component);
        helper.setPricingStat(component);
    },

    onSalesAreaChange: function(component, event, helper) {
        // change on Sales Area
        console.log('sales area change');
        component.set('v.displaySpinner', true);
        let salesAreas = component.get('v.salesAreas');
        let salesData = component.get('v.salesData');

        let inputName = event.getSource().get('v.name');
        if (inputName === 'salesOrg') {
            let distributionChannels = helper.setDistributionChannels(component, salesAreas, salesData.SalesOrganization);
            //let distChan = distributionChannels.length > 0 ? distributionChannels[0].DistributionChannel : '';
            //salesData.DistributionChannel = distChan;
        }

        if (inputName === 'salesOrg' || inputName === 'distChannel') {
            let divisions = helper.setDivisions(component, salesAreas, salesData.SalesOrganization, salesData.DistributionChannel);
            //let division = divisions.length > 0 ? divisions[0].Division : '';
            //salesData.Division = division;
        }

        //helper.setSalesOfficeAndSalesGroup(component, component.get('v.groupOffice'), salesData);

        component.set('v.salesData', salesData);

        var evt = component.getEvent('salesAreaChange');
        evt.fire();
    },

    onSalesOfficeChange: function(component, event, helper) {
        // change on Sales Office
        let salesData = component.get('v.salesData');
        let salesGroups = helper.setSalesGroup(component, component.get('v.groupOffice'), salesData.SalesOffice);

        if (salesData.SalesGroup) {
            salesGroup = salesGroups.find(sg => sg.SalesGroup === salesData.SalesGroup);
            if (!salesGroup) salesData.SalesGroup = '';

            component.set('v.salesData', salesData);
        }
    }
})