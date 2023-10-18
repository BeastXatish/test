public class ExtractStateAbbreviation {
    
    public static String getStateAbbreviationFromMetaData(String stateName){
        String stateAbbreviationValue;
       
        List<StateAbbreviation__mdt> stateValue = [Select AbbreviationValue__c From StateAbbreviation__mdt Where MasterLabel =: stateName];
        if(stateValue.size()>0){
            stateAbbreviationValue = stateValue[0].AbbreviationValue__c;
        }
        System.debug('stateAbbreviationValue '+stateAbbreviationValue);
        return stateAbbreviationValue;
    }
}