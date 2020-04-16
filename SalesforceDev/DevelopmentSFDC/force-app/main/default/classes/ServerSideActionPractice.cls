public class ServerSideActionPractice {
    
    @AuraEnabled
    public static list<Account> getserverEcho(string firstName, string isActive){
        System.debug('@@@firstName:'+firstName);
        //return [SELECT id, Name, Phone, fax, Active__c, Website FROM Account WHERE Name Like :firstName+'%' and Active__c=:isActive];
        return [SELECT id, Name, Phone, fax, Active__c, Website FROM Account WHERE Name Like :firstName+'%'];
    }
    
    //To create account
    @AuraEnabled
    public static void createNewAccount(Account acct){
        System.debug('@@@ACCOUNT Details:'+acct);
        if(String.isNotBlank(acct.Name)){
           insert acct;     
        }    
    }

}