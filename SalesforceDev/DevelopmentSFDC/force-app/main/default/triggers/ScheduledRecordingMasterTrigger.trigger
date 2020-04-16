trigger ScheduledRecordingMasterTrigger on Recording__c(after insert, after update, after delete) {
   
  XLCScheduledRecTriggerHandler.DeleteCompletedSchduledRec();
   /*
   if(trigger.isAfter && Trigger.isInsert){
      XLCScheduledRecTriggerHandler.DeleteCompletedSchduledRec();	
   }
   
   if(trigger.isAfter && Trigger.isUpdate){
      XLCScheduledRecTriggerHandler.DeleteCompletedSchduledRec();	
   }
   
   if(trigger.isAfter && trigger.isDelete){
      XLCScheduledRecTriggerHandler.DeleteCompletedSchduledRec();   	
   }
   
   */
}