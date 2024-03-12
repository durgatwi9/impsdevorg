public class BatchApexExample implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, LastName FROM Contact';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Contact> conlist) {
        // Get the batch job ID and parent job ID
        system.debug('THE child id:'+bc.getChildJobId());
        system.debug('THE parent id:'+bc.getJobId());
        
        for(Contact con : conlist) {   
            con.FirstName = 'yodha';
            con.LastName = 'srikanth sir';
        }
        update conlist;
    }
    
    public void finish(Database.BatchableContext BC) {
        // Execute any post-processing operations like sending email
    }
}