import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';

export default class NavigatetoObjectpage extends NavigationMixin(LightningElement) {

    handlenewrecord() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'new'// when putting 'new' as actionName and omiting recordId it will display Create new Account record page.
            }
        })
    }
    handleeditrecord() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'view',
                recordId: '0015j0000081p7FAAQ'
            }
        })
    }
    handlenewdefaults() {
        let defaultValues = encodeDefaultFieldValues({
            Phone: '123456798'
        })
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'new'
            },
            state: {
                defaultFieldValues: defaultValues
            }
        })
    }
// what if we are not adding the tab in the app
// how to get account realted opportunity realted product
    handlelist() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            },
            state: {
                filterName : 'Recent'
            }

        })
    }

    navigateToFiles(){
        this[NavigationMixin.Navigate]({
            type:'standard__objectPage',
            attributes:{
                objectApiName:'ContentDocument',
                actionName:'home'
            }
          })
    

    }

}