public class PracticeCollectionDateType {
    //Collection Data type
    //1.List   2.Set   3.Map
    //List: 
    // - It store collection of data
    // - It can contains value in order
    // - it can contains Duplicate value
    // - It can be nested upto five level
    // - List value can be sorted in Ascending order: sort();
    // Syntax: List<DataType> obj = new List<DataType>();
    
    List<Integer> lstint = new List<Integer>();
    //Arrray
    //Integer[] lstint1 = new Integer[5];
    List<String> lstString = new List<String>();
    List<Position__c> lstPosition = new List<Position__c>();
    List<Account> lstAcct = new List<Account>();
    public void ListCollectionPractice(){
        System.debug('List of integer'+lstint);
        
        lstint.add(101);
        lstint.add(102);
        lstint.add(103);
        lstint.add(104);
        //Arrary
        /*
        lstint1[0] = 101;
        lstint1[1] = 102;
        lstint1[2] = 103;
        lstint1[3] = 104;*/
        System.debug('List of integer'+lstint);
        System.debug('Print 103:'+lstint.get(2));
        for(Integer abc:lstint){
            if(abc == 103){
                //Statement
                System.debug('103 value found in list');
            }
        }
        
        // Where id='001280000035YKA'
        Account acct = [SELECT id, Name, Phone, Customer_ID__c, SLA__c, AccountNumber,fax from Account Where id='001280000035YKA'];
        System.debug('Single Salesforce Object value:'+acct);
        
        List<Account> acct1 = [SELECT id, Name, Phone, Customer_ID__c, SLA__c, AccountNumber,fax from Account];
        System.debug('list of Salesforce Object value:'+acct1);
        
        //Account acct2 = [SELECT id, Name, Phone, Customer_ID__c, SLA__c, AccountNumber,fax from Account Where name='323234'];
        // Integer => long => Double => Decimal
        List<Account> acct3 = new List<Account>();
        //for(Account ac: [SELECT id, Name, Phone, Customer_ID__c, SLA__c, AccountNumber,fax from Account]){
        for(Account ac: acct1){
           acct3.add(ac);
        }
        System.debug('List of Account:'+acct3);
    }
    
    public void setCollectionTyePractice(){
        //Set: 
        //1. It contains unique value but in un-order fromat
        set<Integer> setRef = new set<Integer>();
        setRef.add(1);
        setRef.add(2);
        setRef.add(3);
        for(Integer i=0;i<10;i++){
          setRef.add(i);
        }
        System.debug('Set values:'+setRef+'<<<<Set Size>>>>'+setRef.size());
        setRef.clear();
        System.debug('Set Values:'+setRef);
        if(setRef.size()>0){
         //insert setRef;   
        }
        //DML: insert, update, delete, undelete, merge: Limit 150/Transaction
        // SOQL: 100 /transaction
        //set<id> ids = new set<id>();
        for(Integer i=0;i<=200;i++){
            //
            //
            //
            //ids.add(id);
            //Bad practice to write soql or DML operation in for loop
            //Account acct = [SELECT id,  Name from Account id=:id];
        }
        //List<Account> acct = [SELECT id,  Name from Account where id=:ids];
        Integer i=0;
        while(i<200){
            Account acct = [SELECT id,  Name from Account limit 1];
        }
    }
    
    public void mapCollectionTyePractice(){
       //map:
       //It contains value in key-value pair
       //Where kay will be unique and value can be duplicate
       //Map Systax: map<key,value> varmap = new map<key,value>();
       //Key must be primitive data type and value can be any data type
       map<String,Account> acctMap = new map<String,Account>();
       map<Integer,Integer> acctMapint = new map<Integer,Integer>(); 
       acctMapint.put(1, 101) ;
       acctMapint.put(2, 202);
       acctMapint.put(3, 303);
       acctMapint.put(4, 404);
       acctMapint.put(5, 505);
       acctMapint.put(6, 606);
        for(Integer i:acctMapint.keySet()){
            System.debug('Map Key :'+i);
            if(i == 5){
              System.debug('>>>>'+acctMapint.get(i));  
            }
            
        }
        
        for(Integer i:acctMapint.values()){
            System.debug('Map All Values:'+i);
        }
        map<id,Account> mapRef = new map<Id,Account>();
        for(Account acc:[Select id, Name, Phone from Account]){
            mapRef.put(acc.id,acc);
        }
        //00128000002ktjW
        if(mapRef.containsKey('00128000002ktjW')){
            System.debug('Account details>>>:'+mapRef.get('00128000002ktjW'));
        }else{
            System.debug('Id not found');
        }
    }
}