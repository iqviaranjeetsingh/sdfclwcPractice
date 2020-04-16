public class Leapyear {
    public integer dateyear(date d){
        system.debug('today date is'+d);
        integer day=d.day();
        system.debug('todays date is:'+day);
        integer month=d.month();
        system.debug('this month is'+month);
        integer year=d.year();
        system.debug('this year is'+year);//public static Boolean isLeapYear(Integer year)
        
        If(Date.isLeapYear(year)){
            system.debug('the'+year+ 'yaer entered is a leap year');
        }else{
            system.debug('it is not a leap year');
        }
        return year;
    }
    
}