Public Class  EmployeeManagement{
    //Variable Declaration
    public Id Emp_Id;
    Public Integer Emp_No;
    Public String FirstName;
    Public Date admissionDate;
    public Boolean isTakeAdmission;
    Integer count;
    
    //Method Declaration
    Public void EmployeeDetails(){
    
    }
    
    public Integer CreateEmployee(){
       Integer emp_no = 54545;
      // we always user 'return' keyword to return the value.
      return emp_no;
    }
    
    public void AddNumber(Integer num1,Integer num2){
        Integer Result = num1 +num2;
        System.debug('@@@@@@Sum Result:'+result);
    }
    // Num1 = 50 and num2 = 70
    // Integer Result = 50 + 70;
    // @@@@@@Sum Result: 120
    
    public Integer AddTwoNumber(Integer num1,Integer num2, integer num3, integer num4){
          Integer Result = num1 + num2 + num3 + num4;
          System.debug(result);
          return Result;
    }
    // num1 = 10, num2 = 20, num3 = 30, num4 = 40
    // Integer Result = 10 + 20 + 30 + 40;
    // Integer Result = 100;
    // 100
    // return 100;
    // Integer finalResult = 100;
    // Final Result:100
}