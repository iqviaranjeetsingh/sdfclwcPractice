trigger TriggerContextVariable on Candidate__c (before insert, after insert, before update, after update, before delete, after delete) {
    System.debug('Trigger.new>>>:'+trigger.new);
    System.debug('Trigger.isinsert:'+trigger.isInsert);
}