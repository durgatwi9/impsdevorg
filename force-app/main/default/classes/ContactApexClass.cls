public class ContactApexClass {
    //Dynamic Var Declaration
    public String NameAcc;
    public String subjectvar;

    public void AccCre() {
        Account acc = new Account();
        acc.Name = NameAcc;
        insert acc;
        
        // Call method inside Method
        // Dynamic id Calling
        contactcre(acc.Id); 
        
    }
    
    // Inside method Var declration (Id Accidvar)
    public void contactcre(Id Accidvar) {
        Contact con = new Contact();
        con.LastName = subjectvar;
        con.AccountId = Accidvar;
        insert con;
    }
}