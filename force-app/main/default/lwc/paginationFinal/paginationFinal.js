import { LightningElement ,wire} from 'lwc';
import getdataofaccounts from '@salesforce/apex/PaginationController.getAccountsData';

const columns = [
    {label:'Account Name', fieldName : 'Name'},
    {label:'Phone', fieldName: 'Phone'},
    {label:'Industry', fieldName:'Industry'},
    {label:'Ownership', fieldName:'Ownership'},  
];
export default class PaginationFinal extends LightningElement {
    accountsdata
    column = columns;
    visiblerecords;
    selection = [];
    @wire(getdataofaccounts)
    wiredata({data,error}){
        if(data){
            this.accountsdata = data;
            // let My_id = [];
            // My_id.push(this.accountsdata[0].Id);
            // this.selection = My_id;

          //  console.log('this.selection ',this.selection);
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
            console.log('Selected Value: '+ selectedRowInfo[i].accName);
            console.log('Boolean Value: '+ selectedRowInfo[i].isActive);
            this.selection.push(selectedRowInfo[i].id);
            console.log('Selection',this.selection);
        }
    }
}