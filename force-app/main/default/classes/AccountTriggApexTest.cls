@isTest
public class AccountTriggApexTest {
    
    public static TestMethod void AccountTest(){
        
        Test.startTest();
        Account Acc = new Account();
        Acc.Name  = 'Sanju';
        Acc.Industry = 'Banking';
        insert Acc;
        
        if(acc.id != null &&  Acc.Industry == 'Banking'){
            contact con = new contact();
            con.LastName = Acc.Name;
            con.AccountId = Acc.id;
            Test.stopTest();
        }
    }
    
}