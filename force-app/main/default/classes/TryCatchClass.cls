public class TryCatchClass {
    
    public void Tryblock() {
        Savepoint sp = Database.setSavepoint();
        Account acc = new Account();
        acc.Name = 'Sanju';
        
        List<Contact> conList = new List<Contact>();
        
        try {
            insert acc;
            // System.debug('Inserted Account: ' + acc);
            
            for (Integer i = 0; i < 3; i++) {
                Contact con = new Contact();
                //con.LastName = 'Durga_' + i;  // Provide distinct last names
                con.AccountId = acc.Id;
                conList.add(con);
            }
            insert conList;
            System.debug('Inserted Contacts: ' + conList);
        } catch (Exception ex) {
            System.debug('Error Message: ' + ex.getMessage());
            Database.rollback(sp);
        }
    }
}