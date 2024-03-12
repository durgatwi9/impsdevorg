public class AccwithConCtreateApexClass {
    
    public string  AccName;
    public string  ConName;
    
    public void AccCrete(){
        Account Acc = new Account();
        Acc.Name = 'Durga123';    
        Insert acc;
        ConCrete(Acc.Id);
    }
    
    List<Contact> contact1 = new List<Contact>();
    
    public void ConCrete(id AccvarId){
        for (Integer i = 1; i <= 6; i++) {
            Contact con = new Contact();
            con.FirstName = 'Contact123';
            con.LastName = 'Record ' + i;
            con.AccountId = AccvarId; // Associate the Contact with the Account
            contact1.add(con);
        }
        
        insert contact1;

    
    }
}