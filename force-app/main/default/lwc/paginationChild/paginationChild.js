import { LightningElement ,api} from 'lwc';

export default class PaginationChild extends LightningElement {
    totalrecords
    currentpage =1
    totalpage =0;
    visiblerecord
    pagesize = 5
   @api selectedrecord = [];
    @api
    get records(){
        return this.visiblerecord;
    }
    set records(data){
            if(data){
                this.totalrecords = data;
                this.totalpage = Math.ceil(data.length/this.pagesize);
                this.updateRecords()
            }
    }
    get disableprevious(){
        return this.currentpage<=1
    }
    get disablenext(){
        return this.currentpage>=this.totalpage
    }
    handlenext(){
        if(this.currentpage < this.totalpage){
            this.currentpage = this.currentpage +1;
            this.updateRecords();
        }
    }
    handleprevious(){
        if(this.currentpage>1){
            this.currentpage = this.currentpage-1
            this.updateRecords();
        }
    }
    updateRecords(){
        const start = (this.currentpage-1)*this.pagesize;
        const end = this.pagesize*this.currentpage;
        this.visiblerecord = this.totalrecords.slice(start,end);
        this.selectedrecord = this.visiblerecord;
        this.dispatchEvent(new CustomEvent('update',{
            detail:{
                records: this.visiblerecord
            }
        }))
    }
    
}