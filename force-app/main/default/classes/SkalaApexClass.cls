public class SkalaApexClass {
    
    Public string name;
    Public id cid;
    
    public void Acc(){
        
        Account Acc = New Account();
        Acc.Name = 'Test';
        Acc.phone = '897889998';
        insert acc;
        contact1(acc.Id);
        
        system.debug('Test ' + Acc);
        
        
    }
    public void contact1(id Accid){
        Contact con = new contact();
        con.lastName = 'Durga';
        con.AccountId = Accid;
        insert con;
        system.debug('Test ' + Con);
    }
}