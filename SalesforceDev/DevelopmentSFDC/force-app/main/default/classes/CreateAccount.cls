global class CreateAccount{
   webservice static void InsertAccount(String AcctName){
     Account acct = new Account(name = AcctName);
     insert acct;
   
   }
}