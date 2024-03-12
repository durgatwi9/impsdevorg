public class MethodExp {
    Account Acc;
    contact con;
     
    public  void creAccount(){
        Account Acc = new Account();
        acc.name = 'Saju Baba';
        insert Acc;
        CreCon(acc.Id);
    }
    
    public  void CreCon(id Accid){
         con = new Contact();
        con.lastname = 'Durga';
        con.AccountId = Accid;
        insert con;
        
        system.debug('Con with Acc' + con);
        
        list<contact> conlist = [select id, name,accountid from contact where accountid = : Acc.Id];
        for(contact con1 : conlist){
            system.debug('List of Con records' + con1);
        }
    }
}