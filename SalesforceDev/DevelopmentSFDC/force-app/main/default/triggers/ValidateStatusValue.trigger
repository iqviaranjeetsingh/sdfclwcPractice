trigger ValidateStatusValue on test_one__c (before insert, before update) {
   System.debug('Trigger.New:>>>'+Trigger.New);
}