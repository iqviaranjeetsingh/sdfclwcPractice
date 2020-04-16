public Class Calculator{
    Public integer Add(Integer value1 , integer value2){
        /*Integer value1 = 10;
        Integer value2 =20;*/
        Integer sum = value1+value2;
        System.debug('Sum of two number is:' +sum);
        return sum ;     
        
    }
    Public integer Substract(integer num1, integer num2){
        integer sub=num1-num2;
        system.debug('Substraction of two no is:'+sub);
        return sub;
        
    } 
    Public integer multiplication(integer value1,integer value2){
        //integer value1;
        //integer value2;
        integer result=value1*value2;
       system.debug('Product of two no is'+result);
        return result;
        
            }
    Public integer Division(integer val1,integer val2){
        integer div=val1/val2;
        system.debug('Quotient of divison is:'+div);
        return div;
        
    }    
   }