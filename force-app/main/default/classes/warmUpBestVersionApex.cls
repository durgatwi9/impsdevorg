public class warmUpBestVersionApex {
    
    public class AccountWithContacts {
        public Account account { get; set; }
        public List<Contact> contacts { get; set; }
    }
    public void P2CMethodMJointQuery() {
        // Query the Accounts along with their related Contacts using a subquery
        List<AccountWithContacts> accountsWithContacts = new List<AccountWithContacts>();
        
        for (Account acc : [SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts) FROM Account WHERE Id IN (SELECT AccountId FROM Contact)]) {
            AccountWithContacts awc = new AccountWithContacts();
            awc.account = acc;
            awc.contacts = acc.Contacts;
            accountsWithContacts.add(awc);
        }
        
        // Debug the list of AccountWithContacts
        System.debug('accountsWithContacts: ' + accountsWithContacts.size());
        for (warmUpBestVersionApex.AccountWithContacts acccon : accountsWithContacts) {
            System.debug('accountsWithContacts: ' + acccon);
          
        }
          
    }
    
    public  void c2pMethod(){
        List <case>  caseBag= [SELECT Id, AccountId, Status, Type FROM Case where AccountId != Null];
        set<id> CaseSet = New set<id>();
        For(case c : caseBag){
            CaseSet.add(c.AccountId);
        }
        system.debug('Case Records '+ CaseSet.size());
        
        list<Account> Acc = [select id, Name, phone from account where id =: CaseSet]; //Dynamic Value = always coll name
        system.debug('Case Records '+ Acc.size());
        for(account A : Acc){
            System.debug('Test >>'+ A);
        }
    }

   public void TestBestRetunMethod() {
    // Create a set to store Account Ids
    Set<Id> Accid = new Set<Id>();
    for (Account Acc : [SELECT Id, Name, phone FROM Account]) {
        Accid.add(Acc.Id);
    }
    // Query Contact records using AccountId
    List<Contact> ConData = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId IN :Accid];

    // Update Contact records based on related Account data
    for (Contact con : ConData) {
        for (Account Acc : [SELECT Id, Name, phone FROM Account]) {
            if (con.AccountId == Acc.Id) {
                con.phone = Acc.phone;
                con.LastName = Acc.Name;
                break; // Break the loop once a matching Account is found
            }
        }
    }

    // Update Contact records in the database
    update ConData;

    // Debugging
    System.debug('Total Contacts Updated: ' + ConData.size());
 }
    
    public void ContactDataUpdateinAccount(){
        
    }
   
	public void UpdateContactsWithAccountData() {
    // Retrieve all necessary account fields (Id and phone) in a single query
    List<Account> accountList = [SELECT Id, Name, Phone FROM Account];

    // Create a map to store Account Ids and related Account data
    Map<Id, Account> accountMap = new Map<Id, Account>();
    for (Account acc : accountList) {
        accountMap.put(acc.Id, acc);
    }

    // Retrieve contact records with necessary fields (Id, LastName, AccountId)
    List<Contact> contactsToUpdate = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId IN :accountMap.keySet()];

    // Update Contact records based on related Account data
    for (Contact con : contactsToUpdate) {
        Account relatedAccount = accountMap.get(con.AccountId);
        if (relatedAccount != null) {
            con.Phone = relatedAccount.Phone;
            con.LastName = relatedAccount.Name;
        }
    }

    // Update Contact records in the database
    if (contactsToUpdate != Null && !contactsToUpdate.isEmpty()) {
        update contactsToUpdate;
    }

    // Debugging
    System.debug('Total Contacts Updated: ' + contactsToUpdate.size());
}

    public void obj3GetUserMethod() {
    // Query contacts associated with accounts, including account owner information
    List<Contact> contactsList = [SELECT Id, LastName, AccountId, Account.Name, Account.OwnerId, Account_Owner__c FROM Contact WHERE AccountId != null];

    // Create a set to store unique owner Ids
    map<id, contact> conMap = new map<id, contact>();
    for (Contact con : contactsList) {
        conMap.put(con.Account.OwnerId, con);
    }

    // Query users based on owner Ids
    Map<Id, User> ownersMap = new Map<Id, User>([SELECT Id, Name FROM User WHERE Id IN :conMap.keySet()]);

    // Create a list to store contacts that need to be updated
    List<Contact> contactsToUpdate = new List<Contact>();

    // Update the "Account_Owner__c" field in the Contact records
    for (Contact con : contactsList) {
        User owner = ownersMap.get(con.Account.OwnerId);
        if (owner != null) { // Check if owner is found
            con.Account_Owner__c = owner.Name;
            contactsToUpdate.add(con);
        }
    }

    // Update the Contact records with the new "Account_Owner__c" values
    if (!contactsToUpdate.isEmpty()) {
        update contactsToUpdate;
    }
}
    

}