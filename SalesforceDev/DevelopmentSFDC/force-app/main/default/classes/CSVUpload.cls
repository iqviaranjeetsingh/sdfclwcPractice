public class CSVUpload{
   
   public Blob uploadedFile{get;set;}
   public list<Account> accountDetails{get;set;}
   public PageReference UploadFile(){
      accountDetails = new list<Account>();
      string BlobToString = blobToString(uploadedFile,'UTF-8');
      System.debug('@@@@@@Converted File:'+BlobToString);
      
      list<string> fileValues = BlobToString.split('\n');
      System.debug('@@@@@@fileValues :'+fileValues);
      
      for(string str:fileValues){
         system.debug('@@@String Value:'+str);
      }
      
      for(Integer i=1; i < fileValues.size(); i++){
         system.debug('****@@@String Value:'+fileValues[i]);
         List<String> accountD = fileValues[i].split(',');
         Account acct = new Account();
         acct.Name = accountD.get(0);
         acct.ShippingStreet = accountD.get(1);   
         acct.ShippingCity = accountD.get(2);
         acct.ShippingState = accountD.get(3);
         acct.ShippingPostalCode = accountD.get(4);
         acct.ShippingCountry = accountD.get(5);
         accountDetails.add(acct);
      }
   
      return null;
   }
   
   
   public List<Account> getAcctDetails(){
      if(accountDetails != null){
         return accountDetails;
      } else {
         return null;
      }
   
   }
   
    /**
         This function convers the input CSV file in BLOB format into a string
        @param input    Blob data representing correct string in @inCharset encoding
        @param inCharset    encoding of the Blob data (for example 'ISO 8859-1')
     */
    public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }         
}