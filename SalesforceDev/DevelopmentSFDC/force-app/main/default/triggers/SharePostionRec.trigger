trigger SharePostionRec on Position__c(after insert){
  
 /* list<Position__Share> posLst = new List<Position__Share>();
  for(Position__c pos : trigger.new){
     if(pos.Location__c == 'Bangalore'){
         Position__Share posShare = new Position__Share();
         posShare.ParentId = pos.id; //Position Record Id
         posShare.UserOrGroupId = '00528000000Y55r'; // Assing either User id or Public group id
         posShare.AccessLevel = 'Read'; //All, Read, Edit
         posShare.RowCause = 'Manual';
         posLst.add(posShare);
     }
     
  }
  
  if(posLst.size()>0){
    insert posLst;
  }*/
  
  createsharingrules.sharepositionrecord(trigger.new);
  system.debug('new value' +trigger.new);
  
}