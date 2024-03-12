@RestResource(urlMapping='/Account/*')
global class MyRestResource {
    
    Global class Wrapper{
        Public string Name;
        Public string Phone;
        List<Wrapper2> conwrap;
    }
    Global class Wrapper2{
        Public string Lastname;
        Public string Phone;
    }
    @HttpGet
    global static Void GetM(){
        RestRequest req =  Restcontext.request;
        RestResponse res =  Restcontext.response; // To return
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);// input passing
        Account Acc = [SELECT Id, Name, Phone,(select id, LastName, Phone from contacts) FROM Account WHERE Id = :accountId];
        
        wrapper wrp = new wrapper();
        wrp.name = Acc.name;
        wrp.phone = Acc.phone;
        
        List<contact> conlist = Acc.contacts;
        List<Wrapper2> Updateconwrp = new List<Wrapper2>();
        
        for(contact con :  conlist){
            Wrapper2 Wrp2 = new Wrapper2();
            Wrp2.phone = con.phone;
            Wrp2.Lastname = con.Lastname;
            Updateconwrp.add(Wrp2);
        }
        
        Wrp.conwrap = Updateconwrp;
        //Return wrp; Response Method for void 
        //// ResponseBody Method show in Json, understand - Blob
        // Blob understand string
        //Json.seialize convert apex to string
        res.statuscode  = 200;
        string body = json.serializePretty(wrp);  // Wrp(abex object data) convert in to string 
        res.responseBody  = Blob.valueof(body); 
        
    }
    
    @HttpPost
    global static Void doPost() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        string  body = req.requestbody.tostring(); // to print .tostring(); // 
        // JSON.deserialize(Body, Related.class) - format// typecast "objData"
        ResponseResult ObjData = (ResponseResult)JSON.deserialize(Body, ResponseResult.class);             
        
        contact con = new contact();
        con.lastName = ObjData.LastName;
        con.Phone = ObjData.Phone;
        try{
            Insert con;
            res.statuscode  = 200;
            res.responseBody  = Blob.valueof ('Contact id : '+ con.id);  // ResponseBody
        }catch(exception ex){
            res.statuscode  = 400;
            res.responseBody  = Blob.valueof ('Failed : '+ Ex.getMessage()); 
        }
    }
    Global class ResponseResult{ // wrapper
        Public string Phone;
        Public string Lastname;
    }
}