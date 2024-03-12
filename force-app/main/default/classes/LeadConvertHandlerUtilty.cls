public class LeadConvertHandlerUtilty {
    
    public static void doConvert(List<Lead> newLeads) {
        
            List<Id> leadIdsToConvert = new List<Id>();
            for (Lead leadToConvert : newLeads) {
                if (leadToConvert.Id != null) {
                    leadIdsToConvert.add(leadToConvert.Id);
                }
            }
            List<LeadStatus> convertStatusList = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true];
            for (Id leadId : leadIdsToConvert) {
                Database.LeadConvert lc = new Database.LeadConvert();
                lc.setLeadId(leadId);
                lc.setConvertedStatus(convertStatusList[0].MasterLabel);
                
                Database.LeadConvertResult lcr = Database.convertLead(lc);
                
                if (lcr != null) {
                System.debug('Lead converted successfully: ' + lcr.isSuccess());
                System.debug('Lead: ' + lcr.getAccountId() + ' ' + lcr.getContactId());
            } else {
                System.debug('Lead conversion failed.');
            }
            
        }
    }
}