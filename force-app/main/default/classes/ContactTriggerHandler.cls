public class ContactTriggerHandler {
    ContactTriggerHandlerUtility utility = new ContactTriggerHandlerUtility();

    public void doAfterInsert(List<Contact> newList, Map<Id, Contact> newMap){
        utility.CountOfContacts(newList, null);
       // utility.AccountToContactData(newList, null);
    }
    
    public void doAfterUpdate(List<Contact> newList, Map<Id, Contact> newMap, List<Contact> oldList, Map<Id, Contact> oldMap){
        utility.CountOfContacts(newList, oldMap);
      // utility.AccountToContactData(newList, oldMap);
    }
    
    public void doAfterDelete(List<Contact> oldList, Map<Id, Contact> oldMap){
        utility.CountOfContacts(oldList, null);
    }
    
    public void doAfterUnDelete(List<Contact> newList, Map<Id, Contact> newMap){
        utility.CountOfContacts(newList, null);
    }
}