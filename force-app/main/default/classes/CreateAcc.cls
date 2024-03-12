public class CreateAcc {
    
    Public static void CreAcc(){
        Account Acc = new Account();
        Acc.Name = 'Durtga';
        insert Acc;
        //system.debug(' Account Deatils '+ Acc);
        
        Contact con = new Contact();
        con.Lastname = 'Sanju';
        con.Accountid = Acc.Id; 
        insert con;
       // system.debug(' Account Deatils '+ con);
        
    }
    Public static void TestData(){
        
        list <Account> AccList = [Select id, Name From Account];
        list <id> AccColl = new list<id>();   // even set also we can use
        for(Account  A: AccList){
            AccColl.add(A.Id);
            //System.debug('List Acc Records Acc >> '+ A);
        }
        
        list <Account> Accountlist =  ([Select id, name, Phone  from Account]);
        list <id> SetofAccu = new  list <id>();
        for (Account c : Accountlist){
            SetofAccu.add(c.id);
            //system.debug('Conatc List Data '+ C);
        }
        
              list <Contact> ConListonlyAccid =  ([Select id, name  from Contact where Accountid != Null]);
        system.debug('Conatc List Data Set >>'+ ConListonlyAccid.size());
         for (Contact Con3 : ConListonlyAccid){
             system.debug(' Conatc List Data Set >>'+ Con3);
         }
        }
    }