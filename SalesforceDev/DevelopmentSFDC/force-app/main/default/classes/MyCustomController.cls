public class MyCustomController { 
    
    public list<account> getAccounts() {
        return [SELECT id, Name from Account];
    }



public MyCustomController() {}

@RemoteAction
    public static String createContact(string FirstName, string LastName) {
       Contact c = new Contact(FirstName=FirstName,LastName=LastName);
       insert c;
       return c.Id; 
       
    }

}