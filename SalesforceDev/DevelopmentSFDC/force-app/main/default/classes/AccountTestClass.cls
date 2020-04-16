@isTest(SeeAllData=true)
public class AccountTestClass {

   // Methods for testing
   @isTest static void test1() {
      //List<Account> acct = [SELECT id, Name FROM Account][0];
      Account acct = [SELECT id, Name FROM Account][0];
      System.debug('@@@@'+acct);
       
      String acct01 = [SELECT id, Name FROM Account][0].Name;
      System.debug('@@@@'+acct01);
      
       SObjectType s = [SELECT Id FROM account LIMIT 1][0].getSObjectType();//.newSObject([SELECT Id FROM Account LIMIT 1][0].Id);
       System.debug('@@@@'+s);
       
       SObject s1 = [SELECT Id FROM account LIMIT 1][0].getSObjectType().newSObject([SELECT Id FROM Account LIMIT 1][0].Id);
       System.debug('@@@@'+s1);
       
       String name = [SELECT Name FROM Account Limit 1].Name;
       System.debug('@@@@'+name);
   }
    
    @isTest(SeeAllData=false) static void test2() {
       list<Account> acct = [SELECT id, Name from Account];
       System.debug('@@@@acct Details in SeeAllData False:'+acct);
    }
}