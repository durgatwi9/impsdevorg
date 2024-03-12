public class ContactStructureData {
    
    public void readAndStoreContacts() {
        String jsonUrl = 'https://raw.githubusercontent.com/srikanthBellamkonda/contactsInfo/master/contactsInfo.json';
        
        // Create an HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(jsonUrl);
        request.setMethod('GET');
        
        // Send the HTTP request
        HttpResponse response = new Http().send(request);
        
        // Check if the request was successful
        if (response.getStatusCode() == 200) {
            String jsonString = response.getBody();
            
            // Deserialize JSON into untyped object
            Object untypedData = JSON.deserializeUntyped(jsonString);
            
            // Process each contact
            if (untypedData instanceof Map<String, Object>) {
                Map<String, Object> dataMap = (Map<String, Object>) untypedData;
                List<Object> contactList = (List<Object>) dataMap.get('contacts');
                List<Contact> contactsListFinal = new List<Contact>();
                
                // Collect existing contact emails for duplicate check
                Set<String> existingEmails = new Set<String>();
                for (Contact existingContact : [SELECT Email FROM Contact]) {
                    existingEmails.add(existingContact.Email);
                }
                
                for (Object contactObj : contactList) {
                    Map<String, Object> contactMap = (Map<String, Object>) contactObj;
                    
                    // Access the fields from the contactMap
                    String contactId = (String) contactMap.get('id');
                    String contactFirstName = (String) contactMap.get('name');
                    String contactLastName = (String) contactMap.get('lastName');
                    String contactEmail = (String) contactMap.get('email');
                    
                    // Check for duplicate email
                    if (!existingEmails.contains(contactEmail)) {
                        // Create a new Contact record
                        Contact newContact = new Contact(
                           // Custom_Id_Field__c = contactId,
                            FirstName = contactFirstName,
                            LastName = contactLastName,
                            Email = contactEmail
                        );
                        
                        // Add the new Contact to the list
                        contactsListFinal.add(newContact);
                    }
                }
                
                // Insert the Contact records into Salesforce
                insert contactsListFinal;
            }
        }
    }
}