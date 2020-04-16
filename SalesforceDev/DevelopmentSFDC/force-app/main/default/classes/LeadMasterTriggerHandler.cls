public with sharing class LeadMasterTriggerHandler {
    
    public static void processLead(list<Lead> newLeads, Map<id,Lead> oldLeadMap){
        for(Lead ld:newLeads) {
            Lead oldLead = oldLeadMap.get(ld.id);
            System.debug(ld.Ownerid+'@@@@'+oldLead.OwnerId);
            if(ld.Ownerid != oldLead.OwnerId) {
                System.debug(ld.Ownerid+'@@@@'+oldLead.OwnerId);
                ld.AddError('You can not change Owner@@@@@:'+ld.Ownerid);
            }
        }
    }
    
}