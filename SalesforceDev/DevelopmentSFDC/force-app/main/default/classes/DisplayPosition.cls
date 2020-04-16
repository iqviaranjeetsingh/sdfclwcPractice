/************************************************************
Name: DisplayPosition http://www.vinaychaturvedi.com/select-and-export-records-in-lightning-component/
Type: Apex Class  
Purpose: Apex Class  for  lightning component DisplayPosition.cmp
***********************************************************/
public class DisplayPosition {
    
    @AuraEnabled
    public static List<CommonWrapperClass> getPositionRecords() {
        
        List<CommonWrapperClass> lstPositionRecords = new List<CommonWrapperClass>();
        
        List<Position__c> lstPositions =  [SELECT Id, Name FROM R_Singh__Position__c]; 
        
        if(lstPositions != null && lstPositions.size() > 0){
            
            for(Position__c position : lstPositions){
                
                CommonWrapperClass positionRecord = new CommonWrapperClass();
                positionRecord.positionId = position.Id;
                positionRecord.positionTitle = position.Name;
                positionRecord.status = position.Name; 
                
                lstPositionRecords.add(positionRecord);
            }
            
        }
        
        
        return lstPositionRecords;
        
    }    
    @AuraEnabled
    public static void performAction(string positionRecords) {
        
        if(!string.isBlank(positionRecords)){
            
            List<CommonWrapperClass> lstPositionRecords = 
                (List<CommonWrapperClass>)System.JSON.deserialize(positionRecords,List<CommonWrapperClass>.class);
                system.debug('Debug for Dsiplaying all the records: lstPositionRecords'+lstPositionRecords);    
                         //Perform Operation with records 
                         for(CommonWrapperClass objPositionRecords:lstPositionRecords){
                             if(objPositionRecords.isSelected){
                                 //Play with selected Records here                   
                                 system.debug('Selected Record :'+objPositionRecords);
                             }
                         }
                         
        }
  }
}