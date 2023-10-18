import { LightningElement,api } from 'lwc';

export default class Parentcompo extends LightningElement {

valuefortheparent = 'this is the value for the parent'
valueforthechild='this is the overridden value';

currentvalueforbar

handlechildevent(event){
    console.log("custom event has been fired from the child component");
    alert('1 ' +event.detail.firstpara);
    alert('2 ' +event.detail.secondpara);
}

handlebar(event){
this.currentvalueforbar = event.target.value;
}

handleclick(event){
    this.valueforthechild = "Overridden value from the button click"
}

handlecall(){
    var temp = this.template.querySelector('c-childcompo');
    temp.testmethod();
}
}