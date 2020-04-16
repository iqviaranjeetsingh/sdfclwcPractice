public class SwitchCasePractice {

    public static void Calc(Integer option, Integer value1, Integer value2){
        switch on option{
            when 1, 2 {
                System.debug('Added Value:'+(value1+value2));
            } when 3, 4{
                System.debug('Multiplied Value:'+(value1*value2));
            } when 5, 6{
                System.debug('Substracted Value:'+(value1-value2));
            } when else{
                System.debug('Option didn\'t found.');
            }
        }
    }
    
    public static void switchOptionPractive(list<Account> newAcct, list<Account> oldAcct, System.TriggerOperation trgEvent){
        System.debug('@@@@newAcct:'+newAcct);
        System.debug('@@@@oldAcct:'+oldAcct);
        System.debug('@@@@trgEvent:'+trgEvent);
        
        switch on trgEvent{
            when AFTER_UPDATE{
                System.debug('After---- Update Operation!');
            } when BEFORE_UPDATE{
                System.debug('Before---- Update Operation!');
            } when else{
                System.debug('No Update Operation!');
            }
        }
    }
}