/*
    This class updated in SubLime Text 3 Editor.
    This editor is more helpful for salesforce development.
*/
public with sharing class AccountNew {
   public string acctName{get;set;}
   public String acctNo{get;set;}
   public string acctType{get;set;}
   public String acctRating{get;set;}
   public String acctPhone{get;set;}
   public String acctOwnere{get;set;}
   public String acctIndustry{get;set;}
   public string acctDescription{get;set;}
   
   public PageReference CreateNewAccount(){
      Account acctObj = new Account();
      acctObj.Name = acctName;
      acctObj.AccountNumber = acctNo;
      acctObj.Type = acctType;
      acctObj.Rating = acctRating;
      acctObj.Phone = acctPhone;
      acctObj.Ownership = acctOwnere;
      acctObj.industry = acctIndustry;
      acctObj.Description = acctDescription;
      insert acctObj;
      
      //After insert got to newly create account detail page   
      PageReference AcctPage = new ApexPages.StandardController(acctObj).view();
      AcctPage.setRedirect(true);
      return AcctPage;
   }
   
   public PageReference ResetAcct(){
      acctName = '';
      acctNo = null;
      acctType = null;
      acctRating = null;
      acctPhone = null;
      acctOwnere = null;
      acctIndustry = null;
      acctDescription = null;
      return null;
   } 
   public static void insertAcct(){
        List<Account> acctlist = new list<Account>();
        for(Integer i=0;i<2;i++){
            Account acct = new Account();
            acct.Name = 'Account '+i;
            acct.Phone = '902983012'+i;
            acctlist.add(acct);
         }
        System.debug(Database.insert(acctlist, false ));
    }
   
}