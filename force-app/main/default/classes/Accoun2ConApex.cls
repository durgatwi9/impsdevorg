public class Accoun2ConApex {
    
    public static list<contact> AccounttoCon(string Name, string PhoneNum, integer Num){
        //Collection Declartion
        list<contact> conlist = new list<contact>();
        List<contact> myList = new List<contact>();
        
        // Account Create
        account Acc = new Account();
        Acc.Name = Name;
        Acc.Phone = PhoneNum;
        insert Acc;
        
        if(Num > 0){
            //list<contact> conlist = new list<contact>();
            for(integer i =0; i< Num; i++){
                contact con = new Contact();
                con.LastName = 'This is 555 dd  '+ Acc.Name;
                //add in list// so create list 
                conlist.add(con);
            }
        }
        
        // Null Check
        if(conlist.size() > 0 && conlist!=null)
        {
            insert conlist;
            system.debug(' Test '+ conlist.size());
        }
        
        //Add in collection
        for(contact c : conlist){
            myList.add(c);
            System.debug('List Acc Records 1 >> '+ c);
            
        }
        System.debug('List Acc Records 2 >> '+ conlist);
        return conlist;
    } 
}