import { LightningElement, wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACC_OBJ from '@salesforce/schema/Account';
import ACC_NAME from '@salesforce/schema/Account.Name'
import ACC_NUMBER from '@salesforce/schema/Account.AccountNumber'

export default class Getrecordwire extends LightningElement {
    accrecId = "0015j0000081p7DAAQ";
    accname;
    accno;
    temp={};
    @api objectApiName
   /* @wire(getRecord, {
        recordId: '$accrecId',
        fields: [
            ACC_NAME,
            ACC_NUMBER
        ]
    })
    getaccrecord({data,error}){
        if(data){
            console.log("@@@@@@@@",data);
            this.accname = data.fields.Name.value;
            this.accno = data.fields.AccountNumber.value;
        }
        if(error){
            console.log("Error occured" ,error)
        }
    }*/

    @wire(getObjectInfo,{objectApiName : ACC_OBJ})
    getaccobj({data,error}){
        if(data){
            
            data.childRelationships.forEach(currentitem => {
                console.log(currentitem.childObjectApiName)
            });
            console.log('$$$$$$$$$$$', this.temp);
        }
        if(error){
            console.log("ERROR OCCURED" ,error);
        }
    }
}