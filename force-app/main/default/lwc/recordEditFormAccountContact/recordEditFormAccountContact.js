import { LightningElement,api } from 'lwc';
import ACC_Object from '@salesforce/schema/Account';
import accName from '@salesforce/schema/Account.Name';
import accNumber from '@salesforce/schema/Account.AccountNumber';
import accPhone from '@salesforce/schema/Account.Phone';
import accCountry from '@salesforce/schema/Account.BillingCountry';

export default class RecordEditFormAccountContact extends LightningElement {

    fields = [accName,accNumber,accPhone,accCountry];
    objectApiName = ACC_Object;
    @api recordId;
}