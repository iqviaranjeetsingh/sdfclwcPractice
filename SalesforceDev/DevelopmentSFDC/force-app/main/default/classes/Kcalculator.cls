public class Kcalculator {
    Public integer Add(integer a,integer b){
        integer c=a+b;
        system.debug('Sum of two no is:'+c);
            return c;
    }
   Public integer Add(integer a,integer b,integer c){
        integer d=a+b+c;
       System.debug('Value of:' +a);
       System.debug('Value of:' +b);
       System.debug('Value of:' +c);
        system.debug('Sum of three no is:'+d);
            return d;
    }
    Public integer Substract(integer a,integer b){
        integer sub=a-b;
        system.debug('remaing value is:'+sub);
        return sub;
    }
    Public integer multiplication(integer a,integer b){
        integer prod=a*b;
        system.debug('Product of two no is:'+prod);
        return prod;
    }
     Public integer multiplication(integer a,integer b,integer c){
        integer prod=a*b*c;
        system.debug('Product of three no is:'+prod);
        return prod;
    }
    Public integer Division(integer a,integer b){
        integer div=a/b;
        system.debug('Divident of two no is:'+div);
        return div;
        }
    public integer square(integer a){
        integer sqr=a*a;
        System.debug('Sqare of a number is:'+sqr);
        return sqr;
    }
   /* Public integer leapyear(integer year,integer ly){
        system.debug('Please enter the year:');
        if(ly=year/100|400){
            system.debug('it is a leap year'+ly);
            return ly;
        
        else{
            integer ly=year/100/400;
            system.debug('is not a leap year'+ly);
            return ly;
        }*/
    }