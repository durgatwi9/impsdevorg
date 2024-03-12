public class MapApexPractice {

    public void Method1(list<contact> conlist, map<id, contact> oldmapconmap){
         string targetname = 'durga';
        //list<contact> conlist = [select id, Lastname from contact];
        list<task> taskfinal = new list<task>();
        for(contact con : conlist ){
            contact oldMapcon = oldmapconmap.get(con.Id);
            if(con.id != null && con.lastname == targetname && oldMapcon.Name != null){
                task ta = new task();
                ta.Priority = 'high';
              //  ta.AccountId = con.AccountId;
                taskfinal.add(ta);
            }
        }
        if(!taskfinal.Isempty()){
            insert taskfinal;
        }
    }
}