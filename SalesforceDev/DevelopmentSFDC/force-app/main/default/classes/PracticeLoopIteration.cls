public class PracticeLoopIteration {
    
    public static void countNumber(){
        Integer count = 0;
        //Traditional for All
        for(Integer i=0; i<=10; i++){
          count = count + i;
    	}    
        System.debug('1 to 10 Count For loop:'+count);
        //SOQL For loop
        //SOQL Stands for Salesforce Object Query Language
        for(Position__c pos:[Select id, Name, Location__c, Min_Pay__c,Max_Pay__c, Skill_Sets__c FROM Position__c]){
            System.debug('Postion Record:'+pos);
        }
        
        Integer i = 0;
        count = 0;
        while(i<=10){
            count = count + i;
            i++; // incremental operator
            //i = i + 1;
        }
        System.debug('1 to 10 Count For while loop:'+count);
    }
    

}