public class InterViewUsecase {
    
    public void OpportunityLead(list <Opportunity> opplist , map<id,Opportunity> oldMap ){
        
        //list <Opportunity> opplist = [select id, name from Opportunity];
        list<Lead> leList = new list<Lead> ();
        for(Opportunity oppnew : opplist){
            Opportunity oldmaps  = oldMap.get(oppnew.id);
            if(oppnew.StageName == 'closedown' && (oldmaps == Null || oldmaps.stageName !='closedown')){
                  lead le = new lead();
                  le.Company = oppnew.NextStep;
                   leList.add(le);
            }          
           
        }
        if(!leList.isempty()){
            insert leList;
        }
         
        
    }
}