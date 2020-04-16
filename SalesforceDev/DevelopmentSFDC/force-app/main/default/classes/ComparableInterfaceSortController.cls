global with sharing class ComparableInterfaceSortController {
    
    public list<AccountWrapper> AccountWrappervar{get;set;}
    public string sortByString{get;set;}
    public ComparableInterfaceSortController(){
        AccountWrappervar = new list<AccountWrapper>();
        Integer i = 1;
        for(Account acct: [SELECT id, Name from Account]){
            AccountWrapper refAcct = new AccountWrapper();
            refAcct.id = acct.id;
            refAcct.acctName = acct.Name;
            refAcct.order = i;
            AccountWrappervar.add(refAcct);
            i *= 2;
        }
        AccountWrappervar.sort();
    }
    
    
    public pagereference strartSorting(){
        AccountWrapper acctwrp = new AccountWrapper();
        acctwrp.sortByValue(sortByString);
        AccountWrappervar.sort();
        return null;
    }
}