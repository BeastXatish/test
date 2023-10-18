import { LightningElement, wire, api, track } from 'lwc';
import getAccData from '@salesforce/apex/AccountContactController.myMethod';
import saveData from '@salesforce/apex/AccountContactController.updateAccountDetail';
import newContactMethod from '@salesforce/apex/AccountContactController.returnNewContactFromLWC';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class accountDisplayWithContacts extends  LightningElement {


    @api recordId;
    account;
    contacts;

    updatedAccount={};

    updatedContacts={};
    

    @wire(getAccData, { accId: '$recordId' })
    accData({ data, error }) {
        if (data) {
            console.log('data',data);
            this.account = {...data.account};
            this.contacts = data.contacts;
        }

    }

    get  accounts(){
        return this.account
    }

    handleupdatedvalue(event){
       // debugger;
        console.log('event.target.name Account',event.target.name);
        console.log('event.target.dataset.id Account',event.target.dataset.id);
        console.log('event.target.value Account',event.target.value);

        this.updatedAccount[event.target.name] = event.target.value;
        this.updatedAccount['Id'] = event.target.dataset.id;

        console.log('Account', this.updatedAccount);
    }

    handleUpdatedValueOfContact(event){
       // debugger;
        console.log('event.target.name Contact',event.target.name);
        console.log('event.target.dataset.id Contact',event.target.dataset.id);
        console.log('event.target.value',event.target.value);
        
        let contact = this.updatedContacts[event.target.dataset.id] ? this.updatedContacts[event.target.dataset.id] : {} ;

        contact[event.target.name] = event.target.value;
        contact['Id'] = event.target.dataset.id;

        this.updatedContacts[event.target.dataset.id] = contact;

        console.log('contacts', this.updatedContacts);
    }

    handlesave() {
        //debugger;
        let data = {contacts:[]};
        data['account'] = this.updatedAccount;

        for(var key in this.updatedContacts) {
            data['contacts'].push(this.updatedContacts[key]);
        }
       // data['contacts'].push(this.updatedContacts);

        console.log('data after click on save',data);


        saveData({ objInstance: JSON.stringify(data)})
            .then(result => {
               console.log('ApexResult', result);
                const evnt1 =  new ShowToastEvent({
                   title : 'Salesforce Toast',
                   message : 'Record Updated Successfully',
                   variant : 'success'
               })
               this.dispatchEvent(evnt1);
               location.reload()

             })
            .catch(error => {
                console.log('Error', JSON.stringify(error));
           })
    }
    @track customFormModal = false; 
    
    customShowModalPopup() {            
        this.customFormModal = true;
    }
 
    customHideModalPopup() {    
        
        this.customFormModal = false;
    }

newContact = {};

handleNewValue(event){
this.newContact[event.target.name] = event.target.value;
console.log('New Contact',this.newContact);
}

handleNewContactOnSave(){
    //debugger;
    console.log('Occured');
newContactMethod({objInstance1 : JSON.stringify(this.newContact), accIds:  this.accounts['Id']})
.then(result =>{
    console.log('Account Id',this.accounts['Id']);
    console.log('Record Inserted ID is = ',result.Id);
    const evnt =  new ShowToastEvent({
        title : 'Salesforce Toast',
        message : 'Record Created Successfully',
        variant : 'success'
    })
    this.dispatchEvent(evnt);
   
    this.customFormModal = false;
    location.reload()
})
.catch(error=>{ 
    console.log('Error Incoming',error);
})
}

}