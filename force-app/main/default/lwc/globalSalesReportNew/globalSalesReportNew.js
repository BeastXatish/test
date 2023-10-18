import { LightningElement,api,wire,track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";

import NAME_FIELD from "@salesforce/schema/Global_Sales_Call_Report__c.Name";

const fields = [NAME_FIELD];


export default class GlobalSalesReportNew extends NavigationMixin(LightningElement) {

    @api recordId;
    @api accountId;
   @track showDetails = true;
   successMessage='';


   @wire(getRecord, { recordId: "$recordId", fields })
  globalsales;

  get recordName() {
    return getFieldValue(this.globalsales.data, NAME_FIELD);
  }

   reloadForm(){
    this.showDetails=false;
    setTimeout(()=>{
        this.showDetails =true;
    },0);
   }
   handleSubmit(event){

        
   // event.preventDefault();
    

   }
 
     handleSuccess(event) {
       this.reloadForm();
       this.recordId='';
       let createdId = event.detail.id;    
       if(createdId){
        const name = event.detail.fields.Name.value;
        if(this.recordId){    
         this.successMessage= 'Global Sales Call Report '+ name  +' was saved' ;
    }
    else{
         this.successMessage = 'Global Sales Call Report '+ name +' was created';
    }
   

       this.dispatchEvent(
        new ShowToastEvent({
            label :'success', 
            message: this.successMessage,
            variant: 'success'
        })
    );
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: createdId,
                objectApiName: 'Global_Sales_Call_Report__c',
                actionName: 'view'
            }
        });
  
    }

    }
    goBack(event){
        this.reloadForm();
        window.history.back();
 
    }
    
}