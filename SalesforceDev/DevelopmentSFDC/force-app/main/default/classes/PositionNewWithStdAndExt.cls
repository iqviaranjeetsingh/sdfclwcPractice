public with sharing class PositionNewWithStdAndExt {
    public Position__c Pos{get;set;}
    public PositionNewWithStdAndExt(ApexPages.StandardController controller) {
       Pos = new Position__c();
    }
    
    public PageReference CreatePosition(){
    	insert Pos;
    	System.debug('Position Id'+pos.id);
    	//PageREference pageRef = new PageReference('/'+pos.id);
    	PageREference pageRef = new PageReference('/apex/welcomePage?id='+pos.id);
    	pageRef.setRedirect(true);
    	return pageRef;
    }
    
    public PageReference CancelPosition(){
    	PageReference pageRef = new PageReference('/a05/o');
    	pageRef.setredirect(true);
    	return pageRef;
    }

}