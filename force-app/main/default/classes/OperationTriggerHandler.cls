public class OperationTriggerHandler {
    /*@future
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
    }*/

    public static void beforeupdate(){
        System.debug('beforeupdate1');
        test__c test = [SELECT id,SumCurrency__c FROM test__c WHERE id = 'a02J3000003INzOIAW'];
        System.debug(test.SumCurrency__c);
    }
}