import { api, LightningElement, wire } from 'lwc';
import getchildcontact from '@salesforce/apex/datatableexamplecontroller.getrelatedcontacts';
import updatedvaluesdata from '@salesforce/apex/datatableexamplecontroller.updatedContactDetail';
// defining the columns for the datatable fieldname having the object APi name
const columns = [
    { label: 'NAME', fieldName: 'Name', editable: true },
    { label: 'EMAIL', fieldName: 'Email', type: 'email',editable: true },
    { label: 'PHONE', fieldName: 'Phone', type: 'phone',editable: true },
    { label: 'RecordId', fieldName: 'Id' }
];

export default class Datatableexample extends LightningElement {
    error;
    // privare variable whaterver er are changing in our java script file to this variable and if we are using this variable inside our lightning web component will be automatically get re-render that it is re-active @api @wire are re-active in nature that means it automatically update the value.
    columnsforcontact = columns;
    contacts
    // @api enable public property to a variable just like access modifier in apex to access the varibale outside the class.
    // also @api is used access data from SF :- recordId , sObjectName
    @api recordId;

   /* @wire(getchildcontact ,{accid : "$recordId"
    })contacts;
    Works as an constructor if we make any "Apex" method call with the help of @wire then it will immediately execute when the compoment is initialised  
    */
    @wire(getchildcontact ,{accid : "$recordId"})
    wiredAccounts({data, error}){
		if(data) { // if data is true that means data mai value pass hogyi from apex method
            console.log('### ',data);
			this.contacts = data;
			this.error = undefined;
		}else {
			this.contacts =undefined; 
			this.error = error;
		}
	}
     handlesave(event){
         const updatedvalues = event.detail.draftValues;
         console.log('The Updated Values',JSON.stringify(updatedvalues));

         updatedvaluesdata({objInstance : updatedvalues})
     .then(data =>{
         console.log('ApexResult',JSON.stringify(data));
     })
     .catch(error=>{
         console.log('Error',JSON.stringify(error));
     })
     }
   
    
}