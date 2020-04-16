public with sharing class PracticeExportCSVFileController {
   public Blob pracAttachFile{get;set;}
   public List<Account> acct{get;set;}
   public String strBlob{get;set;}
   public List<String> lstStr{get;set;}
   public PageReference ParseCSVFile(){
      acct = new List<Account>();
      lstStr = new List<String>();
      strBlob = pracAttachFile.toString();
      System.debug('@@@@strBlob>>'+strBlob);
      lstStr.addAll(strBlob.split('\n'));
      System.debug('@@@@lstStr>>'+lstStr);
      for(Integer i=1; i<lstStr.size();i++){
         String[] strValue = lstStr[i].split(',');
         System.debug('@@@Print Value:'+strValue);
         Account acctDetails = new Account();
         acctDetails.Name = strValue[0];
         acctDetails.Phone= strValue[1];
         acctDetails.Description = strValue[2];
         acct.add(acctDetails);
      }
      return null;
   }
   public PageReference InsertAccount(){
      if(acct.size() >0)
         insert acct;
      return null;
   }
}