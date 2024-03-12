public class ContactUtiltyClass {
    public void customLookup(List<contact> listOfcontacts, Map<Id, Contact> oldMapofContacts){
        set<Id> accountIdset = new set<Id>();
        for(contact con: listOfcontacts){
            if(con.AccountId!= null && oldMapofContacts==null){
                accountIdset.add(con.AccountId);
                
            }else if (con.AccountId!=null && !oldMapofContacts.isEmpty()){
                contact oldcontact = oldMapofContacts.get(con.id);
                if(oldcontact.AccountId!=con.AccountId){
                    accountIdset.add(oldcontact.AccountId);
                    accountIdset.add(con.AccountId);
          }
        }
        }
        List<Account> toUpdateAcntList = new List<Account>();
        for(Account acnt : [Select Id, Total_No_Contacts__c, (select Id from contacts) 
                            From Account where ID IN: accountIdset]){
                                acnt.Total_No_Contacts__c = acnt.contacts.size();
                                toUpdateAcntList.add(acnt);
                            }
        if(!toUpdateAcntList.isEmpty()){
            update toUpdateAcntList;
        }
    }
}