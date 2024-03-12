@RestResource(urlMapping='/Account/Durga/*')  //is integaration class rest service provider
global  class AccwithconRest { // gloabl means outside system also can connect
    
    //one to many
    Global class Wrapper {  // warpper class for security and data maniplating
        Public string Name {get;set;}  // Account warpper variable declaration
        Public string Phone {get;set;} 
        public string Email {get;set;}
        List<ConWrapper> Conwrplist {get;set;}  // Mulitple contacts Wrapper Holding // class define as collection 
    }
    Global class ConWrapper{
        Public string lastname {get;set;}  // contact Warpper variable declartion
        Public string Phone {get;set;}
        public string Email {get;set;}
    }

    // section 1 _single record 
    @HttpGet
    global static Wrapper doGet() {
        RestRequest req = RestContext.request; // [Input handeling]
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1); // Substring what we are pasing
        //https://insta4-dev-ed.develop.my.salesforce.com/services/apexrest/Account/Durga/0015i00000wGBKhAAO
        Account Acc = [select id,name,phone, (select id, Lastname,phone from contacts) from Account WHERE Id = :accountId]; // [input Accountid]
        
        //Single record handling 
        //Account in id set in to the wrapper and return wrapper class.
        Wrapper wrp = new Wrapper();  // Warapper class instantiation 
        wrp.Name = Acc.Name;    // assign data to Wrpper
        wrp.Phone = Acc.Phone;
        
        // Section 2 _ Multiple record handling
        // Acc.contacts set in the conwraplist
        List<contact> Conlist = Acc.contacts; // Contatct data in List
        list<ConWrapper> conWrpListupdate = new list<ConWrapper>();  // Empty list with contact Warpper class

        for(contact con : Conlist){    //List of contacts passing for each loop
            ConWrapper cwrap = new ConWrapper();   // Contact Warpper instantiation 
            cwrap.Lastname = con.lastname;// Assgin data in to wtrapper class
            cwrap.phone = con.Phone;
            conWrpListupdate.add(cwrap);  // add data wrapper empty list 
        }
        // Assigning 
        wrp.Conwrplist  = conWrpListupdate; // Assign contactswrapper in to Wrapper class
        return wrp;  // finally return wrapper class
    }
}