trigger shubham_test on Employee__c (before insert) {
    
     List<employee__c> emppDetails = trigger.New;
     for(employee__c emp:emppDetails)
     {
     if(emp.Country__c == 'India' && (emp.State__c == '' || emp.State__c == null))
     	{
             emp.State__c.addError('State field is required when country selected as India.');
        
     	} else
        	{
        	emp.State__c = 'Bihar';
     		}

	}
}