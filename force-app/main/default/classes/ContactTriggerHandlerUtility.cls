public class ContactTriggerHandlerUtility {
    public void CountOfContacts(List<Contact> newList, Map<Id, Contact> oldMap) {
        Set<Id> accIds = new Set<Id>();
        
        for (Contact con : newList) {
            if (con.accountid != null && oldMap == null) {
                accIds.add(con.AccountId);
            } else if (con.accountid != null && !oldMap.isEmpty()) {
                contact oldcon = oldMap.get(con.id);
                if (oldcon.accountid != con.AccountId) {
                    accIds.add(oldcon.Accountid);
                    accIds.add(con.AccountId);
                }
            }
        }

        // Move the query outside the loop
        Map<Id, Integer> accountContactCountMap = new Map<Id, Integer>();
        for (AggregateResult age : [
            SELECT AccountId, COUNT(Id) cnt FROM Contact WHERE AccountId IN :accIds GROUP BY AccountId
        ]) {
            accountContactCountMap.put((Id) age.get('AccountId'), (Integer) age.get('cnt'));
        }

        List<Account> toUpdateAcntList = new List<Account>();
        for (Account acnt : [SELECT Id FROM Account WHERE Id IN :accIds]) {
            if (accountContactCountMap.containsKey(acnt.Id)) {
                acnt.Total_No_Contacts__c = accountContactCountMap.get(acnt.Id); //value
                toUpdateAcntList.add(acnt);
            }
        }

        if (!toUpdateAcntList.isEmpty()) {
            try {
                update toUpdateAcntList;
            } catch (Exception e) {
                // Handle the exception (e.g., log it or notify an admin)
                System.debug('Exception during Account update: ' + e.getMessage());
            }
        }
    }
}