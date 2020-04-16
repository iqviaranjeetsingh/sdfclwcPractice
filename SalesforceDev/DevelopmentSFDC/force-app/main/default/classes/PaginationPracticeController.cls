public class PaginationPracticeController {
   @AuraEnabled
    public static list<PaginationPracticeWrapper> getAccountDetails(){
        list<PaginationPracticeWrapper> acctDetails = new list<PaginationPracticeWrapper>();
        for(Account acct: [SELECT id, Name, Phone FROM Account ORDER By Name]){
            PaginationPracticeWrapper tempAcct = new PaginationPracticeWrapper();
            tempAcct.isSelected = false;
            tempAcct.acctId = acct.Id;
            tempAcct.acctname = acct.Name;
            tempAcct.phone = acct.Phone;
            acctDetails.add(tempAcct);
        }
        return acctDetails;
    }
}