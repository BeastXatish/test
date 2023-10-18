import { LightningElement, wire } from 'lwc';
import { getRecordUi } from 'lightning/uiRecordApi';
export default class SampleCompo extends LightningElement {

    rec;
    @wire(getRecordUi, { recordIds: '0015j00000l7OAIAA2', childRelationships: "Account.Contacts" })
    myRecord({ data, error }) {
        if (data) {
            debugger;
            this.rec = data;
            console.log('My records', this.rec);
        } if (error) {
            console.log('Error ', error);
        }
    }
}