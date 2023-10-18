public with sharing class pokemonCardListController {

    @AuraEnabled
    public static List<Pokemon__c> getpokemonlist(String searchkey){

        if(searchkey != ''){
            String key = '%'+searchkey+'%';
            List<Pokemon__c> pokemonsearchlist =[SELECT Id, Name, Height__c , Image__c, Weight__c, Pokemon_Trainer__r.FirstName FROM Pokemon__c WHERE Name Like :key]; 
            return pokemonsearchlist;
        }
        else {
            List<Pokemon__c> pokemonlist =[SELECT Id, Name, Height__c , Image__c, Weight__c, Pokemon_Trainer__r.FirstName FROM Pokemon__c];
            if(!pokemonlist.isEmpty()){
                return pokemonlist;
            }
                return Null;
        }
       
    }

}