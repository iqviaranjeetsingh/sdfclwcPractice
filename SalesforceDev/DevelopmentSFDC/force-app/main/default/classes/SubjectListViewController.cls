/**
* @Author: IQVIA
* @Description: This class is used to prepare data and show Subject list view with related attachment.
* Revision History:
* 2020-02-19 | RANJEET SINGH | Created
*		
*/
public with sharing class SubjectListViewController {
    
    /**
	* @Description Invoke getSubjects() method to get Subject and Related attachment data on page load
	* @return List<SubjectWithAttachment> list of wrapper(Subject with attachment)
    */
    @AuraEnabled(Cacheable = true)
    public static List<SubjectWithAttachment> getSubjects(){
       //Initialize wrapper class
       List<SubjectWithAttachment> lstOfStudyWithAttachment = new List<SubjectWithAttachment>();
       Map<id, R_Singh__Subject__c> subjects = new Map<id, R_Singh__Subject__c>(
           [SELECT Id, Name, R_Singh__Subject_Name__c, R_Singh__Status__c ,
                   R_Singh__Informed_Consent__c FROM R_Singh__Subject__c ORDER By Name]);
       Map<id, id> subjectIdWithDocumentMap = new Map<id, id>();

       //Do SOQL query on ContentDocumentLink to retreive Subject realted Content Document Id
       for(ContentDocumentLink doc: [SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId=:subjects.keySet()]){
           subjectIdWithDocumentMap.put(doc.LinkedEntityId, doc.ContentDocumentId);
       }
       
       /*
        Gathered Subject and related attachment details.
        Now Prepeare wrapper class to map the Subject with related Content Document Id.
       */
       for(R_Singh__Subject__c subject : subjects.values()) {
           if(subjectIdWithDocumentMap.containsKey(subject.id)) {
               lstOfStudyWithAttachment.add(new SubjectWithAttachment(subject, subjectIdWithDocumentMap.get(subject.id), true));
           } else {
               lstOfStudyWithAttachment.add(new SubjectWithAttachment(subject, null, false));
           }
                     
       }
       //Prepare final Subject data
       return lstOfStudyWithAttachment;
    }

    //Wrapper class to prepare Study with attachment data.
    public class SubjectWithAttachment {
        @AuraEnabled public R_Singh__Subject__c subject;
        @AuraEnabled public string attachmentId;
        @AuraEnabled public boolean isAvailableAttachment;
        public SubjectWithAttachment(R_Singh__Subject__c subject, string attachmentId, boolean isAvailableAttachment){
            this.subject = subject;
            this.attachmentId = attachmentId;
            this.isAvailableAttachment = isAvailableAttachment;
        }
    }
}