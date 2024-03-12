public class AllApexClasss {
    
    Public static void InsertAccwithCon(){
        account acc = new account();
        acc.name = 'bhanu';
        acc.phone = '9886534';
        insert acc;
        system.debug('contact deatils' + acc);
        
        contact con = new contact();
        con.lastname = acc.name;
        con.AccountId = acc.Id;
        insert con;
        system.debug('contact deatils' + con);
    }
    
    Public void updatesingleRecord(){
        account acc  = new account();
        acc.Id = '0015i0000120o28AAA';
        acc.name = 'Ramneni';
        update acc;
        system.debug('acc update name deatils' + acc);
        
        account accRecord = [select id, name from account where id =: '0015i0000120o28AAA'];
        accrecord.name = 'sanju';
        update accRecord;
        system.debug('acc update name deatils' + accRecord);
    }
    
    //Parent to child
    Public void Account_contacts(){
        
        list<account> acc = [select id, name from account];
        set<id> accdata  = new set<id>();
        
        for(account accids : acc){
            accdata.add(accids.id);
        }
        system.debug('acc ids'+ accdata.size());
        
        list<contact> conlist =  [select id, lastname from contact where accountid IN: accdata];
        list<contact> condata = new list<contact>();
        
        for(contact con : conlist){
            system.debug('contacts' + con);
            condata.add(con);
        }
        system.debug('list of contacts with assosited with account' + condata.size());
    }
    //Child to parent
    public static void Contact_Account(){
        list<contact> conlist = [select id, lastname, accountid from contact where accountid != null];
        set<id> conids = new set<id>();
        for(contact con : conlist){
            conids.add(con.AccountId);
        }
        system.debug('account with contact size' + conids.size());
        
        list<account> acclist = [ select id, name from account where id IN: conids];
        list<account> accdata = new list<account>();
        for(account acc : acclist){
            accdata.add(acc);   
            system.debug('account details with con' + acc);
        }
        system.debug('account details with con' + accdata.size());
    }
    
    //Map Usage
    public static void MapPractice(){
        list<case> casel = [select id, casenumber from case limit 1 ];
        
        map<id, case> caseMap = new map<id, case>();
        for(case ca : casel){
            caseMap.put(ca.id, ca);
        }
        list<case> casList = caseMap.values();
        set<id> casid = casemap.keyset();
        
        system.debug( 'casList data'+ casList);
        system.debug( 'casid data'+ casid);
        
        
    }
    public static void MapPractice1(){
        
        map<id, case> caselist = new map<id, case>([select id, casenumber from case]);
        for(case cavalue : caselist.values()){
            //case cavalue = caselist.get(ckey);
            system.debug('value case ' + cavalue);
            
            // Dealing with 1 object Man
            Map<id, account> Account = new map<id, account>();
            // Dealing with 2 objects special man
            Map<id, list<contact>> accWithConMap = new Map<id, list<contact>>(); // Account with contacts data
            // Dealing with 3 objects Super man
            Map<id, Map<id, list<case>>> accWithConwithCases = new Map<id, Map<id, list<case>>>();  // Account with contacts with Cases data
        }
    }
    
    
}