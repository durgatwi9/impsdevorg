global class newBatchApexExample implements Database.Batchable<sObject> {
    private Integer chunkNumber;

    global newBatchApexExample() {
        chunkNumber = 1;
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id, LastName FROM Contact';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Contact> accList) {
        System.debug('Processing Chunk ' + chunkNumber);
        
        // Process each batch of records
        for (Contact acc : accList) {
            // Update the Account Name 
            acc.LastName = acc.LastName + 'sfdcpoint1';
        }

        try {
            // Update the Contact Records
            update accList;
        } catch (Exception e) {
            System.debug(e);
        }

        // Log information about the chunk
        System.debug('Chunk ' + chunkNumber + ' processed successfully.');

        chunkNumber++;
    }

    global void finish(Database.BatchableContext BC) {
        // Execute any post-processing operations like sending email
    }
}