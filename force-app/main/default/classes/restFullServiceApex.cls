@RestResource(urlMapping='/samp/Internal/services/*')
global class restFullServiceApex {
    
    global class Wrapper {
        public String AccountName;
        public String Phone;
    }
    
    @HttpGet
    global static Wrapper GetMethod() {
        RestRequest req = RestContext.request; // Input handeling context
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1); //divide as substring
        //https://insta4-dev-ed.develop.my.salesforce.com/samp/Internal/services/[0015i000014pncDAAQ]/*;  // [Input]
        Account result = [select id, name,(select id, lastname from contacts) from Account Where Id = :accountId];
        
        Wrapper wrap = new Wrapper();
        wrap.AccountName = result.Name;
        wrap.Phone = result.Phone;
        
        return wrap;
        
        // Mistakes Retuntype given account insted of wrapper
    }
}