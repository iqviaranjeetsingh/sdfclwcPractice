public class ifelse 
{
    //public static Boolean isLeapYear(Integer year)
    //Class Name: Date
    
    public static Boolean myCustomLeadYear(Integer yyyy){
     	Boolean result = Date.isLeapYear(yyyy);
        if(result == true){
            System.debug('It is leap year');
        }else{
            System.debug('It is not a leap year');
        }
        
        return result;
    }
    
    //Use: ClassName.MethodName(Argument);
    //Boolean islpyear = ifelse.myCustomLeadYear(2015);
    //Boolean islpYear = Date.isLeapYear(2015);
    public void methodName(Date dt, Boolean dt1,Long dt2){
        
    }
    public Date methodName(Decimal dec01){
        Date dt;
        Integer test1;
        return dt;
    }
    
    public Boolean methodName(Integer day, Boolean islpyear){
        Boolean isLeapYear;
        return isLeapYear;
    }
    
  
  
    
    public integer find_day_month_year(date a)
    {
        system.debug('date' +a);
        integer day = a.day();
        system.debug('todays date' +day);
        
        
        integer month = a.month();
        system.debug('month' +month);
        
        
        integer year = a.year();
        system.debug('year' +year);
        
        if (date.isLeapYear(year))
        {
            system.debug('this ' +year+ 'is leap year ');
        }
        
        else
        {
            system.debug('this ' +year+ 'is not leap year ');
        }
        
        return null;
    }
    
}