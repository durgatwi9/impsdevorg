public class CaseInsertionService {
    public static void insertCases() {
        User agentsuryaUser = [SELECT Id FROM User WHERE Username = 'durgaprasad.vukoti6@gmail.com' LIMIT 1];

        System.runAs(new User(Id = agentsuryaUser.Id)) {
            List<Case> casesToInsert = new List<Case>();
            
            for (Integer i = 0; i < 2000; i++) {
                Case newCase = new Case();
                newCase.Subject = 'Case ' + i;
                newCase.Description = 'Description for Case ' + i;
                // Set other fields accordingly
                
                casesToInsert.add(newCase);
            }
            
            insert casesToInsert;
        }
    }
}