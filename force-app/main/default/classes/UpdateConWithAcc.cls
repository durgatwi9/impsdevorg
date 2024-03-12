public class UpdateConWithAcc {
    
    Public static void UpdateconWithAcc(List<Account> Acclist, Map<id, account> OldMap){
        
        Map<id,Account> AccountData = new Map<id,Account>(Acclist);
        list<contact> conlist = [select id, lastname, phone, accountid from contact where Accountid IN:AccountData.keyset()];
        system.debug('contacts with accounts' + conlist.size());
        list<contact> conData = new list<contact>();
        
        for(contact con : conlist){
            Account NewAcc = AccountData.get(con.accountid);
            Account OldAcc = Oldmap.get(con.AccountId);
            System.debug('ContactId: ' + con.Id);
            System.debug('newAcc: ' + newAcc);
            System.debug('oldAcc: ' + oldAcc);
            
            if(newAcc.Phone != null && oldAcc.Phone != newAcc.Phone){
                con.phone = newacc.phone;
                conData.add(con);
            }
        }
        Update condata;
        system.debug('updated con data'+ condata.size());
    }
    
    
}