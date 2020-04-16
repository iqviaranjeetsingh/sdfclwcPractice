global class  CustomIterable implements Iterator<list<ContactWrapper>> { 
   list<ContactWrapper> InnerList{get;set;}
   list<ContactWrapper> ListRequested{get;set;}

   Integer i {get; set;} 
   public Integer setPageSize {get; set;} 

   public CustomIterable(List<ContactWrapper> lstAccWr){
       System.debug('@@@@CustomIterable Constructor Execution Started.....');
       InnerList = new list<ContactWrapper >(); 
       ListRequested = new list<ContactWrapper >();  
       
       System.debug('@@@@InnerList Before>>'+InnerList);   
       InnerList = lstAccWr;
       System.debug('@@@@InnerList Before>>'+InnerList);
       System.debug('@@@@setPageSize>>'+setPageSize);
       System.debug('@@@@ I>>'+i);    
       setPageSize = 10;
       i = 0; 
   }   

   global boolean hasNext(){
       if(i >= InnerList.size()) {
           return false; 
       } else {
           return true; 
       }
   } 
   
   global boolean hasPrevious(){ 
       if(i <= setPageSize) {
           return false; 
       } else {
           return true; 
       }
   }   

   global list<ContactWrapper > next(){       
       system.debug('@@@@ next I>>>>' + i);
       system.debug('@@@@ next ListRequested>Before>>>' +ListRequested);
       ListRequested = new list<ContactWrapper >();
       system.debug('@@@@ next ListRequested>After>>>' + ListRequested); 
       integer startNumber;
       system.debug('@@@@ next startNumber>>>' + startNumber);
       system.debug('@@@@ next InnerList>>>' + InnerList);
       integer size = InnerList.size();
       system.debug('@@@@ next size>>>'+ size);
       system.debug('@@@@ next setPageSize>>>'+ setPageSize);
       if(hasNext())
       {  
           if(size <= (i + setPageSize))
           {
               startNumber = i;
               system.debug('@@@@ next IF startNumber>>>'+ startNumber);
               i = size;
               system.debug('@@@@ next IF I>>>'+ i);
           }
           else
           {
               i = (i + setPageSize);
               system.debug('@@@@ next Else I>>>'+ i);
               startNumber = (i - setPageSize);
               system.debug('@@@@ next Else startNumber >>>'+ startNumber );
           }
           
          system.debug('@@@@ next Outside I>>>'+ i);
          system.debug('@@@@ next OutSide startNumber >>>'+ startNumber );
           for(integer start = startNumber; start < i; start++)
           {
               ListRequested.add(InnerList[start]);
           }
       } 
       return ListRequested;
   } 
   
   global list<ContactWrapper > previous(){      
       ListRequested = new list<ContactWrapper >(); 
       system.debug('i value is previous before =====' + i);
       integer size = InnerList.size(); 
       if(i == size)
       {
           if(math.mod(size, setPageSize) > 0)
           {    
               i = size - math.mod(size, setPageSize);
           }
           else
           {
               i = (size - setPageSize);
           } 
       }
       else
       {
           i = (i - setPageSize);
       }
       
       system.debug('i value is previous =====' + i);
       system.debug('i value is 2previous ==== ' + (i - setPageSize));
       
       for(integer start = (i - setPageSize); start < i; ++start)
       {
           ListRequested.add(InnerList[start]);
       } 
       return ListRequested;
   }   
}