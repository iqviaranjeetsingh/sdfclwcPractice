trigger QuoteTranslation on Quote (before insert, before update) {
   Trigger.New[0].Delivery_Time__c.addError('You Seleted Delivery Time:'+Trigger.New[0].Delivery_Time__c);
}