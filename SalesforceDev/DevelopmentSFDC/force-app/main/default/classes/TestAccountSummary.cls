public with sharing class TestAccountSummary {
	public List<Account> acctDetails{get;set;}
	public TestAccountSummary() {
		acctDetails = new list<Account>();
		acctDetails = [SELECT id, Name, Phone, Rating FROM Account Where Name!=null];
	}

	//To update account changes on UI
	public PageReference saveAccount(){
        if(acctDetails.size() > 0){
            update acctDetails;
        }
		return null;
	}
}