public class BestPracticeApexClass {
    
    // Account data to trnasfer 
    public void AcctoCase(){
        Map<id, Account> AccDatamap = New  Map<id, Account>();
        for(Account Acc : [select id, Name from Account]){
            AccDatamap.put(Acc.id, Acc);
        }
        
        List<case> caseList= [select id,SuppliedName, ContactPhone, Accountid from case where Accountid In : AccDatamap.keyset()];
        list <case> updateCaseList = new list <case>();
        for(case ca : caseList){
            Account Acc =  AccDatamap.get(ca.Accountid);
            if(Acc != Null){
                ca.SuppliedName = Acc.Name;
                ca.SuppliedPhone = Acc.Phone;
                ca.Subject = Acc.AccountSource;
                updateCaseList.add(ca);
            }
            if(!updateCaseList.isEmpty()){
                update updateCaseList;
            }
        }
    }
}