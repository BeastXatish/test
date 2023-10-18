import { LightningElement } from 'lwc';
import ACC_Object from '@salesforce/schema/Account'
import NAME_FIELD from '@salesforce/schema/Account.Name'
import SOURCE_FIELD from '@salesforce/schema/Account.AccountSource'
import ACTIVE_FIELD from '@salesforce/schema/Account.Active__c'
export default class Recordform extends LightningElement {

    objectapi = ACC_Object ;
    recid="0015j00000l7OAIAA2"
    fields = [NAME_FIELD,SOURCE_FIELD,ACTIVE_FIELD];
}