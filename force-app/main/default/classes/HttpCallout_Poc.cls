public class HttpCallout_Poc {
    // Service Consuming
    public List<WrapperJson> objDataList;
    
    //Part 1 Caallout
    public HttpCallout_Poc () {
        // Instantiate a new Http object
        Http h = new Http();
        // Instantiate a new HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://www.meteosource.com/api/v1/free/find_places?text=hyderabad&key=ap2qe0d8zw818p87o6luehn4lz7gau9g0h7ck98s');
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        String jsonBody = res.getBody();
        System.debug('Json data check: ' + jsonBody); // warapper class for deserlize.
        // Deserializing JSON array into a list of WrapperJson objects // Start with array [] , so used list to store
        objDataList = (List<WrapperJson>)JSON.deserialize(jsonBody, List<WrapperJson>.class);
        // Debugging the deserialized data
        System.debug('Deserialized JSON Data: ' + objDataList);
    }
    //Part 3: DML Operation
    public void doDMLgitContacts() {
        List<POC_Object__c> UpdateObjIN = new List<POC_Object__c>();
        for (WrapperJson Obj : objDataList) {
            POC_Object__c Poc = new POC_Object__c();
            Poc.Name = Obj.name;
            Poc.Place__c = Obj.place_id;
            Poc.adm_area1__c = Obj.adm_area1;
            Poc.adm_area2__c = Obj.adm_area2;
            Poc.country__c = Obj.country;
            Poc.lat__c = Obj.lat;
            Poc.lon__c = Obj.lon;
            Poc.timezone__c = Obj.timezone;
            Poc.type__c = Obj.type;
            
            UpdateObjIN.add(Poc);
        }
        if (!UpdateObjIN.isEmpty()) {
            Insert UpdateObjIN;
            System.debug('Inserted records: ' + UpdateObjIN.size());
        }
    }
    //Part 2
    public class WrapperJson {
        public String name;
        public String place_id;
        public String adm_area1;
        public String adm_area2;
        public String country;
        public String lat;
        public String lon;
        public String timezone;
        public String type;
    }
}