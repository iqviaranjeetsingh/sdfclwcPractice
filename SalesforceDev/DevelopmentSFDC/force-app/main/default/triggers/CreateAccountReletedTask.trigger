trigger CreateAccountReletedTask on Account(after insert, after update){
  
   //When we create Task, set whoid, whatid
   //Whoid: we can set only Contact or Lead id
   //Whatid: we can set all sobject id except Contact and Lead id
   
   List<Account> acct = Trigger.New;
   CreateNewTask.CreateACCTask(acct);
   /*
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
   }*/
}