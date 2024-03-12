public class warmUpFinalVersionApex {
    
      //3 tier object: update the "statsus" field on the case
    public void updateCaseStatusBasedOnAccount() {
    // Query for closed Accounts and store them in a map
    Map<Id, Account> closedAccountsMap = new Map<Id, Account>(
        [SELECT Id, Status__c FROM Account WHERE Status__c = 'Closed']
    );

    // Check if there are closed Accounts
    if (!closedAccountsMap.isEmpty()) {
        // Query Cases related to closed Accounts
        List<Case> relatedCasesList = [
            SELECT Id, Status, Contact.AccountId
            FROM Case
            WHERE Contact.AccountId IN :closedAccountsMap.keySet()
        ];

        // Create a list to store Cases to update
        List<Case> casesToUpdate = new List<Case>();

        // Loop through related Cases
        for (Case caseRecord : relatedCasesList) {
            // Get the related Account
            Account relatedAccount = closedAccountsMap.get(caseRecord.Contact.AccountId);
            
            // Check if the Account is closed and update Case Status
            if (relatedAccount != null && relatedAccount.Status__c == 'Closed') {
                caseRecord.Status = relatedAccount.Status__c;
                casesToUpdate.add(caseRecord);
            }
        }

        // Update Cases if there are records to update
        if (!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        }
    }
}


    //3 tier object: update the "Status__c" field on the Account object based on the status of the Cases related to the Account through their Contacts.
    public void updateAccStatusbycase() {
        // Query Cases related to Contacts and collect related Account Ids
        List<Case> relatedCases = [SELECT Id, Status, Contact.AccountId FROM Case WHERE Contact.AccountId != null AND Status != 'Closed'];
        
        Map<Id, List<Case>> accountIdToCasesMap = new Map<Id, List<Case>>();
        
        // Populate the accountIdToCasesMap
        for (Case cas : relatedCases) {
            Id accountId = cas.Contact.AccountId;
            
            if (!accountIdToCasesMap.containsKey(accountId)) {
                accountIdToCasesMap.put(accountId, new List<Case>{cas});
            } else {
                accountIdToCasesMap.get(accountId).add(cas);
            }
        }
        
        List<Account> updateAccountList = new List<Account>();
        
        // Check if all related Cases for each Account are 'Closed'
        for (Id accountIdc : accountIdToCasesMap.keySet()) {
            List<Case> cases = accountIdToCasesMap.get(accountIdc);
            Boolean allCasesClosed = true;
            
            for (Case cas : cases) {
                if (cas.Status != 'Closed') {
                    allCasesClosed = false;
                    break;
                }
            }
            
            if (allCasesClosed) {
                Account acc = new Account(Id = accountIdc, Status__c = 'Closed');
                updateAccountList.add(acc);
            }
        }
        
        // Update the Accounts if needed
        if (!updateAccountList.isEmpty()) {
            update updateAccountList;
            
            System.debug('Updated Account records: ' + updateAccountList.size());
            System.debug('Updated Account records: ' + updateAccountList);
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
}