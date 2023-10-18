import { LightningElement,api,wire} from 'lwc';
import { getRecord , getFieldValue} from 'lightning/uiRecordApi';
import TRAINER_FIELD from '@salesforce/schema/Pokemon__c.Pokemon_Trainer__c'

const pokemonfield = [TRAINER_FIELD];
export default class Poketrainerdetail extends LightningElement {
    @api recordId;
    @wire(getRecord,{recordId : '$recordId', fields : pokemonfield})// @wire accpets record which we are getting from @api recordId which holds the current page recid and in the field we have given the trainer field on the pokemon obj and storing the info in the pokemons property 
    pokemons;

    // get the trainer field value and use the trainerid method in the Html to store the record-id
    get trainerid(){
        return getFieldValue(this.pokemons.data,TRAINER_FIELD)
    }
}