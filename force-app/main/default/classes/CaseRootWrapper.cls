public class CaseRootWrapper extends CaseWrapper {
    
    list<CaseWrapper1> WrapList = new List<CaseWrapper1>();
    
    list<case> casList = new list <case>();
    public void Datalist(){
        for(CaseWrapper1 Csw : WrapList ){
            case cas = new case();
            cas.SuppliedEmail = Csw.email;
            cas.Subject = csw.Name;
            cas.SuppliedPhone = csw.phone.mobile;
            cas.SuppliedCompany = csw.Address.country;
            casList.add(cas);
            
        }
        insert casList;
        
    }
    //Test Data
    
}