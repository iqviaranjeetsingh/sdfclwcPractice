public class PracticeConditionalStatement {
    //Enter year and verify, is it a leap year.
    //If leap year, then Print 'It is leap year'
    //if not, Print 'it is not a leap year'
    public void findLeapYear(Integer year){
        if(Date.isLeapYear(year)){
            System.debug('This '+year+' it is leap year');
        } else{
            System.debug('This '+year+' it is not a leap year');
        }
    }
    
    public static void findColor(){
        
        Integer val = -3;
        String coloar = null;
        // == Comparison Operator
        // = Assignment Operator
        if(val == 1){
            coloar = 'red';
        } else if(val ==2){
            coloar = 'Green';
        } else if(val ==3){
            coloar = 'Blue';
        } else if(val ==4){
            coloar = 'Purple';
        }  else{
            coloar = 'Other';
        }
        /*
        if(false){
            //Statement
        } else{
            //Statement
        }
       */        
        System.debug('Coloar:'+coloar);
        
    }
}