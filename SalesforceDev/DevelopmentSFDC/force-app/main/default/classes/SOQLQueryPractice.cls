public class SOQLQueryPractice {
    
    public static void showLoggedInUserAssignedPS(){
        Integer count = 0;
        for(PermissionSetAssignment PSA:[SELECT id, PERMISSIONSETID, ASSIGNEEID FROM PermissionSetAssignment WHERE ASSIGNEEID=:UserInfo.getUserId()]){
           count++;       
           System.debug('@@@@'+count+':'+PSA);
        }
        System.debug('Number of Permission Sets Assigned:'+count);
    }
    
    //Relating Records by Using an External ID
    public static void RelateParentRecordWIthChild(){
        R_Singh__Test_One_Child__c testRef = new R_Singh__Test_One_Child__c(Name='Test P Ref 001');
        R_Singh__test_one__c testORef = new R_Singh__test_one__c(R_Singh__Ext_Id__c='99991');
        testRef.R_Singh__test_one__r = testORef;
        insert testRef;
    }
    
    //Creating Parent and Child Records in a Single Statement Using Foreign Keys.
    public static void CreateParentChildRec(){
    
        R_Singh__Test_One_Child__c testRef = new R_Singh__Test_One_Child__c(Name='Test P Ref');
        R_Singh__test_one__c testORef = new R_Singh__test_one__c(R_Singh__Ext_Id__c='10001');
        testRef.R_Singh__test_one__r = testORef;
        R_Singh__test_one__c parentOne = new R_Singh__test_one__c(Name='P&Child Single trans', R_Singh__Status__c='Follow-Up', R_Singh__Ext_Id__c='10001');
        Database.SaveResult[] results = Database.insert(new SObject[] {parentOne, testRef});
    }
    
    //SOSL: Search @Salesforce.com in Email field in Lead and Contact using SOSL
    public static void runSOSLQuery(){
        List<List<sObject>> searchList = [FIND '@salesforce.com' IN EMAIL FIELDS RETURNING Lead(Id, Name, Email), Contact(Id, FirstName,LastName, Email)];
        Lead[] searchLead = (Lead[])searchList[0];
		Contact[] searchContacts = (Contact[])searchList[1];
        System.debug('@@@@@searchLead:'+searchLead);
        System.debug('@@@@@searchContacts:'+searchContacts);
        
        List<AggregateResult> groupedResults = [SELECT CampaignId, AVG(Amount) FROM Opportunity GROUP BY CampaignId];
        System.debug('@@@@@groupedResults:'+groupedResults);
    }
    

}