/**
    * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
    * @date Original: 17 Feb 2016, Last Modified: 21 FEB 2016
    * @description: XLCUtilities Class is used as Helper class, all reusable methods and Message added in this controller 
*/
public Class XLCUtilities{
  
  //constant variable to store message
  public static final String RECORDING_DEVICE_MSG = 'Please Select a Recording Device.';
  public static final String RECORDING_SCHEDULE_MSG = 'No new Scheduled Recordings may be created in the past.';  
  public static final String EXCEPTION_MSG = 'Exception Occured:: Please Contact to System Admin';
  public static Boolean islogicExecutionCompleted = false;
  /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 17 Feb 2016, Last Modified:
       * @description: getPickValues(Sobject objectAPIName, String fieldAPIName, String first_Value) method is used to retrieve the
                       picklist values using describe. It takes three parameters Sobject, Field API Name and first value. 
                       based on these three parameters prepare the list of Selectoption and Returns.
       * @param: objectAPIName: This Sobject type parameter used to identify which object need to describe
                 fieldAPIName: This String type parameter used to identify which Field value need to describe
                 first_Value: This String type parameter used to set the first Value in SelectOption
   */
   public static List<SelectOption> getPickValues(Sobject objectAPIName, String fieldAPIName, String first_Value) {
      
      List<selectOption> options = new List<selectOption>();
      if (String.isNotBlank(first_Value)) {
         options.add(new selectOption(first_Value, first_Value));
      }
      Schema.sObjectType sobject_Type = objectAPIName.getSObjectType();
      Schema.DescribeSObjectResult sobject_describe = sobject_Type.getDescribe();
      Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap();
      List<Schema.PicklistEntry> picklist_values = field_map.get(fieldAPIName).getDescribe().getPickListValues();
      for (Schema.PicklistEntry a : picklist_values) {
            options.add(new selectOption(a.getValue(), a.getLabel()));
      }
      return options;
   }
   
   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 17 Feb 2016, Last Modified:
       * @description: DateTimeFormatting(DateTime dt) method is used to remove Minutes and Seconds value and Set Zero from DateTime value.
                       and reture the formatted DateTime excluding Muntes and Second.
                       
       * @param: dt: This DateTime type parameter, used to prepare formatted DateTime and Returns formatted DateTime.
   */
   public static DateTime DateTimeFormatting(DateTime dt){
      DateTime formattedDateTime = Datetime.newInstance(dt.year(),dt.month(),dt.day(), dt.hour(), 0, 0);
      return formattedDateTime;
   }

   /**
       * @author Original: Ranjeet Kumar Singh, Last Modified: Ranjeet Kumar Singh 
       * @date Original: 19 Feb 2016, Last Modified:
       * @description: DateTimeToString(DateTime dt) method is used to format DateTime into String format(Fri, Feb 19 04:00 PM/AM)
       * @param: dt: This DateTime type parameter used to Format dt into String and returns
   */
   public static string DateTimeToString(DateTime dt){
      string formattedDTString = dt.format('E, MMM dd hh:00 a');
      return formattedDTString;
   }
}