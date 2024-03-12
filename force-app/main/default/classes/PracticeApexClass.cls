public  class PracticeApexClass {
    map<id,Map<Id, List<Contact>>> Conmap2 = new map<id,Map<Id, List<Contact>>> ();
    
    Public static void BringAccounts(){
        
        map<id, Account> AccMap = New Map <id, Account>([select id, Name From Account ]);
        map<id, contact> ConMap = New Map <id, contact>([select id, lastName, Accountid from contact where Accountid =: AccMap.keyset() ]);
        
        set<id>  con2 = new  set<id>();
        for(contact con : ConMap.values()){
            con2.add(con.AccountId);
        }
              
        list <account> acclist = new list <account>([select id, Name from Account where name like '%durga123%']);
        system.debug('Acc with name '+ acclist.size() );
        for(account acc : [select id, Name from Account where name like '%durga123%']){
            
            system.debug('Acc with name '+ acc );
        }
        
    }
    public  void TestCall() {
        // Declare and initialize the map
        Map<Id, Map<Id, List<Contact>>> Conmap2 = new Map<Id, Map<Id, List<Contact>>>();
        
        // Create a list of contacts
        List<Contact> contacts = new List<Contact>();
        
        // Create a new contact object and populate its fields
        Contact con1 = new Contact();
        con1.LastName = 'Doe';
        con1.Email = 'john.doe@example.com';
        
        // Add the contact to the list
        contacts.add(con1);
        
        // Create the inner map and add the list of contacts
        Map<Id, List<Contact>> innerMap = new Map<Id, List<Contact>>();
        innerMap.put('5005i00000QZR8AAAX', contacts);
        
        // Add the inner map to the outer map
        Conmap2.put('6005i00000QZR8AAA4', innerMap);
        
        System.debug('Test Data: ' + Conmap2);
        
        
    }
    public  void TestCallmethodnew() {
        map<id, Account> Parmap = new map<id, Account>([SELECT Id, Name, (SELECT Id, Status FROM cases) FROM Account WHERE Id IN (SELECT AccountId FROM case)]);
        
        for (Account accN : ParMap.values()) {
            System.debug('Account record: ' + accN);
            List<Case> relatedCases = accN.Cases; // Retrieve related Cases for the current Account
            System.debug('Related Cases for Account ' + accN.Name + ': ' + relatedCases);
        }        
        
    }
    public  void TestSoql() {
        
        list<account> accounidlist = [select id, name from account];
        map<id,case> caseid = new map<id, case>([select id,Accountid, status from case WHERE Accountid IN:accounidlist]);
        map<id,case> caseid1 = new map<id, case>([select id,Accountid, status from case WHERE Accountid = :accounidlist]);
        system.debug('Sizeof rtecords IN' + caseid.size());
        system.debug('Sizeof rtecords =:' + caseid1.size());
    }
    
    public  void AsyncApexJobApex(){
        String parentJobId = '7075i00004JboUCAAZ'; // Replace with the actual parent job ID you want to check
        
        List<AsyncApexJob> childJobs = [SELECT Id, JobItemsProcessed, Status FROM AsyncApexJob WHERE ParentJobId = :parentJobId];
        
        for (AsyncApexJob childJob : childJobs) {
            String childJobId = childJob.Id;
            Integer jobItemsProcessed = childJob.JobItemsProcessed;
            String status = childJob.Status;
            
            // Now you have information about the child job, including its ID, processed items, and status
            system.debug('Sizeof rtecords =:' + childJobId);
        }
        
    }

    public static void testapexMap(){
        map<id, case> caseMap = new map<id,case>([SELECT CaseNumber,reason, Id FROM Case]);

        for(id casid : caseMap.keyset()){
            
        }
    }
}