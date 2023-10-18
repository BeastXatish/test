({
    setSalesArea: function(component, salesAreas, salesData) {
        if (salesAreas.length) {
            let salesOrganizations = this.setSalesOrgs(component, salesAreas);
            if (!salesData.SalesOrganization) {
                //salesData.SalesOrganization = salesOrganizations.length > 0 ? salesOrganizations[0].SalesOrganization : '';
            }

            let distributionChannels = this.setDistributionChannels(component, salesAreas, salesData.SalesOrganization);
            if (!salesData.DistributionChannel) {
                //salesData.DistributionChannel = distributionChannels.length > 0 ? distributionChannels[0].DistributionChannel : '';
            }

            let divisions = this.setDivisions(component, salesAreas, salesData.SalesOrganization, salesData.DistributionChannel);
            if (!salesData.Division) {
                //salesData.Division = divisions.length > 0 ? divisions[0].Division : '';
            }

            component.set('v.salesData', salesData);
        }
    },

    setSalesOrgs: function(component, salesDatas) {
        let salesOrganizationsSet = new Set();
        let salesOrganizations = [];
        let appSettings = component.get('v.appSettings');
        let sorgToFilter = appSettings.salesOrgToFilter;

        salesDatas.forEach(obj => {
            if (!salesOrganizationsSet.has(obj.SalesOrganization)) {
                salesOrganizationsSet.add(obj.SalesOrganization);
                let newObj = {};
                newObj.SalesOrganization = obj.SalesOrganization;
                newObj.SalesOrganizationName = obj.SalesOrganizationName;
                salesOrganizations.push(newObj);
            }
        })
        salesOrganizations = salesOrganizations.filter(item => sorgToFilter.includes(item.SalesOrganization))
        component.set('v.salesOrganizations', salesOrganizations);

        return salesOrganizations;
    },

    setDistributionChannels: function(component, salesDatas, salesOrg) {
        let distributionChannelsSet = new Set();
        let distributionChannels = [];

        salesDatas.forEach(obj => {
            if (obj.SalesOrganization === salesOrg && !distributionChannelsSet.has(obj.DistributionChannel)) {
                distributionChannelsSet.add(obj.DistributionChannel);
                let newObj = {};
                newObj.DistributionChannel = obj.DistributionChannel;
                newObj.DistributionChannelName = obj.DistributionChannelName;
                distributionChannels.push(newObj);
            }
        })
        component.set('v.distributionChannels', distributionChannels);

        return distributionChannels;
    },

    setDivisions: function(component, salesDatas, salesOrg, distChannel) {
        let divisions = [];

        salesDatas.forEach(obj => {
            if (obj.SalesOrganization === salesOrg && obj.DistributionChannel === distChannel) {
                let newObj = {};
                newObj.Division = obj.Division;
                newObj.DivisionName = obj.DivisionName;
                divisions.push(newObj);
            }
        })
        component.set('v.divisions', divisions);

        return divisions;
    },

    setGroupOffice: function(component) {
        let groupOffice = component.get('v.groupOffice');
        if (groupOffice) {
            component.set('v.salesDistricts', groupOffice.ET_SALES_DISTRICT_List.filter(item => item.BZIRK));

            let salesData = component.get('v.salesData');
            this.setSalesOfficeAndSalesGroup(component, groupOffice, salesData);
            component.set('v.salesData', salesData);
        }
    },

    setSalesOfficeAndSalesGroup: function(component, groupOffice, salesData) {
        let salesOffices = this.setSalesOffice(component, groupOffice, salesData);

        if (salesData.SalesOffice) {
            let salesOffice = salesOffices.find(so => so.VKBUR === salesData.SalesOffice);
            if (!salesOffice) salesData.SalesOffice = '';
        }

        let salesGroups = this.setSalesGroup(component, groupOffice, salesData.SalesOffice);
        if (salesData.SalesGroup) {
            let salesGroup = salesGroups.find(sg => sg.SalesGroup === salesData.SalesGroup);
            if (!salesGroup) salesData.SalesGroup = '';
        }
    },

    setSalesOffice: function(component, groupOffice, salesData) {
        let salesOffices = groupOffice.ET_SALES_OFFICE_List.filter(item => {
            if (item.SalesOrganization === salesData.SalesOrganization &&
                item.DistributionChannel === salesData.DistributionChannel &&
                item.Division === salesData.Division) {
                    return item;
                }
        });

        component.set('v.salesOffices', salesOffices);

        return salesOffices;
    },

    setSalesGroup: function(component, groupOffice, salesOffice) {
        let salesGroups = groupOffice.ET_SALES_GROUP_List.filter(sg => sg.VKBUR === salesOffice);
        component.set('v.salesGroups', salesGroups);

        return salesGroups;
    },

    setShipInfo: function(component) {
        let shipInfo = component.get('v.shipInfo');
        if (shipInfo) {
            let incoTerms = shipInfo.ET_FREIGHT_TERMS_List.filter(ft => ft.INCO1);
            let paymentTerms = shipInfo.ET_PAY_TERMS_List.filter(pt => pt.ZTERM);
            let shippingConditions = shipInfo.ET_SHIP_COND_List.filter(sc => sc.ShippingConditions);
            component.set('v.incoTerms', incoTerms);
            component.set('v.paymentTerms', paymentTerms);
            component.set('v.shippingConditions', shippingConditions);
        }
    },

    setPricingStat: function(component) {
        let pricingStat = component.get('v.pricingStat');
        if (pricingStat) {
            let priceGroups = pricingStat.ET_CUST_PRICE_GRP_List.filter(pg => pg.KONDA);
            let pricingProcedures = pricingStat.ET_CUST_PRICE_PROC_List.filter(pp => pp.KALKS);
            let priceLists = pricingStat.ET_CUST_PRICE_LIST_List.filter(pl => pl.PLTYP);
            component.set('v.priceGroups', priceGroups);
            component.set('v.pricingProcedures', pricingProcedures);
            component.set('v.priceLists', priceLists);
        }
    }
})