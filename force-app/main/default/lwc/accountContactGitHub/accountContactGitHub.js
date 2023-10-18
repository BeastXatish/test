import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import getaccountInfo from '@salesforce/apex/accountContactStandardController.getAccountDetail';
import getContactInfo from '@salesforce/apex/accountContactStandardController.getContactDetail';
export default class AccountContactGitHub extends NavigationMixin(LightningElement) {
  accountId;
  countOfContactsSaved = 0;
  @api recordId;
  accRecordValue;
  contacts = [];
  accName;
 
  @wire(getaccountInfo, { accId: '$recordId' })
  accdata({ data, error }) {
    if (data) {
      this.accRecordValue = data;
      //accName = this.accRecordValue.Name;
    }
  }                 

  @wire(getContactInfo, { accIdForContact: '$recordId' })
  contactdata({ data, error }) {
    if (data) {
      //  debugger;
      this.contacts = data;
      console.log('this.contacts', this.contacts);
      console.log('this.contacts.length', this.contacts.length);
    }
  }
  handleSave(event) {
  debugger;
    console.info("save");
     let accountForm = this.template.querySelector('lightning-record-edit-form[data-id="accountForm"]');
     accountForm.submit();

     let contactForm = this.template.querySelectorAll('lightning-record-edit-form[data-id="contactForm"]');
     contactForm.forEach((form) => {
       form.submit();
     });

     console.log('Contact Form',contactForm);
  }

  handleAccountSuccess(event) {
    this.accountId = event.detail.id;
    console.info("Account is saved, new id is: " + this.accountId);

    this.template.querySelectorAll('lightning-input-field[data-id="contactAccountId"]').forEach((field) => {
      field.value = this.accountId;
    });


  }
  
  handleContactSaveSuccess(event) {
    this.countOfContactsSaved = this.countOfContactsSaved += 1;
    // once we have saved 3 contacts then we can navigate!
    if (this.countOfContactsSaved === 3) {
      console.log("3 contacts saved! Lets redirect!");
      this.navigateToNewAccount();
    }
  }

  navigateToNewAccount() {
    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: this.accountId,
        actionName: "view"
      }
    });
  }

  handleReset(event) {
    this.accountId = "";
  }
}