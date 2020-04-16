public class SelectRecordController {
    public List<wrapRecord> wrapRecordList {get; set;}
     
    public SelectRecordController(){
        if(wrapRecordList == null) {
            wrapRecordList = new List<wrapRecord>();
            for(Account a: [select Id, Name,BillingState, Website, Phone from Account limit 10]) {                
                wrapRecordList.add(new wrapRecord(a));
            }
        }
    }
     
    public class wrapRecord {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
        
        public wrapRecord(Account a) {
            acc = a;
            selected = false;
        }
    }
}