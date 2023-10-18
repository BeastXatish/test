import { LightningElement, wire ,api, track} from 'lwc';
import getaccinfo from '@salesforce/apex/dataTableEx.getaccrecord';
export default class EmployeeDatatable extends LightningElement {
     columns = [

        { label: 'Id', fieldName: 'Id', type : 'text' },
    
        { label: 'AccountNumber', fieldName: 'AccountNumber', type: 'text'}
    
    
    ];
    

    employeeColumns = [
        { label: 'Employee Id', fieldName: 'employeeId' },
        { label: 'First Name', fieldName: 'firstName' },
        { label: 'Last Name', fieldName: 'lastName' },
        { label: 'Phone Number', fieldName: 'employeePhone', type: 'phone' },
        { label: 'Email Address', fieldName: 'employeEemail', type: 'email' }
    ];
   
     datavalue;
    @api recordId;
     datainfo = [];
     
    connectedCallback(){

        getaccinfo({conId : this.recordId} )

            .then(result=>{
                console.log('%%%%%',result.Id);
                console.log('^^^^^', result);
                /*this.datainfo.push ({

                    RecordId : result.Id ,
            
                    AccountNumber: result.AccountNumber,
            
                    AnnualRevenue: result.AnnualRevenue
            
                    });*/
               // this.datainfo = JSON.stringify(result);
                this.datavalue = result;

                console.log('$$$$$',this.datavalue);

            })

            .catch(error=>{

                this.datainfo = undefined;
                console.log('####', error);

            });

    }

    //columns = columns;
    
    employeeData = [
        {
            employeeId: '1',
            firstName: 'Richard',
            lastName: 'Hendricks',
            employeePhone: '(158) 389-2794',
            employeeEmail: 'richard@piedpiper.com'
        },
        {
            employeeId: '2',
            firstName: 'Jared',
            lastName: 'Dunn',
            employeePhone: '(518) 390-2749',
            employeeEmail: 'jared@piedpiper.com'
        },
        {
            employeeId: '3',
            firstName: 'Erlich',
            lastName: 'Bachman',
            employeePhone: '(815) 391-2974',
            employeeEmail: 'erlich.bachman@piedpiper.com'
        }
    ];

   /* @wire(getaccinfo ,{ conId: '$recordId' })

    accinfo({error,data}){



        if (data) {

            
            this.datainfo = data;
            this.datainfo = JSON.stringify(data);
            console.log('$$$$$$$',this.datainfo);


        }
        if(error){
            console.log('#######',error);
        }

    }*/


}