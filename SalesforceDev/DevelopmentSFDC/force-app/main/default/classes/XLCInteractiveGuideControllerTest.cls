@isTest
public with sharing class XLCInteractiveGuideControllerTest {
   //Select Name, Subscribed_Channels__c, Customer__c, BillingAddress, BillingStreet, BillingState, BillingPostalCode, BillingCity,BillingCountry From Account
   
   //To prepare test data for testing
   @testSetup static void XLCInteractiveGuideTestData() {
       //Create Account record
       Account testAccount = new Account(Name='Test Account', Customer__c=UserInfo.getUserId(), BillingStreet='PH1, Block 5', BillingCity='New York', BillingState='New Jersey', BillingPostalCode='10017', BillingCountry='United States');
       insert testAccount;
       
       //Create list of Recording Device for Account, Creating three Test Recording Device records that will be realted to test Account.
       list<Recording_Device__c> testRecordingDevice = new list<Recording_Device__c>();
       for(Integer i=0; i < 3; i++){
          Recording_Device__c tempRD = new Recording_Device__c();
          tempRD.Name = 'Recording Device '+i+1;
          tempRD.Account__c = testAccount.id;
          testRecordingDevice.add(tempRD);
       }
       
       //Validate the list size, if size is more than 0 then do insert the Recording Device
       if(testRecordingDevice.size() > 0){
          insert testRecordingDevice;
       }
       
       //Create test Show Records
       Account acctObj = new Account();
       list<Show__c> testShow = new list<Show__c>();
       for(Integer i=1; i<=24; i++){
           Show__c Tempshow = new Show__c(Name ='Test Channel'+i);
           testShow.add(Tempshow);
       }
       //Validate the list size, if size is more than 0 then do insert the Recording Device
       if(testShow.size() > 0){
          insert testShow;
       }
       
       //Create Test BoradCast Records
       list<Broadcast__c> testBraodCasts = new list<Broadcast__c>();
       for(SelectOption Channel:XLCUtilities.getPickValues(acctObj,'Subscribed_Channels__c',null)){
          Integer hourCounter = 0;
          for(Show__c show : testShow){
             Broadcast__c tempBroadCast = new Broadcast__c(Name='Test Broadcast', Channel__c=Channel.getValue(), Show__c=show.id, Start_Time__c=System.now().addHours(hourCounter));
             testBraodCasts.add(tempBroadCast);  
             hourCounter++; 
          }	
       }
       
       //Validate the list size, if size is more than 0 then do insert the Recording Device
       if(testBraodCasts.size() > 0){
          insert testBraodCasts;	
       }
   }
   
   //Start Testing XLC Interactive Guide Funcationalities
   static testMethod void TestXLCInteractiveGuide(){
      XLCInteractiveGuideController testXLCIG = new XLCInteractiveGuideController();	
   }
}