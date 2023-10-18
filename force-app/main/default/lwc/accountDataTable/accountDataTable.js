import { LightningElement, wire } from 'lwc';
import getAccData from '@salesforce/apex/accountDataTableController.getAccList';
import getUpdatedAccount from '@salesforce/apex/accountDataTableController.updatedAccount';
import LightningConfirm from 'lightning/confirm';
const columns = [
    { label: 'Account Name', fieldName: 'Name', editable: true },
    { label: 'Id', fieldName: 'Id' },
    { label: 'AccNumber', fieldName: 'AccountNumber', editable: true }
]
export default class AccountDataTable extends LightningElement {
    columnsData = columns;
    accountData;
    @wire(getAccData)
    wiredDataOfAccount({ data, error }) {
        if (data) {
            this.accountData = data;
        }
        if (error) {
            console.log('Error Occured', error);
        }
    }
    async handlesave(event) {
        const result = await LightningConfirm.open({
            message: 'Records has been Saved Successfully',
            variant: 'headerless',
            label: 'this is the aria-label value',
        })
        if (result == true) {
            const updatedvalues = event.detail.draftValues;
            console.log('Updated Values', updatedvalues);
            getUpdatedAccount({ objInstance: updatedvalues })
                .then(data => {
                    console.log('Apex Result', JSON.stringify(data));
                })
                .catch(error => {
                    console.log('Error', JSON.stringify(error));
                })
        }
    }
}