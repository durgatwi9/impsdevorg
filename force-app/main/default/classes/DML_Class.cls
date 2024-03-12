public class DML_Class {
    
    
    public void Dml_Method_insert(string AccN){
        List<Account> accList = new List<Account>();
        
        for (Integer i = 0; i < 2; i++) {
            Account acc1 = new Account();
            acc1.Name = AccN;
            accList.add(acc1);
        }
        
        insert accList;
        system.debug('Insert After 🚀🚀🚀+🧑‍🚀 '+ AccList.size());
        
    }
    
    public void Dml_Method_update(string Accid){
        
        list <account>  Acc = [select id,name from account where name =: Accid];
        system.debug('Accsize 😊'+ acc.size());
        
        for(account acc2 : Acc){
            acc2.name = 'Test for me 😊';
            
        }        
        update Acc;
        system.debug('Accsize'+ acc.size());
    }
    
    public void Dml_MethodDelete(string Accname){
        list<Account> AccD = [select id, name from account where name =: Accname];
        system.debug('AccDelete record_size'+ AccD.size());
        delete AccD;
    }
}