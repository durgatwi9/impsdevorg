public with sharing class LocationDataController {
    @AuraEnabled
    public static List<Map<String, Object>> getLocationData(String location) {
        List<Map<String, Object>> locationDataList = new List<Map<String, Object>>();
        
        // Make HTTP callout to the JSON URL
        //String url = 'https://www.meteosource.com/api/v1/free/find_places?text=' + location + '&key=ap2qe0d8zw818p87o6luehn4lz7gau9g0h7ck98s';
        String baseUrl = 'https://www.meteosource.com/api/v1/free/find_places?';
        String key = 'key=ap2qe0d8zw818p87o6luehn4lz7gau9g0h7ck98s';
        String url = baseUrl + 'text=' + EncodingUtil.urlEncode(location, 'UTF-8') + '&' + key;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        // Parse JSON response
        if (response.getStatusCode() == 200) {
            String jsonBody = response.getBody();
            List<Object> parsedData = (List<Object>) JSON.deserializeUntyped(jsonBody);
            
            // Iterate over the parsed data and extract required fields dynamically
            for (Object obj : parsedData) {
                Map<String, Object> locationData = new Map<String, Object>();
                Map<String, Object> parsedObj = (Map<String, Object>) obj;
                locationData.put('name', parsedObj.get('name'));
                locationData.put('place_id', parsedObj.get('place_id'));
                locationData.put('adm_area1', parsedObj.get('adm_area1'));
                locationData.put('adm_area2', parsedObj.get('adm_area2'));
                locationData.put('country', parsedObj.get('country'));
                locationData.put('lat', parsedObj.get('lat'));
                locationData.put('lon', parsedObj.get('lon'));
                locationData.put('timezone', parsedObj.get('timezone'));
                locationData.put('type', parsedObj.get('type'));
                locationDataList.add(locationData);
            }
        }
        
        return locationDataList;
    }
}