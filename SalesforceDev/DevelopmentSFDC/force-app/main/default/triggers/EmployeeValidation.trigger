trigger EmployeeValidation on Employee__c(before insert,before update){
   
   //trigger.New : always return list of sobject of new record.
   List<Employee__c> emppDetails = trigger.New;
   //for(Employee__c emp:trigger.New){
   for(Employee__c emp:emppDetails){
     if(emp.Country__c == 'India' && (emp.State__c == '' || emp.State__c == null)){
        //Error message
        //Method: AddError('Error Message');
        //Error Location: Top of the Page
        //emp.addError('State field is required when country selected as India.');
        //Error Location: Below the State Field
        emp.State__c.addError('State field is required when country selected as India.');
        
     } else{
        emp.State__c = 'Bihar';
     }
     //   Country : india; State: null
     // 0 == 0: True, 0 != 0 : FALSE
     //   TRUE && (FALSE || FALSE): TRUE && FALSE: FALSE
     // TRUE &&(FALSE || TRUE): TRUE && TRUE : TRUE
   
   }

}