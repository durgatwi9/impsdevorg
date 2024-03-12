public class auraGetContacts {
    @AuraEnabled
    public static List<Contact> Getcontacts(String Accid) {
        List<Contact> conList = [SELECT Id, AccountId, LastName, Phone FROM Contact WHERE AccountId = :Accid];
        System.debug('Contact Number: ' + conList.size());
        return conList;
    }
}