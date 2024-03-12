public class CaseStatusUpdateHandler {
    
    public void CaseStatusUpdate(List<Case> updatedCases, Map<Id, Case> oldCasesMap) {
        Map<Id, Account> accountsToUpdate = new Map<Id, Account>();
        
        for (Case updatedCase : updatedCases) {
            Case oldCase = oldCasesMap.get(updatedCase.Id);
            
            // Check if the Case status has changed to 'Closed' and the old status was 'Open'
            if (updatedCase.Status == 'Closed' && oldCase.Status != 'Closed') {
                Id accountId = updatedCase.Contact.AccountId;
                
                if (!accountsToUpdate.containsKey(accountId)) {
                    // Create an Account with the correct ID and set the Status__c field
                    Account updatedAccount = new Account(Id = accountId, Status__c = 'Closed');
                    accountsToUpdate.put(accountId, updatedAccount);
                } else {
                    // If the Account is already in the map, update its Status__c field
                    accountsToUpdate.get(accountId).Status__c = 'Closed';
                }
            }
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate.values();
            System.debug('Updated Account Records: ' + accountsToUpdate.size());
        }
    }
}