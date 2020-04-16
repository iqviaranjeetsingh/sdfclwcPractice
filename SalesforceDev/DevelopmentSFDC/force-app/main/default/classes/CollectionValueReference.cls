public class CollectionValueReference {
    private map<string,map<string,string>> cityMapCountry;
    string str = 'Hyderabad;Bangalore;Pune;Mangalore;Bhopal;Delhi';
    public CollectionValueReference(){
        cityMapCountry = new map<string, map<string,string>>();
        for(string str :str.split(';')){
            if(!cityMapCountry.containsKey(str)){
                cityMapCountry.put(str, new map<string, string>());
            }
            cityMapCountry.get(str).put(str, str);
        }
    }
    
    public void processMap(){
        System.debug(cityMapCountry.size()+':@@@@in processMap:'+cityMapCountry);
        for(string str: cityMapCountry.keySet()){
            if(cityMapCountry.containsKey(str)){
                generateMapValinListForProcess(cityMapCountry.get(str));
            }
        }
        System.debug(cityMapCountry.size()+' :@@@@in processMap After:'+cityMapCountry);
    }
    
    public void generateMapValinListForProcess(map<string,string> cm){
        for(string str: cm.keyset()){
           cm.remove(str);
        }
    }

}