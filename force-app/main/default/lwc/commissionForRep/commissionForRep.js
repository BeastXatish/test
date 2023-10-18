import { LightningElement,api, wire} from 'lwc';
import getdata from '@salesforce/apex/DealCommission.getDealCommission'

const columns = [
    
    {label: 'Subtotal', fieldName: 'Subtotal'},
    {label:'Rep Name', fieldName: 'Name'},
    {label:'Total Amoumt', fieldName:'total'},
]
export default class CommissionForRep extends LightningElement {

    @api recordId;
    showdata=[];
    repdata =columns;
  
       @wire(getdata,{DealId :"$recordId"})
       getcommissiondata({data,error}){
        if(data){
            let Subtotal;
            let Name;
            let total;
            this.showdata = data.map(row=>{
                Subtotal = `${row.subtotal}`
                Name = `${row.name}`
                total = `${row.Total}`
                return{...row,Subtotal,Name,total}
            });
            console.log('*******',this.showdata);
         /*this.showdata= data;
         this.showdata.map(row =>{
            let repname;
            repname = row.name;
         })*/
        }
       }
   if(error){
    this.errors = error;
    console.log('%%%%%',JSON.stringify(this.errors));
   }  
}