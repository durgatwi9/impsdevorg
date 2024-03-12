@isTest  
private class LeadTriggerTest {  

    static testMethod void testLeadConv() {  
		   Test.startTest();

		Lead objLead = new Lead( FirstName = 'Test', LastName = 'Sample', Company = 'Testing Sample Co', Lead_Convert__c = true );  
		insert objLead;  
		  
		Database.LeadConvert lc = new database.LeadConvert();  
		lc.setLeadId( objLead.Id );  
		lc.setDoNotCreateOpportunity( true );  
		lc.setConvertedStatus( 'Closed – Converted' );  
		  
		Database.LeadConvertResult lcr = Database.convertLead(lc, false);  
		  
		system.debug( 'Errors are ' + lcr.getErrors() );  
		  
        Test.stopTest();
	}  
  
}