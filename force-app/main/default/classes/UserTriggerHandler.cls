public class UserTriggerHandler {
    
    public void doAfterupdate(List<User> newUsers, Map<Id, User> newMapUsers,List<User> oldUsers, Map<Id, User> oldMapUsers){
        Map<Id, Id> deactivatedUserIdWithRelatedManagerIdMap = new Map<Id, Id>();        
        for(User ur: newUsers){
            //isChanged// 
            if(ur.isActive == false && oldMapUsers.get(ur.id).isActive == true){
                deactivatedUserIdWithRelatedManagerIdMap.put(ur.id, ur.ManagerId);                
            }
        }
        
        doNonSetupOperation(deactivatedUserIdWithRelatedManagerIdMap);
        
        
    }
    
    @future
    public static void doNonSetupOperation( Map<Id, Id> deactivatedUserIdWithRelatedManagerIdMap){
        List<Account> acntToUpdateList = new List<Account>();
        for(Account acnt: [SELECT Id, OwnerId 
                           FROM Account 
                           WHERE OwnerId IN: deactivatedUserIdWithRelatedManagerIdMap.keyset()]){
                               Id deactiveUserIdKey = acnt.ownerId;
                               Id managerIDValue = deactivatedUserIdWithRelatedManagerIdMap.get(deactiveUserIdKey);
                               // replacing existing deactivated user id with his related manager id.
                               acnt.ownerId =  managerIDValue;
                               acntToUpdateList.add(acnt);
                           }
        if(!acntToUpdateList.isEmpty()){
            update acntToUpdateList;
        }
    }
    
    
}