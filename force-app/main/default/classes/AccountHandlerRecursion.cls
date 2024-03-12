public class AccountHandlerRecursion {
    private static Boolean isExecuting = false; // Static variable to prevent recursion
    //public id  CurLoginid =  userinfo.getuserid();

    public static void updateContactCount(Set<Id> accountIds, Map<Id, Account> oldAccountMap) {
        if (!isExecuting) {
            isExecuting = true;
            List<Account> accountsToUpdate = new List<Account>();

            for (Id accountId : accountIds) {
                Account acc = new Account(Id = accountId);
                acc.Total_No_Contacts__c = [SELECT Count() FROM Contact WHERE AccountId = :accountId];
                accountsToUpdate.add(acc);
            }
            if (!accountsToUpdate.isEmpty()) {
                update accountsToUpdate;
            }
            isExecuting = false; // Reset the static variable
        }
    }
}