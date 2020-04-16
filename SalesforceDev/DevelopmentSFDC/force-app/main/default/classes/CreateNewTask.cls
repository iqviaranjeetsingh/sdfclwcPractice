Public class CreateNewTask{

   public static void CreateACCTask(List<Account> acct){
       List<Task> tempTask = new List<Task>();
       for(Account ac:acct){
          Task t = new Task();
          t.Subject = 'Follow this Account';
          t.Whatid = ac.id;
          t.Status = 'in Progress';
          t.Priority = 'High';
          t.ActivityDate = Date.today()+7;
          t.Description = 'Created new task through trigger.';
          tempTask.add(t);
       }
       
       if(tempTask.size()>0){
          insert tempTask;
       }
   }
}