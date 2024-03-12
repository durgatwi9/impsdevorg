public class CaseUpdaterApex {
    public static void updateCaseStatus(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
        
        
        Set<Id> accountIdsToProcess = new Set<Id>();
        Map<Id, List<Case>> accountCasesMap = new Map<Id, List<Case>>();
        Map<Id, Account> newAccountsMap = new Map<Id, Account>(newAccounts);
        List<Case> casesToUpdate = new List<Case>();
        

        // Iterate through new accounts and collect account IDs with status changes
        for (Account newAccount : newAccounts) {
            Account oldAccount = oldAccountMap.get(newAccount.Id); // value

            // Check if the account status has changed
            if (newAccount.Status__c != oldAccount.Status__c) {
                accountIdsToProcess.add(newAccount.Id);
            }
        }

        // Query for related open cases outside of the loop
        if (!accountIdsToProcess.isEmpty()) {
            for (Case relatedCase : [
                SELECT Id, Status, AccountId
                FROM Case
                WHERE AccountId IN :accountIdsToProcess AND IsClosed = false
            ]) {
                if (!accountCasesMap.containsKey(relatedCase.AccountId)) {
                    accountCasesMap.put(relatedCase.AccountId, new List<Case>());
                }
                accountCasesMap.get(relatedCase.AccountId).add(relatedCase);
            }
        }

        // Create a Map<Id, Account> for efficient access
        //Map<Id, Account> newAccountsMap = new Map<Id, Account>(newAccounts);

        // Update case status
        for (List<Case> cases : accountCasesMap.values()) {
            for (Case c : cases) {
                // Directly access the relevant account using the Map
                if (newAccountsMap.containsKey(c.AccountId)) {
                    c.Status = newAccountsMap.get(c.AccountId).Status__c;
                    casesToUpdate.add(c);
                }
            }
        }

        // Perform updates
        if (!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        }
    }
}