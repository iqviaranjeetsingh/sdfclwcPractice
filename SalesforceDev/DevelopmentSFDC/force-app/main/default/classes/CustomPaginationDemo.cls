public with sharing class CustomPaginationDemo
{

    public List<ContactWrapper> lstWrapper {get;set;}
    public List<ContactWrapper> lstSetController{get;set;}
    
    CustomIterable obj;
    
    public CustomPaginationDemo() {
        System.debug('@@@@Constructor Execution Started...');
        lstWrapper =  new List<ContactWrapper>();
        lstSetController = new List<ContactWrapper>();

        List<Contact> lstContact = [select id,name from Contact order by Name ASC limit 22];
        System.debug('@@@@lstContact>>>'+lstContact.size());
        System.debug('@@@@lstWrapper Before>>>'+lstWrapper);
        
        for(Contact cont : lstContact ){
            lstWrapper.add(new ContactWrapper(cont ,false));
        }
        System.debug('@@@@lstWrapper After>>>'+lstWrapper);
        
        obj = new CustomIterable (lstWrapper); 
        obj.setPageSize = 5;
        System.debug('@@@@obj >>>'+obj );
        next();         
    }
    
    
        public Boolean hasNext {
            get 
            {
                System.debug('@@@@hasNext>>>');
                return obj.hasNext();
            }
            set;
        }
        
        public Boolean hasPrevious {
            get 
            {
                System.debug('@@@@hasPrevious>>>');
                return obj.hasPrevious();
            }
            set;
        }
        
        public void next() 
        {
            System.debug('@@@@lstSetController Before Next>>>'+lstSetController);
            lstSetController = obj.next();
            System.debug('@@@@lstSetController After Next>>>'+lstSetController);
        }
        
        public void previous() 
        {
            System.debug('@@@@lstSetController Before previous>>>'+lstSetController );
            lstSetController = obj.previous();
            System.debug('@@@@lstSetController After previous>>>'+lstSetController );
        }
    
}