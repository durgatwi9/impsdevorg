public class AccTaskApex {
    public  static void createTasks( List<Account> acccc) {
        
        // parameter having value
 // List<Account> newAccounts = new List<Account>(); // empty list
 List<Task> taskList = new List<Task>();
 list<case> c = new list <case>();
        List<Account> newAccounts = [select id, Name from account];
        
        for (Account acc : newAccounts) {
            Task newTask = new Task();
            newTask.Subject = 'New Account'+Acc.Name;
            newTask.WhatId = acc.Id;
            newTask.Description = 'A new Account was created with the name: ' + acc.Name;
            newTask.Status = 'Completed';
            newTask.Priority = 'Normal';
            newTask.OwnerId = acc.OwnerId;

            taskList.add(newTask);
        }

        insert taskList;
        System.debug('Created Task list: ' + taskList);
    }


}