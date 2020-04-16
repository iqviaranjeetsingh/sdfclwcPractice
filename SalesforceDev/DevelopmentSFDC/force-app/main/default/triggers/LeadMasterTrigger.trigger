trigger LeadMasterTrigger on Lead (before update) {
    LeadMasterTriggerHandler.processLead(trigger.new, trigger.oldMap);
/*
  for(Lead ld:trigger.new) {
    Lead oldLead = trigger.oldmap.get(ld.id);
    System.debug(ld.Ownerid+'@@@@'+oldLead.OwnerId);
    if(ld.Ownerid != oldLead.OwnerId) {
       System.debug(ld.Ownerid+'@@@@'+oldLead.OwnerId);
       ld.AddError('You can not change Owner.');
    }
  }
*/
}