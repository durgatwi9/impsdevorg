public class Contact1ApexClass {

    Public void AccCre(){
        Account acc = new Account();
        acc.name = 'sanju';
        insert acc;
        ContactCre(acc.Id);
        
    }
    public void ContactCre(id idvar){
        contact con = new contact();
        con.LastName = 'durga';
        con.AccountId = idvar;
        insert con;
    }
    
}