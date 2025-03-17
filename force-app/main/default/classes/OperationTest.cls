public with sharing class OperationTest {
    public static void OperationTest() {
        wait(10000);
    }
    
    public static void wait(Integer ms){
        Long startTime = DateTime.now().getTime();
        Long finishTime = DateTime.now().getTime();
    
        while((finishTime - startTime) < ms){
            finishTime = DateTime.now().getTime();
        }
    }
}