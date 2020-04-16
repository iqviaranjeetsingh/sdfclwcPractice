public class AccountListInLightning {
   @auraEnabled
    public static list<Account> getAccountDetails(){
        list<Account> acctDetails = new list<Account>();
        acctDetails = [SELECT id, Name, Phone, Type, OwnerId, Owner.Name FROM Account];
        return acctDetails;
    }
}