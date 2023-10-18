import { LightningElement } from 'lwc';

export default class PopulateAddress extends LightningElement {

    stateValue = '';
    cityValue = '';
    countryValue = '';
   // data = [1];
    dataNew = [{ index: 1, state: '', city: '', country: '' }];
    isShowComponent = true;

    handleChange(event) {
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
                } else {
                    valueToBeUpdated.state = '';
                    valueToBeUpdated.city = '';
                    valueToBeUpdated.country = '';
                }
                this.dataNew[i] = valueToBeUpdated;
            }
        }
        this.isShowComponent = true;
        console.log('After Update', this.dataNew);
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

    handleSubmit(){
        let cityList = this.template.querySelectorAll(".cityInputField");
        let stateList = this.template.querySelectorAll(".stateInputField");
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
      
    }
}