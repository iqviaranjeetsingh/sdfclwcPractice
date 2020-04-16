public class MarkAttendance{
   public boolean showDropDown{get;set;}
   public boolean showTable{get;set;}
   public string selectedResource{get;set;}
   public list<Account> sessionList{get;set;}
   public list<Contact> currentContacts{get;set;}
   public MarkAttendance(){
      showDropDown = true;
      sessionList = [SELECT id, Name, CreatedDate From Account];
      currentContacts = [SELECT id, Name, Phone from Contact];
   }
   public pagereference selectResource(){
      return null;
   }
   
   public list<selectOption> getresourceOptions(){
      list<selectOption> opt = new list<selectOption>();
      opt.add(new selectOption('Test','Test'));
       return opt;
         
   }
   
 
}