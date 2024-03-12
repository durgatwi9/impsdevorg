public class AccountUtils {
    public static void updateAccountNames(List<Account> accounts) {
        for (Account acc : accounts) {
            acc.Name = 'Updated Name - ' + acc.Name;
        }
        update accounts;
    }
    
    public static List<Account> getAccountsByType(String accountType) {
        return [SELECT Id, Name, Type FROM Account WHERE Type = :accountType];
    }
    
    public static void deleteAccounts(List<Account> accounts) {
        delete accounts;
    }
}