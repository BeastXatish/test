import { LightningElement, api } from 'lwc';

export default class ChildCmp extends LightningElement {

    // @api getValueFromParent = "hiiiii";

    searchKey;

    handleChange(event){
        this.searchKey = event.target.value; //Event will hold context(details) of text box 

        //Create Event
        const searchEvent = new CustomEvent("getsearchvalue", {
            detail : this.searchKey});


        this.dispatchEvent(searchEvent); //Fire the Event

    }
}