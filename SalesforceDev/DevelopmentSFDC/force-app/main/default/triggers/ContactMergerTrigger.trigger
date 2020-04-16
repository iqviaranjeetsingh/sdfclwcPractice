trigger ContactMergerTrigger on Contact(before insert, before update, before delete, after insert, after update, after delete, after undelete) {
   System.debug('Contact***********************'+Trigger.OperationType+'**********************');
   System.debug('@@New Value:'+trigger.new);
   System.debug('@@Old Value:'+trigger.old);
}