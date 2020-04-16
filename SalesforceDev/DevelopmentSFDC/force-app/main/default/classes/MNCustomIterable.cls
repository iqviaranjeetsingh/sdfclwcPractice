global class MNCustomIterable implements Iterator<Account>{ 

   List<Account> accs {get; set;} 
   Integer i {get; set;} 

   public MNCustomIterable(){ 
       accs = [SELECT Id, Name, NumberOfEmployees FROM Account limit 8]; 
       i = 0; 
   }   

   global boolean hasNext(){ 
       if(i >= accs.size()) {
           return false; 
       } else {
           return true; 
       }
   }    

   global Account next(){ 
       // 8 is an arbitrary constant in this example that represents the maximum size of the list.
       if(i == 8){return null;} 
       i++; 
       return accs[i-1]; 
   } 
   
   public pageReference dislayNextAccount(){
      return null;
   }
   
   public Account getAccountRec(){
      return next();
   }
   
   public boolean gethasNextAccount(){
      return hasNext();
   }
   
}