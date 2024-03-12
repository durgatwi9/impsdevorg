public class LeadConvertHandler {
    public static void handleTrigger(List<Lead> newLeads, Map<Id, Lead> oldLeadMap) {
        List<Lead> leadIdsToConvert = new List<Lead>();
        
        for (Lead lead : newLeads) {
            if (lead.Lead_Convert__c == true && !oldLeadMap.get(lead.Id).Lead_Convert__c) {
                leadIdsToConvert.add(lead);
            }
        }

        if (!leadIdsToConvert.isEmpty()) {
           LeadConvertHandlerUtilty.doConvert(leadIdsToConvert);
        }
    }

}