public class shubh_for {
    
    public static void countnumber(){
        integer count = 0;
        for ( integer i = 0; i<=100; i++)
        {
            count = count + i;
        }
        system.debug('1 to 1oo count:' +count);
    } 
    
    public static void countnumber1()
    {
        integer i = 0;
        integer count = 0;
        while(i<=100)
        {
            count = count + i;
            i++;
        }
        system.debug('1 to 100 count by while loop: ' +count);
   
 
    //for (position__c soql: [SELECT Name, Location__c, Max_Pay__c, Skill_Sets__c from position__c]){
      //  system.debug('Position Details :' +soql);   
    
    
        
        for(Account soql1:[SELECT Customer_ID__c, SLA__c, AccountNumber, phone, Name, ID, fax from Account]){
          system.debug('Account Details: '+soql1);
            system.debug('Account ID: '+soql1.Id);
            system.debug('Account name: '+soql1.name);
            system.debug('Account cust_id: '+soql1.Customer_ID__c);
            system.debug('Account Phone: '+soql1.Phone);
        }    
        //{Name=Burlington Textiles Corp of America, Customer_ID__c=5, 
        //AccountNumber=CD656092, Fax=(336) 222-8000, SLA__c=Silver, Id=00128000002ktjaAAA}
        //
    
        
        
          } 
    
    public static void account_insert(){
        account acct = new account();
        //Position__c pos = new Position__c();
        acct.Name = 'pqr';
        acct.phone = '9835074398';
        acct.active__c = 'Ha'; 
        acct.customer_id__c = '50';
        insert acct;
    }
   
}