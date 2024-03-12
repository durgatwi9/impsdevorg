//this class will make outbound callout
//You have write this code on Org2-- 
//For Poc i used Priyanka ORG
//Ref: https://manisha-rice123.medium.com/setting-up-named-credentials-in-salesforce-18b74a3e1509
public class connectOrgOnHttpCallout {
    
    //Part 1
    public string Org_URL = 'https://insta4-dev-ed.develop.my.salesforce.com/services/oauth2/token';
    public string REST_APX_CLS_URL = 'https://insta4-dev-ed.develop.my.salesforce.com/services/apexrest/Account/0015i00000wGBKhAAO';
    public string consumerKey = '3MVG9wt4IL4O5wvIxRhlQN0DuQ2l9OM9RxDNeOG_UlriAaA9.UsfOH0lFZRvszcG8dFF.FMYZsfbbHYknuTwV';
    public string secretKey = '7D10A65C9E38B9D54D645C1C874FE42D56F8E4E0AD71198BB6597C63556426C0';
    public string userName = 'durga.twi9@test.com';
    public string password = 'Sanju@345';
    
    //Part 4- Callout // Authorization Callout - Pick Data
    public  connectOrgOnHttpCallout(){
        //doConnectGETaccessToken();  // after part3 Check once data geeting call by annonmus window.
        string accessToken = doConnectGETaccessToken();
        //data 
        Http hp = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(REST_APX_CLS_URL);
        req.setHeader('Authorization', 'Bearer ' + accessToken);
        req.setHeader('Content-Type', 'application/json');        
        HttpResponse resp = hp.send(req);
        String jsonResp = resp.getBody();   
            System.debug('JSON RESP: '+jsonResp);
        
    }
    
    // Part 5// Add DML opertion Code
    
    
    // Part2 Authentication Callout // Hand Shake
    Public string doConnectgetAccessToken(){
        Http hp = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Org_URL);
        
        req.setMethod('POST');
        string oAuthbody = 'grant_type=password&client_id='+consumerKey+
            '&client_secret='+secretKey+
            '&username='+userName+
            '&password='+password;
        
        req.setbody(oAuthbody);
        HttpResponse res = hp.send(req);
        System.debug('responce ' + res);
        string jsonResp = res.getbody();
        System.debug('Jsonresp responce ' + jsonResp); // json.deserialize wrapper class prepare
        jsonWrapper objData = (jsonWrapper)json.deserialize(jsonResp, jsonWrapper.class);
        //jsonWrapper jsonObj = (jsonWrapper)JSON.deserialized(jsonResp, jsonWrapper.class);
        system.debug('Access token' +  objData);
        return objData.access_token;
    }
    
    //Part 3  // json.deserialize
    public class jsonWrapper {
        
        public String access_token;
        public String instance_url;
        public String id;
        public String token_type;
        public String issued_at;
        public String signature;
        
    }
    
}