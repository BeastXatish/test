import { LightningElement ,api} from 'lwc';
import ACC_OBJ from '@salesforce/schema/Account'
import NAME_FIELD from '@salesforce/schema/Account.Name'
import SOURCE_FIELD from '@salesforce/schema/Account.AccountSource'
import PHONE_FIELD from '@salesforce/schema/Account.Phone'
import RATING_FIELD from '@salesforce/schema/Account.Rating'
import ACCNO_FIELD from '@salesforce/schema/Account.AccountNumber'
import ACTIVE_FIELD from '@salesforce/schema/Account.Active__c'
export default class Recordformwithgrid extends LightningElement {

    objapi=ACC_OBJ
    accname =NAME_FIELD
    source=SOURCE_FIELD
    phone=PHONE_FIELD
    rating=RATING_FIELD 
    accnumber =ACCNO_FIELD
    active =ACTIVE_FIELD
    @api recid = "0015j0000081p7DAAQ"
    value= ''
    handlereset(event){
        let inputFields = this.template.querySelectorAll('lightning-input-field');
        console.log('InputFields', inputFields);
       
        if (inputFields) {
           
          Array.from(inputFields).forEach(currentItem=>{
            currentItem.value = undefined;
          })
        }
    }
}