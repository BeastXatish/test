import { LightningElement ,wire} from 'lwc';
import getdata from '@salesforce/apex/PaginationController.getAccountsData';

const columns = [
    {label:'Account Name', fieldName : 'accName'},
    {label:'Phone', fieldName: 'phoneValue'},
    {label:'Industry', fieldName:'industryValue'},
    {label:'Ownership', fieldName:'ownershipValue'},
    
];
export default class DataTablePagination extends LightningElement {
    accountsdata
    column = columns;
    visiblerecords;
    selection = [];
    @wire(getdata)
    wiredata({data,error}){
        if(data){
            this.accountsdata = data;
            // let My_id = [];
            // My_id.push(this.accountsdata[0].Id);
            // this.selection = My_id;

            console.log('this.selection ',this.selection);
        }
        if(error){
            console.log('&&',error);
        }
    }
    updateHandler(event){
        this.visiblerecords = [...event.detail.records];
        console.log('######',event.detail.records)
    }
    onSelectedRow(event){
        const selectedRowInfo = event.detail.selectedRows;
        console.log('SelectedRows',selectedRowInfo);
        for (let i = 0; i < selectedRowInfo.length; i++) {
            console.log('You selected: ' + selectedRowInfo[i].id);
            console.log('Selected Value'+ selectedRowInfo[i].accName);
            console.log('Boolean Value'+ selectedRowInfo[i].isActive);
            this.selection.push(selectedRowInfo[i].id);
        }
    }
}