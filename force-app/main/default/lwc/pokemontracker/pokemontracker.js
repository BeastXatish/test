import { LightningElement,api,wire} from 'lwc';
import { getRecord , getFieldValue } from 'lightning/uiRecordApi';

const NAME = 'Pokemon__c.Name';
const LATITUDE = 'Pokemon__c.Location__Latitude__s';
const LONGITUDE = 'Pokemon__c.Location__Longitude__s';
const Pokemonfields = [NAME,LONGITUDE,LATITUDE];

export default class Pokemontracker extends LightningElement {
    @api recordId;
    mapmarkers=[];
    name;
    cardtitle;

    @wire(getRecord,{ recordId:'$recordId',fields: Pokemonfields})
    pokemondata({error,data}){
        if(error){
            console.log('error :'+JSON.stringify(error))
        }
        else if(data){
            this.name = getFieldValue(data,NAME);
            this.cardtitle = this.name;
            const Latitude = getFieldValue(data,LATITUDE);
            const Longitude = getFieldValue(data,LONGITUDE);

            this.mapmarkers =[{
                location : {Latitude,Longitude},
                title : this.name,
                description : `Cords: ${Latitude},${Longitude}`
            }]
        }
    }
}