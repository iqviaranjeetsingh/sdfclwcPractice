public class ksimpleinterest {
    public integer simpleinterest(integer p,integer r,integer t){
        integer si;
        si=p*r*t/100;
        system.debug('Please enter Amount   :'+p);
        system.debug('enter rate of interest :'+r);
        system.debug('Enter time in month    :'+t);
        system.debug('total interest is :'+si);
        integer TA;
        TA=si+p;
        system.debug('Total Amount to repay is  :'+TA);
        return TA;
        
    }

}