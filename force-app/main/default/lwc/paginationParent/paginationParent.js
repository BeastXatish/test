import { LightningElement, wire} from 'lwc';
import getdata from '@salesforce/apex/GetAccountPagination.getAccounts'

// const columns = [
//     {label: 'Account Name', fieldname:'name'}
// ];
export default class PaginationParent extends LightningElement {
    //column = columns;
    visiblerecords;
    mainData = [];
    error;
   // showtable = false;
    @wire(getdata)
    wireddata({data,error}){
        if(data){
            //this.showtable = true;
            this.mainData = data;
            console.log('$$$$$',this.mainData);
        }
        if(error){
            this.error = error;
            console.log('%%%%', error);
        }
    }
    updateHandler(event){
        this.visiblerecords = [...event.detail.records];
        console.log('######',event.detail.records)
    }
}