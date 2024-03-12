public class UpdateContactsHandler {
    public static void updateContactNamesAndPhoneNumbers(List<Account> newAccounts, Map<Id, Account> oldAccountMap) {
        List<Contact> contactsToUpdate = new List<Contact>();

        Set<Id> accountIdsToUpdate = new Set<Id>();

        // Iterate through new accounts and collect account IDs to update
        for (Account newAccount : newAccounts) {
            Account oldAccount = oldAccountMap.get(newAccount.Id);

            if (newAccount.Name != oldAccount.Name) {
                accountIdsToUpdate.add(newAccount.Id);
            }
        }

        // Query related contacts outside of the loop
        for (Contact con : [SELECT Id, FirstName, LastName, Phone, AccountId FROM Contact WHERE AccountId IN :accountIdsToUpdate]) {
            Account relatedAccount = oldAccountMap.get(con.AccountId);
            con.FirstName = relatedAccount.Name;
            con.Phone = relatedAccount.Phone;  // Assuming Account's Phone field is used for contact's phone

            contactsToUpdate.add(con);
        }

        // Perform updates
        if (!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}