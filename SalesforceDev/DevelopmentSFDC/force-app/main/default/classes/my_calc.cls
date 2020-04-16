public class my_calc 
 {
        public integer a;
		public integer b;
     
      public integer Add() 
      {
          integer sum = a + b;
          system.debug('sum = '+sum);
          return sum;
      }
     
  public integer Add (integer num1, integer num2)
    {
        integer Add = num1 + num2;
       // system.debug('Add = '+Add);
        return add;
        
    }
     
    public integer Sub (integer num1, integer num2)
    {
        integer sub = num1 - num2;
        system.debug('sub = '+sub);
        return sub;  
    }
    
    public integer mul (integer num1, integer num2)
    {
      	integer product = num1 * num2;
     	system.debug('product = '+product);
        return product;
    }
    
    public integer Div(integer num1, integer num2)
    {
     	integer Div = num1 / num2;
        system.debug('Div = '+Div);
        return Div;
    } 
    
}