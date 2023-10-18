import { LightningElement ,wire} from 'lwc';
import fetchOppData from '@salesforce/apex/lwcWrapperClassCtrl.fetchOppData'
export default class LwcOppoWrapper extends LightningElement {
    @wire(fetchOppData) oppData;
}