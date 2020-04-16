public class PracticeConstructor {
    Integer x = null;
    integer y = null;
    //Default constructor
    public PracticeConstructor(){
        x = 80;
        y = 90;
        System.debug('Executed Default constructor');
    }
    //Parameterize constructor
    public PracticeConstructor(Integer x, String y){
        System.debug('Executed parameterize constructor Integer,String constructor');
    }
    
    public PracticeConstructor(Integer x, Integer y){
        System.debug('Executed parameterize constructor Integer,integer constructor');
    }
    
    public PracticeConstructor(Integer x, Integer y, Integer z){
        System.debug('Executed parameterize constructor Integer,integer,integer constructor');
    }
    
    public void AddNumber(){
        integer add = x + y;
        System.debug('Final Result:'+add);
    }
}