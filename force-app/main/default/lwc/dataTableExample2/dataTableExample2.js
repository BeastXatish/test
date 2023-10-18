import { LightningElement, wire ,api} from 'lwc';
import getaccdata from '@salesforce/apex/GetAccountPagination.getAccounts'
//import { refreshApex } from '@salesforce/apex';

const columns = [
    { label: 'Account Name', fieldName: 'accName' },
    { label: 'Phone', fieldName: 'phoneValue' },
    { label: 'Industry', fieldName: 'industryValue' },
    { label: 'Ownership', fieldName: 'ownershipValue' },
    { label: 'Id Of Account', fieldName: 'id' },

]
export default class DataTableExample2 extends LightningElement {
    accountsdata
    column = columns;
    visiblerecordstoshow;
    @api selection = [];
    @wire(getaccdata)
    wiredata({ data, error }) {
        if (data) {
            this.accountsdata = data;
            // let My_id = [];
            // My_id.push(this.accountsdata[0].Id);
            // this.selection = My_id;

            //  console.log('this.selection ',this.selection);
        }
        if (error) {
            console.log('&&', error);
        }
    }
    updateHandler(event) {
        this.visiblerecordstoshow = [...event.detail.records];
       // refreshApex(this.visiblerecordstoshow);
        console.log('######', event.detail.records)
    }
    onSelectedRow(event) {
        // const selectedRowInfo = event.detail.selectedRows;
        // console.log('SelectedRows', selectedRowInfo);
        // for (let i = 0; i < selectedRowInfo.length; i++) {
        //     console.log('You selected: ' + selectedRowInfo[i].id);
        //     console.log('Selected Value: ' + selectedRowInfo[i].accName);
        //     console.log('Boolean Value: ' + selectedRowInfo[i].isActive);
        var el = this.template.querySelector('lightning-datatable');
        console.log(el);
        this.selection = el.getSelectedRows();
        console.log('The Selected Value ' + this.selection);

        //  console.log("event.detail.selectedRows", event.detail.selectedRows)
        // this.selectedRows = event.detail.selectedRows;
        // //this.selectedRows = event.detail.selectedRows;
        // console.log('Values :' + this.selectedRows);
        //this.selection.push(selectedRowInfo[i].id);
        //console.log('Selection',this.selection);
    }
    
    // get dataforparent(){
    //     return this.selection;
    // }
}