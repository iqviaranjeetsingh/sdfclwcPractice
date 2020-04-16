global class AccountWrapper    implements Comparable{
    public string acctName{get;set;}
    public string id{get;set;}
    public integer order{get;set;}
    public string SORT_BY;
    
    public void sortByValue(string val){
        SORT_BY = val;
    }
    
    global Integer compareTo(Object ObjToCompare) {
        System.debug(this.acctName+'@@@'+SORT_BY+'@@@'+ObjToCompare);
        AccountWrapper tempAR = (AccountWrapper)ObjToCompare;
        if(SORT_BY == 'acctName'){
            if(this.acctName == tempAR.acctName)
                return 0;
            
            if(this.acctName > tempAR.acctName)
                return 1;
            
            return -1; 
        }
        
        if(SORT_BY == 'id'){
            if(this.id == tempAR.id)
                return 0;
            
            if(this.id > tempAR.id)
                return 1;
            
            return -1; 
        }
        
        return -1;
    }
}