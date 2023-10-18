import { LightningElement } from 'lwc';

export default class ParentCmp extends LightningElement {

    // value = 'Value coming from Parent Component';

    searchValue;

    //method to catch event from child
    handleSearchValue(event){
        this.searchValue = event.detail;
    }

}