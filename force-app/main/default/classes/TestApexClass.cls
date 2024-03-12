public  class TestApexClass {
    
    public static void dotnotaion(){
        
        //List <case>  caseBag= [SELECT Id, AccountId, Status, Type FROM Case where AccountId != Null];
        set<id> CaseSet = New set<id>();
        For(case c : [SELECT Id, AccountId, Status, Type FROM Case where AccountId != Null]){
            CaseSet.add(c.AccountId);
        }
        system.debug('Case Records '+ CaseSet.size());
        
        // list<Account> Acc = [select id, Name, phone from account where id =: CaseSet]; //Dynamic Value = always coll name
        //system.debug('Case Records '+ Acc.size());
        for(account A : [select id, Name, phone from account where id =: CaseSet]){
            System.debug('Test >>'+ A);
            
        }
    }
    
    public  static Map<id, contact> MapAcc(string serchkey){
        Map<id, contact> conmap; // map bag
        
        if (string.isNotBlank(serchkey)) // only for string is notblank beacuse null will not handle blank
        {
            //account bag
            Map<id, Account> ACCMap =  new Map<id, Account>([select name, id from Account where name Like : '%'+serchkey+'%']);
            //conmap = new Map<id, contact>([select name, Accountid from contact where Accountid =: ACCMap.keyset()]);
            conmap = new Map<id, contact>([select name, Accountid from contact where Accountid =: ACCMap.values()]);
        }
        
        // view list way
        
        List<contact> myList = new List<contact>();
        for(contact c : conmap.values()){
            myList.add(c);
            System.debug('List Acc Records >> '+ c);
            
        }
        system.debug('conmap '  + conmap);
        system.debug('conmap '  + myList.size());
        return conmap;   
    }
}