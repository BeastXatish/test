import { LightningElement } from 'lwc';

export default class Datatablewithrowselection extends LightningElement {

    buttonvalue = 'show Details';

    handleclick(event) {
        const label = event.target.label;
        if (label == 'show Details') {
            this.buttonvalue = 'Hide details'
        }
        else if(label == 'Hide details'){
            this.buttonvalue = 'show Details'
        }
    }
}