public class GarageOverrideController{
    public String status{get;set;}
    public string recId{get;set;}
    public GarageOverrideController(ApexPages.StandardController controller) {
         R_Singh__Vehicle__c vStatus = [SELECT id, Name, R_Singh__Status__c FROM R_Singh__Vehicle__c WHERE id=:controller.getid()];
         recId = vStatus.id;
         status = vStatus.R_Singh__Status__c;
    }
  
}