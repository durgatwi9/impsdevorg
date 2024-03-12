public class PracticeTest {
    
    list<Contact> con = [select id, Accountid, lastName  from contact where Accountid != null  limit 6];
    
    public void MapCal(){
        /* Map<id, contact> conmap = new Map<id, contact>();
for(contact cond : con){
conmap.put(cond.Accountid, cond); // add in empty map
}
system.debug('Contact Keys' + conmap.keyset());
system.debug('Contact values' + conmap.values());
*/
        // From map collection get keyset and values itrate each record
        Map<id, contact> ConMapData = new Map<id, contact>([select id, lastname from contact limit 3]);
        
        for(contact cond : con){
            ConMapData.put(cond.accountid, cond); // add in empty map
        }
        system.debug('Contact put Keys' + ConMapData.keyset());
        system.debug('Contact put values' + ConMapData.values());
        
        for ( id keyscon : ConMapData.keySet()){
            contact cond1 = ConMapData.get(keyscon);  //.get(key) print values
            system.debug('Conkeysetvalue'+ cond1);
        }
        
        for ( contact conVlaue : ConMapData.values()){
            system.debug('conVlaue '+ conVlaue);
        }
        
    }
    
    /*
//map saprating keyset will store in set // values store in list
set<id> keydata =   conmap.keyset();
list<contact> valueData = conmap.values();

system.debug('Contact values' + keydata);
system.debug('Contact values' + valueData);

list<contact> con3 = new list<contact>();
for(contact con2 : con ){
con2.lastname ='durga'; 
con3.add(con2);  // add in list empty list
*/
}