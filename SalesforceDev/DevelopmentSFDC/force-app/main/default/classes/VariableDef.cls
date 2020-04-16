public Class VariableDef{
  //Local Variable & Global Variable
  
  //Global Variable
  Integer Result;
  Integer sum;
  
  Public void AddNumber(Integer num1, Integer num2){
     //Local Variable: sum
     Integer sum;
     sum = num1 + num2;
  }
  
  Public void AddNumber(Integer num1, Integer num2, Integer num3){
     
     Result = num1 + num2 + num3;
  }
  
  public Void Multiplication(Integer num1, Integer num2){
     Result = num1 * num2;
  }
}