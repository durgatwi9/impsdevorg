public class CaseUtilsApex {
    public static void closeRelatedCases() {
        List<Account> updatedAccounts = [select id, name, Status__c from Account];
        Set<Id> accountIdsToProcess = new Set<Id>();
        List<Case> casesToUpdate = new List<Case>();

        // Collect account IDs that need processing
        for (Account updatedAccount : updatedAccounts) {
            if (updatedAccount.Status__c == 'Closed') {
                accountIdsToProcess.add(updatedAccount.Id);
            }
        }

        if (!accountIdsToProcess.isEmpty()) {
            // Query for related cases outside of the loop
            Map<Id, List<Case>> relatedCasesMap = new Map<Id, List<Case>>();
            for (Case relatedCase : [SELECT Id, Status, AccountId FROM Case WHERE AccountId IN :accountIdsToProcess]) {
                if (!relatedCasesMap.containsKey(relatedCase.AccountId)) {
                    relatedCasesMap.put(relatedCase.AccountId, new List<Case>());
                }
                relatedCasesMap.get(relatedCase.AccountId).add(relatedCase);
            }

            // Update related cases directly using the map
            for (List<Case> relatedCases : relatedCasesMap.values()) {
                for (Case relatedCase : relatedCases) {
                    relatedCase.Status = 'Closed';
                    casesToUpdate.add(relatedCase);
                }
            }
        }

        // Update all related cases
        if (!casesToUpdate.isEmpty()) {
            update casesToUpdate;
        }
    }
}