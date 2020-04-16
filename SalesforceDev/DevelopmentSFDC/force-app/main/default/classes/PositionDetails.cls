public class PositionDetails{

    public PositionDetails(ApexPages.StandardController controller) {
        pos = [SELECT id, Name, Location__c, Min_Pay__c, Max_Pay__c From Position__c];
    }

   public List<Position__c> pos{get;set;}
   /*
   public PositionDetails(){
     
   }*/
}