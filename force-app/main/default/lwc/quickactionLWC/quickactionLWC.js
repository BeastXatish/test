import { LightningElement, api } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import createacc from '@salesforce/apex/QuickActionLWCcontroller.createAccount';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class QuickactionLWC extends LightningElement {

    @api recordId;
    name = ''
    phone = ''
    isSpinner = false
    connectedCallback(){
        this.name = 'TestAction'
        this.phone = '7894561230'
    }
    closeAction(){ // This is used to close the window on the quick action and import close method from library
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    handlechange = event => {
        debugger;
        event.preventDefault();
        let textBoxName = event.target.label // use to store the input field name attribute can identified with any attribute name of input field
        let textBoxValue = event.target.value

        if(textBoxName === 'Account Name'){ // use to compare the input field of name is html
            this.name = textBoxValue
        } else{
            this.phone = textBoxValue
        }
    }

    handlesave = event =>{// This is used to save the record method name is handlesave event is the parameter of this function and inside the function we are getting an event method named as preventdefault
        this.isSpinner = true;
        event.preventDefault();
        createacc({
            accName : this.name ,
            accPhone : this.phone ,
            parentrecId : this.recordId // calling the apex method and passing the updated value
        })
        .then(result =>{
            console.log('Result :',result)
            this.dispatchEvent(new ShowToastEvent({
                title : 'Success',
                message : 'Account Created',
                variant : 'success'
            }));     
            this.closeAction()
        }) 
        .catch(error =>{
            console.log('Error :',error)
        })
        .finally(()=> {
            this.isSpinner = false;
        })
    }

}