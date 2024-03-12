public class HttpCalloutSample {
    // Call with Method
    public JSON2Apex objData;
    
    //Part 1: Get JSON Data
    public HttpCalloutSample(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://raw.githubusercontent.com/Bellamko/srikanthbellamkonda/main/Jsoncontacts');
        req.setMethod('GET');
        
        HttpResponse res = http.send(req);
        String jsonBody = res.getBody();
         System.debug('Get Contacts Data 3: ' + jsonBody);
        objData = (JSON2Apex)JSON.deserialize(jsonBody, JSON2Apex.class);
        System.debug('Get Contacts Data: ' + objData);
        System.debug('Get Contacts Data: ' + objData.contacts.size());
    }
    //Part 3: DML Operation
    public void doDMLgitContacts() {
        List<GitHubContact__c> gitHubContacts = new List<GitHubContact__c>();
        for (contacts con : objData.contacts) {
            GitHubContact__c gitHubContact = new GitHubContact__c();
            gitHubContact.Name = con.name;
            gitHubContact.Id__c = con.id;
            gitHubContact.Address__c = con.address;
            gitHubContact.Gender__c = con.gender;
            gitHubContact.Mobile__c = con.phone.mobile;
            gitHubContact.Office__c = con.phone.office;
            gitHubContact.Home__c = con.phone.home;
            gitHubContacts.add(gitHubContact);
        }
        if (!gitHubContacts.isEmpty()) {
            Insert gitHubContacts;
            System.debug('Inserted records: ' + gitHubContacts.size());
        }
    }
//Part 2: Wrapper 
public class JSON2Apex {
    public List<contacts> contacts {get; set;}
}

public class contacts {
    public String id {get; set;}
    public String name {get; set;}
    public String address {get; set;}
    public String gender {get; set;}
    public Phone phone {get; set;}
}

public class Phone {
    public String mobile {get; set;}
    public String office {get; set;}
    public String home {get; set;}
}
}