public class ExpenseRecordsController {
   @AuraEnabled
    public static List<Expense__c> getExpensesDetails() {

        // Perform isAccessible() check here
        return [SELECT Id, Name, Amount__c, Client__c, Date__c, Reimbursed__c, CreatedDate FROM Expense__c limit 2];
    }
}