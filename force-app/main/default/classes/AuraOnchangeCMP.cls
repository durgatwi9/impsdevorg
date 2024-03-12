public class AuraOnchangeCMP {
    
    @auraEnabled
    Public static list<Account> GetAccountwithKey(string serchKey){
        
        String InputKey =  '%' +serchKey+ '%';
        list<Account> Acclist = [SELECT Id, Name, Phone FROM Account WHERE Name LIKE :InputKey];
        return Acclist;
        
    }
}