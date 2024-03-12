public class JsonTestApex {
    
    public List<Contact> getContacts() {
        List<Contact> contacts = new List<Contact>();
        
        // HTTP request to retrieve the JSON data
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('https://raw.githubusercontent.com/srikanthBellamkonda/contactsInfo/master/contactsInfo.json');
        httpRequest.setMethod('GET');
        Http http = new Http();
        HttpResponse httpResponse = http.send(httpRequest);
        
        // Check if the HTTP request was successful
        if (httpResponse.getStatusCode() == 200) {
            String jsonData = httpResponse.getBody();
            
            // Deserialize the JSON data into a map
            Map<String, Object> parsedData = (Map<String, Object>) JSON.deserializeUntyped(jsonData);
            
            if (parsedData.containsKey('contacts')) {
                List<Object> contactsData = (List<Object>) parsedData.get('contacts');
                
                for (Object contactData : contactsData) {
                    Map<String, Object> contactMap = (Map<String, Object>) contactData;
                    Contact contact = new Contact();
                    
                    contact.id = (String) contactMap.get('id');
                    contact.name = (String) contactMap.get('name');
                    contact.email = (String) contactMap.get('email');
                    contact.address = (String) contactMap.get('address');
                    contact.gender = (String) contactMap.get('gender');
                    
                    Map<String, Object> phoneMap = (Map<String, Object>) contactMap.get('phone');
                    if (phoneMap != null) {
                        Phone phone = new Phone();
                        phone.mobile = (String) phoneMap.get('mobile');
                        phone.home = (String) phoneMap.get('home');
                        phone.office = (String) phoneMap.get('office');
                        contact.phone = phone;
                    }
                    
                    contacts.add(contact);
                    
                    // Log the contact information to the debug logs
                    System.debug('Contact ID: ' + contact.id);
                    System.debug('Name: ' + contact.name);
                    System.debug('Email: ' + contact.email);
                    System.debug('Address: ' + contact.address);
                    System.debug('Gender: ' + contact.gender);
                    if (contact.phone != null) {
                        System.debug('Mobile: ' + contact.phone.mobile);
                        System.debug('Home: ' + contact.phone.home);
                        System.debug('Office: ' + contact.phone.office);
                    }
                }
            }
        } else {
            System.debug('Error occurred while retrieving JSON data. Status code: ' + httpResponse.getStatusCode());
        }
        
        return contacts;
    }
    // Define a class to represent the phone details
    public class Phone {
        public String mobile;
        public String home;
        public String office;
    }
    
    // Define a class to represent a contact
    public class Contact {
        public String id;
        public String name;
        public String email;
        public String address;
        public String gender;
        public Phone phone;
    }
}