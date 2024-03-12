public class WarmUpPracticeApex {
    
    public void UpdateAccwithcondata() {
        // Query contacts associated with accounts
        List<Contact> conList = [SELECT Id, LastName, AccountId, Phone FROM Contact WHERE AccountId != null];
        
        // Create a map to associate accounts with their contacts
        Map<Id, Contact> conMap = new Map<Id, Contact>();
        for (Contact con : conList) {
            conMap.put(con.AccountId, con);
        }
        
        List<Account> accountsToUpdate = [SELECT Id, Name FROM Account WHERE Id IN :conMap.keyset()];
        
        // Create a map to store updated account records
        Map<Id, Account> updatedAccounts = new Map<Id, Account>();
        
        // Update account records
        for (Account acc : accountsToUpdate) {
            Contact associatedContact = conMap.get(acc.Id);
            if (associatedContact != null) {
                // Update account name and phone based on contact
                acc.Name = associatedContact.LastName + 'Yodha';
                acc.Phone = associatedContact.Phone;
                updatedAccounts.put(acc.Id, acc);
            }
        }
        // Perform updates if there are records to update
        if (!updatedAccounts.isEmpty()) {
            try {
                update updatedAccounts.values();
                System.debug('Updated ' + updatedAccounts.size() + ' accounts.');
            } catch (DmlException e) {
                System.debug('Error updating accounts: ' + e.getMessage());
            }
        }
    }
    
    public void updateTasksWithAccounts(){
        list<account> Acclist = [select id, name, CleanStatus from Account];
        Map<id, Account> AccMap = new Map<id, Account>();
        
        for(Account Acc : Acclist){
            AccMap.put(Acc.id, Acc);
        }
        system.debug('Task Records map'+ AccMap.size());
        list<task> taskList = [SELECT Id, Accountid, CallObject, CallDisposition, Subject FROM Task where Accountid in :AccMap.keyset()]; 
        system.debug('Task Records'+ taskList.size());
        
        list<task> TaskupdateList = new list<task>();
        
        for(task ta : taskList){
            Account Acc = AccMap.get(ta.AccountId);
            
            if(Acc != null){
                ta.CallObject = Acc.CleanStatus;
                ta.CallDisposition = Acc.name+ 'Skala';
                ta.Subject = Acc.name+  'Env';
                TaskupdateList.add(ta);
            }
        }
        
        if(!TaskupdateList.isEmpty()){
            update TaskupdateList;
            system.debug('Updated Records'+ TaskupdateList.size());
        }
    }
    
    //public class CaseStatusUpdateHandler {
    public void caseStatusUpdate(){
        map<id, Account> closedAccounts = new map<id, Account>([SELECT Id, Status__c FROM Account WHERE Status__c = 'Closed']);
        
        if (!closedAccounts.isEmpty()){
            List<Case> caseList = [ SELECT Id, Status, Contact.AccountId
                                   FROM Case
                                   WHERE Contact.AccountId IN :closedAccounts.keySet() ];
            
            list<case> updatedCasestatus = new list<case>();
            
            for (Case c : caseList) {
                Account AccRelated = closedAccounts.get(c.Contact.AccountId);
                if(AccRelated != Null && AccRelated.Status__c == 'Closed'){
                    c.Status = AccRelated.Status__c;
                    updatedCasestatus.add(c);
                }
                if(!updatedCasestatus.isEmpty()){
                    update updatedCasestatus;
                }
            }
        }
    }
    
    //Testing Method change status
    Public void changeStatus(){
        list<case> caselist = [select id, status from case where status = 'Closed'];
        for(case c : caselist){
            c.Status = 'new';
        }
        update caselist;
    }
    
    
    public void updateAccStatus(){
        map<id, case> MapCase = new map <id, case>([select id, status, Contact.AccountId from case where Contact.AccountId != Null ]);
        
        list<account> Acclist = [select id,status__c from account where id in : MapCase.keySet()];
        system.debug('Case with Account records'+ Acclist);
        
        list<Account> updateAcclist = new list<Account>();
        for(account acc : Acclist){
            case cas = MapCase.get(acc.Id);
            if(cas.Status == 'Closed'  && acc.Status__c != 'Closed'){
                acc.Status__c = cas.Status;
                updateAcclist.add(acc);
                
            }
            update updateAcclist;
            system.debug('Case with Account records'+ updateAcclist);
        }
    }
    
    public void updateAccStatusGp() {
        
        // Query Cases related to Contacts and collect related Account Ids
        List<Case> relatedCases = [SELECT Id, Status, Contact.AccountId FROM Case WHERE Contact.AccountId != null AND Status != 'Closed'];
        
        Map<Id, List<Case>> accountIdToCasesMap = new Map<Id, List<Case>>();
        
        for (Case cas : relatedCases) {
            Id accountId = cas.Contact.AccountId;
            
            if (!accountIdToCasesMap.containsKey(accountId)) {
                accountIdToCasesMap.put(accountId, new List<Case>{cas});
            }else{
                accountIdToCasesMap.get(accountId).add(cas);
            }
        }
        
        List<Account> updateAccountList = new List<Account>();
        
        // Check if all related Cases for each Account are 'Closed'
        for (Id accountId : accountIdToCasesMap.keySet()) {
            List<Case> cases = accountIdToCasesMap.get(accountId);
            Boolean allCasesClosed = true;
            
            for (Case cas : cases) {
                if (cas.Status != 'Closed') {
                    allCasesClosed = false;
                    break;
                }
            }
            if (allCasesClosed) {
                Account acc = new Account(Id = accountId, Status__c = 'Closed');
                updateAccountList.add(acc);
            }
        }
        if (!updateAccountList.isEmpty()) {
            update updateAccountList;
            
            System.debug('Updated Account records: ' + updateAccountList.size());
            System.debug('Updated Account records: ' + updateAccountList);
        }
    }

    public void CasesafeIDCon(){
        List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 10]; // Query for the records

        set<id> AcclistId = new set<id>();
        for (Account acc : accounts) {
            String eighteenCharId = acc.Id; // Get the 18-char ID
            String fifteenCharId = eighteenCharId.substring(0, 15); // Convert to 15-char ID
            AcclistId.add(fifteenCharId);
            // Now you can work with the 15-char ID
            System.debug('15-char ID: ' + fifteenCharId);
        }
        {
            List<Id> eighteenCharIdsCon = new List<Id>();

            for (String fifteenCharIdList : AcclistId) {
                Id eighteenCharIdCon = Id.valueOf(fifteenCharIdList); // Convert to 18-character ID
                eighteenCharIdsCon.add(eighteenCharIdCon);

                // Now you can work with the 18-character ID
                System.debug('18-char ID: ' + eighteenCharIdCon);
            }

            System.debug('List of 18-char IDs: ' + eighteenCharIdsCon);
        }
        
    }
}