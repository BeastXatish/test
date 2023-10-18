import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigatetoRecordpage extends NavigationMixin(LightningElement) {
    handlerecordview() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'view', 
                recordId: '0015j0000081p7FAAQ'
            }
        })
    }


    handlerecordedit() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'edit', 
                recordId: '0015j0000081p7FAAQ'
            }
        })
    }

    navigateToRelatedRecords(){
        this[NavigationMixin.Navigate]({
            type:'standard__recordRelationshipPage',
            attributes:{
                objectApiName : 'Account',
                recordId :'0015j0000081p7FAAQ',
                relationshipApiName:'Contacts',
                actionName : 'view'
            }
        })
    }

    navigateToWebPage(){
        this[NavigationMixin.Navigate]({
            type:'standard__webPage',
            attributes:{
                url:'https://programmers.io/'
            }
        })
    }
}