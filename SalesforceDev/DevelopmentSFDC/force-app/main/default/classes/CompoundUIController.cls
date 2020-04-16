public with sharing class CompoundUIController {

   public List<Account> getAcctDetails(){
       List<Account> accts = [SELECT id, Name, BillingAddress,ShippingAddress FROM Account];
       return accts;
  
   }
}