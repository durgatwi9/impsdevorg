@RestResource(urlMapping='/SamRestserviceProvider/*')
global class sampRestApex {
    
    // @httpGet
    global static string Getmethod(){
        return 'sanju';
    }
    
    @HttpGet
    global static Account doGet() {
        Account result = [SELECT Id, Name, Phone, Website FROM Account limit 1];
        return result;
    }
    
    
}