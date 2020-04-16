public class LightningButtonGroup{

   public Integer i{get;set;}
   public boolean isHideModel{get;set;}
   public LightningButtonGroup(){
      i = 0;
   }
   public pagereference count(){
      i++;
      return null;
   }
   
   public pagereference show(){
      isHideModel = true;
      return null;
   }
   
   public pagereference hide(){
      isHideModel = false;
      return null;
   }
}