public class DailyPractice {
    
    public static void insertAccwithCon(){
        
        account acc = new account();
        acc.name = 'sanju';
        insert acc;
        system.debug('This is Account'+ acc);
        
        contact con = new contact();
        con.lastname = 'Bhanu';
        con.accountid = acc.Id;
        insert con;
        system.debug('This is Account'+ con);
    }
    
    /*
list<account> acc = new list<account>();
set <case> ca = new set <case>();
Map<id, account> Accid = new Map<id, account>();
Map<id, list<contact>> Conid = New Map<id, list<contact>>(); // one to many
Map<id, Map<id, list<case>>> caseid = new  Map<id, Map<id, list<case>>>();

*/
    
    
    Public static void ConData(){
        Map<id, Account> AccMap = new Map<id, Account>([select id, name from account]);
        
        list<contact> conupdate = new list<contact> ();
        list<contact> condata =[select Id, lastname, Accountid from Contact where Accountid IN: AccMap.keySet()];
        system.debug('Num of contatcs Assosiated with Account'+ condata.size());
        
        for(contact con : condata){
            Account acc = accMap.get(con.AccountId);
            if(acc.id != NUll){
                con.lastName = acc.Name;
                conupdate.add(con);
            }
        }
        update conupdate;
    }
    
    
   


 
}