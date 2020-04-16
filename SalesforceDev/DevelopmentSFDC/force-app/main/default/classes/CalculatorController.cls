public class CalculatorController {

   public Integer number_One{get;set;}
   public Integer number_Two{get;set;}
   public Integer Result{get;set;}
   
   public PageReference AddNumber(){
      Calculator calc = new Calculator();
      Result = calc.Add(number_One,number_Two);
      return null;
   }
   //Minus
   public PageReference Minus(){
      Calculator calc = new Calculator();
      Result = calc.Substract(number_One,number_Two);
      return null;
   }
}