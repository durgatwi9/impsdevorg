public  class Acc2OppApex {
    public static contact c;
    Public static  list <opportunity> CrtAcc2Opp(string Name, integer num){
        list <opportunity> oppList = new list <opportunity>();
        
        Account acc = New account();
        acc.Name = Name;
        insert acc;
        
        for( integer i=0; i < num; i++){
            
            opportunity opp = new opportunity();
            opp.Name   = 'Test'+  Acc.name;
            opp.closeDate = date.today();
            opp.StageName = 'closedwon f';
            oppList.add(opp);
        }
        
        if(oppList != null ){
            insert oppList;
            
            system.debug('oppList  ' + oppList );
            system.debug('oppList Size  ' + oppList.Size());
        }
        return oppList;
    }
    
    
    public static  Map<id, contact> MapAcc(string serchkey){
        Map<id, contact> conmap; // map bag
        
        if (string.isNotBlank(serchkey)) // only for string is notblank beacuse null will not handle blank
        {
            //account bag
            
            Map<id, Account> ACCMap =  new Map<id, Account>([select name, id from Account where name Like : '%'+serchkey+'%']);
            conmap = new Map<id, contact>([select name, Accountid from contact where Accountid =: ACCMap.keyset()]);
           // conmap = new Map<id, contact>([select name, Accountid from contact where Accountid =: ACCMap.values()]);
        }
        
        // view list way
        List<contact> Conlist = new List<contact>();
        for(contact c : conmap.Values()){
            Conlist.add(c);
            System.debug('List Acc Records >> '+ c);
        }
        
        
        List<id> myListid = new List<id>();
        for(id ids : conmap.keyset()){
            myListid.add(ids);
            System.debug('List Acc Records >> '+ ids);
        }

        system.debug('conmap '  + conmap);
        system.debug('conmapsize'  + Conlist.size());
        return conmap;   
        
        
    }
}