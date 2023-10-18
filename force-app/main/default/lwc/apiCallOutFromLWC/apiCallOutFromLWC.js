import { LightningElement } from 'lwc';
import getDataFromApex from '@salesforce/apex/AccountSoapCallOut1.sendAccountViaSoap';
export default class ApiCallOutFromLWC extends LightningElement {
    divideResult;
    valueOne;
    valueSecond;
    handleclick() {
        getDataFromApex({ firstValue: this.valueOne, secondValue: this.valueSecond }).then(result => {
            this.divideResult = result;
        })
    }
    handlefirstInputchange(event) {
        this.valueOne = event.target.value;
    }
    handlesecondInputchange(event) {
        this.valueSecond = event.target.value;
    }
}   