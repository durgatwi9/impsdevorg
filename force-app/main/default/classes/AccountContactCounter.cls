public class AccountContactCounter {
    public static void updateAccountContactCount(Set<Id> contactIds) {
        List<Account> accountsToUpdate = new List<Account>();

        for (Contact contact : [SELECT Id, AccountId FROM Contact WHERE Id IN :contactIds]) {
            Account account = new Account(Id = contact.AccountId);
            account.Total_No_Contacts__c = [SELECT COUNT() FROM Contact WHERE AccountId = :account.Id];
            accountsToUpdate.add(account);
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}