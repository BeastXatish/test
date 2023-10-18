import { LightningElement } from 'lwc';

export default class LeaveTracker extends LightningElement {

    refreshLeaveReqeuestHandler(){
        this.refs.myLeavesComp.refreshGrid();
    }
}