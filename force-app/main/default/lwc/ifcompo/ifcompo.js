import { LightningElement , wire } from 'lwc';
import getcontactlist from '@salesforce/apex/foreachcontroller.getcontactlist'
export default class Ifcompo extends LightningElement {

    gamechanger = false;
    valueholder = 'show card';

    handleclick(event) {
        const lab = event.target.label;

        if(lab === 'show card') {     
            this.valueholder = 'hide card';
            this.gamechanger = true;
        }
        else if(lab === 'hide card'){
            this.valueholder = 'show card';
            this.gamechanger = false;
        }
    }

    data=[];

    @wire(getcontactlist)
    conlist; // it is the variable in which we are getting the salesforce obj data

}