public with sharing class XLCScheduledRecTriggerHandler{
   
   public static void DeleteCompletedSchduledRec(){
      
      if(!XLCUtilities.islogicExecutionCompleted){
	      try{
		      List<Recording__c> recordingTodel = new List<Recording__c>();

		      //To formate Date time that exclude the minutes and Second from Time
		      DateTime pastOneHoursDateTime = XLCUtilities.DateTimeFormatting(System.now().addHours(-1));
		      
		      //To Retrieve all Past Scheduled Recording records which related braodcast's Start Date Time is one hour past.
		      for(Recording__c recDevice:[SELECT id, Name, Broadcast__r.Start_Time__c FROM Recording__c WHERE Broadcast__r.Start_Time__c <: pastOneHoursDateTime Limit:(Limits.getLimitQueryRows() - Limits.getQueryRows())]){
		         recordingTodel.add(recDevice);
		      }
		      
		      if(recordingTodel.size() > 0){
		      	delete recordingTodel;
		      }
		      
		  }catch(Exception ex){
	      	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,XLCUtilities.EXCEPTION_MSG+ex.getMessage()));
	      }
	      XLCUtilities.islogicExecutionCompleted = true;
	  }
   }
   
   public static void UpdateConflictSR(list<Recording__c> scheduledRecordings){
   	      
   	      //Iterate over list of recording record to get related broadcast id and 
		      set<id> recordingDeviceId = new set<id>();
		      for(Recording__c recording:scheduledRecordings){
		         recordingDeviceId.add(recording.Recording_Device__c);	
		      }
   	      //Retreive all Scheduled Recording records which realted to Recording Device and Validate, there are any conflict in Scheduled Recording
		      list<Recording__c> scheduledRecToUpdate = new list<Recording__c>();
		      map<DateTime,Recording__c> scheduledRecording = new map<DateTime,Recording__c>();
		      for(Recording_Device__c rd:[Select Id, Name, (Select Id, Broadcast__r.Start_Time__c, Conflict_Warning__c From Scheduled_Recordings__r) From Recording_Device__c WHERE id=:recordingDeviceId]){
		         for(Recording__c SR:rd.Scheduled_Recordings__r){
		         	DateTime tempDT = XLCUtilities.DateTimeFormatting(sr.Broadcast__r.Start_Time__c);
		            if(scheduledRecording.containsKey(tempDT)){
		               Recording__c recordingDevice = scheduledRecording.get(tempDT);
		               if(!recordingDevice.Conflict_Warning__c){
		                  recordingDevice.Conflict_Warning__c = true;
		                  scheduledRecToUpdate.add(recordingDevice);
		               }
		               SR.Conflict_Warning__c = true;
		               scheduledRecToUpdate.add(sr);
		            } else{
		               scheduledRecording.put(tempDT, SR);
		            }
		            System.debug('@@@@@@Recording Device:'+SR);	
		            System.debug('@@@@@@Recording Device:'+sr.Broadcast__r.Start_Time__c);
		         }
		         	
		      }
		      System.debug('@@@@@@scheduledRecToUpdate:'+scheduledRecToUpdate);
		      if(scheduledRecToUpdate.size() > 0){
		      	update scheduledRecToUpdate;
		      }
   }
}