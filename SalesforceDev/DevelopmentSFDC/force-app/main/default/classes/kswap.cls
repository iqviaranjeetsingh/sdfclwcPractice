public class kswap {
    public integer swapingtwo(integer a, integer b){
        system.debug('you have entered first value for A :   '+a);
        system.debug('you have entered first value for B :   '+b);
        /*integer temp;
        a=temp;
        b=a;
        temp=b;*/
        a=a+b;
        b=a-b;
        a=a-b;
        system.debug('value of A after swaping  :'+a);
        system.debug('value ob B after swaping  :'+b);
        return a;
        return b;
        
        
    }

}