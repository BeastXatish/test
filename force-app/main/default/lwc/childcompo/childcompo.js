import { LightningElement,api } from 'lwc';

export default class Childcompo extends LightningElement {

    @api valuefromthechild = 'this is the child component value'
    @api valuebar
   /* @api testmethod(){
        alert('THis is the child method calling from parent event');
    }*/


    
    handleclick(){
        const cusevent= new CustomEvent('buttonclick',
        //FOr single parameter{detail : 'child component parameter'}
        {
            // passing multiple values
            detail : {
                        firstpara : 'First Value',
                        secondpara : 'second value'
                      }
        }

        );
        this.dispatchEvent(cusevent);
    }
}