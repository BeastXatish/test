import { LightningElement ,wire,api,track} from 'lwc';
import getAccData from '@salesforce/apex/AccountContactController.myMethod';
import getContactData from '@salesforce/apex/AccountContactController.updatedAccountDetail';
export default class AccountContactLWC extends LightningElement {

   accobject = {nameWrapper : "ABC",
 phoneWrapper : 123456,
 industryWrapper: "Unknown",
typeWrapper: "Yes" };
//           console.log("acc",Accobject.Phone);

 @api recordId;
// accountdata;
// Error;
// textValue='';
// phone = '';
// Industry = '';
// type = '';
// accValues = [];
// @wire(getAccData,{accId: '$recordId'})
// results({data,error}){
//     if(data){
//         this.accountdata = data;
//         console.log('Account Data',JSON.stringify(this.accountdata));
//         let numbers = Object.values(this.accountdata);
//         this.textValue = this.accountdata.Name;
//         this.phone = this.accountdata.Phone;
//         this.Industry = this.accountdata.Industry;
//         this.type = this.accountdata.Type;
//         console.log('Values',numbers);
//     }
//     if(error){
//         this.Error = error;
//         console.log('Error',this.Error);
//     }
// }

// contactData;
// @wire(getContactData,{accIds: '$recordId'})
// resultsContact({data,error}){
//     if(data){
//         this.contactData = data;
//         console.log('Contact Data',JSON.stringify(this.contactData));
//     }
//     if(error){
//         this.Error = error;
//         console.log('Error',this.Error);
//     }
// }
// handleupdatedvalue(event){
// const updatevalue = event.detail.value;
// console.log('The updated values is ',updatevalue);
// }
@track accRecords = '';
 @wire(getAccData,{accId:'$recordId'})
 accData({data,error}){
    if(data){
        this.accRecords = data;
    }
 }

 updatedValues ='';
 handleupdatedvalue(event){
    const updatedVal = event.detail.value;
   this.updatedValues = updatedVal;
    //console.log('Updated Value',updatedVal);
    
 }

 handlesave(){
    console.log(this.accData.data[0].idWrapper);
    //let updates = this.template.querySelectorAll('lightning-input');
   // this.updatedValues = this.updates.value;
   // console.log('The Updates',this.updatedValues);
    console.log(JSON.parse(JSON.stringify(this.accData.data)));
    console.log('Selector',JSON.parse(JSON.stringify(this.template.querySelector('lightning-input'))));
    let element = this.template.querySelectorAll('lightning-input');
    this.score = 0;
    Array.from(element).forEach(currentitem =>{
        if(currentitem.label == 'AccountName'){
        this.accobject.nameWrapper = currentitem.value;
        } else if(currentitem.label == 'Phone'){
            this.accobject.phoneWrapper = currentitem.value;
        }
            
           console.log('item ',this.accobject);
         })
         this.accobject.idWrapper =this.accData.data[0].idWrapper;
    getContactData({objInstance :  JSON.stringify(this.accobject)})
     .then(result =>{
         console.log('ApexResult',result);
     })
     .catch(error=>{
         console.log('Error',JSON.stringify(error));
     })
 }

}