import { LightningElement , api} from 'lwc';
import newMethod from '@salesforce/apex/GettingDataFromLWC.method1';
import fileUpload from '@salesforce/apex/GettingDataFromLWC.uploadFile';
export default class PopulateAddressWithApiCall extends LightningElement {

    stateValue = '';
    cityValue = '';
    countryValue = '';
   // data = [1];
   firstNameValue;
   lastNameValue;
    dataNew = [{ index: 1, state: '', city: '', country: '' }];
    dataNew1 = {firstname: '', lastname:''};
    finalData = {Name:{},Address:[{}]}
    isShowComponent = true;
    fileNameCheck = false;
    fileNames=[];
    wrapperResult ;
    
    recordId = '0015j00000ymgZQAAY';

    async handleChange(event) {
        this.isShowComponent = false
        let isChecked = event.target.checked;
        let indexValue = event.target.dataset.id;
        console.log('CheckBoxId', indexValue);
        console.log('Checked Value', isChecked);
        for (var i in this.dataNew) {
            if (this.dataNew[i].index == indexValue) {
                console.log('this.dataNew[i].index == indexValue',this.dataNew[i].index == indexValue);
                var valueToBeUpdated = this.dataNew[i];
                console.log('valueToBeUpdated',valueToBeUpdated);
                if (isChecked == true) {
                    valueToBeUpdated.state = 'Rajasthan';
                    valueToBeUpdated.city = 'Jaipur';
                    valueToBeUpdated.country = 'India';
                 
                    let cityList = this.template.querySelector(".cityInputField");
                   
                        let city = cityList.value;
                         if(!city){
                        console.log('Ok',this.dataNew[indexValue-1].city);
                     }
                        // else{
                        //     this.dataNew.city.setCustomValidity('Please fill the City name before clicking on Submit');
                        // }
                        // this.dataNew.city.reportValidity();
                    
                    
                } else {
                    valueToBeUpdated.state = '';
                    valueToBeUpdated.city = '';
                    valueToBeUpdated.country = '';
                }
                this.dataNew[i] = valueToBeUpdated;
            }
        }
        let cityList = this.template.querySelectorAll(".cityInputField");  
        //console.log(cityList[indexValue-1].value);  
        let currentItem = cityList[indexValue-1];
        let city = currentItem.value;
        if(!city){
                    currentItem.setCustomValidity('');
              }
              currentItem.reportValidity();

        let stateList = this.template.querySelectorAll(".stateInputField");
        let currentItem1 = stateList[indexValue-1];
        let state = currentItem1.value;
        if(!state){
                    currentItem1.setCustomValidity('');
              }
              currentItem1.reportValidity();
        
        let countryList = this.template.querySelectorAll(".countryInputField");
        let currentItem2 = countryList[indexValue-1];
        let country = currentItem2.value;
        if(!country){
            currentItem2.setCustomValidity('');
              }
              currentItem2.reportValidity();

        console.log('After Update', this.dataNew);
        this.isShowComponent = true;
    }

    handleClick() {
        this.isShowComponent = false
        let lengthofData = this.dataNew.length;
        console.log('lengthofData', lengthofData);
        this.dataNew.push({ index: this.dataNew[lengthofData-1].index+1 , state: '', city: '', country: '' });
        console.log('Index Logic',this.dataNew[lengthofData-1].index+1);
        console.log('Data Value', this.dataNew);
        this.isShowComponent = true;
    }

    get acceptedFormats() {
        return ['.pdf'];
    }
    name = [];
    contentVersion = [];
 fileList = {name:'',contenVersionid:''};
    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        console.log('UploadedFiles',uploadedFiles);
        for(var i in uploadedFiles){
        this.fileNames.push(uploadedFiles[i].name);
        }
        console.log('FileNames',this.fileNames);
        fileUpload({fileObj:uploadedFiles}).then(result=>{
            this.wrapperResult = result;
            console.log('Res',this.wrapperResult);
            this.name.push(this.wrapperResult.name);
          //  this.contentVersion.push(result.contentVersionid);
           // this.fileList = {name:this.name,contenVersionid: this.contentVersion};
           // console.log('FileList',this.fileList);
           // this.handleSubmit();
        })
        
        .catch(error=>{
            console.log('Error is = ',error);
        })
        this.fileNameCheck = true;
    }
    handleRemove(event) {
        this.isShowComponent = false
        let indexValue = event.target.dataset.id;
        console.log('IndexValue',indexValue);
        this.dataNew.splice(indexValue-1,1);
        
        let tempArray = this.dataNew;

        for (let i in this.dataNew) {
            console.log('i',i);
            tempArray[i].index = parseInt(i)+1;
            console.log('Parse Value', parseInt(i)+1);
            console.log('tempArray[i].index = parseInt(i)+1;',tempArray[i].index)
        }
        this.dataNew = tempArray;
        console.log('After this.dataNew',this.dataNew);
        this.isShowComponent = true;
    }
    handleFirstNameChange(event){
        this.firstNameValue = event.target.value;
    }

    handleLastNameChange(event){
    this.lastNameValue = event.target.value;
    }
    
     handleSubmit(){
        this.dataNew1 = {firstname:this.firstNameValue,lastname:this.lastNameValue};
        this.finalData ={Name:this.dataNew1,Address:this.dataNew};
        console.log('Final Data',this.finalData);

        newMethod({jsonData: JSON.stringify(this.finalData),fileData:JSON.stringify(this.wrapperResult)}).then(result=>{
            console.log('Result is',result);
        })
        .catch(error => {
            console.log('Error', JSON.stringify(error));
       })

        let cityList = this.template.querySelectorAll(".cityInputField");
        let stateList = this.template.querySelectorAll(".stateInputField");
        let countryList = this.template.querySelectorAll(".countryInputField");

        cityList.forEach(currentItem =>{
            let city = currentItem.value;
            console.log('Current Item Value',city);
            if(!city){
                currentItem.setCustomValidity('Please fill the City name before clicking on Submit');
            }
            else{
                currentItem.setCustomValidity('');
            }
            currentItem.reportValidity();
        })

        stateList.forEach(currentItem =>{
            let state = currentItem.value;
            if(!state){
                currentItem.setCustomValidity('Please fill the State name before clicking on Submit');
            }
            else{
                currentItem.setCustomValidity('');
            }
            currentItem.reportValidity();
        })

        countryList.forEach(currentItem =>{
            let country = currentItem.value;
           // console.log('Current Item Value',country);
            if(!country){
                currentItem.setCustomValidity('Please fill the Country name before clicking on Submit');
            }
            else{
                currentItem.setCustomValidity('');
            }
            currentItem.reportValidity();
        })      
    }
}