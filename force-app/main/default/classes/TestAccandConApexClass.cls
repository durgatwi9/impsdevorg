public class TestAccandConApexClass {
        
    public string  AccName;
    public string  ConName;
    public integer num;
    
    public void AccCrete(){
        Account Acc = new Account();
        Acc.Name = 'Durga123';    
        Insert acc;
        ConCrete(Acc.Id); // dynamic calling
    }
    
    List<Contact> contacts1 = new List<Contact>();
    
    public void ConCrete(id AccvarId) // var declaration
    {
        for (Integer i = 1; i <= num; i++) {
            Contact con = new Contact();
            con.FirstName = 'Contact123';
            con.LastName = 'Record ' + i;
            con.AccountId = AccvarId; // Associate the Contact with the Account
            contacts1.add(con);
        }
        
        insert contacts1;
        system.debug('Test >>'+ contacts1);

    }

    }

  /* annynonumus
  TestAccandConApexClass obj = new TestAccandConApexClass();
obj.num = 8;
obj.AccCrete();

*/