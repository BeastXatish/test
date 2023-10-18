import { LightningElement } from 'lwc';
import getPokemonList from '@salesforce/apex/pokemonCardListController.getpokemonlist';
export default class Pokemoncardlist extends LightningElement {

    pokemondata;
    errors;
    searchwords = '';
    searchavailable = true;
    connectedCallback(){
      this.loadpokemondata(this.searchwords);
    }

    handlechange(event){
        this.searchwords = event.target.value;
        this.loadpokemondata(this.searchwords);// at the tim of calling this method searchwords value will go in 'searchword'
    }

    loadpokemondata(searchword){
        getPokemonList({searchkey : searchword})// searchkey is the variable in the apex class as we are calling the apex method here imperatively passing the string arguments named searchword which hold the event value after the apex logic promise will run displaying the data and error and data is stored in another variable named as pokemondata which then is used in the html to itterate as it returns list 
        .then(data=>{
            this.pokemondata = data;
            console.log('The Resulted Data : '+JSON.stringify(this.pokemondata));
            if(this.pokemondata.length>0){
                this.searchavailable = true;
            }
            else{
                this.searchavailable = false;
            }
        })
        .catch(error =>{
            this.searchavailable = false;
            this.errors = error; 
        })
    }
}