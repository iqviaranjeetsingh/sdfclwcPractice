public class UpdateParentAccount implements Queueable {
    
    private list<Account> acctList;
    private id acctParentId;
    
    public UpdateParentAccount(id acctParentId, list<Account> acctList){
       this.acctParentId = acctParentId;
       this.acctList = acctList;
    }
    
    public void execute(QueueableContext context){
        
        list<Account> lstAccountUpdate = new list<Account>();
        for(Account acct: acctList){
            acct.ParentId =  acctParentId;
            lstAccountUpdate.add(acct);
        }
        
        if(lstAccountUpdate.size() > 0){
           update lstAccountUpdate; 
        }
    }
}