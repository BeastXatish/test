import { LightningElement, api, wire } from 'lwc';
import getAccountName from '@salesforce/apex/helloWorldcontroller.getAccountRec';
export default class HelloWorld extends LightningElement {

  //userName = 'World';
  textBoxValue = '';
  lastname = '';
  accName = '';
  @api recordId //used in imperative call;

  /*handleChange(event) {
      this.userName = event.detail.value;
  }*/

  /*loadlastname(event){
    this.lastname = event.detail.value;
  }*/

  @wire(getAccountName, {accid: "$recordId"
  })
  accountName ;// variable used to store the data (converted ) {data:"Burlington"}

  changeHandler() { // to call apex in LWC 1.imperative function call 2.Wire

    /*getAccountName({ accid: this.recordId })
      .then(data => {
        console.log('>>> ', data);
        if (data)
          this.accName = data;
      })

      .catch(errors => {
        console.log('err ', errors);
      })*/


    console.log('TEsting');
    debugger;
    let input = this.template.querySelectorAll('lightning-input');
    console.log('>>>>>', input);

    input.forEach(function (element) {

      console.log('element ', element.name)
      if (element.name == "inputfirstname")
        this.textBoxValue = element.value; //with the help of element.value we are getting the value which the user is paasing in the input field named as 'inputfirstname' and storing the value in textboxvalue variable and displaying it on html
      else if (element.name == "inputlastname")
        this.lastname = element.value;
    }, this)
  }

}