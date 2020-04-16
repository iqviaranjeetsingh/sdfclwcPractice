global class CommonWrapperClass {
    @AuraEnabled public boolean isSelected{get;set;}
    @AuraEnabled public string positionTitle{get;set;}
    @AuraEnabled public string status{get;set;}
    @AuraEnabled public string positionId{get;set;}
    public CommonWrapperClass(){
       isSelected = false;
       positionTitle = '';
       status = '';
    }
}