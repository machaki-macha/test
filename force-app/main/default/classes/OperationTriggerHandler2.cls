public class OperationTriggerHandler2 {
    @future
    public static void OperationTest() {
        //throw new NullPointerException();
        wait(10000);
        
    }
    
    public static void wait(Integer ms){
        

        Long startTime = DateTime.now().getTime();
        Long finishTime = DateTime.now().getTime();
    
        

        while((finishTime - startTime) < ms){
            finishTime = DateTime.now().getTime();
        }

        throw new NullPointerException();
    }
}