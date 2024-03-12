public class Aura_ContactInsert_LC {
      
    public class wrapper{
        @auraEnabled
        public string recordid;
          @auraEnabled
        public boolean isSuccess ;
    }
    
    @AuraEnabled
    public static wrapper InsertCon(Contact conObj) {
        //  wrapper for muliple values to return
        //string recordid = null;
        Wrapper wrp = new Wrapper();
        try {
            insert conObj;
            wrp.recordid = conObj.Id;
            wrp.isSuccess = True;
            return wrp;
        } catch(Exception e) {
            wrp.recordid = null;
            wrp.isSuccess = False;
            System.debug('Error inserting contact: ' + e.getMessage());
            return wrp;
        }
    }
}