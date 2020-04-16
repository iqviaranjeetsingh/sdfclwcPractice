//To Learn Schedule functionalities
public Class SchedulePractice{

  public void doPrintMessage(){
     System.debug('@@@@Method invoked by Scheduler.');
     Account acct = new Account();
     acct.Name = 'Scheduler'+System.today();
     insert acct;
  }
   
}