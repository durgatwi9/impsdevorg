public class Practice_24_Apex {
    
    public static void Insertacc(){
        
        account acc =new account();
        acc.name = 'sanju';
        insert acc;
        system.debug( 'Acc Details' + acc);
        
        contact con = new contact();
        con.lastname = 'Bhanu';
        con.AccountId = acc.Id;
        insert con;
        system.debug( 'Acc Details' + con);
    }
    
    public static void updateObj(){
        
        account acc = new account();
        acc.id = '0015i0000148023AAA';
        acc.name = 'babe';
        update acc;
        system.debug('updated name ' + acc);
        
        
       account acc1= [select id, name from account where id  =: '0015i0000148023AAA'];
        acc1.name = 'puppy';
        update acc1;
         system.debug('updated name ' + acc1);
    }
    
    public static void getcontactsassosiatedacc(){
        
        list<account> acc = [select id, Name from account];
        set<id> accid = new set<id>();
        for(account accq: acc){
            accid.add(accq.id);
        }
            
        list<contact> conlist = [select id, lastname, accountid from contact where accountid IN: accid];
        list<contact> cond = new list<contact>();
        for(contact con1 : conlist){
            cond.add(con1);
        }
        System.debug('contact with accounts' + cond.size());
    }
    
    public static void GetChildtoparentdata(){
        
        list<contact> conlist = [select id, lastname, Accountid from contact where Accountid != Null];
        
        set<id> accid = new set<id>();
        for(contact con : conlist){
            accid.add(con.AccountId);
        }
        
        list<account> acclist = [select id, name from account where id IN: accid];
        list<account> accdata = new list<account> ();
        for(account acc: acclist){
            accdata.add(acc);
        }
        system.debug('account data'+ accdata.size());
    }
}