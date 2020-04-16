/**
    * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
    * @date Original: 17 Feb 2016, Last Modified: 21 FEB 2016
    * @description: This Class is used to create logic for Excel Communications (XLC) Company to provide flexibility to their Customer 
                    to see the installed Recording Device and current running show and future shows. In addition to this functionalities
                    Customer Can:
                    - See all available recording devices in Drop-down field.
                    - Subscribe the available Channels if any Broadcast is available for current/future hours, if not subscribed available channel.
                    - Record the Current/future running broadcast which Start Date Time is greater than current Date Time.
                    - Record all, record the selected Broadcast plus future broadcasts that available.
                    - Cancel the Recording that Scheduled for Current or Future broadcast.
                    - see Broadcast for channels that available from Current Date Time to Up to 48 hours.
                    - see 'No Data' if Broadcast is not available for Channels and Current/Future Date Time.
                    - See broadcast in tabular format, with Channel Name and Broadcast start from Current Date and hour (Eg: User can see the table header Date time in this format (Thu, Feb 18 07:00 AM)).
                    - Go to next Page and previous/Current page to see the available broadcasts for channels on click of <Previous   |  Next > Link. 
                    
*/
public with Sharing Class XLCInteractiveGuideController{
   
   //get and set variable for Recording Device
   public String selectedRecordingDevice{get;set;}
   //get and set variable to store formatted date and display on Table header.
   public string showStartDateTime01{get;set;}
   public string showStartDateTime02{get;set;}
   public string showStartDateTime03{get;set;}
   public string showStartDateTime04{get;set;}
   public string showStartDateTime05{get;set;}
   public string showStartDateTime06{get;set;}
   //Get and Set variable to store Pagenumber
   public Integer pageNumber{get;set;}
   //Account instance, used in utility method to get picklist value
   Account acct = new Account();
   //To store the unique channels name
   set<String> allChannels = new set<String>();
   //To store list of Recording Device
   List<Recording_Device__c> recDevice = new List<Recording_Device__c>();
   //To store the broadcast id and boolean value(true/false), is Scheduling record is Conflict.
   map<id,boolean> broadCastRecordingMap = new map<id,boolean>();
   //To store the Channel Names and Related list of Wrapper records.
   public map<string, list<ChannlesWithShowData>> channelAndBoradcastdetails{get;set;}
   //get and set variable to store the Selected Broadcast Id
   public string selectedBoradCastId{get;set;}
   //Boolean get and set vailable to rendered the visualforce component based on condition
   public boolean isBoradCastSelected{get;set;}
   //Boolean get and set vailable to rendered the visualforce component based on condition
   public boolean isChannelSubscribed{get;set;}
   //Boolean get and set vailable to rendered the visualforce component based on condition
   public boolean isChannelRecord{get;set;}
   //Boolean get and set vailable to rendered the visualforce component based on condition
   public boolean isChannelRecordAll{get;set;}
   //Get and Set variable to store BroadCast details and Display on Page
   public Broadcast__c selectedBroadCastDetails{get;set;}
   //Get and Set variable to store Scheduled Recording Record and Display on Page
   public Recording__c scheduledRecord{get;set;}
   //Get and Set variable to set Scheduled BraodCast Name and display on UI
   public String scheduledBraodCastName{get;set;}
   //Get and Set variable to set Scheduled BraodCast Description and display on UI
   public String scheduledBraodCastDesc{get;set;}
   //Boolean get and set variable to rendered button based on condition
   public boolean isRecordingScheduled{get;set;}
   //To set the default Recording Device Id
   String defaultRecordingDeviceName;
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 17 Feb 2016, Last Modified:
       * @description: XLCInteractiveGuideController() Constructor is used to initialize the variable and Execute logic to disply the defualt value on page.
       * @param: No Parameter 
   */
   public XLCInteractiveGuideController(){
      channelAndBoradcastdetails = new  map<string, list<ChannlesWithShowData>>();
      selectedBroadCastDetails = new Broadcast__c();
      pageNumber = 1;
      scheduledRecord = new Recording__c();
      selectedBoradCastId = null;
      isBoradCastSelected = false;
      isChannelSubscribed = false;
      isChannelRecordAll = false;
      isRecordingScheduled = false;
      isChannelRecord = false;
      for(SelectOption subscribeChannels : XLCUtilities.getPickValues(acct, 'Subscribed_Channels__c', null)){
        allChannels.add(subscribeChannels.getValue());
      }
      PopulateRecDevice();
      formatDateAndStartExecution(pageNumber);      
   }
   
    /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 17 Feb 2016, Last Modified:
       * @description: getRecordingDeviceType() getter method returns the recording devices that available for Logged-in User/Customer.
                       Logic Iterate with list of Recording devices that related with the Customer's Account and add to list of SelectOption to dispaly as picklist on the UI.
       * @param: No Parameter 
   */
   public list<SelectOption> getRecordingDeviceType(){
      list<SelectOption> options = new list<SelectOption>();
      for(Recording_Device__c rd: recDevice){
         options.add(new SelectOption(rd.id,rd.Name));
      }
      return options;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 17 Feb 2016, Last Modified:
       * @description: PopulateRecDevice() method is used to populate the recording devices that available for Logged-in User/Customer based on Customer Account.
                       Stored all recording devices in list to reuse in other methods and assign the default recording device id on defaultRecordingDeviceName variable, it helps 
                       to display the default scheduled record and Scheduled recording with conflict. Logic Iterate with SOQL results and holds all Recording Devices details in List variable.
       * @param: No Parameter  
   */
   private void PopulateRecDevice(){
      for(Recording_Device__c rd:[SELECT id, Name FROM Recording_Device__c WHERE Account__r.Customer__c =: UserInfo.getUserId() ORDER By Name Asc Limit:(Limits.getLimitQueryRows() - Limits.getQueryRows())]){
         recDevice.add(rd);   
      }
      
      if(recDevice.size() > 0)
       defaultRecordingDeviceName = recDevice[0].id; 
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 17 Feb 2016, Last Modified:
       * @description: AllScheduledRecording() method is used to get the Scheduled Recording records that related to selected Recording Device. 
                       Stored Scheduled Recording record in map and used in other methods to Display the information on UI.
                       Like, if Broadcast is already scheduled then display X with Broadcast Name.
                       If Broadcast is already schedule and there are conflict, then display X with Broadcast Name.
       * @param: No Parameter  
   */
   public void AllScheduledRecording(){
      broadCastRecordingMap.clear();
      String rdId = null;
      
      if(String.isBlank(selectedRecordingDevice))
         rdId = defaultRecordingDeviceName;
      else
         rdId = selectedRecordingDevice; 
      for(Recording__c recording:[SELECT id, Broadcast__c, Conflict_Warning__c FROM Recording__c WHERE Recording_Device__c =:rdId Limit:(Limits.getLimitQueryRows() - Limits.getQueryRows())]){
         broadCastRecordingMap.put(recording.Broadcast__c,recording.Conflict_Warning__c);   
      }
   }
   
    /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 18 Feb 2016, Last Modified:
       * @description: UpdateDataOnChangeRecordingDevice() method invokes onchange of Recording Device from UI.
                       Functionalities: to append the X OR O message with the broadcast Name based on the Recording Device selection.  
                       Like, if Broadcast is already scheduled then display X with Broadcast Name.
                       If Broadcast is already schedule and there are conflict, then display X with Broadcast Name.
       * @param: No Parameter  
   */
   public PageReference UpdateDataOnChangeRecordingDevice(){
      formatDateAndStartExecution(pageNumber);
      isRecordingScheduled = false;
      isBoradCastSelected = false;
      return null;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 18 Feb 2016, Last Modified:
       * @description: PreparePaginationDataData(DateTime broadstartDT) method invokes everytime on page load, on change of Recording Device or Pagination if User click on Next/Previous link on UI.
                       Functionalities: - To prepare Broadcast data for all channel
                                        - If Broadcast data is not available for hour, then setting 'NO Data' as value.
                                        - Created six string variable to display formatted date time(Fri, Feb 19 06:00 AM) on table header.
       * @param: broadstartDT: using this DateTime parameter, Method consider the Start DateTime for the Broadcast and prepare Broadcast data for next 6 hours.
   */
   private void PreparePaginationDataData(DateTime broadstartDT){
      AllScheduledRecording();
      showStartDateTime01 = null;
      showStartDateTime02 = null;
      showStartDateTime03 = null;
      showStartDateTime04 = null;
      showStartDateTime05 = null;
      showStartDateTime06 = null;
      DateTime currentDateTime = broadstartDT;
      for(Integer i=0; i < 6; i++){
         if(i == 0){
            showStartDateTime01 = XLCUtilities.DateTimeToString(currentDateTime.addHours(i));
         } else if(i == 1){
            showStartDateTime02 = XLCUtilities.DateTimeToString(currentDateTime.addHours(i));
         } else if(i == 2){
            showStartDateTime03 = XLCUtilities.DateTimeToString(currentDateTime.addHours(i));
         } else if(i == 3){
            showStartDateTime04 = XLCUtilities.DateTimeToString(currentDateTime.addHours(i));
         } else if(i == 4){
            showStartDateTime05 = XLCUtilities.DateTimeToString(currentDateTime.addHours(i));
         } else if(i == 5){
            showStartDateTime06 = XLCUtilities.DateTimeToString(currentDateTime.addHours(i));
         }              
      } 
      channelAndBoradcastdetails.clear();
      for(SelectOption channelOption: XLCUtilities.getPickValues(acct, 'Subscribed_Channels__c', null)){
         if(mapChannelAndBoradcast.containsKey(channelOption.getValue())){
            list<ChannlesWithShowData> tempShowData = new list<ChannlesWithShowData>();
            map<DateTime,Broadcast__c> tempMapData = mapChannelAndBoradcast.get(channelOption.getValue());
            for(integer i=0; i < 6; i++){
               Broadcast__c tempBroadCast = new Broadcast__c();
               DateTime tempDT = XLCUtilities.DateTimeFormatting(currentDateTime.addHours(i));
               String tempNoData = null;
               boolean isConflict = null;
               if(tempMapData.containsKey(tempDT)){
                  tempBroadCast = tempMapData.get(tempDT);
                  if(broadCastRecordingMap.containsKey(tempBroadCast.id)){
                     isConflict = broadCastRecordingMap.get(tempBroadCast.id);
                  }
               }else{
                  tempNoData = 'NO Data';
               }
               tempShowData.add(new ChannlesWithShowData(channelOption.getValue(), tempBroadCast, tempNoData, isConflict));     
            }   
            
            channelAndBoradcastdetails.put(channelOption.getValue(),tempShowData);
            //System.debug('@@@@@Added channelAndBoradcastdetails'+channelAndBoradcastdetails);
         }  
      }
      //System.debug('@@@@@Added Outside channelAndBoradcastdetails'+channelAndBoradcastdetails);
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 18 Feb 2016, Last Modified:
       * @description: GoToNextPage() method invokes on click of Next> link.
                       Functionalities: Increase the page number and invoke other methods to prepare data data and display updated broadcast details on UI.
       * @param: No Parameter  
   */
   public PageReference GoToNextPage(){
      pageNumber = pageNumber + 1 ;
      formatDateAndStartExecution(pageNumber);
      return null;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 18 Feb 2016, Last Modified:
       * @description: GoToPreviousPage() method invokes on click of < Previous link.
                       Functionalities: Decrease the page number and invoke other methods to prepare data to display updated broadcast details on UI.
       * @param: No Parameter  
   */
   public PageReference GoToPreviousPage(){
      pageNumber = pageNumber - 1 ;
      formatDateAndStartExecution(pageNumber);
      return null;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 18 Feb 2016, Last Modified:
       * @description: formatDateAndStartExecution(Integer currentPageNumber) method is used to format date time and prepare the Start Date Time  and End Date Time excluding minutes and Seconds.
                       Functionalities: From Date Time and To Date Time prepared based on Page number follow with next six hours.
                                        - Prepare BroadCast data based on Broadcast Start Date time and End Date Time
       * @param: currentPageNumber: this Integer parameter helps to prepare Broadcast Start Time and Broadcast End Date Time.  
   */
   private void formatDateAndStartExecution(Integer currentPageNumber){
      
      Integer incrementFromTime = currentPageNumber - 1;
      incrementFromTime = incrementFromTime * 6;  
         
      Integer incrementToTime = incrementFromTime + 6;
      
      DateTime currentDateTime = DateTime.now().addHours(incrementFromTime);
      DateTime fromDateTime = XLCUtilities.DateTimeFormatting(currentDateTime);
      
      DateTime endDateTime = DateTime.now().addHours(incrementToTime);
      DateTime toDateTime = XLCUtilities.DateTimeFormatting(endDateTime);
      GetBordcastData(fromDateTime,toDateTime);
      PreparePaginationDataData(fromDateTime);
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 18 Feb 2016, Last Modified:
       * @description: GetBordcastData(DateTime fromDateTime, DateTime toDateTime) method is used retrieve Broadcast which start between fromDateTime and toDateTime parameters.
                       Functionalities: Used map variable to store braodcast records, used Key as Channel Name and Value as list of Broadcast records.
       * @param: fromDateTime: this Date Time parameter helps to retrieve Braodcast record start from or after fromfromDateTime.
                 toDateTime: this Date Time parameter helps to retrieve Broadcast record that End at or before toDateTime.
   */
   map<string,map<DateTime,Broadcast__c>> mapChannelAndBoradcast = new map<string,map<DateTime,Broadcast__c>>();
   public void GetBordcastData(DateTime fromDateTime, DateTime toDateTime){
     mapChannelAndBoradcast.clear();
     List<Broadcast__c> allBoradCastDetails = new List<Broadcast__c>();
     for(Broadcast__c boradCast: [Select Id, Name, Start_Time__c, Show__c, Description__c, Channel__c From Broadcast__c  WHERE Start_Time__c >=: fromDateTime and Start_Time__c <=: toDateTime AND Channel__c IN:allChannels ORDER BY Start_Time__c ASC Limit:(Limits.getLimitQueryRows() - Limits.getQueryRows())]){
        allBoradCastDetails.add(boradCast);
     }
     
     for(SelectOption channelOption: XLCUtilities.getPickValues(acct, 'Subscribed_Channels__c', null)){
        map<DateTime, Broadcast__c> channelAndBroadCasts = new map<DateTime,Broadcast__c>();
        for(Broadcast__c broadCast: allBoradCastDetails){
           if(broadCast.Channel__c == channelOption.getValue()){
              channelAndBroadCasts.put(XLCUtilities.DateTimeFormatting(broadCast.Start_Time__c),broadCast); 
           }
        }
        //System.debug('@@@@mapChannelAndBoradcast Before'+mapChannelAndBoradcast);
        mapChannelAndBoradcast.put(channelOption.getValue(),channelAndBroadCasts);
        //System.debug('@@@@mapChannelAndBoradcast After'+mapChannelAndBoradcast);
     }
     //System.debug('@@@@Final'+mapChannelAndBoradcast);
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 19 Feb 2016, Last Modified:
       * @description: DisplayBroadCastDetails() method invokes on click of Broadcast Name.
                       Functionalities: To retrieve broadcast details based on the Broadcast id and validate and Enable functionalities based on the following condition.
                                        - To check Broadcast for channel is already subscribed or not, if not subscribed then Enable features to Subscribe the Channel.
                                        - If channel already subscribed then enable features to Record the Broadcast.
                                        - If broadcast is Scheduled for recording then enable feature to Cancel Scheduled Recording.
       * @param: No Parameter
   */
   public PageReference DisplayBroadCastDetails(){
    isBoradCastSelected = true;
    if(String.isNotBlank(selectedBoradCastId)){
       selectedBroadCastDetails = [Select Id, Name, Channel__c, Start_Time__c, Description__c From Broadcast__c WHERE id=:selectedBoradCastId Limit:(Limits.getLimitQueryRows() - Limits.getQueryRows())];  
    }
    if(selectedBroadCastDetails != null){
       isChannelSubscribed = isUserSubscribedSelectedChannle(selectedBroadCastDetails.Channel__c);  
    }
    
    if(isChannelSubscribed){
      isChannelRecordAll = true;
      isChannelRecord = true;
      isRecordingScheduled = false;
      
      if(isScheduledRecordingForChannle(selectedRecordingDevice,selectedBroadCastDetails.id)){
         isRecordingScheduled = true;
         isBoradCastSelected = false;   
      }
    }
    
    return null;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 19 Feb 2016, Last Modified:
       * @description: isScheduledRecordingForChannle(String rdId, String bcId) method accept the Recording Device id and Broadcast id, based on both parameters
                       verify in system like for selected broadcast recording already scheduled or not. If already Recording is scheduled then return true, othereswise false.
       * @param: rdId: This String parameter hold the Recording Device Id
                 bcId: This String parameter hold the Broadcast Id
   */
   private boolean isScheduledRecordingForChannle(String rdId, String bcId){
      boolean result = false;
      list<Recording__c> lstRcDevice = new list<Recording__c>();
      for(Recording__c rd:[SELECT id, Broadcast__r.Name,  Broadcast__r.Description__c, Conflict_Warning__c from Recording__c WHERE Broadcast__c=:bcId AND Recording_Device__c =:rdId Limit:(Limits.getLimitQueryRows() - Limits.getQueryRows())]){
         lstRcDevice.add(rd);   
      }
     if(lstRcDevice.size() > 0){
        result = true;
        scheduledRecord = lstRcDevice[0];
        scheduledBraodCastDesc = scheduledRecord.Broadcast__r.Description__c;
        scheduledBraodCastName = scheduledRecord.Broadcast__r.Name;
     }
     return result;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 19 Feb 2016, Last Modified:
       * @description: isUserSubscribedSelectedChannle(String channelName) method accept the Channel Name as parameters and validate that Logged-in user is already subscribed selected 
                       Channel or not, if subscribed then channel then return true, otherwise false. 
       * @param: channelName: This String parameter hold the Channel Name
                 
   */
   private boolean isUserSubscribedSelectedChannle(String channelName){
      boolean result = false;
      Account acct = [SELECT id, Name, Customer__c, Subscribed_Channels__c FROM Account WHERE Customer__c =: Userinfo.GetUserid() Limit:(Limits.getLimitQueryRows() - Limits.getQueryRows())];
      if(acct != null && String.isNotBlank(acct.Subscribed_Channels__c) && acct.Subscribed_Channels__c.contains(channelName)){
         result = true; 
      } 
      return result;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 19 Feb 2016, Last Modified:
       * @description: SubscribeChannel() method is used to subscribe channel for logged-in user based on Subscribe Now! button Click. To subscribe channel, added Channel name 
                       related the Selected Broadcast to Subscribed Channels multi-select field on Account record.
       
       * @param: No Parameters
                 
   */
   public Pagereference SubscribeChannel(){
       try{
           Account acct = [SELECT id, Name, Customer__c, Subscribed_Channels__c FROM Account WHERE Customer__c =: Userinfo.GetUserid() Limit:(Limits.getLimitQueryRows() - Limits.getQueryRows())];
           if(String.isBlank(acct.Subscribed_Channels__c))
              acct.Subscribed_Channels__c = selectedBroadCastDetails.Channel__c;
           else
              acct.Subscribed_Channels__c = acct.Subscribed_Channels__c+';'+selectedBroadCastDetails.Channel__c;  
           
           update acct;
           isChannelSubscribed = true;
           isChannelRecordAll = true;
           isChannelRecord = true;
       }catch(Exception ex){}
        
       return null;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 18 Feb 2016, Last Modified:
       * @description: isPassedValidation() method is used to validate the data and display the proper error message on page, Returns true is user selected the Recording Device, otherwise return false.
       * @param: No Parameters
   */
   private Boolean isPassedValidation(){
      boolean result = true;
      if(String.isBlank(selectedRecordingDevice)){
         result = false;
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,XLCUtilities.RECORDING_DEVICE_MSG)); 
      }
      return result;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 18 Feb 2016, Last Modified:
       * @description: isRunningBroadCast() method is used to validate the data and display the proper error message on page, Validate the selected broadcast is schedulable,
                       If broadcast Start Date time is less that current System Date time then returns false, otherwise return true. 
       * @param: No Parameters
   */
   private boolean isRunningBroadCast(){
      boolean result = true;
      //System.debug('@@@@@selectedBroadCastDetails'+selectedBroadCastDetails);
      if(selectedBroadCastDetails.Start_Time__c < System.now()){
        result = false;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,XLCUtilities.RECORDING_SCHEDULE_MSG));
      }
      
      return result;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 19 Feb 2016, Last Modified:
       * @description: ScheduleRecordingRecord() method is used to start recording of selected Broadcast. To invoke this method user need to click on Record button on Page
                       To start recording for selected broadcast, Setting Broadcast id and Recording Device id and creating new record in Schedule Recording object.
                       here,setting the static name for Recording object because workflow automatically setting the Recording device name.
       * @param: No Parameters
   */
   public PageReference ScheduleRecordingRecord(){
      try{
        if(isPassedValidation() && isRunningBroadCast()){
            Recording__c schRecord = new Recording__c();
            schRecord.Recording_Device__c = selectedRecordingDevice;
            schRecord.Broadcast__c = selectedBroadCastDetails.id;
            schRecord.Name = 'Schedule Broadcast';
            insert schRecord;
            
            scheduledRecord = [SELECT id, Broadcast__r.Name,  Broadcast__r.Description__c, Conflict_Warning__c FROM Recording__c WHERE id=:schRecord.id Limit:(Limits.getLimitQueryRows() - Limits.getQueryRows())];
            scheduledBraodCastDesc = scheduledRecord.Broadcast__r.Description__c;
            scheduledBraodCastName = scheduledRecord.Broadcast__r.Name;
            isBoradCastSelected = false;
            isRecordingScheduled = true;
            formatDateAndStartExecution(pageNumber);
        }
        
      }catch(Exception ex){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,XLCUtilities.EXCEPTION_MSG+ex.getMessage()));
      }
      return null;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 19 Feb 2016, Last Modified:
       * @description: ScheduleRecordingRecordAll() method is used to start recording of selected Broadcast and available future broadcast for last 48 hours.
                       To start recording for selected broadcast, Setting Broadcast id and Recording Device id and creating new record in Schedule Recording object.
                       here,setting the static name for Recording object because workflow automatically setting the Recording device name.
       * @param: No Parameters
   */
   public PageReference ScheduleRecordingRecordAll(){
      try{
        if(isPassedValidation() && isRunningBroadCast()){
          
           list<Recording__c> recordSelectedPlusFutreBroad = new list<Recording__c>();
           //Prepare Recording for selected braodcast
           Recording__c schRecord = new Recording__c();
           schRecord.Recording_Device__c = selectedRecordingDevice;
           schRecord.Broadcast__c = selectedBroadCastDetails.id;
           schRecord.Name = 'Schedule Broadcast';
           recordSelectedPlusFutreBroad.add(schRecord);
           
           DateTime fromDateTime = XLCUtilities.DateTimeFormatting(selectedBroadCastDetails.Start_Time__c.addHours(1));
           DateTime ToDateTime = XLCUtilities.DateTimeFormatting(selectedBroadCastDetails.Start_Time__c.addHours(Integer.valueof(System.Label.Recording_Past_Hours)));
           
           //To Ignore the duplicate broadcast start on the same hour
           set<DateTime> ignoreDuplicateBraodcast = new set<DateTime>();
           for(Broadcast__c braodcast:[SELECT id, Name,Start_Time__c FROM Broadcast__c WHERE Channel__c=:selectedBroadCastDetails.Channel__c and Start_Time__c >:fromDateTime and  Start_Time__c<=:ToDateTime]){
             if(!ignoreDuplicateBraodcast.contains(XLCUtilities.DateTimeFormatting(braodcast.Start_Time__c))){
                ignoreDuplicateBraodcast.add(XLCUtilities.DateTimeFormatting(braodcast.Start_Time__c));
                Recording__c tempSchRecord = new Recording__c();
                tempSchRecord.Recording_Device__c = selectedRecordingDevice;
                tempSchRecord.Broadcast__c = braodcast.id;
                tempSchRecord.Name = 'Schedule Broadcast'; 
                recordSelectedPlusFutreBroad.add(tempSchRecord);	
             }
           }
           
           //to Check the collections size before insert
           if(recordSelectedPlusFutreBroad.size() > 0){
              insert recordSelectedPlusFutreBroad;
              scheduledRecord = [SELECT id, Broadcast__r.Name,  Broadcast__r.Description__c, Conflict_Warning__c FROM Recording__c WHERE id=:recordSelectedPlusFutreBroad[0].id Limit:(Limits.getLimitQueryRows() - Limits.getQueryRows())];
	          scheduledBraodCastDesc = scheduledRecord.Broadcast__r.Description__c;
	          scheduledBraodCastName = scheduledRecord.Broadcast__r.Name;
	          isBoradCastSelected = false;
	          isRecordingScheduled = true;
	          formatDateAndStartExecution(pageNumber);
           }
        }
        
      }catch(Exception ex){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,XLCUtilities.EXCEPTION_MSG+ex.getMessage()));
      }
      return null;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 19 Feb 2016, Last Modified:
       * @description: CancelRecording() method is used to Cancel the Recording for braodcast, if already scheduled.
                       To Cancel the Broadcast, simply deleting the Scheduled Recording on Click of Cancel button.
       * @param: No Parameters
   */
   public Pagereference CancelRecording(){
    isRecordingScheduled = false;
    try{
        delete scheduledRecord;
        formatDateAndStartExecution(pageNumber);
      }catch(Exception ex){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,XLCUtilities.EXCEPTION_MSG+ex.getMessage()));
      }
    return null;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 17 Feb 2016, Last Modified:
       * @description: ChannlesWithShowData Wrapper class is used to hold the Channel Name, Broadcast record, String message if Broadcast Record is not available for Date time,
                       Boolean value (to check and display the X if True, Otherwise O if false on UI)
       * @param: No Parameters
   */
   public Class ChannlesWithShowData{
      public String channelName{get;set;}
      public Broadcast__c broadcastRec{get;set;}
      public String noDataMessage{get;set;}
      public Boolean isRecordingConflict{get;set;}
      public ChannlesWithShowData(String channelName, Broadcast__c broadcastRec, String noDataMessage, Boolean isRecordingConflict){
         this.channelName = channelName;
         this.broadcastRec = broadcastRec;
         this.noDataMessage = noDataMessage;
         this.isRecordingConflict = isRecordingConflict;
      }
   
   }
}