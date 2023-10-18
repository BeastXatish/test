import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation'; 

export default class NavigatetoNamedpage extends NavigationMixin (LightningElement) {

    handlenamednavigate(){
        this[NavigationMixin.Navigate]({
            type : 'standard__namedPage',
            attributes : {
                pageName:'home'
            }
        })
    }

    handlenavigatechatter(){
        this[NavigationMixin.Navigate]({
            type : 'standard__namedPage',
            attributes : {
                pageName:'chatter'
            }
        })
    }
}