public class ExceptPractice {
   
    @AuraEnabled
    public static integer DoSubstraction(){
        integer x = 10;
        integer y = 0;
        if(y == 0){
           throw new AuraHandledException('You cann\'t divide number by zero.'); 
        }
        integer i = 10/0;
        return i;
    }
}