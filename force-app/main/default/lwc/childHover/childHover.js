import { LightningElement, wire } from 'lwc';
import getaccdata from '@salesforce/apex/objectHoverController.getAccounts';

 const columns =[
     {label:'name',fieldname:'Name'},
     {label:'Acc Number', fieldname:'AccountNumber'},
 ]
export default class ChildHover extends LightningElement {
    columndsdata =columns;
    accountdata=[];
    errors;
    
    @wire(getaccdata)
    resultdata({ data , error }){
        if(data){
             for (let key in data) {
                 this.accountdata.push({key:key , value:data[key]});
              }
             console.log('Account Data',this.accountdata);
        }
    }
    if(error){
        this.errors = error;
        console.log('Error',this.errors);
    }
}