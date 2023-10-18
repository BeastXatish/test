global class AccountSoapService {

    webService static Account exposeAccountInfo(String accId){
        return [Select Name From Account Where Id =:accId];
    }
}