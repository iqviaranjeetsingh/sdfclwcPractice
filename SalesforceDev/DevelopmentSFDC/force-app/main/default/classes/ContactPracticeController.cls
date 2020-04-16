public class ContactPracticeController {
   @AuraEnabled
    public static list<Contact> getAllContacts(){
        return [SELECT Id, Name, MailingStreet, Phone, Email, Level__c FROM Contact];
    }
    
    @AuraEnabled
    public static list<Contact> getPrimaryContact(){
        return [SELECT Id, Name, MailingStreet, Phone, Email, Level__c FROM Contact WHERE Level__c='Primary'];
    }
}