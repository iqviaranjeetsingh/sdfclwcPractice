global class SchedulePracticeCls implements Schedulable{
   public void execute(SchedulableContext sc){
      SchedulePractice refSP = new SchedulePractice();
      refSP.doPrintMessage();
   }
}